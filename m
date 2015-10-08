Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45298 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbbJHNUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Oct 2015 09:20:14 -0400
Date: Thu, 8 Oct 2015 08:20:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [Patch v6 4/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
Message-ID: <20151008132010.GI27633@localhost>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
 <1442218057-4355-5-git-send-email-jiang.liu@linux.intel.com>
 <20151006174725.GA29420@localhost>
 <5615FFD4.3090202@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5615FFD4.3090202@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 08, 2015 at 01:32:04PM +0800, Jiang Liu wrote:
> On 2015/10/7 1:47, Bjorn Helgaas wrote:
> >> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >> +				     struct acpi_pci_root_ops *ops,
> >> +				     struct acpi_pci_root_info *info,
> >> +				     void *sysdata)
> >> +{
> >> +	int ret, busnum = root->secondary.start;
> >> +	struct acpi_device *device = root->device;
> >> +	int node = acpi_get_node(device->handle);
> >> +	struct pci_bus *bus;
> >> +
> >> +	info->root = root;
> >> +	info->bridge = device;
> >> +	info->ops = ops;
> >> +	INIT_LIST_HEAD(&info->resources);
> >> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
> >> +		 root->segment, busnum);
> >> +
> >> +	if (ops->init_info && ops->init_info(info))
> >> +		goto out_release_info;
> >> +	ret = acpi_pci_probe_root_resources(info);
> >> +	if (ops->prepare_resources)
> >> +		ret = ops->prepare_resources(info, ret);
> >> +	if (ret < 0)
> >> +		goto out_release_info;
> >> +	else if (ret > 0)
> >> +		pci_acpi_root_add_resources(info);
> > 
> > This is unnecessarily complicated: you set "ret", then overwrite it if
> > ops->prepare_resources.  By the time you test "ret", it's messy to
> > figure out what it means.
> > 
> > Both ops->prepare_resources() and pci_acpi_root_add_resources()
> > should be able to deal with empty resource lists, so can you do the
> > following instead?
> > 
> >     ret = acpi_pci_probe_root_resources(info);
> >     if (ret < 0)
> >         goto out_release_info;
>
> 	The original code is used to handle a special case for x86,
> where acpi_pci_probe_root_resources() fails but ops->prepare_resources()
> succeeds. For x86, PCI host bridge resources may probed by means
> other than ACPI when pci_use_crs is true (AMD and Broadcom hostbridges).
> So we can't return failure when acpi_pci_probe_root_resources() fails.

That's even worse than I thought.  I take back my ack; I think this
really needs to be restructured so it does the right thing *and* reads
clearly.  Having convoluted generic code to deal with an arch-specific
special case is a recipe for breakage in the future.

Maybe you can move the non-ACPI resource probing from
prepare_resources() into acpi_pci_probe_root_resources() (you could
rename it to something more generic if that helps).

> +	ret = acpi_pci_probe_root_resources(info);
> +	if (ops->prepare_resources)
> +		ret = ops->prepare_resources(info, ret);
> +	if (ret < 0)
> +		goto out_release_info;
> 
> >     if (ops->prepare_resources) {
> >         ret = ops->prepare_resources(info, ret);
> >         if (ret < 0)
> >             goto out_release_info;
> >     }
> >     pci_acpi_root_add_resources(info);
> I will remove the redundant check of (ret > 0) in:
> +	else if (ret > 0)
> +		pci_acpi_root_add_resources(info);
