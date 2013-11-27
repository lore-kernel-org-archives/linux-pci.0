Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51238 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab3K0SQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 13:16:43 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so12388916iec.5
        for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2013 10:16:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8446b1354b434e759cd37ddb5f8b6cc5@BLUPR05MB118.namprd05.prod.outlook.com>
References: <528D4739.80700@fold.natur.cuni.cz> <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
 <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
 <20131125194044.GA9710@google.com> <5293F3FB.6000401@fold.natur.cuni.cz>
 <20131126031317.GA6258@google.com> <cfeb9976fbb74028b600c9f86fcdd9ad@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo41KYXbgz5q=U9gfDD_tZNp9qFr0LGqMvnem2rQTLTL1g@mail.gmail.com>
 <55dfa94fa7224bafa14d52c5835ea1ca@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo5BSzUJofyuNH5wKqYfcydOXEtrnJSq0xpssafomqHWrQ@mail.gmail.com>
 <1385507535.25738.74.camel@ul30vt.home> <8446b1354b434e759cd37ddb5f8b6cc5@BLUPR05MB118.namprd05.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 27 Nov 2013 11:16:20 -0700
Message-ID: <CAErSpo5o=deCSd=61hV23CkY-PNMAaJ0OurWP7v2y4OmFDJaHA@mail.gmail.com>
Subject: Re: pciehp LinkState
To: Rajat Jain <rajatjain@juniper.net>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 27, 2013 at 12:02 AM, Rajat Jain <rajatjain@juniper.net> wrote:
>
>
>> > >> > Currently in my patch, the pciehp_use_link_events=1 is used to
>> > >> > only
>> > >> enable link state change notifications, but in case pcie_isr()
>> > >> finds "DLL changed" bit set in "Slot status", it processes the link
>> > >> state change. I'll make the single line change to pcie_isr() to
>> > >> process the event only if pciehp_use_link_events=1. Let me know if
>> > >> this sounds alright.
>> > >>
>> > >> If we can avoid it, I'd prefer not to add the
>> "pciehp_use_link_events"
>> > >> module parameter.  What would break if we just *always* used link
>> > >> events?
>> > >
>> > > Not really "break", but I'd think some changes in behavior shall be
>> visible:
>> > >
>> > > 1) When a card is pulled out (thus causing the link to go down), it
>> shall always be disabled - whether or not it supports "surprise removal"
>> (in the capabilities). I think this would be the right thing to do in
>> this situation.
>> >
>> > Yep, this sounds like it would be OK.
>> >
>> > > 2) Even other scenarios where the link may go down - e.g. device
>> reset using an external reset pin, or a firmware initiated reset etc,
>> shall cause the device to be immediately removed and re-added again when
>> the link comes back up). This may also be desired.
>> >
>> > This sounds OK, too.  There's already some fancy dancing for similar
>> > scenarios in pciehp_reset_slot(); maybe that would have to be
>> > extended.  Alex might have input here.
>>
>> So long as reset initiated through pci-core doesn't cause a hotplug I
>> think I'm ok with it.  I saw code was already being added around slot
>> reset to mask link changes, just like we do with presence detection.
>
> Thanks Alex for taking a look at my patch. Yes, I have taken care in the pciehp_reset_slot().
>
>> Thanks,
>>
>> Alex
>>
>> > > 3) If the link comes up automatically as soon as a card is plugged
>> in (i.e. without the need to turn on power or do anything else from SW),
>> the card shall be immediately added - even if surprise capability is not
>> present. I'm not sure if this is desired. That's because the current
>> behavior is that for slots that do not support surprise events, the user
>> has to initiate the hot-add using the attention button. Even after that,
>> he gets a 5 second time to cancel the operation in case he wishes. This
>> will no longer be the case, if use of link events is always enabled.
>> >
>> > This one sounds like a problem.  But I think we could manage this,
>> > e.g., by noticing the link-up interrupt, but waiting for the 5-second
>> > timeout if an attention button is present.
>
> I think that one aspect might still not be right. The spec seems to indicate that the hot-plug should be *initiated* by the press of attention button, and after attention button press user has a time of 5 seconds.

Yes, sorry, my response didn't make sense.  BTW, what spec are you
reading that describes the hot-plug flow?  I don't see many details in
the PCIe spec, so I'm looking at the Standard Hot-Plug Controller
Specification, rev 1.0.  I think PCIe hotplug is modeled after that
and keeps the same UI model.  It might be nice if we had a summary in
Documentation/PCI with pointers to the specs.  The model feels a bit
like folklore that everybody is "supposed to know" but I don't know
how everybody is supposed to learn it.

As I read the SHPC spec, the attention button is basically a request
to apply power to the slot:

  - user inserts a card into a powered-off slot,
  - user presses attention button,
  - OS blinks power indicator,
  - after 5 seconds, OS applies power
  - link becomes up,
  - OS enumerates device,
  - OS turns power indicator on

If user presses attention button during 5-second interval while power
indicator is blinking, operation is cancelled and OS turns off power
indicator and leaves slot powered off.

> So I think if we want to remove that module parameter and also retain attention button behavior, our options might be:
>
> * If attention button is present, do not use link state events all together. (i.e. user has to use attention button always to initiate enabling or disabling device. This'd be compliant with current behavior and expectations I guess). In all the remaining cases, the link events can be used just fine.
>
> * If attention button is present, process LINK-DOWN events, but not LINK-UP events. Any devices whose link suddenly goes down, will be disabled (sounds quite right). But when Link comes back up, they'll not be enabled (although this may not sound right, but this complies with the current behavior and the semantics of attention button).
>
> Or else, we can leave the module parameter in place.
>
> BTW, what are the odds of coming across a slot where the link comes up automatically without the need for SW to do anything (despite having an attention button there), but "surprise" events are not supported :-)? Just wondering if we are discussing a realistic scenario. If we don't see this as realistic, then we can safely drop the module parameter IMHO.

If the link comes up, that means power is applied already, and I don't
know what else the OS could or should do before enumerating the
device.  It seems like this is the case regardless of whether there's
an attention button or other hardware.  So my vote is to just drop the
module parameter.

Bjorn
