Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D79286D5D
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770177524; cv=none; b=Te+1KMp+5HwrWPozNBoIbaDoRTOetqB1j6HfvnRAjR7p+Vn0G3CLU8/gLVm2ph6I/TwvyDHKU7eDwPB2rdrSfIFkHJJmi+rd72xLz1dKQaCF5C+piyOktVYST0hKTy69g21zjCGYq+MtH09jgosO658zTiDBr+j6PBH9Pi2qTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770177524; c=relaxed/simple;
	bh=/LARrgaz3sLEL6bIdR7Aro2ZRcHqruv4O0cnYbwT8u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IMcHz1pueEZP8JJjEQS4gVoEKYn2Iv3Rk1pEJqcU2cUJNt5WtTLnIIgdC3OW4ahm6cyHsVCWrNNRNGOTN1AgUlD/clj2HsCsnhWBMi2rVCBZ7PdVk4Ci0zZd+59LPRKKMdlha/J2RoNb6skyXsVgSedu3atGFOWPzAJvTBfMHuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mdDoG5RJ; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mdDoG5RJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YcXajX8dhAEzeEVNdFd7X6DzWaasHvqoYbfacUyofqY=;
	b=mdDoG5RJ3Pv0B+mibOUQkj0N3QoxPzUQjmkmEfweDHDVcplLELqnI2FGGfqf9OZKWIsdMggny
	SCcIFNBBY25lV5ogIRjpgRkkH7AU+Kll26yEUGS4vW5tjsa0nZXZosx2CB3ZjmtRIqO0V/Y1cbw
	VNcYhkmJdfO3NsOkeTKR1YQ=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f5RLJ46jgzcZyp;
	Wed,  4 Feb 2026 11:54:16 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B4E4840363;
	Wed,  4 Feb 2026 11:58:38 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 11:58:35 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 11:58:35 +0800
Message-ID: <fd3d565d-829c-49f7-865c-559c6d35df8a@huawei.com>
Date: Wed, 4 Feb 2026 11:58:34 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix PCI bridge resource allocation when base exceeds
 limit
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<shiju.jose@huawei.com>, <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>
References: <20260203023545.2753811-1-liusizhe5@huawei.com>
 <cc4121b7-b99e-d7e0-8c20-8a2f0d3a0e2d@linux.intel.com>
From: Sizhe LIU <liusizhe5@huawei.com>
In-Reply-To: <cc4121b7-b99e-d7e0-8c20-8a2f0d3a0e2d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200012.china.huawei.com (7.202.194.135)


On 2026/2/3 23:14, Ilpo Järvinen wrote:
> On Tue, 3 Feb 2026, Sizhe Liu wrote:
>
>> In pci_read_bridge_mmio_pref(), pci_read_bridge_mmio() and pci_read_bridge_io(),
>> when the MEMORY_BASE value is greater than MEMORY_LIMIT,
>> resource_set_range(res, 0, 0) is called to set both the start address
>> and the size of the address of the PCI bridge resource to 0.
>> However, the end address is later calculated as:
>> res->end = res->start + size - 1
>> As a result, the resource range becomes [0x00000000-0xffffffffffffffff]
>> instead of the expected [0x00000000-0x00000000].
> Hi,
>
> Thanks for the patch but your understanding on how resources addresses
> work is not correct.
>
> A zero sized resource should have end at start - 1, just like
> resource_set_range() sets it!

Hi,

Thanks for your correction! I agree with you.

Use [0x00000000-0xffffffffffffffff] to represent a zero-length

resource address, even though it may look misleading.

If the zero-length resource address is represented as 
[0x00000000-0x00000000],

the size returned by resource_size() would be 1, which is incorrect.

