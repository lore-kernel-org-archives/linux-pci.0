Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC383C282DD
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34B218D2
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 03:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jIlVimOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDXDMK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:12:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12862 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfDXDMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 23:12:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cbfd4040000>; Tue, 23 Apr 2019 20:12:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 23 Apr 2019 20:12:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 23 Apr 2019 20:12:07 -0700
Received: from [10.25.73.236] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Apr
 2019 03:12:02 +0000
Subject: Re: [PATCH V4 05/16] PCI: dwc: Move config space capability search
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
 <20190423082730.370-6-vidyas@nvidia.com> <20190423203244.GD14616@google.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <22c7a99b-2d6c-e49b-43b0-219c60f7e5e9@nvidia.com>
Date:   Wed, 24 Apr 2019 08:41:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423203244.GD14616@google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1556075524; bh=ZOM3uemtdSmTK3MJ77Qg6Gy4+3pdvInoy2lEtXXdOMo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jIlVimOAevsMvHwYFiFmzQI409QipPX4z7sICPD5m1ECUC03YXianq7Yj+3d6ToOn
         mSFgd0wubq72wWeEimFMBdVnZGrop8//QUgVHChJLxsVU7QWRr0OKnqIkayQbMz5vF
         sXduvv1xAfSVdU4lDHzH8v8au7URVsS0KpJ54jpHbP50b49LsGI6ZPOMaSCBvh1Iqr
         Lx1k52grxdlMqFXPlDd71grUcNYvVLweF9tHa9PXLABXfCy3a0igG8cW7Pb6+VTA0K
         V44sc6hXYrNZVMSInAXDvTOebYT1F7gDR3FBKLz+je0fviD5HN56v3F0r5g4mUwyxH
         6lfuiU6fqG1Tw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/24/2019 2:02 AM, Bjorn Helgaas wrote:
> On Tue, Apr 23, 2019 at 01:57:19PM +0530, Vidya Sagar wrote:
>> Move PCIe config space capability search API to common DesignWare file
>> as this can be used by both host and ep mode codes.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> ---
>> Changes from [v3]:
>> * Rebased to linux-next top of the tree
>>
>> Changes from [v2]:
>> * None
>>
>> Changes from [v1]:
>> * Removed dw_pcie_find_next_ext_capability() API from here and made a
>>    separate patch for that
>>
>>   drivers/pci/controller/dwc/pcie-designware.c | 33 ++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h |  2 ++
> 
> You claim this is a "move", but I only see adds.  Where did it move
> *from*?
These are supposed to be moved from pcie-designware-ep.c file. That was the case
with my old patches but when I rebased them onto ToT, I missed the change that
removes them from pcie-designware-ep.c file. Thanks for catching this. I'll
address it in the next patch.

> 
> While you're at it, can you add a comment in the code about why we
> can't use the regular pci_find_capability() interface?  It's really a
> shame to have to reimplement that.
Regular pci_find_capability() uses 'struct pci_dev *dev' pointer and can be used
only after device enumeration is done. Whereas, these APIs are used particularly
before link up and use 'struct dw_pcie *pci' pointer.

> 
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 8e0081ccf83b..6a98135244d6 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -20,6 +20,39 @@
>>   #define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
>>   #define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
>>   
>> +static u8 __dw_pcie_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>> +				  u8 cap)
>> +{
>> +	u8 cap_id, next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, cap_ptr);
>> +	next_cap_ptr = (reg & 0xff00) >> 8;
>> +	cap_id = (reg & 0x00ff);
>> +
>> +	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
>> +		return 0;
>> +
>> +	if (cap_id == cap)
>> +		return cap_ptr;
>> +
>> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap)
>> +{
>> +	u8 next_cap_ptr;
>> +	u16 reg;
>> +
>> +	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>> +	next_cap_ptr = (reg & 0x00ff);
>> +
>> +	if (!next_cap_ptr)
>> +		return 0;
>> +
>> +	return __dw_pcie_find_next_cap(pci, next_cap_ptr, cap);
>> +}
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>>   {
>>   	if (!IS_ALIGNED((uintptr_t)addr, size)) {
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 9ee98ced1ef6..35160b4ce929 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -248,6 +248,8 @@ struct dw_pcie {
>>   #define to_dw_pcie_from_ep(endpoint)   \
>>   		container_of((endpoint), struct dw_pcie, ep)
>>   
>> +u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>> +
>>   int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>>   int dw_pcie_write(void __iomem *addr, int size, u32 val);
>>   
>> -- 
>> 2.17.1
>>

