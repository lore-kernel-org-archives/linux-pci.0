Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbeBLPBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 10:01:52 -0500
Date: Mon, 12 Feb 2018 09:01:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        linux-kernel@vger.kernel.org,
        MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCI/portdrv: Remove "pcie_hp=nomsi" kernel parameter
Message-ID: <20180212150146.GA75542@bhelgaas-glaptop.roam.corp.google.com>
References: <20180211024815.73781.92853.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180211092525.GA1085@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180211092525.GA1085@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 11, 2018 at 10:25:25AM +0100, Lukas Wunner wrote:
> On Sat, Feb 10, 2018 at 08:48:15PM -0600, Bjorn Helgaas wrote:
> > 7570a333d8b0 ("PCI: Add pcie_hp=nomsi to disable MSI/MSI-X for pciehp
> > driver") added the "pcie_hp=nomsi" kernel parameter to work around this
> > error on shutdown:
> > 
> >   irq 16: nobody cared (try booting with the "irqpoll" option)
> >   Pid: 1081, comm: reboot Not tainted 3.2.0 #1
> >   ...
> >   Disabling IRQ #16
> > 
> > This happened on an unspecified system (possibly involving the Integrated
> > Device Technology, Inc. Device 807f bridge).  There is no automated way to
> > set this parameter, so it's not very useful for distributions or end users.
> > 
> > I suspect the root cause of the underlying "irq 16: nobody cared" issue was
> > fixed by Prarit Bhargava <prarit@redhat.com> with fda78d7a0ead ("PCI/MSI:
> > Stop disabling MSI/MSI-X in pci_device_shutdown()") and we probably don't
> > need "pcie_hp=nomsi" any more.
> > 
> > Revert 7570a333d8b0 to remove the "pcie_hp=nomsi" parameter.
> 
> This has been useful when bringing up broken hardware which claims to
> support MSI but really doesn't, such as in commit 19bf4d4f909d
> ("thunderbolt: Support 1st gen Light Ridge controller").  In this case
> I didn't know why the controller wasn't sending interrupts, on a hunch
> I tried "pcie_hp=nomsi" and that worked, and looking in the macOS source
> code I was able to verify that they disable MSI for this particular
> hardware as well.  So please leave it in to ease developers' lives.

Wouldn't "pci=nomsi" be sufficient for that sort of bringup
experimentation?  We don't need to be super specific in that
situation.

The reason I want to remove it is that the port driver
(drivers/pci/pcie/portdrv*) has become a rat's nest of switches and
special cases, and I'm trying to simplify it.  Things like
"pcie_hp=nomsi" are trivial individually, but collectively it's
getting unmanageable.

Bjorn