>> This causes an exception in the subsequent resource claiming process,
>> because the address range [0x00000000-0xffffffffffffffff] exceeds
>> the range specified in the DSDT. The abnormal bridge triggers clipping
>> when claiming resources, then the entire parent PCI bus address range
>> becomes occupied. Other bridges on the same bus will report
>> address conflicts during their claim process. The resource allocation
>> may be degraded from 64-bit to 32-bit, or even worse, it fails.
>>
>> The related boot log is as follows:
>> pci 0000:20:00.0: PCI bridge to [bus 21]
>> pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
>> pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
> pci_bus_clip_resource() should not touch IORESOURCE_DISABLED resources
> nor zero sized resources. The problem seems to originate from
> pci_claim_bridge_resources() and pci_claim_bridge_resource() which try to
> claim such resources no matter what.
>
> I think pci_claim_bridge_resources() should check if IORESOURCE_DISABLED
> is set and use continue, it already has check !r->flags which probably
> worked prior to 8278c6914306 ("PCI: Preserve bridge window resource type
> flags") but is no longer enough to decided if bridge window is valid or
> not.
>
> Do you want to do that patch and test it? (I'm quite busy this week
> myself.)
No problem, I've seen your patch and I will test it later.
>> pci 0000:20:00.0:   bridge window [io  0x0000-0xffff disabled]
>> pci 0000:20:00.0: bridge window [mem size 0x00000000 disabled]: can't claim; no address assigned
>> pci 0000:20:00.0: [mem 0x00000000-0xffffffffffffffff disabled] clipped to [mem 0x800000000000-0x8013ffffffff disabled]
>> pci 0000:20:00.0: bridge window [mem 0x800000000000-0x8013ffffffff disabled]: can't claim; no compatible bridge window
>> pci 0000:20:00.0: bridge window [mem size 0x00000000 64bit pref disabled]: can't claim; no address assigned
>> pci 0000:20:00.0: [mem 0x00000000-0xffffffffffffffff 64bit pref disabled] clipped to [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
>> pci 0000:20:00.0:   bridge window [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
>> pci 0000:20:08.0: PCI bridge to [bus 22]
>> pci 0000:20:08.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
>> pci 0000:20:08.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
>> pci 0000:20:08.0: bridge window [io  0x0000-0xffff disabled]: can't claim; address conflict with PCI Bus 0000:21 [io  0x0000-0xffff disabled]
>> pci 0000:20:08.0: bridge window [mem size 0x00000000 disabled]: can't claim; no address assigned
>> pci 0000:20:08.0: [mem 0x00000000-0xffffffffffffffff disabled] clipped to [mem 0x800000000000-0x8013ffffffff disabled]
>> pci 0000:20:08.0: bridge window [mem 0x800000000000-0x8013ffffffff disabled]: can't claim; no compatible bridge window
>> pci 0000:20:08.0: bridge window [mem size 0x00000000 64bit pref disabled]: can't claim; no address assigned
>> pci 0000:20:08.0: [mem 0x00000000-0xffffffffffffffff 64bit pref disabled] clipped to [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
>> pci 0000:20:08.0: bridge window [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]: can't claim; address conflict with PCI Bus 0000:21 [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
>> pci 0000:20:09.0: PCI bridge to [bus 23]
>> pci 0000:20:09.0: bridge window [io  0x0000-0x0fff]: can't claim; address conflict with PCI Bus 0000:21 [io  0x0000-0xffff disabled]
>> pci 0000:20:09.0: bridge window [mem 0x800003000000-0x8000048fffff 64bit pref]: can't claim; address conflict with PCI Bus 0000:21 [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
>>
>> Solution:
>> A comment in pci_read_bridge_mmio_pref() states:
>> /*
>>   * Some bridges set the base > limit by default, and some
>>   * (broken) BIOSes do not initialize them.  If we find
>>   * this, just assume they are not being used.
>>   */
>> When the base is greater than the limit, a proper fix is to set the
>> resource flag to IORESOURCE_UNSET or IORESOURCE_DISABLED while keeping
>> the start and end addresses as 0. This prevents the clipping process
>> from being triggered incorrectly.
>>
>> Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
>> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
>> ---
>>   drivers/pci/probe.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 41183aed8f5d..561f2420d9eb 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -429,7 +429,6 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
>>   		if (log)
>>   			pci_info(dev, "  bridge window %pR\n", res);
>>   	} else {
>> -		resource_set_range(res, 0, 0);
>>   		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>>   	}
>>   }
>> @@ -455,7 +454,6 @@ static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res,
>>   		if (log)
>>   			pci_info(dev, "  bridge window %pR\n", res);
>>   	} else {
>> -		resource_set_range(res, 0, 0);
>>   		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>>   	}
>>   }
>> @@ -511,7 +509,6 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>>   		if (log)
>>   			pci_info(dev, "  bridge window %pR\n", res);
>>   	} else {
>> -		resource_set_range(res, 0, 0);
>>   		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
>>   	}
>>   }
>
