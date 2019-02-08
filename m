Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE5AC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 11:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B0A218D9
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 11:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NKZG0jMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfBHLKC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:10:02 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:44494 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 06:10:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x18B9pxv059341;
        Fri, 8 Feb 2019 05:09:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549624191;
        bh=2+giqlVPw6Y7QdLfe97MgsAj8BxL9rL+/csqrEH98sM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NKZG0jMJoFOQVq1G8BoBApjW8fu9mHsCuhXbo6Y7X/c5DzVU2/xwGwu++mEG2PMSB
         Ky4Pxdq48EIZaaqtGayQXY8KT3/WiXBIT3yZb9xGQsxesohIIte+5FmoSAkudx34an
         GbLsyoIJjgo8pgBRqLz/RrGqTLoUcX7TttUSQAQc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x18B9pNj094824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Feb 2019 05:09:51 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Feb 2019 05:09:50 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Feb 2019 05:09:50 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x18B9liT022440;
        Fri, 8 Feb 2019 05:09:48 -0600
Subject: Re: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check
 the IRQ_STATUS of INTA/B/C/D
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-3-kishon@ti.com> <20190207205257.GM7268@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <bd4bd3ec-56d5-db60-e074-1a6a36b303f9@ti.com>
Date:   Fri, 8 Feb 2019 16:39:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207205257.GM7268@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 08/02/19 2:22 AM, Bjorn Helgaas wrote:
> In the subject, "legacy_irq_handler" looks like it's supposed to be a
> function name, but it's not.  Maybe something like:
> 
>   PCI: keystone: Check INTA/B/C/D IRQ_STATUS in ks_pcie_legacy_irq_handler()
> 
> On Thu, Feb 07, 2019 at 04:39:17PM +0530, Kishon Vijay Abraham I wrote:
>> The legacy interrupt handler directly checks the IRQ_STATUS register
>> corresponding to a interrupt line inorder to invoke generic_handle_irq.
> 
> s/The legacy interrupt handler/ks_pcie_handle_legacy_irq()/ ?
> s/to a/to an/
> s/inorder/in order/
> s/generic_handle_irq/generic_handle_irq()/
> 
>> While this is okay for K2G platform which has separate interrupt line for
>> each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
>> has a single interrupt line for all the legacy interrupts. So for AM654
>> the interrupt handler won't be able to directly check the IRQ_STATUS
>> register corresponding to the interrupt line.
> 
> s/platform which/platform, which/
> s/separate interrupt line/separate interrupt lines/
> s/AM654 which/AM654, which/
> s/PCIe wrapper/PCIe wrapper,/
> s/interrupt line for all/interrupt line shared by all/
> 
> 
>> Also the legacy interrupt handler uses 'virq' obtained from
>> irq_of_parse_and_map to find the correct interrupt line which raised the
>> interrupt. There is no guarantee that virq assigned for contiguous hardware
>> irq will be contiguous and the interrupt handler might end up checking
>> the wrong IRQ_STATUS register.
> 
> s/irq_of_parse_and_map/irq_of_parse_and_map()
> s/irq will/IRQ will/
> 
>> In order to overcome the above issues, read the IRQ_STATUS register of
>> all the 4 legacy interrupts to determine which interrupt was raised.
>>
>> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 5286a480f76b..4cf9849d5a1d 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>>  {
>>  	struct dw_pcie *pci = ks_pcie->pci;
>>  	struct device *dev = pci->dev;
>> -	u32 pending;
>>  	int virq;
>>  
>> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
>> -
>> -	if (BIT(0) & pending) {
>> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
>> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
>> -		generic_handle_irq(virq);
>> -	}
>> +	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
>> +	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
>> +	generic_handle_irq(virq);
>>  
>>  	/* EOI the INTx interrupt */
>>  	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
>> @@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>>  	struct dw_pcie *pci = ks_pcie->pci;
>>  	struct device *dev = pci->dev;
>> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	unsigned int irq_no;
>> +	u32 reg;
>>  
>>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>>  
>> @@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>  	 * ack operation.
>>  	 */
>>  	chained_irq_enter(chip, desc);
>> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
>> +	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {
>> +		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
>> +		if (!(reg & INTx_EN))
>> +			continue;
>> +		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);
> 
> It's too bad that reading IRQ_STATUS and writing IRQ_EOI are now in
> separate functions.  It's nice to have them together for code auditing
> purposes.
> 
> Could maybe accumulate a mask of which INTx bits are set and call
> ks_pcie_handle_legacy_irq() only once with that mask?  Of course, then
> you'd need another loop in ks_pcie_handle_legacy_irq().

Patch "5" of this series "PCI: keystone: Cleanup ks_pcie_msi_irq_handler and
ks_pcie_legacy_irq_handler" does more cleanup in irq handler and there
ks_pcie_handle_legacy_irq is removed and everything is done in a single function.

I have to anyway revisit legacy irq handler and have some of the register
writes move to proper irq_chip callbacks as Lorenzo commented in [1]

[1] -> https://lkml.org/lkml/2019/1/24/333

Thanks
Kishon
