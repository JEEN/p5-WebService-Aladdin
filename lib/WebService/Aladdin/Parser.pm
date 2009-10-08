package WebService::Aladdin::Parser;

use strict;
use warnings;
use XML::FeedPP;

use WebService::Aladdin::Items;
use WebService::Aladdin::Item;

use WebService::Aladdin::Item::Book;
use WebService::Aladdin::Item::DVD;
use WebService::Aladdin::Item::Music;

sub parse_product {
    my ($class, $res) = @_;

    my $data = XML::FeedPP->new($res->content); 
    my $i = $data->{rss}->{channel}->{item}->[0];

    my $item = WebService::Aladdin::Item->new;
    if ($i->{'aladdin:bookinfo'}) { 
	$item = WebService::Aladdin::Item::Book->new;
	$item->init(delete $i->{'aladdin:bookinfo'});
    } elsif ($i->{'aladdin:musicinfo'}) {
	$item = WebService::Aladdin::Item::Music->new;
	$item->init(delete $i->{'aladdin:musicinfo'});
    } elsif ($i->{'aladdin:dvdinfo'}) {
	$item = WebService::Aladdin::Item::DVD->new;
	$item->init(delete $i->{'aladdin:dvdinfo'});
    }
    
    foreach my $key (keys %{ $i }) {
	my $type = $key;
	$type =~ s/(?:aladdin:|dc:|:encoded)//;
	$type = lcfirst $type;
	$item->$type($i->{$key});
    }
    $item;
}

sub parse_search {
    my ($class, $res) = @_;
    my $p = WebService::Aladdin::Items->new;
    my @items;
    if ($res->is_success) {
	my $data = XML::FeedPP->new($res->content);
        for my $i (@{ $data->{rss}->{channel}->{item} }) {
            my $item = WebService::Aladdin::Item->new;
            foreach my $key (keys %{ $i }) {
                my $type = $key;
                $type =~ s/^(?:aladdin|dc)://;
                $type =~ s/:encoded//;
                $type = lcfirst $type;
                $item->$type($i->{$key});
            }
            unshift @items, $item;
        }
        $p->items(\@items);
        $p->itemsPerPage($data->{rss}->{channel}->{'opensearch:itemsPerPage'});
        $p->totalResults($data->{rss}->{channel}->{'opensearch:totalResults'});
        $p->link($data->{rss}->{channel}->{'link'});
        $p->startIndex($data->{rss}->{channel}->{'opensearch:startIndex'});
    } else {
        $p->status($res->status_line);
        $p->items([]);
    }
    $p;
}

1;
