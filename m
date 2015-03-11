Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:40102 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbCKCzX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 22:55:23 -0400
Received: by oiav63 with SMTP id v63so2118393oia.7
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 19:55:22 -0700 (PDT)
Date: Tue, 10 Mar 2015 21:55:19 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 17/21] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150311025519.GD10994@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083457.32124.55534.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224090037.GK6220@google.com>
 <20150304030051.GA10797@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150304030051.GA10797@richard>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 04, 2015 at 11:01:24AM +0800, Wei Yang wrote:
> On Tue, Feb 24, 2015 at 03:00:37AM -0600, Bjorn Helgaas wrote:
> >On Tue, Feb 24, 2015 at 02:34:57AM -0600, Bjorn Helgaas wrote:
> >> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> 
> >> On PowerNV platform, resource position in M64 implies the PE# the resource
> >> belongs to.  In some cases, adjustment of a resource is necessary to locate
> >> it to a correct position in M64.
> >> 
> >> Add pnv_pci_vf_resource_shift() to shift the 'real' PF IOV BAR address
> >> according to an offset.
> >> 
> >> [bhelgaas: rework loops, rework overlap check, index resource[]
> >> conventionally, remove pci_regs.h include, squashed with next patch]
> >> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> >> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> >...
> >
> >> +#ifdef CONFIG_PCI_IOV
> >> +static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> >> +{
> >> +	struct pci_dn *pdn = pci_get_pdn(dev);
> >> +	int i;
> >> +	struct resource *res, res2;
> >> +	resource_size_t size;
> >> +	u16 vf_num;
> >> +
> >> +	if (!dev->is_physfn)
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * "offset" is in VFs.  The M64 windows are sized so that when they
> >> +	 * are segmented, each segment is the same size as the IOV BAR.
> >> +	 * Each segment is in a separate PE, and the high order bits of the
> >> +	 * address are the PE number.  Therefore, each VF's BAR is in a
> >> +	 * separate PE, and changing the IOV BAR start address changes the
> >> +	 * range of PEs the VFs are in.
> >> +	 */
> >> +	vf_num = pdn->vf_pes;
> >> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >> +		res = &dev->resource[i + PCI_IOV_RESOURCES];
> >> +		if (!res->flags || !res->parent)
> >> +			continue;
> >> +
> >> +		if (!pnv_pci_is_mem_pref_64(res->flags))
> >> +			continue;
> >> +
> >> +		/*
> >> +		 * The actual IOV BAR range is determined by the start address
> >> +		 * and the actual size for vf_num VFs BAR.  This check is to
> >> +		 * make sure that after shifting, the range will not overlap
> >> +		 * with another device.
> >> +		 */
> >> +		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> >> +		res2.flags = res->flags;
> >> +		res2.start = res->start + (size * offset);
> >> +		res2.end = res2.start + (size * vf_num) - 1;
> >> +
> >> +		if (res2.end > res->end) {
> >> +			dev_err(&dev->dev, "VF BAR%d: %pR would extend past %pR (trying to enable %d VFs shifted by %d)\n",
> >> +				i, &res2, res, vf_num, offset);
> >> +			return -EBUSY;
> >> +		}
> >> +	}
> >> +
> >> +	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >> +		res = &dev->resource[i + PCI_IOV_RESOURCES];
> >> +		if (!res->flags || !res->parent)
> >> +			continue;
> >> +
> >> +		if (!pnv_pci_is_mem_pref_64(res->flags))
> >> +			continue;
> >> +
> >> +		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> >> +		res2 = *res;
> >> +		res->start += size * offset;
> >
> >I'm still not happy about this fiddling with res->start.
> >
> >Increasing res->start means that in principle, the "size * offset" bytes
> >that we just removed from res are now available for allocation to somebody
> >else.  I don't think we *will* give that space to anything else because of
> >the alignment restrictions you're enforcing, but "res" now doesn't
> >correctly describe the real resource map.
> >
> >Would you be able to just update the BAR here while leaving the struct
> >resource alone?  In that case, it would look a little funny that lspci
> >would show a BAR value in the middle of the region in /proc/iomem, but
> >the /proc/iomem region would be more correct.
> 
> Bjorn,
> 
> I did some tests, while the result is not good.
> 
> What I did is still write the shifted resource address to the device by
> pci_update_resource(), but I revert the res->start to the original one. If
> this step is not correct, please let me know.
> 
> This can't work since after we revert the res->start, those VFs will be given
> resources from res->start instead of (res->start + offset * size). This is not
> what we expect.

Hmm, yes, I suppose we'd have to have a hook in pci_bus_alloc_from_region()
or something.  That's getting a little messy.  I still don't like messing
with the resource after it's in the resource tree, but I don't have a
better idea right now.  So let's just go with what you have.

> >> +
> >> +		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (enabling %d VFs shifted by %d)\n",
> >> +			 i, &res2, res, vf_num, offset);
> >> +		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
> >> +	}
> >> +	pdn->max_vfs -= offset;
> >> +	return 0;
> >> +}
> >> +#endif /* CONFIG_PCI_IOV */
> 
> -- 
> Richard Yang
> Help you, Help me
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
