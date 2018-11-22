Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD2C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 17:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2906F20865
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gsqb28PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2906F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404414AbeKWEYi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:24:38 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39816 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389307AbeKWEYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 23:24:38 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7CDA024E16AE;
        Thu, 22 Nov 2018 09:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542908654; bh=EGHuR/k8ict056i92iFmBw5dKMMZYR7L2AOeJIYNqfk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=Gsqb28PJohqeX1ssjmewEgyVJqSB0k6Uycef+trMwx8YqcSYalFYNT9JGRBpz5ELL
         OLSXO8+KE1iqbzFe/tRNRjjTCxpgOvvNP2//bNHTMB8uY8ewXwvaWlx/uRL4AbOVDU
         YsOftHMNe0FfMWcg1qBAfb0lrap8nbulUaPdYCVnOSodAX6rRGH3xID8QcBvk158c7
         6cXV/rKJOKGqet1X7FeOwsRbWUvCBGParduZJvL1QEdVzU0QhnawaDvYc+93MNm40Y
         wNzpHYcRggmrYoDHUmQgwc+RBWkuAX2hbk31k2O8ALlhozsdQxS803WlIHbOF5FHr7
         VJzm4cbNF+aCQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5B742378B;
        Thu, 22 Nov 2018 09:44:14 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 22 Nov 2018 09:44:14 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 22 Nov 2018 18:44:12 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 22 Nov 2018 18:44:11 +0100
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <e73891a5-d798-ee9c-607c-9648d07f6505@synopsys.com>
 <86a7mcdlwg.wl-marc.zyngier@arm.com>
 <9b63c20b-f928-7c40-2734-00ed783625f5@synopsys.com>
 <20181122162616.GA17826@e107981-ln.cambridge.arm.com>
 <1d83d4e5-3cfc-3fc4-f875-c25b5ae3284f@arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <86c6e725-8bb8-4223-8dc2-1b49672d765f@synopsys.com>
Date:   Thu, 22 Nov 2018 17:40:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1d83d4e5-3cfc-3fc4-f875-c25b5ae3284f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/11/2018 16:38, Marc Zyngier wrote:
> On 22/11/2018 16:26, Lorenzo Pieralisi wrote:
>> On Thu, Nov 22, 2018 at 12:03:25PM +0000, Gustavo Pimentel wrote:
> 
> [...]
> 
>>> Just a couple of suggestions Lorenzo, maybe you could exchange the *designware*
>>> by *dwc* on all patch series titles and on eca44651920c("PCI: designware: Move
>>> interrupt acking into the proper callback") replace *acking* by *ACKing* like
>>> previous patch has.
>>>
>>> Marc thanks for this patch fix! :)
>>>
>>> Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 0fa9e8f..a5132b3 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>>>                 res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>>                 bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>>
>>> -               pp->irq_status[ctrl] &= ~(1 << bit);
>>> +               pp->irq_mask[ctrl] |= BIT(bit);
>>>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>>> -                                   ~pp->irq_status[ctrl]);
>>> +                                   pp->irq_mask[ctrl]);
>>>         }
>>>
>>>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>>> @@ -187,30 +187,30 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>>>                 res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>>                 bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>>
>>> -               pp->irq_status[ctrl] |= 1 << bit;
>>> +               pp->irq_mask[ctrl] &= ~BIT(bit);
>>>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>>> -                                   ~pp->irq_status[ctrl]);
>>> +                                   pp->irq_mask[ctrl]);
>>>         }
>>>
>>>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>>>  }
>>>
>>> -static void dw_pci_bottom_ack(struct irq_data *d)
>>> +static void dw_pci_bottom_ack(struct irq_data *data)
>>>  {
>>> -       struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
>>> +       struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>>>         unsigned int res, bit, ctrl;
>>>         unsigned long flags;
>>>
>>> -       ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>>> +       ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>>>         res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>> -       bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>> +       bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>>
>>>         raw_spin_lock_irqsave(&pp->lock, flags);
>>>
>>> -       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
>>> +       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
>>>
>>>         if (pp->ops->msi_irq_ack)
>>> -               pp->ops->msi_irq_ack(d->hwirq, pp);
>>> +               pp->ops->msi_irq_ack(data->hwirq, pp);
>>
>> Changes in this hunk are unrelated, I won't squash them in.
> 
> To add to Lorenzo's comment, we're trying hard to have a *minimal* fix
> that can be easily backported. Changing variable and field names as well
> as flipping the semantic of other bits of the driver makes it harder to
> review, and certainly doesn't help getting things backported to stable
> (see the stable kernel rules).
> 
> I'd suggest this kind of repainting is better kept as a separate patch
> and merged separately.

Makes sense.

Gustavo

> 
> Thanks,
> 
> 	M.
> 

