Return-Path: <SRS0=HpDZ=QO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABD8C282C2
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1021907
	for <linux-pci@archiver.kernel.org>; Thu,  7 Feb 2019 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549574786;
	bh=U/2YnB/WK1IGdD93d7XtsgRlaRFoLinSnoRbkTaKUxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UWyNq3M+RzIfgl93fqb8oiYEN8DovTCBx4bc9jEEuaJIcrovNlpvJmy1FiS84alfS
	 EHYLVvuqux7qNYHXCx1OTZ4/Fh1V/NQJsqaJ+jOpnUw0JZkKDlsalguyP91xq/VPBt
	 IChhoZpOVuldFOZ7Nm6d0oeBaGDM5Bupk72dQftQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfBGV00 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:26:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfBGV00 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 16:26:26 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CAEB21721;
        Thu,  7 Feb 2019 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549574784;
        bh=U/2YnB/WK1IGdD93d7XtsgRlaRFoLinSnoRbkTaKUxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHkGrjqKtSA40ScLOGuB8aZBK++BRUVe28Fd5//1saVqHsdDTcR/gSPxOaNZYqOmp
         bJ6101B6yOD1YOmCBPqLv4NR4xJibaApxEppLEMXnGsSNvj2DfEGeIZRUMIZjugmQc
         Xc4YvswIATVC3TrQQZIwM8NvdxS1thDMbieTVH3M=
Date:   Thu, 7 Feb 2019 15:26:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific
 dw_pcie_host_ops
Message-ID: <20190207212622.GO7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-9-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 07, 2019 at 04:39:23PM +0530, Kishon Vijay Abraham I wrote:
> Now that Keystone started using it's own msi_irq_chip, remove
> Keystone specific callback function defined in dw_pcie_host_ops.

s/it's/its/
s/callback function/callback functions/

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 45 ++++++-------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ---
>  2 files changed, 14 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 042de09b0451..9492b05e8ff0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -126,18 +126,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	u64 msi_target;
>  
> -	if (pp->ops->get_msi_addr)
> -		msi_target = pp->ops->get_msi_addr(pp);
> -	else
> -		msi_target = (u64)pp->msi_data;
> +	msi_target = (u64)pp->msi_data;
>  
>  	msg->address_lo = lower_32_bits(msi_target);
>  	msg->address_hi = upper_32_bits(msi_target);
>  
> -	if (pp->ops->get_msi_data)
> -		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
> -	else
> -		msg->data = data->hwirq;
> +	msg->data = data->hwirq;
>  
>  	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
>  		(int)data->hwirq, msg->address_hi, msg->address_lo);
> @@ -157,17 +151,13 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
> -	if (pp->ops->msi_clear_irq) {
> -		pp->ops->msi_clear_irq(pp, data->hwirq);
> -	} else {
> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> -		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -		pp->irq_status[ctrl] &= ~(1 << bit);
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -				    ~pp->irq_status[ctrl]);
> -	}
> +	pp->irq_status[ctrl] &= ~(1 << bit);
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> +			    ~pp->irq_status[ctrl]);
>  
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
> @@ -180,17 +170,13 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
> -	if (pp->ops->msi_set_irq) {
> -		pp->ops->msi_set_irq(pp, data->hwirq);
> -	} else {
> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> -		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -		pp->irq_status[ctrl] |= 1 << bit;
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -				    ~pp->irq_status[ctrl]);
> -	}
> +	pp->irq_status[ctrl] |= 1 << bit;
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> +			    ~pp->irq_status[ctrl]);
>  
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
> @@ -209,9 +195,6 @@ static void dw_pci_bottom_ack(struct irq_data *d)
>  
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
>  
> -	if (pp->ops->msi_irq_ack)
> -		pp->ops->msi_irq_ack(d->hwirq, pp);
> -
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 95e0c3c93f48..ea4b215b605d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -142,14 +142,9 @@ struct dw_pcie_host_ops {
>  	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>  			     unsigned int devfn, int where, int size, u32 val);
>  	int (*host_init)(struct pcie_port *pp);
> -	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> -	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> -	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
> -	u32 (*get_msi_data)(struct pcie_port *pp, int pos);

I don't see the whole series on linux-pci (I only see patches 2, 6, 8, 9),
but I expected to somewhere see the removal of assignments to these
pointers.  It would be easier to review if the removal of assignments and
the removal of the function pointers from the structure were in the same
patch, but maybe that's not really feasible.

>  	void (*scan_bus)(struct pcie_port *pp);
>  	void (*set_num_vectors)(struct pcie_port *pp);
>  	int (*msi_host_init)(struct pcie_port *pp);
> -	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
>  };
>  
>  struct pcie_port {
> -- 
> 2.17.1
> 
