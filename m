Return-Path: <SRS0=SWM8=ST=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F81C10F12
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 09:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ABE21773
	for <linux-pci@archiver.kernel.org>; Wed, 17 Apr 2019 09:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WakDG9+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfDQJfD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:35:03 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12464 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQJfD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Apr 2019 05:35:03 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb6f34a0000>; Wed, 17 Apr 2019 02:35:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 17 Apr 2019 02:35:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 17 Apr 2019 02:35:01 -0700
Received: from [10.24.47.93] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 17 Apr
 2019 09:34:55 +0000
Subject: Re: [PATCH V3 06/16] PCI: dwc: Add ext config space capability search
 API
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
CC:     "mperttunen@nvidia.com" <mperttunen@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20190416192730.15681-1-vidyas@nvidia.com>
 <20190416192730.15681-7-vidyas@nvidia.com>
 <305100E33629484CBB767107E4246BBB0A22C0A7@de02wembxa.internal.synopsys.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <97924cc1-0ccb-52c3-5396-accd516f91d4@nvidia.com>
Date:   Wed, 17 Apr 2019 15:04:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <305100E33629484CBB767107E4246BBB0A22C0A7@de02wembxa.internal.synopsys.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555493707; bh=lYQvSnGyEG7FTaUvC/Slnrmlq6zktMeY67555un3eX8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WakDG9+C77R3EF6pcHtviUDO+cwpjd43sEqpUJhICunpRNSrmfsnjFxoKcg7+P8Gw
         NlghubuY47ir74wma9qu6SwksA9HJfSYJ/seezfXwNqibiZAKkDviO3//uXKuVGtE2
         ajMpM9bClodF3OsqrO5MOj6SY8xAN/DcCaGv6IqvMLbh2czdtNKogYOiPuaRiUpdwX
         weM0pQyVyEiQftntHu4JulTDqAoS0HqzDGStbB6Kziz4IqWN01RYTBvfo6mhMgl0MZ
         MTLb6B6FKtu9jzQ4LKZGm9CLp7/ZsUv575HNaW+4Xl+W1vWsFQsQj8S1uHBVVqa6sB
         pWLmsTVerNNWA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/17/2019 2:57 PM, Gustavo Pimentel wrote:
> On Tue, Apr 16, 2019 at 20:27:20, Vidya Sagar <vidyas@nvidia.com> wrote:
> 
>> Add extended configuration space capability search API using struct dw_pcie *
>> pointer
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
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
>> index d68c123e409c..44c0ba078452 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -53,6 +53,47 @@ u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>>   	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>>   }
>>   
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
>> index 4ccd4c706ddb..fa41d675c48f 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -248,6 +248,7 @@ struct dw_pcie {
>>   		container_of((endpoint), struct dw_pcie, ep)
>>   
>>   u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>> +int dw_pcie_find_ext_capability(struct dw_pcie *pci, int cap);
>>   
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
>> -- 
>> 2.17.1
> 
> This ext capability function is aimed to be used by the EP also?
> 
Yes. It can be used by EP also. Hence I added it in common files.
