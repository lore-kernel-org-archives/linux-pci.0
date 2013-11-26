Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:35536 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758487Ab3KZWGY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Nov 2013 17:06:24 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: pciehp LinkState
Date: Tue, 26 Nov 2013 22:06:12 +0000
Message-ID: <55dfa94fa7224bafa14d52c5835ea1ca@BLUPR05MB118.namprd05.prod.outlook.com>
References: <528D4739.80700@fold.natur.cuni.cz>
 <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
 <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz>
 <20131126031317.GA6258@google.com>
 <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo41KYXbgz5q=U9gfDD_tZNp9qFr0LGqMvnem2rQTLTL1g@mail.gmail.com>
In-Reply-To: <CAErSpo41KYXbgz5q=U9gfDD_tZNp9qFr0LGqMvnem2rQTLTL1g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> 
> >
> > Currently in my patch, the pciehp_use_link_events=1 is used to only
> enable link state change notifications, but in case pcie_isr() finds
> "DLL changed" bit set in "Slot status", it processes the link state
> change. I'll make the single line change to pcie_isr() to process the
> event only if pciehp_use_link_events=1. Let me know if this sounds
> alright.
> 
> If we can avoid it, I'd prefer not to add the "pciehp_use_link_events"
> module parameter.  What would break if we just *always* used link
> events?

Not really "break", but I'd think some changes in behavior shall be visible:

1) When a card is pulled out (thus causing the link to go down), it shall always be disabled - whether or not it supports "surprise removal" (in the capabilities). I think this would be the right thing to do in this situation.

2) Even other scenarios where the link may go down - e.g. device reset using an external reset pin, or a firmware initiated reset etc, shall cause the device to be immediately removed and re-added again when the link comes back up). This may also be desired.

3) If the link comes up automatically as soon as a card is plugged in (i.e. without the need to turn on power or do anything else from SW), the card shall be immediately added - even if surprise capability is not present. I'm not sure if this is desired. That's because the current behavior is that for slots that do not support surprise events, the user has to initiate the hot-add using the attention button. Even after that, he gets a 5 second time to cancel the operation in case he wishes. This will no longer be the case, if use of link events is always enabled.

I think it would be fair to say that if use of link events is always supported, it would be roughly equivalent to a slot supporting surprise events. (Surprise events work on "presence detect" pin, and this will work on the link state changes).

Thanks,

Rajat

