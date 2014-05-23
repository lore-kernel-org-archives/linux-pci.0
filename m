Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:49099 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaEWR0A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 May 2014 13:26:00 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so5351308iec.15
        for <linux-pci@vger.kernel.org>; Fri, 23 May 2014 10:26:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ED32BC36-997C-47B4-A618-53C0657DE592@gmail.com>
References: <EF1232FA-308B-4261-82E6-6E3B932181E2@gmail.com>
 <CAErSpo5U4UpMdBC8nGTJcsatste17THf7Ko1RPZpaC01UyS6tw@mail.gmail.com>
 <9F1CDCD7-94EC-43C3-9568-D5C348531D85@gmail.com> <CAErSpo7HY9vbWrpKWXjvrOX+e0GguGe+7U0eg8vNrEpcEUiHVQ@mail.gmail.com>
 <D2E49FCA-B019-45C7-A30F-FD63B9684629@gmail.com> <CAErSpo76JQpLQ9g5tvcx4qBt+hyOZV7_H0MJ+z+1ndKBjZQQjA@mail.gmail.com>
 <ED32BC36-997C-47B4-A618-53C0657DE592@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 23 May 2014 11:25:39 -0600
Message-ID: <CAErSpo7=sUEPkTYPSMDgE1siwJkDJNaaHTdCzViamXiVAzDu_g@mail.gmail.com>
Subject: Re: Frustrating PCI x ACPI x APIC(?) interaction/bug
To: Micah Dombrowski <mpdwibble@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Ian Abbott <abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 23, 2014 at 3:08 AM, Micah Dombrowski <mpdwibble@gmail.com> wrote:
> On May 22, 2014, at 12:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> Does the T530 have enough oomph to do all this?
>> ...
>> Can the T530 keep up if you drop the
>> processing and output side of the equation?
>
> It should have plenty of bandwidth for the 4020 side, as we returned one of these to Lenovo for them to test, and they were able to get well over 100 MBps through the Expresscard slot under Windows.  We found similar results with a USB 3.0 Expresscard under Linux.

Different types of cards will get different throughput depending on
how much they transfer per interrupt and how much work the interrupt
handler does.  It takes the 4020 about 16K interrupts to transfer
500MB of data.  At 80MBps, that's about 2500 interrupts per second,
which doesn't sound completely unreasonable.

One interesting thing is that on the PC, almost all of the interrupts
go to cpu1, while on the T530, they're more scattered.  I don't know
how much sharing of caches and so on there is between the CPUs, but I
don't think there's parallelization benefit for the driver and there
might be a cost.  You could experiment with the "nosmp" kernel option.
 (Of course, parallelization probably *does* help with running the
processing and output side.)

I wonder if you could learn anything about the system load with
"perf".  I haven't used it myself, so I'm afraid I can't give any
useful advice about it.

>> I don't understand how the "apci=off noapic" thing would make a
>> difference here, so maybe that's a good clue.  Can you collect the
>> same sort of info (dmesg, lspci -vv, /proc/interrupts info) with that
>> configuration?
>
> I’ve attached these to the report, but after much more fiddling with it in this mode (looking closely at the incoming data), I now don’t believe this is actually fixing anything.  It makes some of the timing _appear_ better, sometimes, but I think that’s just due to random slowdowns or something.

OK, that's good, because it would be quite strange if it made a difference.

> The most strange thing in the data is shown in the .jpeg file I’ve attached to the report: https://bugzilla.kernel.org/show_bug.cgi?id=76641#c11  …I have no idea.
>
> One more thing: I made one change to the comedi driver that I knew about, which is to change the size of the ‘DMA buffer’ that the card uses.  The driver comes with this set to 0x1000, but I was advised years ago to set this to 0x8000 for our continuous high-speed stuff, and that’s what all of the prior testing has been at.  I tried changing this to 0x2000 and 0x1000—neither made any difference to the sane sample lengths above.

I really don't see a PCI or interrupt configuration issue yet, so I'm
not sure how much more I can contribute here.

Bjorn
