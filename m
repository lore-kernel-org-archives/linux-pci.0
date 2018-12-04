Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FCFC04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E6E206B7
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 13:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E6E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLDNqG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:46:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbeLDNqG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Dec 2018 08:46:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E44D80D;
        Tue,  4 Dec 2018 05:46:05 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E7373F59C;
        Tue,  4 Dec 2018 05:46:03 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:45:59 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <faiz_abbas@ti.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
Message-ID: <20181204134559.74957d43@why.wild-wind.fr.eu.org>
In-Reply-To: <126f12da-b69d-ae3a-72bf-dc1bff22cd77@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
        <20181113225734.8026-4-marc.zyngier@arm.com>
        <126f12da-b69d-ae3a-72bf-dc1bff22cd77@ti.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Dec 2018 15:50:32 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Hi,
> 
> On 14/11/18 4:27 AM, Marc Zyngier wrote:
> > The write to the status register is really an ACK for the HW,
> > and should be treated as such by the driver. Let's move it to the
> > irq_ack callback, which will prevent people from moving it around
> > in order to paper over other bugs.
> > 
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 0a76948ed49e..f06e67c60593 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> >  					       (i * MAX_MSI_IRQS_PER_CTRL) +
> >  					       pos);
> >  			generic_handle_irq(irq);
> > -			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
> > -						(i * MSI_REG_CTRL_BLOCK_SIZE),
> > -					    4, 1 << pos);
> >  			pos++;
> >  		}
> >  	}
> > @@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
> >  
> >  static void dw_pci_bottom_ack(struct irq_data *d)
> >  {
> > -	struct msi_desc *msi = irq_data_get_msi_desc(d);
> > -	struct pcie_port *pp;
> > +	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
> > +	unsigned int res, bit, ctrl;
> >  	unsigned long flags;
> >  
> > -	pp = msi_desc_to_pci_sysdata(msi);
> > +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> > +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> > +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
> >  
> >  	raw_spin_lock_irqsave(&pp->lock, flags);
> >  
> > +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);  
> 
> This register should be written only if msi_irq_ack callback is not populated
> similar to other dw_pci_bottom_*() functions.

Why? This was so far unconditionally written, and my understanding is
that without this write, no further MSI can be delivered.

What makes you think otherwise?

	M.
-- 
Without deviation from the norm, progress is not possible.
