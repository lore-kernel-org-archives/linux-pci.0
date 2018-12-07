Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98478C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671B92083D
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 10:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671B92083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGKNS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:13:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35256 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGKNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 05:13:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB7ADCl8033404;
        Fri, 7 Dec 2018 04:13:12 -0600
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB7ADCmp108257
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 04:13:12 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 04:13:11 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 04:13:11 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7AD8sv002580;
        Fri, 7 Dec 2018 04:13:09 -0600
Subject: Re: [PATCH 3/3] PCI: designware: Move interrupt acking into the
 proper callback
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@google.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <faiz_abbas@ti.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
        Vignesh R <vigneshr@ti.com>
References: <20181113225734.8026-1-marc.zyngier@arm.com>
 <20181113225734.8026-4-marc.zyngier@arm.com>
 <126f12da-b69d-ae3a-72bf-dc1bff22cd77@ti.com>
 <20181204134559.74957d43@why.wild-wind.fr.eu.org>
 <251318fd-c72c-3082-ac10-99f4312cbd52@ti.com>
 <1ff77544-fc1a-6569-1919-3f169319153f@arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <abb906f9-dbec-8f39-677e-687c0bd4e266@ti.com>
Date:   Fri, 7 Dec 2018 15:43:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1ff77544-fc1a-6569-1919-3f169319153f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 07/12/18 3:15 PM, Marc Zyngier wrote:
> On 07/12/2018 08:12, Kishon Vijay Abraham I wrote:
>> Hi Marc,
>>
>> On 04/12/18 7:15 PM, Marc Zyngier wrote:
>>> On Tue, 4 Dec 2018 15:50:32 +0530
>>> Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>>
>>>> Hi,
>>>>
>>>> On 14/11/18 4:27 AM, Marc Zyngier wrote:
>>>>> The write to the status register is really an ACK for the HW,
>>>>> and should be treated as such by the driver. Let's move it to the
>>>>> irq_ack callback, which will prevent people from moving it around
>>>>> in order to paper over other bugs.
>>>>>
>>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>>> ---
>>>>>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
>>>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> index 0a76948ed49e..f06e67c60593 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> @@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>>>>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
>>>>>  					       pos);
>>>>>  			generic_handle_irq(irq);
>>>>> -			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>>>>> -						(i * MSI_REG_CTRL_BLOCK_SIZE),
>>>>> -					    4, 1 << pos);
>>>>>  			pos++;
>>>>>  		}
>>>>>  	}
>>>>> @@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>>>>>  
>>>>>  static void dw_pci_bottom_ack(struct irq_data *d)
>>>>>  {
>>>>> -	struct msi_desc *msi = irq_data_get_msi_desc(d);
>>>>> -	struct pcie_port *pp;
>>>>> +	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
>>>>> +	unsigned int res, bit, ctrl;
>>>>>  	unsigned long flags;
>>>>>  
>>>>> -	pp = msi_desc_to_pci_sysdata(msi);
>>>>> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>>>>> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>>>> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>>>>  
>>>>>  	raw_spin_lock_irqsave(&pp->lock, flags);
>>>>>  
>>>>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);  
>>>>
>>>> This register should be written only if msi_irq_ack callback is not populated
>>>> similar to other dw_pci_bottom_*() functions.
>>>
>>> Why? This was so far unconditionally written, and my understanding is
>>> that without this write, no further MSI can be delivered.
>>
>> Not all platforms invoke dw_handle_msi_irq() for handling MSI irq.
>>
>> Platforms that doesn't use the MSI functionality of Designware makes use of the
>> various callbacks like msi_irq_ack, msi_host_init etc., Keystone has MSI
>> controller in the Keystone wrapper, AM654 uses GIC ITS etc.,
>>
>> The platforms that doesn't use MSI functionality of Designware doesn't have to
>> write to Designware's MSI configuration registers.
> 
> Let's be clear: a platform that doesn't use the DW MSI functionality
> should never get anywhere this code. If they do, then that's a terrible
> bug, and it should be fixed by making the TI stuff standalone instead of
> calling into the internals.

That makes sense to me. We can start by removing msi_set_irq, msi_clear_irq and
msi_irq_ack callbacks from dw_pcie_host_ops.

This functionality can be added directly in keystone driver.
> 
> Frankly, this whole thing should be marked as BROKEN until it is sorted
> out for good.

Maybe remove those callbacks and make only Keystone broken?

Thanks
Kishon
