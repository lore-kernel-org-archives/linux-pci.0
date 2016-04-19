Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35645 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbcDSIte (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2016 04:49:34 -0400
Received: by mail-pf0-f179.google.com with SMTP id n1so4792734pfn.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Apr 2016 01:49:34 -0700 (PDT)
Subject: Re: [PATCH v8 33/45] powerpc/powernv: Simplify pnv_eeh_reset()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-34-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
	bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715F116.8090202@ozlabs.ru>
Date: Tue, 19 Apr 2016 18:49:26 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-34-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> This drops unnecessary nested if statements in pnv_eeh_reset() to
> improve the code readability. After the changes, the unused local
> variable "ret" is dropped as well. No logical changes introduced.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>



Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 67 +++++++++++++---------------
>   1 file changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 69e41ce..9226df1 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1009,8 +1009,9 @@ static int pnv_eeh_reset_vf_pe(struct eeh_pe *pe, int option)
>   static int pnv_eeh_reset(struct eeh_pe *pe, int option)
>   {
>   	struct pci_controller *hose = pe->phb;
> +	struct pnv_phb *phb;
>   	struct pci_bus *bus;
> -	int ret;
> +	int64_t rc;
>
>   	/*
>   	 * For PHB reset, we always have complete reset. For those PEs whose
> @@ -1026,45 +1027,39 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
>   	 * reset. The side effect is that EEH core has to clear the frozen
>   	 * state explicitly after BAR restore.
>   	 */
> -	if (pe->type & EEH_PE_PHB) {
> -		ret = pnv_eeh_phb_reset(hose, option);
> -	} else {
> -		struct pnv_phb *phb;
> -		s64 rc;
> +	if (pe->type & EEH_PE_PHB)
> +		return pnv_eeh_phb_reset(hose, option);
>
> -		/*
> -		 * The frozen PE might be caused by PAPR error injection
> -		 * registers, which are expected to be cleared after hitting
> -		 * frozen PE as stated in the hardware spec. Unfortunately,
> -		 * that's not true on P7IOC. So we have to clear it manually
> -		 * to avoid recursive EEH errors during recovery.
> -		 */
> -		phb = hose->private_data;
> -		if (phb->model == PNV_PHB_MODEL_P7IOC &&
> -		    (option == EEH_RESET_HOT ||
> -		    option == EEH_RESET_FUNDAMENTAL)) {
> -			rc = opal_pci_reset(phb->opal_id,
> -					    OPAL_RESET_PHB_ERROR,
> -					    OPAL_ASSERT_RESET);
> -			if (rc != OPAL_SUCCESS) {
> -				pr_warn("%s: Failure %lld clearing "
> -					"error injection registers\n",
> -					__func__, rc);
> -				return -EIO;
> -			}
> +	/*
> +	 * The frozen PE might be caused by PAPR error injection
> +	 * registers, which are expected to be cleared after hitting
> +	 * frozen PE as stated in the hardware spec. Unfortunately,
> +	 * that's not true on P7IOC. So we have to clear it manually
> +	 * to avoid recursive EEH errors during recovery.
> +	 */
> +	phb = hose->private_data;
> +	if (phb->model == PNV_PHB_MODEL_P7IOC &&
> +	    (option == EEH_RESET_HOT ||
> +	     option == EEH_RESET_FUNDAMENTAL)) {
> +		rc = opal_pci_reset(phb->opal_id,
> +				    OPAL_RESET_PHB_ERROR,
> +				    OPAL_ASSERT_RESET);
> +		if (rc != OPAL_SUCCESS) {
> +			pr_warn("%s: Failure %lld clearing error injection registers\n",
> +				__func__, rc);
> +			return -EIO;
>   		}
> -
> -		bus = eeh_pe_bus_get(pe);
> -		if (pe->type & EEH_PE_VF)
> -			ret = pnv_eeh_reset_vf_pe(pe, option);
> -		else if (pci_is_root_bus(bus) ||
> -			pci_is_root_bus(bus->parent))
> -			ret = pnv_eeh_root_reset(hose, option);
> -		else
> -			ret = pnv_eeh_bridge_reset(bus->self, option);
>   	}
>
> -	return ret;
> +	bus = eeh_pe_bus_get(pe);
> +	if (pe->type & EEH_PE_VF)
> +		return pnv_eeh_reset_vf_pe(pe, option);
> +
> +	if (pci_is_root_bus(bus) ||
> +	    pci_is_root_bus(bus->parent))
> +		return pnv_eeh_root_reset(hose, option);
> +
> +	return pnv_eeh_bridge_reset(bus->self, option);
>   }
>
>   /**
>


-- 
Alexey
