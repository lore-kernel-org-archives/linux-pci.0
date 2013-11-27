Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:33221 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab3K0TFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2013 14:05:07 -0500
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Subject: Re: [PATCH v4] Kernel oops from pci_disable_msi
Date: Wed, 27 Nov 2013 20:05:03 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Ajay KHANDELWAL <ajay.khandelwal@st.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Eric Nelson <Eric.Nelson@boundarydevices.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com> <201311271046.01274.marex@denx.de> <cmu-lmtpd-20073-1385566822-1@frontend1.mail.m-online.net>
In-Reply-To: <cmu-lmtpd-20073-1385566822-1@frontend1.mail.m-online.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311272005.03545.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjørn Erik Nilsen,

> Commit 904d0e7889933fb48d921c998fd1cabb3a9d6635 added
> irq_create_mapping which pre-allocates irq descs.
> Problem was that in assign_irq these descs were explicitly
> allocated and hence also freed, resulting in a crash.
> 
> Signed-off-by: Bjørn Erik Nilsen <ben@datarespons.no>
> ---
>  drivers/pci/host/pcie-designware.c | 50
> +++++++++++++++++++++++++------------- 1 file changed, 33 insertions(+),
> 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c
> b/drivers/pci/host/pcie-designware.c index e33b68b..6c61abd 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -242,11 +242,18 @@ static int assign_irq(int no_irqs, struct msi_desc
> *desc, int *pos) if (!irq)
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

This function here returns an return value , you _must_ check it and handle the 
possible error accordingly .

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

DTTO here.

> +		/* Disable corresponding interrupt on MSI interrupt controller 
*/
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

This piece of new code could use a comment please.

>  }
> 
>  static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
> @@ -320,12 +337,11 @@ static int dw_msi_setup_irq(struct msi_chip *chip,
> struct pci_dev *pdev, if (irq < 0)
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

Won't this overwrite your new code above ?

>  	msg.data = pos;
