Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55942 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161183AbcFMU27 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 16:28:59 -0400
Date: Mon, 13 Jun 2016 15:28:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Engraf <david.engraf@sysgo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix __pci_bus_size_bridges when bridge is not
 available
Message-ID: <20160613202855.GB14934@localhost>
References: <5734293A.6040702@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5734293A.6040702@sysgo.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 12, 2016 at 08:56:58AM +0200, David Engraf wrote:
> A virtual PCI controller may not have a bridge device, thus when
> __pci_bus_size_bridges is called, it will generate a NULL pointer
> exception when accessing bus->self->class. The attached patch adds a
> check to verify if a bridge has been set. Without a bridge device,
> the function returns.
> 
> Signed-off-by: David Engraf <david.engraf <at> sysgo.com>
> 

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 55641a3..ddb3381 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1245,6 +1245,10 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  	if (pci_is_root_bus(bus))
>  		return;
>  
> +	/* bridge device available? */
> +	if (!bus->self)
> +		return;

I'd like to see the code that relies on this, i.e., the virtual PCI
controller driver.

I don't know how we would handle resource assignment if there's no bridge.
When we assign resources to a device, we normally look at the upstream
bridge to see what resources are available.

Here's an example from my laptop:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
  pci_bus 0000:00: root bus resource [mem 0xbf200000-0xdfffffff window]
  pci 0000:00:1c.3: PCI bridge to [bus 02]
  pci 0000:00:1c.3:   bridge window [mem 0xd0500000-0xd05fffff]
  pci 0000:02:00.0: reg 0x10: [mem 0xd0500000-0xd0501fff 64bit]

PCI0 is the host bridge, and it forwards transactions in the range
[mem 0xbf200000-0xdfffffff] to PCI bus 00.  The 00:1c.3 bridge
forwards transactions in the range [mem 0xd0500000-0xd05fffff] from
bus 00 to bus 02.  So if we want to assign resources to the BARs of
02:00.0, we have to take them from the 00:1c.3 window.

In your virtual PCI controller situation, it sounds like you could
have a device like 02:00.0 that is not on a root bus and does not have
an upstream bridge.  How would we assign resources to it?

>  	switch (bus->self->class >> 8) {
>  	case PCI_CLASS_BRIDGE_CARDBUS:
>  		/* don't size cardbuses yet. */

