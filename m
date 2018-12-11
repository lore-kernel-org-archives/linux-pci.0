Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C36C07E85
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33F02082F
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 12:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33F02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLKMgA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 07:36:00 -0500
Received: from foss.arm.com ([217.140.101.70]:46428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbeLKMf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 07:35:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C21715AB;
        Tue, 11 Dec 2018 04:35:59 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5313F6A8;
        Tue, 11 Dec 2018 04:35:57 -0800 (PST)
Date:   Tue, 11 Dec 2018 12:35:50 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        faiz_abbas@ti.com, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
Message-ID: <20181211123550.GA31209@e107981-ln.cambridge.arm.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <20181113225734.8026-4-marc.zyngier@arm.com>
 <126f12da-b69d-ae3a-72bf-dc1bff22cd77@ti.com>
 <20181204134559.74957d43@why.wild-wind.fr.eu.org>
 <251318fd-c72c-3082-ac10-99f4312cbd52@ti.com>
 <1ff77544-fc1a-6569-1919-3f169319153f@arm.com>
 <abb906f9-dbec-8f39-677e-687c0bd4e266@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb906f9-dbec-8f39-677e-687c0bd4e266@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 03:43:00PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 07/12/18 3:15 PM, Marc Zyngier wrote:
> > On 07/12/2018 08:12, Kishon Vijay Abraham I wrote:
> >> Hi Marc,
> >>
> >> On 04/12/18 7:15 PM, Marc Zyngier wrote:
> >>> On Tue, 4 Dec 2018 15:50:32 +0530
> >>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> On 14/11/18 4:27 AM, Marc Zyngier wrote:
> >>>>> The write to the status register is really an ACK for the HW,
> >>>>> and should be treated as such by the driver. Let's move it to the
> >>>>> irq_ack callback, which will prevent people from moving it around
> >>>>> in order to paper over other bugs.
> >>>>>
> >>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >>>>> ---
> >>>>>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
> >>>>>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >>>>> index 0a76948ed49e..f06e67c60593 100644
> >>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >>>>> @@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> >>>>>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
> >>>>>  					       pos);
> >>>>>  			generic_handle_irq(irq);
> >>>>> -			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
> >>>>> -						(i * MSI_REG_CTRL_BLOCK_SIZE),
> >>>>> -					    4, 1 << pos);
> >>>>>  			pos++;
> >>>>>  		}
> >>>>>  	}
> >>>>> @@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
> >>>>>  
> >>>>>  static void dw_pci_bottom_ack(struct irq_data *d)
> >>>>>  {
> >>>>> -	struct msi_desc *msi = irq_data_get_msi_desc(d);
> >>>>> -	struct pcie_port *pp;
> >>>>> +	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
> >>>>> +	unsigned int res, bit, ctrl;
> >>>>>  	unsigned long flags;
> >>>>>  
> >>>>> -	pp = msi_desc_to_pci_sysdata(msi);
> >>>>> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
> >>>>> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> >>>>> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
> >>>>>  
> >>>>>  	raw_spin_lock_irqsave(&pp->lock, flags);
> >>>>>  
> >>>>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);  
> >>>>
> >>>> This register should be written only if msi_irq_ack callback is not populated
> >>>> similar to other dw_pci_bottom_*() functions.
> >>>
> >>> Why? This was so far unconditionally written, and my understanding is
> >>> that without this write, no further MSI can be delivered.
> >>
> >> Not all platforms invoke dw_handle_msi_irq() for handling MSI irq.
> >>
> >> Platforms that doesn't use the MSI functionality of Designware makes use of the
> >> various callbacks like msi_irq_ack, msi_host_init etc., Keystone has MSI
> >> controller in the Keystone wrapper, AM654 uses GIC ITS etc.,
> >>
> >> The platforms that doesn't use MSI functionality of Designware doesn't have to
> >> write to Designware's MSI configuration registers.
> > 
> > Let's be clear: a platform that doesn't use the DW MSI functionality
> > should never get anywhere this code. If they do, then that's a terrible
> > bug, and it should be fixed by making the TI stuff standalone instead of
> > calling into the internals.
> 
> That makes sense to me. We can start by removing msi_set_irq, msi_clear_irq and
> msi_irq_ack callbacks from dw_pcie_host_ops.
> 
> This functionality can be added directly in keystone driver.
> > 
> > Frankly, this whole thing should be marked as BROKEN until it is sorted
> > out for good.
> 
> Maybe remove those callbacks and make only Keystone broken?

Hi Kishon, Murali,

Is it possible to rework keystone as discussed on this thread on top of
my pci/dwc-msi branch please ?

Thanks,
Lorenzo
