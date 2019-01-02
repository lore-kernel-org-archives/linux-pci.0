Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AB0C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE922075B
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GFAHc5ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfABKRY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:17:24 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50194 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbfABKRX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 05:17:23 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 62F7F10C125F;
        Wed,  2 Jan 2019 02:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546424243; bh=kfrBNHHF0EHzInOdICzSB8v0eSnBIAWIffA2wT8lEQY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=GFAHc5ezlAasbQ5ooStPcD5vS7jWOK87AX9zRGQvxBqVeGj5PjwXxL39JehIYPN3L
         xWhOT/9NHRy3UQfXEJE2pnQRqblBOHqICCK4lqh480JdRE4mcONWwxcllPhtZgQoWV
         7wC53x/L3O54sUqCHkNbtjuMHJ8GyyThPp/plsTpBmt4Q68eqFju0sZeZ6XaqATcGB
         fB9CqI0t9Tiam92kx3/lKzItpF0tcHtQIWdK7t54dPKpqp5nu39Z4QLCUhOieD7Nen
         F2LNyv+zZ/8OTmsdZGiqgwp6Qjn4Na8XLR4ThtNry0ivhieh9kVaZ5HjykvXlP7kzX
         4Ra+ci9ejjHsg==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 451F535BF;
        Wed,  2 Jan 2019 02:17:23 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 02:17:23 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:17:21 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:17:20 +0100
Subject: Re: [PATCH 09/10] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181219124207.13479-1-kishon@ti.com>
 <20181219124207.13479-10-kishon@ti.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <c6566152-6170-7bb2-eec7-bc3f04a6f788@synopsys.com>
Date:   Wed, 2 Jan 2019 10:12:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219124207.13479-10-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 19/12/2018 12:42, Kishon Vijay Abraham I wrote:
> Now that Keystone started using it's own msi_irq_chip, remove
> Keystone specific callback function defined in dw_pcie_host_ops.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 45 ++++++-------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ---
>  2 files changed, 14 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index db21bd11f153..dbc94f3be3d5 100644
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
> index 0873ee4084aa..53cb6ab405b5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -134,14 +134,9 @@ struct dw_pcie_host_ops {
>  	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>  			     unsigned int devfn, int where, int size, u32 val);
>  	int (*host_init)(struct pcie_port *pp);
> -	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> -	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> -	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
> -	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
>  	void (*scan_bus)(struct pcie_port *pp);
>  	void (*set_num_vectors)(struct pcie_port *pp);
>  	int (*msi_host_init)(struct pcie_port *pp);
> -	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
>  };
>  
>  struct pcie_port {
> 

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
