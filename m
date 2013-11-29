Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49414 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3K2Hhf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Nov 2013 02:37:35 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MX0003WWL6KAL50@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 29 Nov 2013 16:37:33 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: =?utf-8?Q?'Bj=C3=B8rn_Erik_Nilsen'?= <ben@datarespons.no>,
	'Marek Vasut' <marex@denx.de>
Cc: 'Pratyush Anand' <pratyush.anand@gmail.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Eric Nelson' <Eric.Nelson@boundarydevices.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com>
 <201311262219.49115.marex@denx.de>
 <cmu-lmtpd-17794-1385506605-2@frontend1.mail.m-online.net>
 <201311271046.01274.marex@denx.de> <C7.DF.00504.D1216925@epmailin4.samsung.com>
In-reply-to: <C7.DF.00504.D1216925@epmailin4.samsung.com>
Subject: Re: [PATCH v4] Kernel oops from pci_disable_msi
Date: Fri, 29 Nov 2013 16:37:32 +0900
Message-id: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, November 28, 2013 12:39 AM, Bjørn Erik Nilsen wrote:
> 
> Commit 904d0e7889933fb48d921c998fd1cabb3a9d6635 added

Please replace it with the following.

Commit 904d0e7889933fb48d921c998fd1cabb3a9d6635
"PCI: designware: Add irq_create_mapping()" added

Also, the subject of the commit is not good.
Usually, 'verb + objective + etc.' looks good.

Ex. PCI: designware: Remove irq_alloc_descs()

I tested this patch on Exynos platform; it works properly.
I will wait for v5 patch which addresses Marek Vasut's comments.
Thank you.

Best regards,
Jingoo Han

> irq_create_mapping which pre-allocates irq descs.
> Problem was that in assign_irq these descs were explicitly
> allocated and hence also freed, resulting in a crash.
> 
> Signed-off-by: Bjørn Erik Nilsen <ben@datarespons.no>
> ---
>  drivers/pci/host/pcie-designware.c | 50 +++++++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index e33b68b..6c61abd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -242,11 +242,18 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>  	if (!irq)
>  		goto no_valid_irq;
> 
> +	/*
> +	 * irq_create_mapping (called from dw_pcie_host_init) pre-allocates
> +	 * descs so there is no need to allocate descs here. We can therefore
> +	 * assume that if irq_find_mapping above returns non-zero, then the
> +	 * descs are also successfully allocated. Hence no need to check the
> +	 * return value of irq_set_msi_desc_off below.
> +	 */
> +
>  	i = 0;
>  	while (i < no_irqs) {
>  		set_bit(pos0 + i, pp->msi_irq_in_use);
> -		irq_alloc_descs((irq + i), (irq + i), 1, 0);
> -		irq_set_msi_desc(irq + i, desc);
> +		irq_set_msi_desc_off(irq, i, desc);
>  		/*Enable corresponding interrupt in MSI interrupt controller */
>  		res = ((pos0 + i) / 32) * 12;
>  		bit = (pos0 + i) % 32;
> @@ -266,7 +273,7 @@ no_valid_irq:
> 
>  static void clear_irq(unsigned int irq)
>  {
> -	int res, bit, val, pos;
> +	int res, bit, val, pos, i, nvec;
>  	struct irq_desc *desc;
>  	struct msi_desc *msi;
>  	struct pcie_port *pp;
> @@ -281,18 +288,28 @@ static void clear_irq(unsigned int irq)
>  		return;
>  	}
> 
> +	/* undo what was done in assign_irq */
>  	pos = data->hwirq;
> +	nvec = 1 << msi->msi_attrib.multiple;
> 
> -	irq_free_desc(irq);
> -
> -	clear_bit(pos, pp->msi_irq_in_use);
> +	i = 0;
> +	while (i < nvec) {
> +		clear_bit(pos + i, pp->msi_irq_in_use);
> +		irq_set_msi_desc_off(irq, i, NULL);
> +		/* Disable corresponding interrupt on MSI interrupt controller */
> +		res = ((pos + i) / 32) * 12;
> +		bit = (pos + i) % 32;
> +		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> +		val &= ~(1 << bit);
> +		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +		++i;
> +	}
> 
> -	/* Disable corresponding interrupt on MSI interrupt controller */
> -	res = (pos / 32) * 12;
> -	bit = pos % 32;
> -	dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, &val);
> -	val &= ~(1 << bit);
> -	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE + res, 4, val);
> +	msi->msg.address_lo = 0;
> +	msi->msg.address_hi = 0;
> +	msi->msg.data = 0;
> +	msi->irq = 0;
> +	msi->msi_attrib.multiple = 0;
>  }
> 
>  static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
> @@ -320,12 +337,11 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
>  	if (irq < 0)
>  		return irq;
> 
> -	msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
> -	msg_ctr |= msgvec << 4;
> -	pci_write_config_word(pdev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
> -				msg_ctr);
> +	/*
> +	 * write_msi_msg() will update PCI_MSI_FLAGS so there
> +	 * is no need to explicitly call pci_write_config here
> +	 */
>  	desc->msi_attrib.multiple = msgvec;
> -
>  	msg.address_lo = virt_to_phys((void *)pp->msi_data);
>  	msg.address_hi = 0x0;
>  	msg.data = pos;
> --
> 1.8.4.4
> 


