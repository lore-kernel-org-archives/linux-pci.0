Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34270 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758138AbbJ3Ddy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 23:33:54 -0400
Received: by padhk11 with SMTP id hk11so60138180pad.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2015 20:33:54 -0700 (PDT)
Subject: Re: [PATCH V10 06/12] powerpc/powernv: EEH device for VF
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-7-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5632E51D.30805@ozlabs.ru>
Date: Fri, 30 Oct 2015 14:33:49 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-7-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/26/2015 02:15 PM, Wei Yang wrote:
> VFs and their corresponding pci_dn instances are created and released
> dynamically as their PF's SRIOV capability is enabled and disabled.
> The patch creates and releases EEH devices for VFs when creating and
> releasing their pci_dn instances, which means EEH devices and pci_dn
> instances have same life cycle. Also, VF's EEH device is identified
> by (struct eeh_dev::physfn).


The add_dev_pci_data() helper (the one you hack) does not create pci_dn 
instances. The add_one_dev_pci_data() helper does.


>
> [gwshan: changelog and removed CONFIG_PCI_IOV]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/eeh.h |  1 +
>   arch/powerpc/kernel/pci_dn.c   | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index c5eb86f..6c383ad 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -140,6 +140,7 @@ struct eeh_dev {
>   	struct pci_controller *phb;	/* Associated PHB		*/
>   	struct pci_dn *pdn;		/* Associated PCI device node	*/
>   	struct pci_dev *pdev;		/* Associated PCI device	*/
> +	struct pci_dev *physfn;		/* Associated PF PORT		*/
>   	struct pci_bus *bus;		/* PCI bus for partial hotplug	*/
>   };
>
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index f771130..f0ddde7 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -180,7 +180,9 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>   struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>   {
>   #ifdef CONFIG_PCI_IOV
> +	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>   	struct pci_dn *parent, *pdn;
> +	struct eeh_dev *edev;
>   	int i;
>
>   	/* Only support IOV for now */
> @@ -206,6 +208,9 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
>   				 __func__, i);
>   			return NULL;
>   		}
> +		eeh_dev_init(pdn, hose);
> +		edev = pdn_to_eeh_dev(pdn);


In theory, pdn_to_eeh_dev() can return NULL. In this patch, it is not clear 
if pdn->edev gets initialized before or after add_dev_pci_data().



> +		edev->physfn = pdev;
>   	}
>   #endif /* CONFIG_PCI_IOV */
>
> @@ -254,10 +259,17 @@ void remove_dev_pci_data(struct pci_dev *pdev)
>   	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>   		list_for_each_entry_safe(pdn, tmp,
>   			&parent->child_list, list) {
> +			struct eeh_dev *edev;
>   			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
>   			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
>   				continue;
>
> +			edev = pdn_to_eeh_dev(pdn);
> +			if (edev) {
> +				pdn->edev = NULL;
> +				kfree(edev);
> +			}
> +
>   			if (!list_empty(&pdn->list))
>   				list_del(&pdn->list);
>
>


-- 
Alexey
