Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33498 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbaIXN1F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 24 Sep 2014 09:27:05 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so6161864ieb.41
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2014 06:27:05 -0700 (PDT)
Date: Wed, 24 Sep 2014 07:27:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/3] PCI: designware: Rename get_msi_data to
 get_msi_addr
Message-ID: <20140924132702.GC13850@google.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-3-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411482540-31297-3-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 10:28:58PM +0800, Minghuan Lian wrote:
> The function get_msi_data is used to return MSI message address.
> In order to accurately express function purpose the patch rename
> it to get_msi_addr.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>

Applied patches 1 and 2 to pci/host-designware with Mohit's ack for v3.18,
thanks!

> ---
> Change log:
> v3: no change
> v2: no change just derived from v1
> 
>  drivers/pci/host/pcie-designware.c | 4 ++--
>  drivers/pci/host/pcie-designware.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 5d720c2..1c09f814 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -361,8 +361,8 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
>  	 */
>  	desc->msi_attrib.multiple = msgvec;
>  
> -	if (pp->ops->get_msi_data)
> -		msg.address_lo = pp->ops->get_msi_data(pp);
> +	if (pp->ops->get_msi_addr)
> +		msg.address_lo = pp->ops->get_msi_addr(pp);
>  	else
>  		msg.address_lo = virt_to_phys((void *)pp->msi_data);
>  	msg.address_hi = 0x0;
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 48f8670..904e40a 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -70,7 +70,7 @@ struct pcie_host_ops {
>  	void (*host_init)(struct pcie_port *pp);
>  	void (*msi_set_irq)(struct pcie_port *pp, int irq);
>  	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> -	u32 (*get_msi_data)(struct pcie_port *pp);
> +	u32 (*get_msi_addr)(struct pcie_port *pp);
>  	void (*scan_bus)(struct pcie_port *pp);
>  	int (*msi_host_init)(struct pcie_port *pp, struct msi_chip *chip);
>  };
> -- 
> 1.9.1
> 
