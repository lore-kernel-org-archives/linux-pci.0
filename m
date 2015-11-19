Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:56267 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbKSIbe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2015 03:31:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Ray Jui <rjui@broadcom.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI: iproc: Add iProc PCIe MSI support
Date: Thu, 19 Nov 2015 09:31:23 +0100
Message-ID: <6927787.cmOcTVpP16@wuerfel>
In-Reply-To: <564D27CC.3030505@broadcom.com>
References: <1447806715-30043-1-git-send-email-rjui@broadcom.com> <20151118084845.49ba6304@arm.com> <564D27CC.3030505@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 18 November 2015 17:37:16 Ray Jui wrote:
> >> +}
> >> +
> >> +static inline void iproc_msi_write_reg(struct iproc_msi *msi,
> >> +                                   enum iproc_msi_reg reg,
> >> +                                   int eq, u32 val)
> >> +{
> >> +    struct iproc_pcie *pcie = msi->pcie;
> >> +
> >> +    writel(val, pcie->base + msi->reg_offsets[eq][reg]);
> >
> > Same here for writel vs writel_relaxed.
> >
> 
> I probably do not need the barrier in most cases. But as we are dealing 
> with MSI, I thought it's a lot safer to have the barrier in place so the 
> CPU does not re-order the device register accesses with respect to other 
> memory accesses?

See my other reply on that. For the actual handler, it makes sense to
carefully think of all the possible side-effects and eliminate the
barrier if possible, but for all other callers the performance doesn't
matter and we should default to using readl/writel.

> >> +};
> >> +
> >> +static struct msi_domain_info iproc_msi_domain_info = {
> >> +    .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> >> +            MSI_FLAG_PCI_MSIX,
> >> +    .chip = &iproc_msi_top_irq_chip,
> >> +};
> >> +
> >> +static int iproc_msi_irq_set_affinity(struct irq_data *data,
> >> +                                  const struct cpumask *mask, bool force)
> >> +{
> >> +    return -EINVAL;
> >
> > I wish people would stop building stupid HW that prevents proper
> > affinity setting for MSI...
> >
> 
> In fact, there's no reason why the HW should prevent us from setting the 
> MSI affinity. This is currently more of a SW issue that I have not spent 
> enough time figuring out.
> 
> Here's my understanding:
> 
> In our system, each MSI is linked to a dedicated interrupt line 
> connected to the GIC upstream (e.g., the GIC from Cortex A9 in Cygnus). 
> Correct me if I'm wrong, to get the MSI affinity to work, all I need 
> should be propagating the affinity setting to the GIC (the 1-to-1 
> mapping helps simply things quite a bit here)?
> 
> I tried to hook this up with irq_chip_set_affinity_parent. But it looks 
> like the irq chip of the parent domain (i.e., the GIC) is pointing to 
> NULL, and therefore it would crash when dereferencing it to get the 
> irq_set_affinity callback.
> 
> I thought I did everything required by figuring out and linking to the 
> correct parent domain in the iproc_msi_init routine:
> 
> parent_node = of_parse_phandle(node, "interrupt-parent", 0);
> if (!parent_node) {
>        dev_err(pcie->dev, "unable to parse MSI interrupt parent\n");
>        return -ENODEV;
> }
> 
> parent_domain = irq_find_host(parent_node);
> if (!parent_domain) {
>        dev_err(pcie->dev, "unable to get MSI parent domain\n");
>        return -ENODEV;
> }
> 
> ...
> ...
> 
> msi->inner_domain = irq_domain_add_hierarchy(parent_domain, 0,
>                                               msi->nirqs, NULL,
>                                               &msi_domain_ops,
>                                               msi);
> 
> I haven't spent too much time investigating, and am hoping to eventually 
> enable affinity support with an incremental patch in the future when I 
> have more time to investigate.

Is it possible that you have a set of MSIs per GIC interrupt (as Marc
suggested earlier) and that the way it is intended to be used is by
having each one of them target a different CPU? That way you can do
affinity by switching to a different MSI in .set_affinity(), I think
that is how the old style MSI all used to work when each CPU had its
own MSI register.

	Arnd
