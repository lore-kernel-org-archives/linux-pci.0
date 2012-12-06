Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:53139 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946776Ab2LFSoa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2012 13:44:30 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so5525175lag.19
        for <linux-pci@vger.kernel.org>; Thu, 06 Dec 2012 10:44:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bug-51331-41252@https.bugzilla.kernel.org/>
References: <bug-51331-41252@https.bugzilla.kernel.org/>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 6 Dec 2012 11:44:08 -0700
Message-ID: <CAErSpo5uewtXu=UoYDchOON+0S_WnK6i=n9yuz4RnbshMpEvrw@mail.gmail.com>
Subject: Re: [Bug 51331] New: pci address space collision on Stratus ftServer
 4500 (usb and network are not recognized)
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> https://bugzilla.kernel.org/show_bug.cgi?id=51331

> I've found that with 3.X (vanilla and Fedora 17) kernels network cards and usb
> devices are not recognized on Stratus ftserver 4500 system.
>
> Kernel reports many 'address space collision' that seems to be the reason why
> the devices are not seen.
>
> The problem appears with all 3.X kernels, 2.6.32 kernel boots and works fine on
> this hardware (do not know about other kernel versions).

Your 2.6.32 kernel detects the 03:01.0 bridge that leads to the igb device:

      pci 0000:03:01.0: PCI bridge to [bus 0e-11]
      pci 0000:0e:1c.0: PCI bridge to [bus 0f]
      pci 0000:0f:00.0: reg 10 32bit mmio: [0x8a140000-0x8a15ffff]
      igb 0000:0f:00.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19

but the 3.6.6 kernel doesn't find 03:01.0 or the devices behind it.

This looks like the problem fixed by this commit:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=284f5f9dbac170b054c1e386ef92cbf654e91bba

That commit appeared in v3.5, so it should be in your 3.6.6 kernel.
It adds a quirk that scans all devices when the DMI SYS_VENDOR matches
"ftServer".  That quirk should be turned on automatically on your box,
but for some reason, your 3.6.6 kernel didn't find the correct DMI
information.

The 2.6.32 kernel found this:

    DMI: Stratus ftServer 4500/G7KRV, BIOS BIOS Version 5.0:17 10/19/2010

which would match the quirk.  But the 3.6.6 kernel didn't print this
DMI information.  Was that boot on the same BIOS version?

The 3.6.6 log looks like a console capture, and it omits KERN_DEBUG
messages.  Can you boot 3.6.6 with the "early_ioremap_debug
pci=pcie_scan_all" flags and attach a dmesg dump (which will include
KERN_DEBUG messages)?
