Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752558AbeBBTVC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Feb 2018 14:21:02 -0500
Date: Fri, 2 Feb 2018 13:20:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: pciehp: Add module parameter to enable
 debouncing of HP link events
Message-ID: <20180202192045.GA53759@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130084121.18653-1-sr@denx.de>
 <20180130102840.GF27654@lahna.fi.intel.com>
 <a91f095b-87d3-d1ab-7dea-e9a0bcfd9e01@denx.de>
 <20180202134710.GA24377@wunner.de>
 <fc56ecd5-7465-872b-48d7-c7eaf0dd779a@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fc56ecd5-7465-872b-48d7-c7eaf0dd779a@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 02, 2018 at 03:44:21PM +0100, Stefan Roese wrote:
> On 02.02.2018 14:47, Lukas Wunner wrote:
> >On Fri, Feb 02, 2018 at 02:38:34PM +0100, Stefan Roese wrote:
> >>>On Tue, Jan 30, 2018 at 09:41:21AM +0100, Stefan Roese wrote:
> >>>>Hotplugging of some PCIe devices on our platform sometimes leads to a
> >>>>bounce of link-up and link-down events, resulting in problems in the
> >>>>corresponding PCI drivers.
> >>>>
> >>>>Here an example of such a hotplug event bounce for a AHCI PCIe card:
> >>>>...
> >>>>pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> >>>>pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> >>>>pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
> >>>>pciehp 0000:00:1c.1:pcie004: Slot(1): Link Down
> >>>>pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> >>>>pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> >>
> >>I'm open for other / better ideas on how to solve this situation, we
> >>are seeing on our systems.

This is definitely a real problem that should be fixed somehow.

But I don't like the idea of a new module parameter because it's not
very user-friendly.  It would be very difficult for a user to identify
the problem, discover the parameter, and figure out what debounce time
to use.

> >If a Link Up event is received and there is already a Link Up / Link Down
> >pair in the queue, the Link Down event can be dequeued and the newly
> >received Link Up event need not be queued.
> >
> >Same if a Link Down event is received and there is already a Link Down /
> >Link Up pair in the queue.
> 
> Makes sense. But I'm more often seeing this sequence here while
> hot-plugging the PCIe card:
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
> 
> So a link-down is following the link-up directly (~30ms here). Sometimes
> a double link-up is also seen. But this one is more frequent in my test
> cases.

Unfortunately I don't have any easy ideas to offer.  I do think the
pciehp interrupt handling is baroque and I suspect that if we could
simplify and rationalize it, some of these issues would take care of
themselves.

Bjorn
