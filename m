Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:36296 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbeBBPLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Feb 2018 10:11:04 -0500
Date: Fri, 2 Feb 2018 17:11:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Stefan Roese <sr@denx.de>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: pciehp: Add module parameter to enable
 debouncing of HP link events
Message-ID: <20180202151100.GP27654@lahna.fi.intel.com>
References: <20180130084121.18653-1-sr@denx.de>
 <20180130102840.GF27654@lahna.fi.intel.com>
 <a91f095b-87d3-d1ab-7dea-e9a0bcfd9e01@denx.de>
 <20180202135659.GN27654@lahna.fi.intel.com>
 <15ddf930-66e2-fae8-09c7-1d1ad7d5b07a@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15ddf930-66e2-fae8-09c7-1d1ad7d5b07a@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 02, 2018 at 03:50:55PM +0100, Stefan Roese wrote:
> I've already sent a patch regarding a libata problem while unplugging
> an AHCI controller:
> 
> https://www.spinics.net/lists/linux-ide/msg55038.html

Great :)

> > BTW, have you checked whether presence detect actually toggles similarly
> > or is it only triggered when the link is fully up? Since currently we
> > prioritize link up/down higher than presence detect but it may be that
> > we should do the opposite.
> 
> As seen in the log sent in my previous mail, presence detect also
> toggles. Here again:
> 
> [   41.260667] pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> [   41.260731] pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> [   41.290650] pciehp 0000:00:1c.1:pcie004: Slot(1): Link Down
> [   41.295837] pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> [   41.320664] pciehp 0000:00:1c.1:pcie004: Slot(1): Card not present
> [   41.330042] pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> [   41.330110] pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> [   41.375950] pci 0000:02:00.0: [1b4b:9215] type 00 class 0x010601
> ...

Indeed, it seems to follow link status changes closely. So changing the
"priority" here would not help.
