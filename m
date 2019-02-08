Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB673C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A037C20863
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 05:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rdXaV2Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfBHFO0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:14:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48120 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBHFOZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 00:14:25 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x185EGqU002615;
        Thu, 7 Feb 2019 23:14:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549602856;
        bh=uv/vDbobEA/423bYmegRzWeDlsmKJhcSL5IECCFS2Jo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rdXaV2Kj9NG4HuETzh3rEo35DD6ctJP1JwLlFL6SP7sO3eWVO5FbXk6waxN8HvP1r
         44JZOMfP7wMtRudJZZ1x/zMc4B9cqPboUVpglaEtEW2Kae2MigP/VGtApOsmfRvPR7
         TcycPqK1eF6RIzuxNkd0AfsZZbhHGwiks+54+KnU=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x185EGri027207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Feb 2019 23:14:16 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 23:14:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 23:14:15 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x185ECjw002829;
        Thu, 7 Feb 2019 23:14:13 -0600
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific
 dw_pcie_host_ops
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-9-kishon@ti.com> <20190207212622.GO7268@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <2b839b2f-d792-069b-b45f-4a455335f016@ti.com>
Date:   Fri, 8 Feb 2019 10:43:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207212622.GO7268@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 08/02/19 2:56 AM, Bjorn Helgaas wrote:
> On Thu, Feb 07, 2019 at 04:39:23PM +0530, Kishon Vijay Abraham I wrote:
>> Now that Keystone started using it's own msi_irq_chip, remove
>> Keystone specific callback function defined in dw_pcie_host_ops.
> 
> s/it's/its/
> s/callback function/callback functions/

okay.
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>>  .../pci/controller/dwc/pcie-designware-host.c | 45 ++++++-------------
>>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ---
>>  2 files changed, 14 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index 042de09b0451..9492b05e8ff0 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -126,18 +126,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>  	u64 msi_target;
>>  
>> -	if (pp->ops->get_msi_addr)
>> -		msi_target = pp->ops->get_msi_addr(pp);
>> -	else
>> -		msi_target = (u64)pp->msi_data;
>> +	msi_target = (u64)pp->msi_data;
>>  
>>  	msg->address_lo = lower_32_bits(msi_target);
>>  	msg->address_hi = upper_32_bits(msi_target);
>>  
>> -	if (pp->ops->get_msi_data)
>> -		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
>> -	else
>> -		msg->data = data->hwirq;
>> +	msg->data = data->hwirq;
>>  
>>  	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
>>  		(int)data->hwirq, msg->address_hi, msg->address_lo);
>> @@ -157,17 +151,13 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>>  
>>  	raw_spin_lock_irqsave(&pp->lock, flags);
>>  
>> -	if (pp->ops->msi_clear_irq) {
>> -		pp->ops->msi_clear_irq(pp, data->hwirq);
>> -	} else {
>> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>> -		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>> +	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>> +	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>  
>> -		pp->irq_status[ctrl] &= ~(1 << bit);
>> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> -				    ~pp->irq_status[ctrl]);
>> -	}
>> +	pp->irq_status[ctrl] &= ~(1 << bit);
>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> +			    ~pp->irq_status[ctrl]);
>>  
>>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>  }
>> @@ -180,17 +170,13 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>>  
>>  	raw_spin_lock_irqsave(&pp->lock, flags);
>>  
>> -	if (pp->ops->msi_set_irq) {
>> -		pp->ops->msi_set_irq(pp, data->hwirq);
>> -	} else {
>> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>> -		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>> +	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
>> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>> +	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>  
>> -		pp->irq_status[ctrl] |= 1 << bit;
>> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> -				    ~pp->irq_status[ctrl]);
>> -	}
>> +	pp->irq_status[ctrl] |= 1 << bit;
>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
>> +			    ~pp->irq_status[ctrl]);
>>  
>>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>  }
>> @@ -209,9 +195,6 @@ static void dw_pci_bottom_ack(struct irq_data *d)
>>  
>>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
>>  
>> -	if (pp->ops->msi_irq_ack)
>> -		pp->ops->msi_irq_ack(d->hwirq, pp);
>> -
>>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>  }
>>  
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 95e0c3c93f48..ea4b215b605d 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -142,14 +142,9 @@ struct dw_pcie_host_ops {
>>  	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>>  			     unsigned int devfn, int where, int size, u32 val);
>>  	int (*host_init)(struct pcie_port *pp);
>> -	void (*msi_set_irq)(struct pcie_port *pp, int irq);
>> -	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
>> -	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
>> -	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
> 
> I don't see the whole series on linux-pci (I only see patches 2, 6, 8, 9),

I do see all the patches here
https://patchwork.kernel.org/project/linux-pci/list/. Maybe it arrived little late?
> but I expected to somewhere see the removal of assignments to these
> pointers.  It would be easier to review if the removal of assignments and
> the removal of the function pointers from the structure were in the same
> patch, but maybe that's not really feasible.

The removal of the assignments are in 7th patch of the series (PCI: keystone:
Use Keystone specific msi_irq_chip). It's feasible but just wanted to keep the
keystone changes and DesignWare changes in separate patches.

Thanks
Kishon
