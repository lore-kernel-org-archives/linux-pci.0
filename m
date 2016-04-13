Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36206 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934332AbcDMHVQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2016 03:21:16 -0400
Received: by mail-pa0-f41.google.com with SMTP id er2so82253pad.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2016 00:21:11 -0700 (PDT)
Subject: Re: [PATCH v8 12/45] powerpc/powernv: Rename M64 related functions
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-13-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
	bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DF35A.1010101@ozlabs.ru>
Date: Wed, 13 Apr 2016 17:20:58 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-13-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> This renames those functions picking PE number based on consumed
> M64 segments, mapping M64 segments to PEs as those functions are
> going to be shared by IODA1/IODA2 in next patch. No logical changes
> introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>




> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fc0374a..1dc663a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -219,7 +219,7 @@ fail:
>   	return -EIO;
>   }
>
> -static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
> +static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
>   					 unsigned long *pe_bitmap)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> @@ -246,22 +246,22 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
>   	}
>   }
>
> -static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
> -				     unsigned long *pe_bitmap,
> -				     bool all)
> +static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
> +				    unsigned long *pe_bitmap,
> +				    bool all)
>   {
>   	struct pci_dev *pdev;
>
>   	list_for_each_entry(pdev, &bus->devices, bus_list) {
> -		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
> +		pnv_ioda_reserve_dev_m64_pe(pdev, pe_bitmap);
>
>   		if (all && pdev->subordinate)
> -			pnv_ioda2_reserve_m64_pe(pdev->subordinate,
> -						 pe_bitmap, all);
> +			pnv_ioda_reserve_m64_pe(pdev->subordinate,
> +						pe_bitmap, all);
>   	}
>   }
>
> -static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
> +static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>   {
>   	struct pci_controller *hose = pci_bus_to_host(bus);
>   	struct pnv_phb *phb = hose->private_data;
> @@ -283,7 +283,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   	}
>
>   	/* Figure out reserved PE numbers by the PE */
> -	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
> +	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
>
>   	/*
>   	 * the current bus might not own M64 window and that's all
> @@ -365,8 +365,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>   	/* Use last M64 BAR to cover M64 window */
>   	phb->ioda.m64_bar_idx = 15;
>   	phb->init_m64 = pnv_ioda2_init_m64;
> -	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
> -	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
> +	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
> +	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
>   }
>
>   static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
>


-- 
Alexey
