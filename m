Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56477C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 05:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2418E2087C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 05:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ETT5KQJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbfDOFfk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:35:40 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37734 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOFfk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 01:35:40 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3F5ZNmY014042;
        Mon, 15 Apr 2019 00:35:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555306523;
        bh=r5VY8B5UJBovlvuC4Y+bAFql763UeZnPUMBwUMPFQa4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ETT5KQJQ/VrbxMunUinIAF0nTHLVqR8kyGi4zlaZbJ3Eil1+v/BQqEaHd4WTqSYLQ
         BCqwxycaKGklr3SWmTaRpr/8q0WSW+09X8fV+ERZpO1dJlpArbrWmXQAeDJyGq2sWa
         6mzPAYdOY5pFEQAkZqzYYP53kQArDFTyqhlkc9rE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3F5ZNeo078772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 00:35:23 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 00:35:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 00:35:23 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3F5ZFpX010920;
        Mon, 15 Apr 2019 00:35:19 -0500
Subject: Re: [PATCH v2 06/26] PCI: keystone: Move initializations to
 appropriate places
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
        <linux-arm-kernel@lists.infradead.org>, <linux-arm-kernel@axis.com>
References: <20190325083501.8088-1-kishon@ti.com>
 <20190325083501.8088-7-kishon@ti.com> <20190413143001.GE126710@google.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <9ab596e8-b012-7f4e-aa93-c5661827af95@ti.com>
Date:   Mon, 15 Apr 2019 11:04:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413143001.GE126710@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 13/04/19 8:00 PM, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 02:04:41PM +0530, Kishon Vijay Abraham I wrote:
>> No functional change. Move host specific platform_get_resource to
>> ks_add_pcie_port and the common platform_get_resource (applicable
>> to both host and endpoint) to probe. This is in preparation for
>> adding endpoint support to pci-keystone driver.
> 
> This seems to move platform_get_resource() *from* (not *to*)
> ks_add_pcie_port().

Maybe I should have mentioned "Keep host specific platform_get_resource() in
ks_add_pcie_port() and move the common platform_get_resource() (applicable
to both host and endpoint) to probe()"
> 
> You seem to be making a distinction in the commit log between (1) a
> resource that's only used for host mode, and (2) a common resource
> that's used for both host and endpoint mode.  But I don't see that
> distinction in the patch, so it's a little confusing to mention it in
> the commit log.
> 
> It must make endpoint support easier, but I can't quite connect the
> dots yet.  Maybe endpoint will also use ks_pcie_add_pcie_port(), but
> will have a separate .probe() function that doesn't look up the
> resource that's specific to host mode?

No ks_pcie_add_pcie_port() is specific to host mode, so "config" resource is
kept there whereas "dbics" and "app" resources are common to both host mode and
device mode, so they are moved to probe().

Thanks
Kishon

> 
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>> index 5eebef9b9ada..95997885a05c 100644
>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>> @@ -806,11 +806,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>>  	struct resource *res;
>>  	int ret;
>>  
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
>> -	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
>> -	if (IS_ERR(pci->dbi_base))
>> -		return PTR_ERR(pci->dbi_base);
>> -
>>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>>  	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>>  	if (IS_ERR(pp->va_cfg0_base))
>> @@ -818,13 +813,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>>  
>>  	pp->va_cfg1_base = pp->va_cfg0_base;
>>  
>> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
>> -	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR(ks_pcie->va_app_base))
>> -		return PTR_ERR(ks_pcie->va_app_base);
>> -
>> -	ks_pcie->app = *res;
>> -
>>  	pp->ops = &ks_pcie_host_ops;
>>  	ret = dw_pcie_host_init(pp);
>>  	if (ret) {
>> @@ -895,6 +883,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  	struct dw_pcie *pci;
>>  	struct keystone_pcie *ks_pcie;
>>  	struct device_link **link;
>> +	struct resource *res;
>> +	void __iomem *base;
>>  	u32 num_viewport;
>>  	struct phy **phy;
>>  	u32 num_lanes;
>> @@ -911,6 +901,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>>  	if (!pci)
>>  		return -ENOMEM;
>>  
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
>> +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(ks_pcie->va_app_base))
>> +		return PTR_ERR(ks_pcie->va_app_base);
>> +
>> +	ks_pcie->app = *res;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
>> +	base = devm_pci_remap_cfg_resource(dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	pci->dbi_base = base;
>>  	pci->dev = dev;
>>  	pci->ops = &ks_pcie_dw_pcie_ops;
>>  
>> -- 
>> 2.17.1
>>
