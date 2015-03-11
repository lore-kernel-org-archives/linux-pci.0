Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:38275 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbCKCv2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 22:51:28 -0400
Received: by oiax69 with SMTP id x69so5416590oia.5
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 19:51:28 -0700 (PDT)
Date: Tue, 10 Mar 2015 21:51:25 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 15/21] powerpc/powernv: Reserve additional space for
 IOV BAR according to the number of total_pe
Message-ID: <20150311025125.GC10994@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083442.32124.96716.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224085234.GJ6220@google.com>
 <20150302074132.GG21571@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302074132.GG21571@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 02, 2015 at 03:41:32PM +0800, Wei Yang wrote:
> On Tue, Feb 24, 2015 at 02:52:34AM -0600, Bjorn Helgaas wrote:
> >On Tue, Feb 24, 2015 at 02:34:42AM -0600, Bjorn Helgaas wrote:
> >> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> 
> >> On PHB3, PF IOV BAR will be covered by M64 window to have better PE
> >> isolation.  The total_pe number is usually different from total_VFs, which
> >> can lead to a conflict between MMIO space and the PE number.
> >> 
> >> For example, if total_VFs is 128 and total_pe is 256, the second half of
> >> M64 window will be part of other PCI device, which may already belong
> >> to other PEs.
> >
> >I'm still trying to wrap my mind around the explanation here.
> >
> >I *think* what's going on is that the M64 window must be a power-of-two
> >size.  If the VF(n) BAR space doesn't completely fill it, we might allocate
> >the leftover space to another device.  Then the M64 window for *this*
> >device may cause the other device to be associated with a PE it didn't
> >expect.
> 
> Yes, this is the exact reason.

Can you include some of this text in your changelog, then?  I can wordsmith
it and try to make it fit together better.

> >> +#ifdef CONFIG_PCI_IOV
> >> +static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
> >> +{
> >> +	struct pci_controller *hose;
> >> +	struct pnv_phb *phb;
> >> +	struct resource *res;
> >> +	int i;
> >> +	resource_size_t size;
> >> +	struct pci_dn *pdn;
> >> +
> >> +	if (!pdev->is_physfn || pdev->is_added)
> >> +		return;
> >> +
> >> +	hose = pci_bus_to_host(pdev->bus);
> >> +	phb = hose->private_data;
> >> +
> >> +	pdn = pci_get_pdn(pdev);
> >> +	pdn->max_vfs = 0;
> >> +
> >> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >> +		res = &pdev->resource[i + PCI_IOV_RESOURCES];
> >> +		if (!res->flags || res->parent)
> >> +			continue;
> >> +		if (!pnv_pci_is_mem_pref_64(res->flags)) {
> >> +			dev_warn(&pdev->dev, "Skipping expanding VF BAR%d: %pR\n",
> >> +				 i, res);
> >> +			continue;
> >> +		}
> >> +
> >> +		dev_dbg(&pdev->dev, " Fixing VF BAR%d: %pR to\n", i, res);
> >> +		size = pci_iov_resource_size(pdev, i + PCI_IOV_RESOURCES);
> >> +		res->end = res->start + size * phb->ioda.total_pe - 1;
> >> +		dev_dbg(&pdev->dev, "                       %pR\n", res);
> >> +		dev_info(&pdev->dev, "VF BAR%d: %pR (expanded to %d VFs for PE alignment)",
> >> +				i, res, phb->ioda.total_pe);
> >> +	}
> >> +	pdn->max_vfs = phb->ioda.total_pe;
> >> +}
> >> +
> >> +static void pnv_pci_ioda_fixup_sriov(struct pci_bus *bus)
> >> +{
> >> +	struct pci_dev *pdev;
> >> +	struct pci_bus *b;
> >> +
> >> +	list_for_each_entry(pdev, &bus->devices, bus_list) {
> >> +		b = pdev->subordinate;
> >> +
> >> +		if (b)
> >> +			pnv_pci_ioda_fixup_sriov(b);
> >> +
> >> +		pnv_pci_ioda_fixup_iov_resources(pdev);
> >
> >I'm not sure this happens at the right time.  We have this call chain:
> >
> >  pcibios_scan_phb
> >    pci_create_root_bus
> >    pci_scan_child_bus
> >    pnv_pci_ioda_fixup_sriov
> >      pnv_pci_ioda_fixup_iov_resources
> >	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
> >	  increase res->size to accomodate 256 PEs (or roundup(totalVFs)
> >
> >so we only do the fixup_iov_resources() when we scan the PHB, and we
> >wouldn't do it at all for hot-added devices.
> 
> Yep, you are right :-)
> 
> I had a separate patch to do this in pcibios_add_pci_devices(). Looks we could
> merge them.

Did you fix this in v13?  I don't see the change if you did.

> >> +	}
> >> +}
> >> +#endif /* CONFIG_PCI_IOV */
> >> +
> >>  /*
> >>   * This function is supposed to be called on basis of PE from top
> >>   * to bottom style. So the the I/O or MMIO segment assigned to
> >> @@ -2125,6 +2180,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
> >>  	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
> >>  	ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
> >>  	ppc_md.pcibios_reset_secondary_bus = pnv_pci_reset_secondary_bus;
> >> +#ifdef CONFIG_PCI_IOV
> >> +	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_sriov;
> >> +#endif /* CONFIG_PCI_IOV */
> >>  	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
> >>  
> >>  	/* Reset IODA tables to a clean state */
> >> 
> 
> -- 
> Richard Yang
> Help you, Help me
> 
