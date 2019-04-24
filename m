Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3118C10F03
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06C9218D2
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dqpqTtwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfDXDMZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:12:25 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12877 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfDXDMZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 23:12:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbfd4140000>; Tue, 23 Apr 2019 20:12:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 20:12:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Apr 2019 20:12:23 -0700
Received: from [10.25.73.236] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 03:12:17 +0000
Subject: Re: [PATCH V4 06/16] PCI: dwc: Add ext config space capability search
 API
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <jingoohan1@gmail.com>,
        <gustavo.pimentel@synopsys.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <sagar.tv@gmail.com>
References: <20190423082730.370-1-vidyas@nvidia.com>
 <20190423082730.370-7-vidyas@nvidia.com> <20190423203502.GE14616@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <96630790-d567-87a3-358d-1174f05a88e5@nvidia.com>
Date:   Wed, 24 Apr 2019 08:42:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423203502.GE14616@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556075540; bh=Bu/xgjX162HQNUkgVfXW+gOwGfo59bhjlr7ewao1YT4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=dqpqTtwAOyVgDv+Lx6Exy8MQH+ZOBQvsjETody3sOEbeH+Py7cLZP9YcKh3HxVmnr
         rc9Atl3SDfcl5AmRAkDj2hp82BIGK/kUJ6uj+37kCEQLIbUkhx03bXCBnjEmXpG8jC
         QiY5nHi8boURYYF9/FaqCwWOruibbsKwIs7QfHKg+5mKUE5OkZFRHIpEP2oV9rklUD
         qifRh30JICi3vHWhuonVpK+gu3OwrxWgGq1qSoLcIpfvoscaDdvhqnBFhPhBujZLZJ
         At6OM0DgiQSg0PuKJGaXaIPIZ1J8aNVOHkX8I4dqjMcVRzvA/WgxF+gHUbqExxfxy/
         2aMPNuaFqF+8A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/24/2019 2:05 AM, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2019 at 01:57:20PM +0530, Vidya Sagar wrote:
>> Add extended configuration space capability search API using struct dw_pcie *
>> pointer
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes from [v3]:
>> * None
>>
>> Changes from [v2]:
>> * None
>>
>> Changes from [v1]:
>> * This is a new patch in v2 series
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 41 ++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h |  1 +
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 6a98135244d6..ecf5fe8842f6 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -53,6 +53,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>>   	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>>   }
>>   
> 
> Please make sure there's a comment here about why
> pci_find_ext_capability() can't be used (a comment covering both this
> and pci_find_capability() is fine, if the reason is the same).
Reason is same that standard pci_find_ext_capability() uses 'struct pci_dev *dev' pointer
and can only be used post enumeration whereas APIs being added here use 'struct dw_pcie *pci'
and can be used before link up also.
I'll add a comment in the other patch where I'm moving these APIs from pcie-designware-ep.c file
to pcie-designware.c file.

> 
>> +static int dw_pcie_find_next_ext_capability(struct dw_pcie *pci, int start,
>> +					    int cap)
>> +{
>> +	u32 header;
>> +	int ttl;
>> +	int pos = PCI_CFG_SPACE_SIZE;
>> +
>> +	/* minimum 8 bytes per capability */
>> +	ttl = (PCI_CFG_SPACE_EXP_SIZE - PCI_CFG_SPACE_SIZE) / 8;
>> +
>> +	if (start)
>> +		pos = start;
>> +
>> +	header = dw_pcie_readl_dbi(pci, pos);
>> +	/*
>> +	 * If we have no capabilities, this is indicated by cap ID,
>> +	 * cap version and next pointer all being 0.
>> +	 */
>> +	if (header == 0)
>> +		return 0;
>> +
>> +	while (ttl-- > 0) {
>> +		if (PCI_EXT_CAP_ID(header) == cap && pos != start)
>> +			return pos;
>> +
>> +		pos = PCI_EXT_CAP_NEXT(header);
>> +		if (pos < PCI_CFG_SPACE_SIZE)
>> +			break;
>> +
>> +		header = dw_pcie_readl_dbi(pci, pos);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap)
>> +{
>> +	return dw_pcie_find_next_ext_capability(pci, 0, cap);
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>>   {
>>   	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 35160b4ce929..67307842e003 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -249,6 +249,7 @@ struct dw_pcie {
>>   		container_of((endpoint), struct dw_pcie, ep)
>>   
>>   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
>>   
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
>> -- 
>> 2.17.1
>>

