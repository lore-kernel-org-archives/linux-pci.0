Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:58513
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753338Ab3K1A7D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Nov 2013 19:59:03 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: pciehp LinkState
Date: Thu, 28 Nov 2013 00:58:57 +0000
Message-ID: <727e197baa7c4ff3ad4bc4a892208d13@BLUPR05MB118.namprd05.prod.outlook.com>
References: <528D4739.80700@fold.natur.cuni.cz>
 <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
 <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz>
 <20131126031317.GA6258@google.com>
 <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo41KYXbgz5q=U9gfDD_tZNp9qFr0LGqMvnem2rQTLTL1g@mail.gmail.com>
 <55dfa94fa7224bafa14d52c5835ea1ca@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo5BSzUJofyuNH5wKqYfcydOXEtrnJSq0xpssafomqHWrQ@mail.gmail.com>
 <1385507535.25738.74.camel@ul30vt.home>
 <8446b1354b434e759cd37ddb5f8b6cc5@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo5o=deCSd=61hV23CkY-PNMAaJ0OurWP7v2y4OmFDJaHA@mail.gmail.com>
In-Reply-To: <CAErSpo5o=deCSd=61hV23CkY-PNMAaJ0OurWP7v2y4OmFDJaHA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >>
> >> > > 3) If the link comes up automatically as soon as a card is
> >> > > plugged
> >> in (i.e. without the need to turn on power or do anything else from
> >> SW), the card shall be immediately added - even if surprise
> >> capability is not present. I'm not sure if this is desired. That's
> >> because the current behavior is that for slots that do not support
> >> surprise events, the user has to initiate the hot-add using the
> >> attention button. Even after that, he gets a 5 second time to cancel
> >> the operation in case he wishes. This will no longer be the case, if
> use of link events is always enabled.
> >> >
> >> > This one sounds like a problem.  But I think we could manage this,
> >> > e.g., by noticing the link-up interrupt, but waiting for the
> >> > 5-second timeout if an attention button is present.
> >
> > I think that one aspect might still not be right. The spec seems to
> indicate that the hot-plug should be *initiated* by the press of
> attention button, and after attention button press user has a time of 5
> seconds.
> 
> Yes, sorry, my response didn't make sense.  BTW, what spec are you
> reading that describes the hot-plug flow?  I don't see many details in
> the PCIe spec, so I'm looking at the Standard Hot-Plug Controller
> Specification, rev 1.0.  I think PCIe hotplug is modeled after that and
> keeps the same UI model.  It might be nice if we had a summary in
> Documentation/PCI with pointers to the specs.  The model feels a bit
> like folklore that everybody is "supposed to know" but I don't know how
> everybody is supposed to learn it.

Ha Ha. Actually right. My knowledge of "spec" is also based mostly on folklore, and reading between the lines of PCIe and SHPC specs.

> 
> As I read the SHPC spec, the attention button is basically a request to
> apply power to the slot:
> 
>   - user inserts a card into a powered-off slot,
>   - user presses attention button,
>   - OS blinks power indicator,
>   - after 5 seconds, OS applies power
>   - link becomes up,
>   - OS enumerates device,
>   - OS turns power indicator on
> 
> If user presses attention button during 5-second interval while power
> indicator is blinking, operation is cancelled and OS turns off power
> indicator and leaves slot powered off.
> 
> > So I think if we want to remove that module parameter and also retain
> attention button behavior, our options might be:
> >
> > * If attention button is present, do not use link state events all
> together. (i.e. user has to use attention button always to initiate
> enabling or disabling device. This'd be compliant with current behavior
> and expectations I guess). In all the remaining cases, the link events
> can be used just fine.
> >
> > * If attention button is present, process LINK-DOWN events, but not
> LINK-UP events. Any devices whose link suddenly goes down, will be
> disabled (sounds quite right). But when Link comes back up, they'll not
> be enabled (although this may not sound right, but this complies with
> the current behavior and the semantics of attention button).
> >
> > Or else, we can leave the module parameter in place.
> >
> > BTW, what are the odds of coming across a slot where the link comes up
> automatically without the need for SW to do anything (despite having an
> attention button there), but "surprise" events are not supported :-)?
> Just wondering if we are discussing a realistic scenario. If we don't
> see this as realistic, then we can safely drop the module parameter
> IMHO.
> 
> If the link comes up, that means power is applied already, and I don't
> know what else the OS could or should do before enumerating the device.
> It seems like this is the case regardless of whether there's an
> attention button or other hardware.  So my vote is to just drop the
> module parameter.

I concur. I'd drop the module parameter. 

Thanks,

Rajat

> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
> 


