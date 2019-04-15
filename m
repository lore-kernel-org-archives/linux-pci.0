Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73CC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7114F2075B
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 05:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yUbpPnjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfDOF3y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:29:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54764 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOF3y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 01:29:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3F5TQNP094710;
        Mon, 15 Apr 2019 00:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555306166;
        bh=OFK8PMjatonXU2Owm9onUAoiIknqP8LbMeYI88OM3RU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yUbpPnjV7PYQvWnE7h0bD4C17yU38vctgB5LNO6v3NbQjz/jzs7Di2reOXpQ8fd0Z
         PlY5ArXt8erVXwGkLVpRq+TWt9jl1S5bZmOU1PEDdgTzTrlRO1CCo5BttDV6g+cMqV
         KIpEehwWQDouysKxOqUVEtOMERk2VzDSOmKXF8pg=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3F5TQY4070479
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 00:29:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 00:29:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 00:29:26 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3F5TH27080742;
        Mon, 15 Apr 2019 00:29:21 -0500
Subject: Re: [PATCH v3 02/26] PCI: keystone: Cleanup error_irq configuration
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-kernel@axis.com>, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-3-kishon@ti.com> <20190413140343.GC126710@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <dce994be-ec08-8966-9338-226bba1f5102@ti.com>
Date:   Mon, 15 Apr 2019 10:58:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413140343.GC126710@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 13/04/19 7:33 PM, Bjorn Helgaas wrote:
> Hi Kishon,
> 
> On Mon, Mar 25, 2019 at 03:09:23PM +0530, Kishon Vijay Abraham I wrote:
>> pci-keystone driver uses irq_of_parse_and_map to get irq number of
>> error_irq. Use platform_get_irq instead and move platform_get_irq()
>> and request_irq() of error_irq from ks_pcie_add_pcie_port to ks_pcie_probe
>> since error_irq is common to both RC mode and EP mode.
> 
> Does this have any DT implications?

No. platform_get_irq() uses of_irq_get(), which in-turn uses of_irq_parse_one()
and irq_create_of_mapping() while irq_of_parse_and_map() directly uses
of_irq_parse_one() and irq_create_of_mapping().

The only difference is platform_get_irq() falls back to using
platform_get_resource() if of_irq_get fails.

I thought it's better to use platform_get_irq() for platform devices.

Thanks
Kishon

> 
> It's not obvious that platform_get_irq() and irq_of_parse_and_map() work
> similarly or that they get the same result from DT.
> 
> I'm sure they *do*, but it would be nice to have some hints in the commit
> log about why that's the case.
> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 43 +++++++++--------------
>>  1 file changed, 17 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 07f55b355d75..e50f8773e768 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -98,8 +98,6 @@ struct keystone_pcie {
>>  	struct irq_domain	*legacy_irq_domain;
>>  	struct device_node	*np;
>>  
>> -	int error_irq;
>> -
>>  	/* Application register space */
>>  	void __iomem		*va_app_base;	/* DT 1st resource */
>>  	struct resource		app;
>> @@ -743,12 +741,6 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>  	return ret;
>>  }
>>  
>> -static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
>> -{
>> -	if (ks_pcie->error_irq > 0)
>> -		ks_pcie_enable_error_irq(ks_pcie);
>> -}
>> -
>>  /*
>>   * When a PCI device does not exist during config cycles, keystone host gets a
>>   * bus error instead of returning 0xffffffff. This handler always returns 0
>> @@ -810,7 +802,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
>>  
>>  	ks_pcie_stop_link(pci);
>>  	ks_pcie_setup_rc_app_regs(ks_pcie);
>> -	ks_pcie_setup_interrupts(ks_pcie);
>>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
>>  			pci->dbi_base + PCI_IO_BASE);
>>  
>> @@ -854,23 +845,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>>  	struct device *dev = &pdev->dev;
>>  	int ret;
>>  
>> -	/*
>> -	 * Index 0 is the platform interrupt for error interrupt
>> -	 * from RC.  This is optional.
>> -	 */
>> -	ks_pcie->error_irq = irq_of_parse_and_map(ks_pcie->np, 0);
>> -	if (ks_pcie->error_irq <= 0)
>> -		dev_info(dev, "no error IRQ defined\n");
>> -	else {
>> -		ret = request_irq(ks_pcie->error_irq, ks_pcie_err_irq_handler,
>> -				  IRQF_SHARED, "pcie-error-irq", ks_pcie);
>> -		if (ret < 0) {
>> -			dev_err(dev, "failed to request error IRQ %d\n",
>> -				ks_pcie->error_irq);
>> -			return ret;
>> -		}
>> -	}
>> -
>>  	pp->ops = &ks_pcie_host_ops;
>>  	ret = ks_pcie_dw_host_init(ks_pcie);
>>  	if (ret) {
>> @@ -946,6 +920,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  	u32 num_lanes;
>>  	char name[10];
>>  	int ret;
>> +	int irq;
>>  	int i;
>>  
>>  	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
>> @@ -965,6 +940,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(dev, "missing IRQ resource: %d\n", irq);
>> +		return irq;
>> +	}
>> +
>> +	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
>> +			  "ks-pcie-error-irq", ks_pcie);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to request error IRQ %d\n",
>> +			irq);
>> +		return ret;
>> +	}
>> +
>>  	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
>>  	if (ret)
>>  		num_lanes = 1;
>> @@ -1020,6 +1009,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_get_sync;
>>  
>> +	ks_pcie_enable_error_irq(ks_pcie);
>> +
>>  	return 0;
>>  
>>  err_get_sync:
>> -- 
>> 2.17.1
>>
