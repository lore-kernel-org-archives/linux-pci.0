Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF838423B;
	Fri, 22 May 2026 09:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441525; cv=none; b=PKXzwTeLiLiUSro3R+COtfgmoikf4FruwX/gL3JuDJ8Pb1S99VBPrP6UtvX48u4GzFHwBktI4bA9ISSWYSe4RiGGr9ZiU05c/DIPV57167/bqif5XQ9gp+i6c3ud/rwPuCt+QomowufQSM8IQsvLfbm2VViJymh7lWe/D/pW6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441525; c=relaxed/simple;
	bh=fF/cIIrBJ4n0hO9xBWl4Fb7JIiwQljGyQX/y80hXrCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S+XbGTNU9ngsx2YjJ8WlR+TGdT9ZVjiXxy/RKhh1fgEclxJvuQROfrpIOWnupV6QNr3MQlMYDCJX4VYjZYoWFMvyH8KMy1GJLFB3MKBf3MzfkuxAkbQ2ERtuIrcQGEGeOTRsMBWBq5wcuQZMKiRTZ1sm3Oq6UKFqTV/W3HJ5Ob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xs6xlECd; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xs6xlECd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7R4lWkpzvvOR/H7RXrAQUePKGvgUfhRQ0zcBuiM1xuM=;
	b=xs6xlECdjtdc5KntcCEeytl461grOUN+sFD7I3IxGPikNWJFdpmw8sx6QfMIJn+/ptG5GXaXG
	qHaVvQpJnNweeYnR/+1njN2Xymtw9VOcG4nmv6ZGP6iEg/VIQGf3zQ+ch7hOm79BuSAKIYnZ+oJ
	JKSzTZxXd5IvPjqyjN9fmuI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gMKJH3lF2z1prKm;
	Fri, 22 May 2026 17:10:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 99EE240537;
	Fri, 22 May 2026 17:18:40 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 17:18:39 +0800
Message-ID: <15bffd1b-e0c7-4393-8cbc-ba54586884c9@huawei.com>
Date: Fri, 22 May 2026 17:18:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/5] PCI/TPH: Add pcie_tph_enabled_mode() helper
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
 <20260518071701.25177-4-fengchengwen@huawei.com>
 <20260521221022.322c2af9@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260521221022.322c2af9@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 5/22/2026 12:10 PM, Alex Williamson wrote:
> On Mon, 18 May 2026 15:16:59 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add a helper to query enabled TPH mode on a PCI device. This is useful for
>> drivers like VFIO-PCI that need to validate TPH state before allowing
>> access to steering tag tables.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/pci/tph.c       | 12 ++++++++++++
>>  include/linux/pci-tph.h |  3 +++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index ba31b010f67a..91c1e83410a3 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -451,6 +451,18 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>>  }
>>  EXPORT_SYMBOL(pcie_enable_tph);
>>  
>> +/**
>> + * pcie_tph_enabled_mode - Get current enabled TPH mode
>> + * @pdev: PCI device
>> + *
>> + * Return the enabled TPH mode (IV/DS) or 0 if disabled.
>> + */
>> +int pcie_tph_enabled_mode(struct pci_dev *pdev)
>> +{
>> +	return pdev->tph_enabled ? pdev->tph_mode : 0;
>> +}
>> +EXPORT_SYMBOL(pcie_tph_enabled_mode);
> 
> Doesn't this create ambiguity with PCI_TPH_ST_NS_MODE?  Maybe return an
> -errno if not enabled.  Duplicate same for stub below.  Thanks,

Because pcie_enable_tph(PCI_TPH_ST_NS_MODE) could also enable TPH,
but PCI_TPH_ST_NS_MODE mean "The function must use a value of all zeros for all Steering Tags"
So I think pcie_enable_tph() should treat PCI_TPH_ST_NS_MODE as a
invalid input.

Thanks
