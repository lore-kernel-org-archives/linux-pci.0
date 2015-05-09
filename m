Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35824 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbEIOMZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 9 May 2015 10:12:25 -0400
Received: by pdbqd1 with SMTP id qd1so110599114pdb.2
        for <linux-pci@vger.kernel.org>; Sat, 09 May 2015 07:12:24 -0700 (PDT)
Message-ID: <554E15C2.40506@ozlabs.ru>
Date: Sun, 10 May 2015 00:12:18 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
CC: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com
Subject: Re: [PATCH v4 10/21] powerpc/powernv: Fundamental reset for PCI bus
 reset
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com> <1430460188-31343-11-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-11-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/01/2015 04:02 PM, Gavin Shan wrote:
> Function pnv_pci_reset_secondary_bus() is used to reset specified
> PCI bus, which is leaded by root complex or PCI bridge. That means
> the function shouldn't be called on PCI root bus and the patch
> removes the logic for that case.
>
> Also, some adapters beneath the indicated PCI bus may require
> fundamental reset in order to successfully reload their firmwares
> after the reset. The patch translates hot reset to fundamental reset
> for that case.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 35 +++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 3c01095..58e4dcf 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -888,18 +888,35 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>   	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>   }
>
> -void pnv_pci_reset_secondary_bus(struct pci_dev *dev)


Why changing dev to pdev? Keeping "dev" could make the patch simpler.


> +static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>   {
> -	struct pci_controller *hose;
> +	int *freset = data;
>
> -	if (pci_is_root_bus(dev->bus)) {
> -		hose = pci_bus_to_host(dev->bus);
> -		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
> -		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
> -	} else {
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> -		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> +	/*
> +	 * Stop the iteration immediately if there is any
> +	 * one PCI device requesting fundamental reset
> +	 */
> +	*freset |= pdev->needs_freset;
> +	return *freset;
> +}
> +
> +void pnv_pci_reset_secondary_bus(struct pci_dev *pdev)
> +{
> +	int option = EEH_RESET_HOT;
> +	int freset = 0;
> +
> +	/* Check if there're any PCI devices asking for fundamental reset */
> +	if (pdev->subordinate) {
> +		pci_walk_bus(pdev->subordinate,
> +			     pnv_pci_dev_reset_type,
> +			     &freset);
> +		if (freset)
> +			option = EEH_RESET_FUNDAMENTAL;
>   	}
> +
> +	/* Issue the requested type of reset */
> +	pnv_eeh_bridge_reset(pdev, option);
> +	pnv_eeh_bridge_reset(pdev, EEH_RESET_DEACTIVATE);
>   }
>
>   /**
>


-- 
Alexey
