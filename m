Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9265C10F04
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 04:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E736222CC
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 04:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lrTYvZUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395538AbfBNE6J (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:58:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47648 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfBNE6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 23:58:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E4vw6C130603;
        Wed, 13 Feb 2019 22:57:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550120278;
        bh=0r2KG+zwzX+y+OPeW0WEBpZEKoQWWookDFGNCXvFXvg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lrTYvZUcPqPmVzh28HBsrxq4MStaa7SfKibYsF+7ra91IPxNpr+HvW14JUplKvdsN
         k1NuwlopT0GWvG9Y6TFiBZ3yV/9rVw03jDc57FLNigAZeP8y+Y9agiFzVMI2goNlgB
         HSkLS+30CSrPcQ6nz6mHCv6CBL5c58JUExTt5Qn4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E4vwD8013089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 22:57:58 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 22:57:57 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 22:57:57 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E4vstg027561;
        Wed, 13 Feb 2019 22:57:55 -0600
Subject: Re: [PATCH v3 3/9] PCI: keystone: Use hwirq to get the legacy IRQ
 number offset
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190213132629.24790-1-kishon@ti.com>
 <20190213132629.24790-4-kishon@ti.com>
 <20190213165739.GE2280@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8028b0e2-ac32-4e36-c87d-6f4818f34301@ti.com>
Date:   Thu, 14 Feb 2019 10:27:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190213165739.GE2280@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 13/02/19 10:27 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 13, 2019 at 06:56:23PM +0530, Kishon Vijay Abraham I wrote:
>> ks_pcie_legacy_irq_handler() uses 'virq' to get the IRQ number offset.
>> This offset is used to get the correct IRQ_STATUS register
>> corresponding to the IRQ line that raised the interrupt.
>> There is no guarantee that 'virq' assigned for consecutive hardware
>> IRQ will be contiguous. And this might get us an incorrect IRQ number
>> offset.
>>
>> Fix it here by using 'hwirq' to get the IRQ number offset.
>>
>> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index e8b1d8eca78e..d35ac712a9f8 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -87,7 +87,7 @@ struct keystone_pcie {
>>  	struct dw_pcie		*pci;
>>  	/* PCI Device ID */
>>  	u32			device_id;
>> -	int			legacy_host_irqs[PCI_NUM_INTX];
>> +	int			legacy_host_irq;
>>  	struct			device_node *legacy_intc_np;
>>  
>>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
>> @@ -582,11 +582,11 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>>   */
>>  static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>  {
>> -	unsigned int irq = irq_desc_get_irq(desc);
>> +	unsigned int irq = desc->irq_data.hwirq;
>>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>>  	struct dw_pcie *pci = ks_pcie->pci;
>>  	struct device *dev = pci->dev;
>> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>> +	u32 irq_offset = irq - ks_pcie->legacy_host_irq;
> 
> I think you should use the plain hwirq number (that if I understand
> correctly range in [0,3]) and drop legacy_host_irq.

The hwirq is [80, 83] for Keystone. We store legacy_host_irq (for Keystone it
is 80) to get the correct offset in the range [0, 3].
> 
> See below.
> 
>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>>  
>>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>> @@ -657,6 +657,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>  	struct device_node *np = ks_pcie->np;
>>  	struct device_node *intc_np;
>>  	int irq_count, irq, ret, i;
>> +	struct irq_data *irq_data;
>>  
>>  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
>>  	if (!intc_np) {
>> @@ -677,7 +678,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>  			ret = -EINVAL;
>>  			goto err;
>>  		}
>> -		ks_pcie->legacy_host_irqs[i] = irq;
>> +
>> +		if (!ks_pcie->legacy_host_irq) {
>> +			irq_data = irq_get_irq_data(irq);
>> +			if (!irq_data) {
>> +				ret = -EINVAL;
>> +				goto err;
>> +			}
>> +			ks_pcie->legacy_host_irq = irq_data->hwirq;
> 
> This depends on DT property ordering and may well be wrong. On top
> of that as I said above I do not think it is even needed.

right, it depends on the ordering of the entries in the "interrupts" property.
Right now we have something like below

                               interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
                                        <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
                                        <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
                                        <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>;

And changing the order will make legacy_host_irq store the wrong hwirq. With
this patch we solve the problem of assuming virq to be contiguous for
contiguous hwirq however we do expect the hwirqs to be populated in the DT in
the correct order.

Ordering entries within a property is also followed in other properties like
"reg" where the drivers use platform_get_resource with index as argument. I'm
not sure if there's a way to get rid of the ordering requirement in DT for the
"interrupts" property.

Thanks
Kishon
