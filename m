Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:62546 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787Ab2HQCtm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 22:49:42 -0400
Received: by qaas11 with SMTP id s11so1206630qaa.19
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2012 19:49:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1343180997-9483-9-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
	<1343180997-9483-9-git-send-email-shangw@linux.vnet.ibm.com>
Date: Fri, 17 Aug 2012 10:49:41 +0800
Message-ID: <CADLM8XOe_C-w2SYr417=if+3KqKbiYB04mAgO8opRy-aosrFVg@mail.gmail.com>
Subject: Re: [PATCH 8/8] ppc/pnv: I/O and memory alignment for p2p bridges
From: Wei Yang <weiyang.kernel@gmail.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	benh@kernel.crashing.org, linuxram@us.ibm.com,
	Richard Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2012/7/25 Gavin Shan <shangw@linux.vnet.ibm.com>:
> The patch implements ppc_md.pcibios_window_alignment for powernv
> platform so that the resource reassignment in PCI core will be
> done according to the I/O and memory alignment returned from
> powernv platform. The alignments returned from powernv platform
> is closely depending on the scheme for PE segmenting. Besides,
> the patch isn't useful for now, but the subsequent patches will
> be working based on it.
>
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |   38 +++++++++++++++++++++++++++++
>  1 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fbdd74d..159bce5 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1139,6 +1139,43 @@ static void __devinit pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
>         }
>  }
>
> +/*
> + * Returns the alignment for I/O or memory windows for p2p
> + * bridges. That actually depends on how PEs are segmented.
> + * For now, we return I/O or M32 segment size for PE sensitive
> + * p2p bridges. Otherwise, the default values (4KiB for I/O,
> + * 1MiB for memory) will be returned.
> + */
> +static resource_size_t pnv_pci_window_alignment(struct pci_bus *bus,
> +                                               unsigned long type)
> +{
> +       struct pci_dev *dev = bus->self;
> +       struct pci_controller *hose = pci_bus_to_host(bus);
> +       struct pnv_phb *phb = hose->private_data;
> +
> +       /* PCI root bus will be assigned with segment size */
> +       if (!dev)
> +               goto out;
> +

there is a function, pci_is_root_bus() which is introduced in
79af72d7, to check whether
this bus is a root bus or not.

> +       /*
> +        * If the parent bridge is PCI bridge, we will return
> +        * the default values
> +        */
> +       dev = dev->bus->self;
> +       if (!dev)
> +               goto out;
> +       if (dev->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE) {
> +               return 1;
> +       }
> +
> +out:
> +       /* We need support prefetchable memory window later */
> +       if (type & IORESOURCE_MEM)
> +               return phb->ioda.m32_segsize;
> +
> +       return phb->ioda.io_segsize;
> +}
> +
>  /* Prevent enabling devices for which we couldn't properly
>   * assign a PE
>   */
> @@ -1306,6 +1343,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
>          */
>         ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
>         ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
> +       ppc_md.pcibios_window_alignment = pnv_pci_window_alignment;
>         pci_add_flags(PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC);
>
>         /* Reset IODA tables to a clean state */
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Richard Yang
Help You, Help Me
