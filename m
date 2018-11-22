Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4C9C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB4120865
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 16:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB4120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404303AbeKWDSi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:18:38 -0500
Received: from foss.arm.com ([217.140.101.70]:53526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388792AbeKWDSi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 22:18:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD941684;
        Thu, 22 Nov 2018 08:38:30 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA0B3F5A0;
        Thu, 22 Nov 2018 08:38:29 -0800 (PST)
Subject: Re: [PATCH 0/3] PCI: designware: Fixing MSI handling flow
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <1d83d4e5-3cfc-3fc4-f875-c25b5ae3284f@arm.com>
Date:   Thu, 22 Nov 2018 16:38:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181122162616.GA17826@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/11/2018 16:26, Lorenzo Pieralisi wrote:
> On Thu, Nov 22, 2018 at 12:03:25PM +0000, Gustavo Pimentel wrote:

[...]

>> Just a couple of suggestions Lorenzo, maybe you could exchange the *designware*
>> by *dwc* on all patch series titles and on eca44651920c("PCI: designware: Move
>> interrupt acking into the proper callback") replace *acking* by *ACKing* like
>> previous patch has.
>>
>> Marc thanks for this patch fix! :)
>>
>> Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 0fa9e8f..a5132b3 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -164,9 +164,9 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>>                 res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>                 bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>
>> -               pp->irq_status[ctrl] &= ~(1 << bit);
>> +               pp->irq_mask[ctrl] |= BIT(bit);
>>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> -                                   ~pp->irq_status[ctrl]);
>> +                                   pp->irq_mask[ctrl]);
>>         }
>>
>>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>> @@ -187,30 +187,30 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>>                 res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>                 bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>
>> -               pp->irq_status[ctrl] |= 1 << bit;
>> +               pp->irq_mask[ctrl] &= ~BIT(bit);
>>                 dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> -                                   ~pp->irq_status[ctrl]);
>> +                                   pp->irq_mask[ctrl]);
>>         }
>>
>>         raw_spin_unlock_irqrestore(&pp->lock, flags);
>>  }
>>
>> -static void dw_pci_bottom_ack(struct irq_data *d)
>> +static void dw_pci_bottom_ack(struct irq_data *data)
>>  {
>> -       struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
>> +       struct pcie_port *pp = irq_data_get_irq_chip_data(data);
>>         unsigned int res, bit, ctrl;
>>         unsigned long flags;
>>
>> -       ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>> +       ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>>         res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>> -       bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>> +       bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>
>>         raw_spin_lock_irqsave(&pp->lock, flags);
>>
>> -       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
>> +       dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, BIT(bit));
>>
>>         if (pp->ops->msi_irq_ack)
>> -               pp->ops->msi_irq_ack(d->hwirq, pp);
>> +               pp->ops->msi_irq_ack(data->hwirq, pp);
> 
> Changes in this hunk are unrelated, I won't squash them in.

To add to Lorenzo's comment, we're trying hard to have a *minimal* fix
that can be easily backported. Changing variable and field names as well
as flipping the semantic of other bits of the driver makes it harder to
review, and certainly doesn't help getting things backported to stable
(see the stable kernel rules).

I'd suggest this kind of repainting is better kept as a separate patch
and merged separately.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
