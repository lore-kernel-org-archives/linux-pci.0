Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD64BC07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 08:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F4C20989
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 08:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ReoFjygn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F4C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLGINQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:13:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGINQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Dec 2018 03:13:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB78D9kQ071172;
        Fri, 7 Dec 2018 02:13:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544170389;
        bh=MrkRsSd7bFXU6+jc1gDdjsl19w+EVxyQHnMHDCawjNs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ReoFjygnmsdNtfsc0UM9rFQQCgWYk1YLY+YkqAaHSKZhFRCLxLbynjG4vSGHAT2aQ
         n/dOn3wtyVqMBotDCQUU7W+m2Cvbj2irQxIJ0A4l1RNDVimZ8j3k5uDuhINZLgiMLc
         BRde2UV1k/O88t/BR2B41PsDFEUA0UUbmp6LMnrQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB78D9Xb127315
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 02:13:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 02:13:08 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 02:13:08 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB78D5c3002587;
        Fri, 7 Dec 2018 02:13:06 -0600
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
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <251318fd-c72c-3082-ac10-99f4312cbd52@ti.com>
Date:   Fri, 7 Dec 2018 13:42:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204134559.74957d43@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 04/12/18 7:15 PM, Marc Zyngier wrote:
> On Tue, 4 Dec 2018 15:50:32 +0530
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
>> Hi,
>>
>> On 14/11/18 4:27 AM, Marc Zyngier wrote:
>>> The write to the status register is really an ACK for the HW,
>>> and should be treated as such by the driver. Let's move it to the
>>> irq_ack callback, which will prevent people from moving it around
>>> in order to paper over other bugs.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>>  drivers/pci/controller/dwc/pcie-designware-host.c | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 0a76948ed49e..f06e67c60593 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -99,9 +99,6 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>>  					       (i * MAX_MSI_IRQS_PER_CTRL) +
>>>  					       pos);
>>>  			generic_handle_irq(irq);
>>> -			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>>> -						(i * MSI_REG_CTRL_BLOCK_SIZE),
>>> -					    4, 1 << pos);
>>>  			pos++;
>>>  		}
>>>  	}
>>> @@ -200,14 +197,18 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>>>  
>>>  static void dw_pci_bottom_ack(struct irq_data *d)
>>>  {
>>> -	struct msi_desc *msi = irq_data_get_msi_desc(d);
>>> -	struct pcie_port *pp;
>>> +	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
>>> +	unsigned int res, bit, ctrl;
>>>  	unsigned long flags;
>>>  
>>> -	pp = msi_desc_to_pci_sysdata(msi);
>>> +	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
>>> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
>>> +	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
>>>  
>>>  	raw_spin_lock_irqsave(&pp->lock, flags);
>>>  
>>> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);  
>>
>> This register should be written only if msi_irq_ack callback is not populated
>> similar to other dw_pci_bottom_*() functions.
> 
> Why? This was so far unconditionally written, and my understanding is
> that without this write, no further MSI can be delivered.

Not all platforms invoke dw_handle_msi_irq() for handling MSI irq.

Platforms that doesn't use the MSI functionality of Designware makes use of the
various callbacks like msi_irq_ack, msi_host_init etc., Keystone has MSI
controller in the Keystone wrapper, AM654 uses GIC ITS etc.,

The platforms that doesn't use MSI functionality of Designware doesn't have to
write to Designware's MSI configuration registers.

Thanks
Kishon
