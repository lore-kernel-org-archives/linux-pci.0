Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34499 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933103AbbELNef (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 09:34:35 -0400
Received: by iecmd7 with SMTP id md7so617799iec.1
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2015 06:34:35 -0700 (PDT)
Date: Tue, 12 May 2015 08:34:31 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
Message-ID: <20150512133431.GA2898@google.com>
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
 <20150505155346.GJ1550@arm.com>
 <20150506141859.GC26028@red-moon>
 <CAErSpo7z_Sf5QvMa8MBY0f7DQOmwhcpUnCFG=ZsmHuwT2HouQw@mail.gmail.com>
 <554ADCE0.8020603@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <554ADCE0.8020603@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 10:32:48PM -0500, Suravee Suthikulanit wrote:
> ...
> I tested this patch series on the AMD Seattle w/o PCI_PROBE_ONLY
> mode and that works fine. However, w/ PCI_PROBE_ONLY, I also run
> into the resource not claimed issue (no surprise here).
> 
> So, I tried porting the pcibios_claim_one_bus() from
> arch/alpha/kernel/pci.c as Lorenzo suggested, plus the a small
> change in pci_claim_resource(), and it seems to work w/
> PCI_PROBE_ONLY. (Please see example patch below.)
> 
> The additional while loop is needed in the pci_claim_resource()
> since I need to reference back to the resource in the root bus,
> which are defined from the DT node. Does this sounds like a
> reasonable approach?
> 
> diff --git a/drivers/pci/host/pci-host-generic.c
> b/drivers/pci/host/pci-host-generic.c
> index e9cc559..0dfa23d 100644
> --- a/drivers/pci/host/pci-host-generic.c
> +++ b/drivers/pci/host/pci-host-generic.c
> @@ -261,7 +261,10 @@ static int gen_pci_probe(struct platform_device *pdev)
>  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
>  		pci_bus_size_bridges(bus);
>  		pci_bus_assign_resources(bus);
> +	} else {
> +		pci_claim_one_bus(bus);
>  	}
> +
>  	pci_bus_add_devices(bus);
> 
>  	/* Configure PCI Express settings */
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 232f925..d4b43b3 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -109,6 +109,7 @@ int pci_claim_resource(struct pci_dev *dev, int
> resource)
>  {
>  	struct resource *res = &dev->resource[resource];
>  	struct resource *root, *conflict;
> +	struct pci_dev *pdev = dev;
> 
>  	if (res->flags & IORESOURCE_UNSET) {
>  		dev_info(&dev->dev, "can't claim BAR %d %pR: no address assigned\n",
> @@ -116,7 +117,18 @@ int pci_claim_resource(struct pci_dev *dev, int
> resource)
>  		return -EINVAL;
>  	}
> 
> -	root = pci_find_parent_resource(dev, res);
> +	while (pdev) {
> +		root = pci_find_parent_resource(pdev, res);
> +		if (root)
> +			break;
> +
> +		if (pci_has_flag(PCI_PROBE_ONLY) &&
> +		    !pci_is_root_bus(pdev->bus))
> +			pdev = pdev->bus->self;
> +		else
> +			break;
> +	}

I don't understand this new loop.  Apparently you have a device BAR, and
the upstream bridge doesn't have a window that contains the BAR?  That
sounds like a problem with the upstream bridge resources.

Do you have an example that would make this more concrete, e.g., a host
bridge, P2P bridge(s), and endpoint with their resources?

> +
>  	if (!root) {
>  		dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible bridge
> window\n",
>  			 resource, res);
> @@ -136,6 +148,36 @@ int pci_claim_resource(struct pci_dev *dev, int
> resource)
>  }
>  EXPORT_SYMBOL(pci_claim_resource);
> 
> +void pci_claim_one_bus(struct pci_bus *b)
> +{
> +	struct pci_dev *pdev;
> +	struct pci_bus *child_bus;
> +
> +	list_for_each_entry(pdev, &b->devices, bus_list) {
> +		int i;
> +
> +		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +			struct resource *r = &pdev->resource[i];
> +
> +			if (r->parent || !r->start || !r->flags)
> +				continue;
> +
> +			if (pci_has_flag(PCI_PROBE_ONLY) ||
> +			    (r->flags & IORESOURCE_PCI_FIXED)) {
> +				if (pci_claim_resource(pdev, i) == 0)
> +					continue;
> +
> +				pci_claim_bridge_resource(pdev, i);
> +			}
> +		}
> +	}
> +
> +	list_for_each_entry(child_bus, &b->children, node) {
> +		pci_claim_one_bus(child_bus);
> +	}
> +}
> +EXPORT_SYMBOL(pci_claim_one_bus);

I'm not a fan of pci_claim_one_bus(), on the philosophical grounds that
claiming resources is a per-device thing, and I don't want to encourage
people to do it on a per-bus level.

I'd rather claim them somewhere in the pci_device_add() path, as s390 does
in pcibios_add_device().  In fact, I'd *like* to do it even earlier, when
we read each BAR, so we could identify invalid or unassigned BARs
immediately.

> +
>  void pci_disable_bridge_window(struct pci_dev *dev)
>  {
>  	dev_info(&dev->dev, "disabling bridge mem windows\n");
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 353db8d..b59ad4b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1085,6 +1085,7 @@ void
> pci_assign_unassigned_bridge_resources(struct pci_dev *bridge);
>  void pci_assign_unassigned_bus_resources(struct pci_bus *bus);
>  void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus);
>  void pdev_enable_device(struct pci_dev *);
> +void pci_claim_one_bus(struct pci_bus *b);
>  int pci_enable_resources(struct pci_dev *, int mask);
>  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
>  		    int (*)(const struct pci_dev *, u8, u8));
> -------- END PATCH ----
> 
> Thanks,
> 
> Suravee
> 
