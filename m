Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A24C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A6A206B2
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A6A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405598AbeKWDG2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:06:28 -0500
Received: from foss.arm.com ([217.140.101.70]:53296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391325AbeKWDG2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 22:06:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30F691684;
        Thu, 22 Nov 2018 08:26:23 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 876643F5A0;
        Thu, 22 Nov 2018 08:26:21 -0800 (PST)
Date:   Thu, 22 Nov 2018 16:26:16 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
Message-ID: <20181122162616.GA17826@e107981-ln.cambridge.arm.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
 <86a7mcdlwg.wl-marc.zyngier@arm.com>
 <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 22, 2018 at 12:03:25PM +0000, Gustavo Pimentel wrote:
> 
> Hi all,
> 
> 
> > 
> > I just realised (at 1am!) that the first patch is awfully buggy:
> > - ENABLE and MASK have opposite polarities
> > - There is nothing initialising the ENABLE and MASK registers
> > 
> > I've stashed the following fix-up on top of the existing series:
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index f06e67c60593..0fa9e8fdce66 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -166,7 +166,7 @@ static void dw_pci_bottom_mask(struct irq_data *data)
> 
> (snip)
> 
> I used your patch and made it more perceptible in my opinion, (basically I
> transformed the variable irq_mask (previous irq_status) into a mirror of MASK
> registers, which removed the need for the *NOT* operation and forced the mask
> operation swap in the callbacks)
> 
> Lorenzo can you apply this fix-up in your branch test/pci-dwc-msi? Maybe merging
> with eca44651920c ("PCI: designware: Move interrupt acking into the proper
> callback"), perhaps.
> 
> I've tested Marc's patch series (with and without my fix-up and both) with a
> NVme EP that generates a burst of 19 MSI-X interrupts. Both approaches are
> working fine.

I want to see more testing before getting this series merged upstream,
especially for the platform configurations on which this bug was
reported.

I am a bit annoyed with DWC platform maintainers in this regard.

> Just a couple of suggestions Lorenzo, maybe you could exchange the *designware*
> by *dwc* on all patch series titles and on eca44651920c("PCI: designware: Move
> interrupt acking into the proper callback") replace *acking* by *ACKing* like
> previous patch has.
> 
> Marc thanks for this patch fix! :)
> 
> Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0fa9e8f..a5132b3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>                 res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>                 bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> 
> -               pp->irq_status[ctrl] &= ~(1 << bit);
> +               pp->irq_mask[ctrl] |= BIT(bit);
>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -                                   ~pp->irq_status[ctrl]);
> +                                   pp->irq_mask[ctrl]);
>         }
> 
>         raw_spin_unlock_irqrestore(&pp->lock, flags);
> @@ -187,30 +187,30 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>                 res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>                 bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> 
> -               pp->irq_status[ctrl] |= 1 << bit;
> +               pp->irq_mask[ctrl] &= ~BIT(bit);
>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -                                   ~pp->irq_status[ctrl]);
> +                                   pp->irq_mask[ctrl]);
>         }
> 
>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
> 
> -static void dw_pci_bottom_ack(struct irq_data *d)
> +static void dw_pci_bottom_ack(struct irq_data *data)
>  {
> -       struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
> +       struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>         unsigned int res, bit, ctrl;
>         unsigned long flags;
> 
> -       ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +       ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>         res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -       bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +       bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> 
>         raw_spin_lock_irqsave(&pp->lock, flags);
> 
> -       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
> +       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
> 
>         if (pp->ops->msi_irq_ack)
> -               pp->ops->msi_irq_ack(d->hwirq, pp);
> +               pp->ops->msi_irq_ack(data->hwirq, pp);

Changes in this hunk are unrelated, I won't squash them in.

Lorenzo

> 
>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
> @@ -665,13 +665,13 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> 
>         /* Initialize IRQ Status array */
>         for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +               pp->irq_mask[ctrl] = ~0;
>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
>                                         (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -                                   4, ~0);
> +                                   4, pp->irq_mask[ctrl]);
>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
>                                         (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>                                     4, ~0);
> -               pp->irq_status[ctrl] = 0;
>         }
> 
>         /* Setup RC BARs */
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> b/drivers/pci/controller/dwc/pcie-designware.h
> index 0989d88..9d1614a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -169,7 +169,7 @@ struct pcie_port {
>         struct irq_domain       *msi_domain;
>         dma_addr_t              msi_data;
>         u32                     num_vectors;
> -       u32                     irq_status[MAX_MSI_CTRLS];
> +       u32                     irq_mask[MAX_MSI_CTRLS];
>         raw_spinlock_t          lock;
>         DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  };
> 
