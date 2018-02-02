Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:54267 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBBNye (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Feb 2018 08:54:34 -0500
Date: Fri, 2 Feb 2018 14:47:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Roese <sr@denx.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH] PCI: pciehp: Add module parameter to enable
 debouncing of HP link events
Message-ID: <20180202134710.GA24377@wunner.de>
References: <20180130084121.18653-1-sr@denx.de>
 <20180130102840.GF27654@lahna.fi.intel.com>
 <a91f095b-87d3-d1ab-7dea-e9a0bcfd9e01@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a91f095b-87d3-d1ab-7dea-e9a0bcfd9e01@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 02, 2018 at 02:38:34PM +0100, Stefan Roese wrote:
> > On Tue, Jan 30, 2018 at 09:41:21AM +0100, Stefan Roese wrote:
> >> Hotplugging of some PCIe devices on our platform sometimes leads to a
> >> bounce of link-up and link-down events, resulting in problems in the
> >> corresponding PCI drivers.
> >>
> >> Here an example of such a hotplug event bounce for a AHCI PCIe card:
> >> ...
> >> pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> >> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> >> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up event ignored; already powering on
> >> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Down
> >> pciehp 0000:00:1c.1:pcie004: Slot(1): Card present
> >> pciehp 0000:00:1c.1:pcie004: Slot(1): Link Up
> 
> I'm open for other / better ideas on how to solve this situation, we
> are seeing on our systems.

If a Link Up event is received and there is already a Link Up / Link Down
pair in the queue, the Link Down event can be dequeued and the newly
received Link Up event need not be queued.

Same if a Link Down event is received and there is already a Link Down /
Link Up pair in the queue.

Thanks,

Lukas
