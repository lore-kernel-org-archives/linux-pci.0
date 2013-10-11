Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:25229 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3JKGs5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 02:48:57 -0400
Message-ID: <52579F20.7040606@huawei.com>
Date: Fri, 11 Oct 2013 14:48:00 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	"Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc/pci: use pci_is_pcie() to simplify code
References: <1381472809-11556-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1381472809-11556-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sorry, this patch should v3 not v2, please ignore, and v3 patch will resend.

Thanks!

On 2013/10/11 14:26, Yijing Wang wrote:
> Use pci_is_pcie() to simplify code.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> 
> ---
> 
> v1->v2: use dev->pcie_cap instead of "cap" in eeh_ops->read_config()
>         "cap" is stale after remove PCIe Cap find code.
>         Point out by Benjamin Herrenschmidt.
> 
> ---
>  arch/powerpc/kernel/eeh.c     |    5 ++---
>  arch/powerpc/sysdev/fsl_pci.c |    2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 55593ee..db86f97 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -189,14 +189,13 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
>  	}
>  
>  	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
> -	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
> -	if (cap) {
> +	if (pci_is_pcie(dev)) {
>  		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
>  		printk(KERN_WARNING
>  		       "EEH: PCI-E capabilities and status follow:\n");
>  
>  		for (i=0; i<=8; i++) {
> -			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
> +			eeh_ops->read_config(dn, dev->pcie_cap+4*i, 4, &cfg);
>  			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
>  			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
>  		}
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index ccfb50d..92e7258 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -45,7 +45,7 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
>  	u8 hdr_type;
>  
>  	/* if we aren't a PCIe don't bother */
> -	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
> +	if (!pci_is_pcie(dev))
>  		return;
>  
>  	/* if we aren't in host mode don't bother */
> 


-- 
Thanks!
Yijing

