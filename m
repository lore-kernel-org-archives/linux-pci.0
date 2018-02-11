Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:47133 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbeBKJXy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Feb 2018 04:23:54 -0500
Date: Sun, 11 Feb 2018 10:25:25 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        linux-kernel@vger.kernel.org,
        MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCI/portdrv: Remove "pcie_hp=nomsi" kernel parameter
Message-ID: <20180211092525.GA1085@wunner.de>
References: <20180211024815.73781.92853.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180211024815.73781.92853.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 10, 2018 at 08:48:15PM -0600, Bjorn Helgaas wrote:
> 7570a333d8b0 ("PCI: Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
> driver") added the "pcie_hp=nomsi" kernel parameter to work around this
> error on shutdown:
> 
>   irq 16: nobody cared (try booting with the "irqpoll" option)
>   Pid: 1081, comm: reboot Not tainted 3.2.0 #1
>   ...
>   Disabling IRQ #16
> 
> This happened on an unspecified system (possibly involving the Integrated
> Device Technology, Inc. Device 807f bridge).  There is no automated way to
> set this parameter, so it's not very useful for distributions or end users.
> 
> I suspect the root cause of the underlying "irq 16: nobody cared" issue was
> fixed by Prarit Bhargava <prarit@redhat.com> with fda78d7a0ead ("PCI/MSI:
> Stop disabling MSI/MSI-X in pci_device_shutdown()") and we probably don't
> need "pcie_hp=nomsi" any more.
> 
> Revert 7570a333d8b0 to remove the "pcie_hp=nomsi" parameter.

This has been useful when bringing up broken hardware which claims to
support MSI but really doesn't, such as in commit 19bf4d4f909d
("thunderbolt: Support 1st gen Light Ridge controller").  In this case
I didn't know why the controller wasn't sending interrupts, on a hunch
I tried "pcie_hp=nomsi" and that worked, and looking in the macOS source
code I was able to verify that they disable MSI for this particular
hardware as well.  So please leave it in to ease developers' lives.

Thanks,

Lukas
