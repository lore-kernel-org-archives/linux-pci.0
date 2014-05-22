Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44399 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaEVQe6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 May 2014 12:34:58 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so3818413iec.32
        for <linux-pci@vger.kernel.org>; Thu, 22 May 2014 09:34:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D2E49FCA-B019-45C7-A30F-FD63B9684629@gmail.com>
References: <EF1232FA-308B-4261-82E6-6E3B932181E2@gmail.com>
 <CAErSpo5U4UpMdBC8nGTJcsatste17THf7Ko1RPZpaC01UyS6tw@mail.gmail.com>
 <9F1CDCD7-94EC-43C3-9568-D5C348531D85@gmail.com> <CAErSpo7HY9vbWrpKWXjvrOX+e0GguGe+7U0eg8vNrEpcEUiHVQ@mail.gmail.com>
 <D2E49FCA-B019-45C7-A30F-FD63B9684629@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 22 May 2014 10:34:36 -0600
Message-ID: <CAErSpo76JQpLQ9g5tvcx4qBt+hyOZV7_H0MJ+z+1ndKBjZQQjA@mail.gmail.com>
Subject: Re: Frustrating PCI x ACPI x APIC(?) interaction/bug
To: Micah Dombrowski <mpdwibble@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Ian Abbott <abbotti@mev.co.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci, linux-kernel, Hartley, Ian; please keep CCs so others
can help or maybe benefit]

On Wed, May 21, 2014 at 8:32 PM, Micah Dombrowski <mpdwibble@gmail.com> wrote:
> On May 21, 2014, at 1:16 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> You seem to have comedi driver version 0.7.76.1 on the PC (where it
>> works) and version 0.7.76 on the T530 (where it doesn't).  I'd try the
>> same driver version on both.
>
> It was actually a much older driver on the PC up until a few minutes before those runs.  They are now both running the latest driver from the comedi git repo—no difference.
>
>> From your initial description, I suspect some sort of interrupt
>> problem.  Can you use /proc/interrupts to get an idea of how many
>> interrupts per second the driver is handling, and compare that between
>> the two systems?
>
> Just added some output to the report https://bugzilla.kernel.org/show_bug.cgi?id=76641#c6
>
> Summary, assuming it’s valid to just sum over all of the CPUs: it seems like, for the same amount of data attempted to be acquired, the PC always does approximately 16500 ints no matter what the data rate, while the Laptop does about 13000 in 20 MBps modes, 5000 in 40 MBps, and 2-3000 in 80 MBps.  Uhhhh...

It's valid to sum all the CPUs, and yes, that definitely seems wonky.
You're seeing a very consistent 128 interrupts/4MB chunk on the PC,
but on the T530, it's only about 100/chunk at 20MBps, 38/chunk at
40MBps, and 20/chunk at 80MBps.

But I can't tell if there's a functional problem.  The DMA does seem
to work (even if you don't get all the data, the path seems
functional), and you are getting *some* interrupts from the 4020, so
the interrupt path seems wired up correctly, too.  And of course, both
paths are used by lots of drivers and the T530 is a common machine, so
it's doubtful that there's a huge issue that nobody else has tripped
over.

Does the T530 have enough oomph to do all this?  If you want to
sustain transfers like this, all that data has to come in via DMA from
the 4020, then go out to a disk or something at the same rate.  80MB/s
seems like a lot to expect for sustained writes through a filesystem
on a laptop (but I'm certainly not a filesystem expert).

Each acquisition is "only" 500MB (128 chunks *4MB), so if you don't
need to sustain it continuously, you might be able to preallocate the
whole buffer and keep it in RAM.  Can the T530 keep up if you drop the
processing and output side of the equation?

I don't understand how the "apci=off noapic" thing would make a
difference here, so maybe that's a good clue.  Can you collect the
same sort of info (dmesg, lspci -vv, /proc/interrupts info) with that
configuration?

> Because I note that the Laptop seems to spread the interrupts out over all four hyperthreading ‘cores’, I’ll mention that we’ve also tried the Laptop with hyperthreading and dual-core disabled.  Didn’t seem to make a difference to the data acquisition.
>
> MPD
