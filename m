Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:34168 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbGMMr3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2015 08:47:29 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Mon, 13 Jul 2015 13:47:27 +0100
Date: Mon, 13 Jul 2015 14:47:17 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux390@de.ibm.com, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC Patch V1 04/12] s390/pci: Use for_pci_msi_entry() to access
 MSI device list
In-Reply-To: <1436428847-8886-5-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.LFD.2.11.1507131443460.1713@denkbrett>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com> <1436428847-8886-5-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 9 Jul 2015, Jiang Liu wrote:

> Use accessor for_pci_msi_entry() to access MSI device list, so we could
> easily move msi_list from struct pci_dev into struct device later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>

Regards,
Sebastian

> ---
>  arch/s390/pci/pci.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 598f023cf8a6..34f162753403 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -414,7 +414,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> 
>  	/* Request MSI interrupts */
>  	hwirq = 0;
> -	list_for_each_entry(msi, &pdev->msi_list, list) {
> +	for_each_pci_msi_entry(msi, pdev) {
>  		rc = -EIO;
>  		irq = irq_alloc_desc(0);	/* Alloc irq on node 0 */
>  		if (irq < 0)
> @@ -440,7 +440,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	return (msi_vecs == nvec) ? 0 : msi_vecs;
> 
>  out_msi:
> -	list_for_each_entry(msi, &pdev->msi_list, list) {
> +	for_each_pci_msi_entry(msi, pdev) {
>  		if (hwirq-- == 0)
>  			break;
>  		irq_set_msi_desc(msi->irq, NULL);
> @@ -470,7 +470,7 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>  		return;
> 
>  	/* Release MSI interrupts */
> -	list_for_each_entry(msi, &pdev->msi_list, list) {
> +	for_each_pci_msi_entry(msi, pdev) {
>  		if (msi->msi_attrib.is_msix)
>  			__pci_msix_desc_mask_irq(msi, 1);
>  		else
> -- 
> 1.7.10.4
> 
> 

