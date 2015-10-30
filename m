Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36393 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479AbbJ3FmM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 01:42:12 -0400
Received: by pacfv9 with SMTP id fv9so65967881pac.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2015 22:42:12 -0700 (PDT)
Subject: Re: [PATCH V10 11/12] powerpc/eeh: Don't block PCI config on
 resetting VF PE
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-12-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5633032F.9000407@ozlabs.ru>
Date: Fri, 30 Oct 2015 16:42:07 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-12-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/26/2015 02:16 PM, Wei Yang wrote:
> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> When passing through SRIOV VF from host to guest via VFIO PCI
> infrastructure, the VF is resetted by EEH specific backend
> (pcibios_set_pcie_reset_state()). We can't block the PCI config,
> otherwise, the reset (FLR or AF FLR), to be completed by PCI
> config access to the VF, can't be done. Then the VF can't be
> put into initial state when passing it to the guest and returning
> back to the host.
>
> The patch just doesn't block the VF's PCI config space when doing
> the reset. It fixes EEH error caused by DMA traffic to bogus DMA
> address on restarting guest after killing the QEMU process, which
> includes Mellanox VF passed through from host.

The patch as it is makes sense as a bugfix for our internal tree where the 
EEH VF feature was present at the time when this patch was posted but in 
this patchset is makes more sense to merge it into:

[PATCH V10 08/12] powerpc/powernv: Support EEH reset for VF PE

as it is quite weird within one patchset to introduce a problem  and then 
fix it in a following patch.


> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Remove "sob: aik@..." please.


> ---
>   arch/powerpc/kernel/eeh.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 28e4d73..e1846f5 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -745,7 +745,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
>   	case pcie_deassert_reset:
>   		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
>   		eeh_unfreeze_pe(pe, false);
> -		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
> +		if (!(pe->type & EEH_PE_VF))
> +			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
>   		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
>   		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
>   		break;
> @@ -753,14 +754,16 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
>   		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
>   		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
>   		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
> -		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
> +		if (!(pe->type & EEH_PE_VF))
> +			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
>   		eeh_ops->reset(pe, EEH_RESET_HOT);
>   		break;
>   	case pcie_warm_reset:
>   		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
>   		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
>   		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
> -		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
> +		if (!(pe->type & EEH_PE_VF))
> +			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
>   		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
>   		break;
>   	default:
>


-- 
Alexey
