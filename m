Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933434AbdEVM73 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 May 2017 08:59:29 -0400
Date: Mon, 22 May 2017 14:00:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Timmy Li <lixiaoping3@huawei.com>
Cc: bhelgaas@google.com, tn@semihalf.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        gabriele.paoloni@huawei.com
Subject: Re: [PATCH] arm64: PCI: free all allocated memory in case of failure
Message-ID: <20170522130028.GC10449@red-moon>
References: <20170512095747.744688-1-lixiaoping3@huawei.com>
 <20170512102825.GA10929@red-moon>
 <84e06412-9aa9-3fe5-d727-036d62114c27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84e06412-9aa9-3fe5-d727-036d62114c27@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 22, 2017 at 08:32:09PM +0800, Timmy Li wrote:
> Hi Lorenzo,
> 
> Thanks for your review and sorry for the late reply.
> 
> On 2017/5/12 18:28, Lorenzo Pieralisi wrote:
> > On Fri, May 12, 2017 at 05:57:47PM +0800, Timmy Li wrote:
> >> There are some memory allocations in pci_acpi_scan_root(). But
> >> ri, root_ops and ri->cfg are not freed properly in failure cases,
> >> which results in memory leaks. This patch fixes the potential
> >> memory leaks.
> >>
> >> Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
> >> ---
> >>  arch/arm64/kernel/pci.c | 22 ++++++++++++++--------
> >>  1 file changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> >> index 4f0e3eb..e7e88ce 100644
> >> --- a/arch/arm64/kernel/pci.c
> >> +++ b/arch/arm64/kernel/pci.c
> >> @@ -188,25 +188,22 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >>  
> >>  	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
> >>  	if (!ri)
> >> -		return NULL;
> >> +		goto err_allocri;
> >>  
> >>  	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
> >>  	if (!root_ops)
> >> -		return NULL;
> >> +		goto err_allocops;
> 
> I think it is still needed to free ri here When ri is allocated
> successfully and root_ops is not. Considering this is the only remain
> place that need to fix, a simple way to do this would be:
> if (!root_ops) {
> +	kfree(ri);
> 	return NULL;
> }

Ok, I will send a fix for that, thanks.

Lorenzo

> 
> >>  
> >>  	ri->cfg = pci_acpi_setup_ecam_mapping(root);
> >> -	if (!ri->cfg) {
> >> -		kfree(ri);
> >> -		kfree(root_ops);
> >> -		return NULL;
> >> -	}
> >> +	if (!ri->cfg)
> >> +		goto err_ecam;
> >>  
> >>  	root_ops->release_info = pci_acpi_generic_release_info;
> > 
> > You are missing this ^^^^^^^^^
> > 
> >>  	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> >>  	root_ops->pci_ops = &ri->cfg->ops->pci_ops;
> >>  	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> >>  	if (!bus)
> > 
> > And how it works if (bus == NULL) here.
> 
> You are correct. There is no need to do anything When acpi_pci_root_create() fails.
> 
> > 
> > Lorenzo
> > 
> >> -		return NULL;
> >> +		goto err_rootcreate;
> >>  
> >>  	pci_bus_size_bridges(bus);
> >>  	pci_bus_assign_resources(bus);
> >> @@ -215,6 +212,15 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >>  		pcie_bus_configure_settings(child);
> >>  
> >>  	return bus;
> >> +
> >> +err_rootcreate:
> >> +	pci_ecam_free(ri->cfg);
> >> +err_ecam:
> >> +	kfree(root_ops);
> >> +err_allocops:
> >> +	kfree(ri);
> >> +err_allocri:
> >> +	return NULL;
> >>  }
> >>  
> >>  void pcibios_add_bus(struct pci_bus *bus)
> >> -- 
> >> 1.9.1
> >>
> >>
> > 
> > .
> > 
> 
