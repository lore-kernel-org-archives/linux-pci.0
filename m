Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:36379 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757765AbdACKWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2017 05:22:23 -0500
Date: Tue, 3 Jan 2017 11:23:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Chris Murphy <lists@colorremedies.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: Thunderbolt adapter fails to instantiate USB and device
 enumeration if already connected at boot time
Message-ID: <20170103102300.GA20751@wunner.de>
References: <CAJCQCtS5gQObZr1j0stEnx9+U890_N-2FBFx_fZCZtmD8-2qJQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1701021626410.28032-100000@netrider.rowland.org>
 <CAJCQCtTGYUFCvwPzugJ4TUtFPGKTy7r+HJr_1o8s=cbASa4zUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJCQCtTGYUFCvwPzugJ4TUtFPGKTy7r+HJr_1o8s=cbASa4zUA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 02, 2017 at 02:45:00PM -0700, Chris Murphy wrote:
> On Mon, Jan 2, 2017 at 2:28 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Considering that the failed boot log contains no USB messages at all,
> > and no messages referring to PCI bus 0000:37 (the bus associated with
> > the adapter), this certainly looks like a PCI problem.
> 
> I see these lines in the problem case, which don't occur in the working case.
> 
> [    0.561046] pci_bus 0000:37: busn_res: [bus 37-ff] end is updated to 37
> [    0.561047] pci_bus 0000:37: busn_res: can not insert [bus 37]
> under domain [bus 00-ff] (conflicts with (null) [bus 00-fe])

In the "failure dmesg" (with the adapter plugged in on boot), bus 37 is
considered a root bus:

[    0.560662] PCI: Discovered peer bus 37
[    0.560667] PCI: root bus 37: using default resources
[    0.560668] PCI: Probing PCI hardware (bus 37)
[    0.560695] ACPI: \: failed to evaluate _DSM (0x1001)
[    0.560698] PCI host bridge to bus 0000:37

Whereas in the "normal behaviour" dmesg (with the adapter plugged in
after booting Linux), bus 37 is below downstream port 0000:02:02.0
(this belongs to the PCIe switch of the Thunderbolt controller):

[   59.247680] pci 0000:02:02.0: scanning [bus 37-37] behind bridge, pass 0
[   59.247915] pci_bus 0000:37: scanning bus
[   59.247963] pci 0000:37:00.0: [8086:15b6] type 00 class 0x0c0330
[   59.248014] pci 0000:37:00.0: reg 0x10: [mem 0xc7f00000-0xc7f0ffff]
[   59.248360] pci 0000:37:00.0: supports D1 D2
[   59.248366] pci 0000:37:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[   59.248379] pci 0000:37:00.0: PME# disabled
[   59.248951] pci_bus 0000:37: fixups for bus
[   59.248959] pci 0000:02:02.0: PCI bridge to [bus 37]
[   59.249117] pci 0000:02:02.0:   bridge window [mem 0xc7f00000-0xc7ffffff]
[   59.249135] pci_bus 0000:37: bus scan returning with max=37

Could be an error in the ACPI tables, could be a misconfiguration in
the EEPROM of the Thunderbolt controller.

Thanks,

Lukas
