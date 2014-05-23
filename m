Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:64458 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaEWJIX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 May 2014 05:08:23 -0400
Received: by mail-qc0-f179.google.com with SMTP id x3so7602008qcv.38
        for <linux-pci@vger.kernel.org>; Fri, 23 May 2014 02:08:23 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: Frustrating PCI x ACPI x APIC(?) interaction/bug
From: Micah Dombrowski <mpdwibble@gmail.com>
In-Reply-To: <CAErSpo76JQpLQ9g5tvcx4qBt+hyOZV7_H0MJ+z+1ndKBjZQQjA@mail.gmail.com>
Date: Fri, 23 May 2014 05:08:20 -0400
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Ian Abbott <abbotti@mev.co.uk>
Message-Id: <ED32BC36-997C-47B4-A618-53C0657DE592@gmail.com>
References: <EF1232FA-308B-4261-82E6-6E3B932181E2@gmail.com> <CAErSpo5U4UpMdBC8nGTJcsatste17THf7Ko1RPZpaC01UyS6tw@mail.gmail.com> <9F1CDCD7-94EC-43C3-9568-D5C348531D85@gmail.com> <CAErSpo7HY9vbWrpKWXjvrOX+e0GguGe+7U0eg8vNrEpcEUiHVQ@mail.gmail.com> <D2E49FCA-B019-45C7-A30F-FD63B9684629@gmail.com> <CAErSpo76JQpLQ9g5tvcx4qBt+hyOZV7_H0MJ+z+1ndKBjZQQjA@mail.gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On May 22, 2014, at 12:34 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:

> Does the T530 have enough oomph to do all this?
> ...
> Can the T530 keep up if you drop the
> processing and output side of the equation?

It should have plenty of bandwidth for the 4020 side, as we returned one of these to Lenovo for them to test, and they were able to get well over 100 MBps through the Expresscard slot under Windows.  We found similar results with a USB 3.0 Expresscard under Linux.

As far as the disk side, I should have mentioned, but I’ve been writing to /tmp which is mounted as a ramdisk.  I’ve also done this test with no output at all (just reading from the comedi buffer and discarding), and found the same oddities in timing.  For looking at the data I’ve also cut the file size saved to /tmp down to only 16 MB.

> I don't understand how the "apci=off noapic" thing would make a
> difference here, so maybe that's a good clue.  Can you collect the
> same sort of info (dmesg, lspci -vv, /proc/interrupts info) with that
> configuration?

I’ve attached these to the report, but after much more fiddling with it in this mode (looking closely at the incoming data), I now don’t believe this is actually fixing anything.  It makes some of the timing _appear_ better, sometimes, but I think that’s just due to random slowdowns or something.

I’ve looked at the data with some slow triangle-wave input, and in either 40 MBps mode (1 channel at 20 MHz or 2 at 10 MHz), the discontinuities appear to occur at around the 800 KB mark.  That is, the card properly transfers over around 400k 2-byte samples (of either one 20 MHz or two 10 MHz channels), and then skips what I eyeball to be about half that.

At 2x20 MHz, this drops to around 120k continuous 2-byte samples, though the skipped number is more like 260k (actually may be the same amount of skip as seen in the above modes).

1x10 MHz remains the fastest sane-appearing mode.

The most strange thing in the data is shown in the .jpeg file I’ve attached to the report: https://bugzilla.kernel.org/show_bug.cgi?id=76641#c11  …I have no idea.

One more thing: I made one change to the comedi driver that I knew about, which is to change the size of the ‘DMA buffer’ that the card uses.  The driver comes with this set to 0x1000, but I was advised years ago to set this to 0x8000 for our continuous high-speed stuff, and that’s what all of the prior testing has been at.  I tried changing this to 0x2000 and 0x1000—neither made any difference to the sane sample lengths above.

MPD