Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753419AbeCUTa4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Mar 2018 15:30:56 -0400
Date: Wed, 21 Mar 2018 14:30:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: rockchip: Create individual folder for
 rockchip drivers
Message-ID: <20180321193053.GB38649@bhelgaas-glaptop.roam.corp.google.com>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
 <1520304202-232891-1-git-send-email-shawn.lin@rock-chips.com>
 <20180320174633.GA137590@bhelgaas-glaptop.roam.corp.google.com>
 <879a4862-d0d5-21fd-6c47-029c795fe78e@rock-chips.com>
 <20180321181940.GA9760@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180321181940.GA9760@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 21, 2018 at 06:19:40PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Mar 21, 2018 at 09:04:21AM +0800, Shawn Lin wrote:
> > On 2018/3/21 1:46, Bjorn Helgaas wrote:
> > >On Tue, Mar 06, 2018 at 10:43:22AM +0800, Shawn Lin wrote:
> > >>In preparation for introducing End-Point driver for Rockchip
> > >>PCIe controller, we create a new folder to follow the convention
> > >>of dwc and cadence. Then we rename the host driver from pcie-rockchip.c
> > >>to pcie-rockchip-host.c, and only leave some common functions in
> > >>pcie-rockchip.c in order to be reused for both of host and EP drivers.

> > >I admit to still being a little dubious about the idea of a bunch of
> > >vendor-specific directories, each containing a completely trivial
> > >Makefile, a mostly-trivial Kconfig, a header file, a shared .c file, a
> > >host .c file, and an endpoint .c file.
> > 
> > So do I.
> > 
> > >One alternative would be to keep the single pcie-rockchip.c file with
> > >an #ifdef CONFIG_PCIE_ROCKCHIP_HOST section and an #ifdef
> > >CONFIG_PCIE_ROCKCHIP_EP section.
> > 
> > I admit I thought this eariler, however, I don't like it personally, as
> > it confuses the new-comer to follow the convention here, if we are
> > alternatives just for "style issue" or "personal taste".
> 
> It would be OK for me to keep files separate too; ...

Here's what's irritating for me: I go to look for something in pciehp,
but I don't know the exact name, so I fire up cscope and look for
files matching "pciehp".  It finds 5 (a header and 4 .c files).  I
pick one of the 4 randomly, and my guess is invariably wrong.  I
usually have to pull up all 4 files before I find what I'm looking
for.

So as a code browser, it's much easier if all the pciehp-related (or
rockchip-) code is in one file.

Even if it were obvious which file to look in, it ends up requiring
multiple windows to follow paths through the code.  There's
unnecessary redundancy because the .h file contains declarations that
have to match the definition.  Symbols should be static but cannot be
because they're referenced from other files.

It's a similar hassle to read the code in portdrv, aerdrv, and all the
hotplug drivers.  My secret agenda is to squash all those files
together into a single file per driver.  I bet the code size would
drop by 25% at the same time.

Okay, rant over :)  You and Lorenzo can agree on something and just do
it, and I'll be happy with whatever you decide.

Bjorn
