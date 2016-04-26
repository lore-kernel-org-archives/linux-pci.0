Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54183 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbcDZMrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 08:47:20 -0400
Date: Tue, 26 Apr 2016 13:47:20 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/3] drivers: pci: add generic code to claim bus
 resources
Message-ID: <20160426124720.GD2204@red-moon>
References: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1456843449-19393-2-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456843449-19393-2-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Replying to self]

On Tue, Mar 01, 2016 at 02:44:07PM +0000, Lorenzo Pieralisi wrote:
> From: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> 
> PCI core code contains a set of functions, eg:
> 
> pci_assign_unassigned_bus_resources()
> 
> that allow to assign the PCI resources for a given bus after
> enumeration.
> 
> On systems where the PCI BARs are immutable (ie they must not and can
> not be assigned), PCI bus resources should still be inserted in the PCI
> resources tree (even if they are not (re)-assigned), but there is
> no generic PCI kernel function for that purpose. Currently the PCI bus
> resources insertion in the resources tree is implemented in an arch
> specific fashion through arch specific callbacks that rely on the PCI
> resources claiming API (for bridges and devices) which resulted in arches
> implementations that contain duplicated code to claim resources for a
> given PCI bus hierarchy.
> 
> This patch, based on the x86/ia64 resources claiming arch implementations,
> implements a set of functions in core PCI code that provides a PCI core
> interface for resources claiming for a given PCI bus hierarchy, paving
> the way for further resource claiming consolidation across architectures.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
> ---
>  drivers/pci/setup-bus.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h     |  1 +
>  2 files changed, 69 insertions(+)

I have v3 ready, which does not change this patch, however I have
some questions below before asking to merge it.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7796d0a..95f0906 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1424,6 +1424,74 @@ void pci_bus_assign_resources(const struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_bus_assign_resources);
>  
> +static void pci_claim_device_resources(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
> +		struct resource *r = &dev->resource[i];
> +
> +		if (!r->flags || r->parent)
> +			continue;
> +
> +		pci_claim_resource(dev, i);

pci_claim_resource() (and in particular pci_find_parent_resource()) fails
if resource.start == 0x0. Is this intentional ? The resource.start == 0x0
check is used in other bits of the kernel to detect an "invalid"
resource, I am not sure I understand its implications correctly.

> +	}
> +}
> +
> +static void pci_claim_bridge_resources(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	for (i = PCI_BRIDGE_RESOURCES; i < PCI_NUM_RESOURCES; i++) {
> +		struct resource *r = &dev->resource[i];
> +
> +		if (!r->flags || r->parent)
> +			continue;
> +
> +		pci_claim_bridge_resource(dev, i);
> +	}
> +}
> +
> +static void pci_bus_allocate_dev_resources(struct pci_bus *b)
> +{
> +	struct pci_dev *dev;
> +	struct pci_bus *child;
> +
> +	list_for_each_entry(dev, &b->devices, bus_list) {
> +		pci_claim_device_resources(dev);
> +
> +		child = dev->subordinate;
> +		if (child)
> +			pci_bus_allocate_dev_resources(child);
> +	}
> +}
> +
> +static void pci_bus_allocate_resources(struct pci_bus *b)
> +{
> +	struct pci_bus *child;
> +
> +	/*
> +	 * Carry out a depth-first search on the PCI bus
> +	 * tree to allocate bridge apertures. Read the
> +	 * programmed bridge bases and recursively claim
> +	 * the respective bridge resources.
> +	 */
> +	if (b->self) {

Is it *always* correct to check b->self to detect a device backing
the PCI bridge ? All PCI bridges should have their ->self pointer
set-up correctly, I wanted to countercheck anyway.

Comments welcome, thanks.

Lorenzo

> +		pci_read_bridge_bases(b);
> +		pci_claim_bridge_resources(b->self);
> +	}
> +
> +	list_for_each_entry(child, &b->children, node)
> +		pci_bus_allocate_resources(child);
> +}
> +
> +void pci_bus_claim_resources(struct pci_bus *b)
> +{
> +	pci_bus_allocate_resources(b);
> +	pci_bus_allocate_dev_resources(b);
> +}
> +EXPORT_SYMBOL(pci_bus_claim_resources);
> +
>  static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
>  					  struct list_head *add_head,
>  					  struct list_head *fail_head)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2771625..e66eba7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1102,6 +1102,7 @@ ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void
>  /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */
>  resource_size_t pcibios_retrieve_fw_addr(struct pci_dev *dev, int idx);
>  void pci_bus_assign_resources(const struct pci_bus *bus);
> +void pci_bus_claim_resources(struct pci_bus *bus);
>  void pci_bus_size_bridges(struct pci_bus *bus);
>  int pci_claim_resource(struct pci_dev *, int);
>  int pci_claim_bridge_resource(struct pci_dev *bridge, int i);
> -- 
> 2.5.1
> 
