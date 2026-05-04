Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663C314A84
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882961; cv=none; b=DehYYh/h8A2Kgb2O86KIfzxpQ7m6tjm6SZ8rvlV3umMdBU9lOaM2FCROogFshB/J9YXijunrJvdarYaVwrpDOTM7Qcngx3h6CMpRKqlVowTcvu33Lg47y7tKr4e3TQu1xtZcnw5bRGdfoaCKPjyKyOOGCChSjbDVBtNvrFWOKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882961; c=relaxed/simple;
	bh=ZTTJkhmcxly0uSBJHLNzBkDsEma5FfJo/2uaz1jLFMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCHA/TIl+sQ+Qs3rR7KG6hPWP08OrJ0vZ7ja/J5E3EJaAWrWkkL9Bzf4ldus/GQjqlPdmpbmKo7LH7r+6k6sy2pl/sydwsm9m4h9amOMq+YNdt1796pxoP3AdMev3PJE3eDMmwkN+wmEBwudbKnE01PISHASWP/Ow1ZsZSyKNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AB1V9yiT; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AB1V9yiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=WOWFWuQ6Aa/jVM4ZrUesSe5Ka2GKpNHDgEray8AQmS8=;
	b=AB1V9yiTMyzK9zyh/ARyxErog+hpntZh3+3+L73nlI6Sdqo2plX6Dd09hHNSux
	RVJv5QDGV1i1y8DGu/xCtvWEm5Z3OCEPvB/nXa/tehCzU3RsdHcvNL/ySgGgHQbD
	7WHGFQ93gBO5PrQ17mTyqkRyEafad6M8P2ARrxFWTbWvM=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnv0tCV_hpNNjUDA--.14088S2;
	Mon, 04 May 2026 16:22:27 +0800 (CST)
Message-ID: <5823faec-d972-4c77-90ec-a215c686e0a8@163.com>
Date: Mon, 4 May 2026 16:22:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get PCIe
 Cap offset in host driver
To: sashiko@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260503161913.77878-1-18255117159@163.com>
 <20260503165243.4A676C2BCB4@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260503165243.4A676C2BCB4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnv0tCV_hpNNjUDA--.14088S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryDAw18KFy5Xry3tFW5Wrg_yoWrKw15pF
	Z5W3WIk3W0qr429r4vy3Z8ZF13GF9Iya47tayvkw13XF17CFyDKF42kF13GF43GrsrJr17
	X3yDta9xu3WayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYNtsUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wN+Imn4V0NdvgAA3S



On 5/4/26 00:52, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] cdns_pcie_find_capability() searches the wrong register space in Host mode and its return value is not validated, leading to Root Port configuration space corruption.
> --
> 
> commit 09b3c64b8f5892eb365acd13030a8067652a15e8
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: cadence: Use cdns_pcie_find_capability() to get PCIe Cap offset in host driver
> 
> This commit replaces the hardcoded CDNS_PCIE_RP_CAP_OFFSET with a dynamic
> lookup using cdns_pcie_find_capability() in Cadence PCIe host-related
> functions. The goal is to ensure correct operation across various SoC designs
> where the capability might not reside at offset 0xC0.
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> index 2b0211870f02..5013d3fe23b5 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
>> @@ -26,14 +26,14 @@ EXPORT_SYMBOL_GPL(bar_max_size);
>>   
>>   int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>>   {
>> -	u32 pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>>   	unsigned long end_jiffies;
>>   	u16 lnk_stat;
>> +	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
> 
> Does this capability search scan the correct register space when operating in
> host mode?
> 
> Looking at the helper function, it uses cdns_pcie_read_cfg() which reads
> directly from the base address without the Root Port offset:
> 
> drivers/pci/controller/cadence/pcie-cadence.c:cdns_pcie_find_capability() {
>      return PCI_FIND_NEXT_CAP(cdns_pcie_read_cfg, PCI_CAPABILITY_LIST,
>                               cap, NULL, pcie);
> }
> 
> However, the Root Port configuration registers are physically located at
> pcie->reg_base + CDNS_PCIE_RP_BASE. Could this cause the search to scan the
> Local Management register space instead, failing to find PCI_CAP_ID_EXP
> and returning 0?

I don't think we need to worry about this issue.

As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions

are required to implement the PCI Express Capability structure, which 
must be included somewhere in this linked list;

So, it won't return 0 here.

Best regards,
Hans


> 
> [ ... ]
> 
>> @@ -68,27 +68,26 @@ EXPORT_SYMBOL_GPL(cdns_pcie_host_wait_for_link);
>>   int cdns_pcie_retrain(struct cdns_pcie *pcie,
>>   		      cdns_pcie_linkup_func pcie_link_up)
>>   {
>> -	u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
>> +	u32 lnk_cap_sls;
>>   	u16 lnk_stat, lnk_ctl;
>>   	int ret = 0;
>> +	u8 cap = cdns_pcie_find_capability(pcie, PCI_CAP_ID_EXP);
>>   
>>   	/*
>>   	 * Set retrain bit if current speed is 2.5 GB/s,
>>   	 * but the PCIe root port support is > 2.5 GB/s.
>>   	 */
>>   
>> -	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
>> +	lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + cap +
>>   					     PCI_EXP_LNKCAP));
> 
> If the capability is not found and cap evaluates to 0, is it safe to proceed
> without validating the return value?
> 
> Since the fallback value would be 0, evaluating cap + PCI_EXP_LNKCAP will
> result in an offset of 0x0C.
> 
> [ ... ]
> 
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 0bc9e6e90e0e..2a3fd41c1cf4 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -147,12 +148,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>>   	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>>   	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>>   
>> -	value = cdns_pcie_rp_readl(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP);
>> +	value = cdns_pcie_rp_readl(pcie, cap + PCI_EXP_LNKCAP);
>>   	if (rc->quirk_broken_aspm_l0s)
>>   		value &= ~PCI_EXP_LNKCAP_ASPM_L0S;
>>   	if (rc->quirk_broken_aspm_l1)
>>   		value &= ~PCI_EXP_LNKCAP_ASPM_L1;
>> -	cdns_pcie_rp_writel(pcie, CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP, value);
>> +	cdns_pcie_rp_writel(pcie, cap + PCI_EXP_LNKCAP, value);
> 
> Will this overwrite the wrong configuration registers if cap is 0?
> 
> The cdns_pcie_rp_writel() function automatically adds CDNS_PCIE_RP_BASE to
> the destination offset. If cap is 0, writing to cap + PCI_EXP_LNKCAP will
> access offset 0x0C.
> 
> Could this regression unintentionally clobber the standard Type 1 PCI header
> registers, such as the Cache Line Size and Latency Timer, and corrupt the
> Root Port hardware state?
> 

