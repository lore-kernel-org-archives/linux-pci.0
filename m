Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34042 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeHXHEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Aug 2018 03:04:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so13073188ois.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Aug 2018 20:31:55 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Drake <drake@endlessm.com>
Date: Fri, 24 Aug 2018 11:31:54 +0800
Message-ID: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
Subject: Rewriting Intel PCI bridge prefetch base address bits solves nvidia
 graphics issues
To: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

We are facing a suspend/resume problem with many different Asus laptop
models (30+ products) with Intel chipsets (multiple generations) and
nvidia GPUs (several different ones). Reproducers include:

1. Boot
2. Suspend/resume
3. Load nouveau driver
4. Start X
5. Observe slow X startup and many many errors in logs (primarily
nouveau fifo faults)

or

1. Boot
2. Load nouveau driver
3. Start X
4. Run glxgears - observe spinning gears
4. Suspend/resume
5. Run glxgears - observe that output is all black

or

1. Boot
2. Load proprietary nvidia driver
3. Start X
4. Suspend/resume
5. Observe screen all black, Xorg using 100% CPU

So, suspend/resume basically kills the nvidia card in some way.

After a lot of experimentation I found a workaround: during resume,
set the value of PCI_PREF_BASE_UPPER32 to 0 on the parent PCI bridge.
Easily done in drivers/pci/quirks.c. Now all nvidia stuff works fine.

As an example of an affected product, take the Asus X542UQ (Intel
KabyLake i7-7500U with Nvidia GeForce 940MX). The PCI bridge is:

00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-LP PCI
Express Root Port [8086:9d10] (rev f1) (prog-if 00 [Normal decode])
    Flags: bus master, fast devsel, latency 0, IRQ 120
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000e000-0000efff
    Memory behind bridge: ee000000-ef0fffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000e1ffffff
    Capabilities: [40] Express Root Port (Slot+), MSI 00
    Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
    Capabilities: [90] Subsystem: ASUSTeK Computer Inc. Sunrise
Point-LP PCI Express Root Port [1043:1a00]
    Capabilities: [a0] Power Management version 3
    Capabilities: [100] Advanced Error Reporting
    Capabilities: [140] Access Control Services
    Capabilities: [200] L1 PM Substates
    Capabilities: [220] #19
    Kernel driver in use: pcieport

The really weird thing here is that the workaround register
PCI_PREF_BASE_UPPER32 already appears to have value 0, as shown above
and also verified during resume. But simply writing value 0 again
definitely results in all the problems going away.


1. Is the Intel PCI bridge misbehaving here? Why does writing the same
value of PCI_PREF_BASE_UPPER32 make any difference at all?


2. Who is responsible for saving and restoring PCI bridge
configuration during suspend and resume? Linux? ACPI? BIOS?

I could not see any Linux code to save and restore these registers.
Likewise I didn't find anything in the ACPI DSDT/SSDT - neither on the
affected products, nor on a similar product that does not suffer this
nvidia issue. Linux does put the PCI bridge into D3 power state during
suspend, and upon resume the lower 32 bits of the prefetch address are
still set to the same value, so through some means this info is not
being lost.


3. Any other suggestions, hints or experiments I could do to help move
forward on this issue?

My goal is to add a workaround to Linux (perhaps as a pci quirk) for
existing devices, but also we are in conversation with Asus engineers
and if we can come up with a concrete diagnosis, we should be able to
have them fix this at the BIOS level in future products.


Thanks
Daniel
