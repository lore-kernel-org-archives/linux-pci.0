Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51128 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878AbaFLKZl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jun 2014 06:25:41 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N710034DWYOEF30@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Jun 2014 19:25:36 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Cc: 'Jason Cooper' <jason@lakedaemon.net>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>, kernel@pengutronix.de,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Marek Vasut' <marex@denx.de>,
	'Richard Zhu' <r65037@freescale.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Pratyush Anand' <pratyush.anand@st.com>
References: <1401979572-32101-1-git-send-email-l.stach@pengutronix.de>
 <1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
In-reply-to: <1401979572-32101-2-git-send-email-l.stach@pengutronix.de>
Subject: Re: [PATCH 1/4] PCI: allow MSI chip providers to implement their own
 multiple MSI setup
Date: Thu, 12 Jun 2014 19:25:35 +0900
Message-id: <000201cf8628$a5f4ee60$f1decb20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 05, 2014 11:46 PM, Lucas Stach wrote:
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

(+cc Marek Vasut, Richard Zhu, Kishon Vijay Abraham I, Pratyush Anand)

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

However, I want more detailed commit message as possible.
Thank you.

Best regards,
Jingoo Han

> ---
>  drivers/pci/msi.c   | 3 +++
>  include/linux/msi.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 27a7e67ddfe4..c45399d3061a 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -68,9 +68,12 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> 
>  int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> +	struct msi_chip *chip = dev->bus->msi;
>  	struct msi_desc *entry;
>  	int ret;
> 
> +	if (chip && chip->setup_irqs)
> +		return chip->setup_irqs(chip, dev, nvec, type);
>  	/*
>  	 * If an architecture wants to support multiple MSI, it needs to
>  	 * override arch_setup_msi_irqs()
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 92a2f991262a..d813f898194c 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -75,6 +75,8 @@ struct msi_chip {
> 
>  	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
>  			 struct msi_desc *desc);
> +	int (*setup_irqs)(struct msi_chip *chip, struct pci_dev *dev,
> +			  int nvec, int type);
>  	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
>  	int (*check_device)(struct msi_chip *chip, struct pci_dev *dev,
>  			    int nvec, int type);
> --
> 2.0.0.rc2

