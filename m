Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD671482E8
	for <linux-pci@vger.kernel.org>; Wed,  4 Feb 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195406; cv=none; b=OIKvOy2VLTomLN3iiH48qXq6Z8vM4+k/EAGPUb9CdS0xSkpFB4OxI18JqsyPaCzr8MDiB3N//Rrq3bSJYaVRXvqbMZnOO/zjxxQqvSS60Fx+MsRP9wTwPvAJantgP3m7DZ68Ie3/ys/rZPAPTRR0U+zWZMSktGI/ggdQSpYH+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195406; c=relaxed/simple;
	bh=Fg+C8WRFvs9uXNw6hQd0CAZ1s96iGZ8XhFy9ejS1agk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VHcPDT8HrYo0u2B/be14Gr0O++naQO74p+h8CrqCe+RVEMtQNAmA9J701NYqFZKJuRwGQSaD6ARXH947B9TK94oa8H3+1OcXTtKW8hc+8zfyDRs+P72X8Fu2b2YVGXC/DgCIijgKZHuPaMTNnNmPJR4gnEhBfQ6QZPaj1yhetSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Coq7n6i6; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Coq7n6i6"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=b8ImQA2jmMWOXpGhhnMVxe4yt9K8y8lR7k36ukSr1ag=;
	b=Coq7n6i6OwZ1rz+7pF0ap3+irDQVjMNVXVqlEoKs1sqAOVPu/DKJIA2pI/mvnxoUgH2WrMuew
	5cWCAsgKFcJf1VPBBcioiAzqgRnjYn4k74XsJrtefjzvA+tNhQNmWhrs/0d4X8nvhXwIyIumthm
	GdxMTpyChHqBF/lcjPjmsmc=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4f5Yxz1Tj0zLlW4;
	Wed,  4 Feb 2026 16:52:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 315E94055B;
	Wed,  4 Feb 2026 16:56:41 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 16:56:40 +0800
Received: from [10.67.120.233] (10.67.120.233) by
 kwepemn200012.china.huawei.com (7.202.194.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Feb 2026 16:56:40 +0800
Message-ID: <90126aca-45fe-4c44-a353-e5745e789024@huawei.com>
Date: Wed, 4 Feb 2026 16:56:39 +0800
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
 <4d9228d6-a230-6ddf-e300-fbf42d523863@linux.intel.com>
From: Sizhe LIU <liusizhe5@huawei.com>
In-Reply-To: <4d9228d6-a230-6ddf-e300-fbf42d523863@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemn200012.china.huawei.com (7.202.194.135)


On 2026/2/4 1:21, Ilpo Järvinen wrote:
> On Tue, 3 Feb 2026, Ilpo Järvinen wrote:
>
>> On Tue, 3 Feb 2026, Sizhe Liu wrote:
>>
>>> In pci_read_bridge_mmio_pref(), pci_read_bridge_mmio() and pci_read_bridge_io(),
>>> when the MEMORY_BASE value is greater than MEMORY_LIMIT,
>>> resource_set_range(res, 0, 0) is called to set both the start address
>>> and the size of the address of the PCI bridge resource to 0.
>>> However, the end address is later calculated as:
>>> res->end = res->start + size - 1
>>> As a result, the resource range becomes [0x00000000-0xffffffffffffffff]
>>> instead of the expected [0x00000000-0x00000000].
>> Hi,
>>
>> Thanks for the patch but your understanding on how resources addresses
>> work is not correct.
>>
>> A zero sized resource should have end at start - 1, just like
>> resource_set_range() sets it!
>>
>>> This causes an exception in the subsequent resource claiming process,
>>> because the address range [0x00000000-0xffffffffffffffff] exceeds
>>> the range specified in the DSDT. The abnormal bridge triggers clipping
>>> when claiming resources, then the entire parent PCI bus address range
>>> becomes occupied. Other bridges on the same bus will report
>>> address conflicts during their claim process. The resource allocation
>>> may be degraded from 64-bit to 32-bit, or even worse, it fails.
>>>
>>> The related boot log is as follows:
>>> pci 0000:20:00.0: PCI bridge to [bus 21]
>>> pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
>>> pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
>> pci_bus_clip_resource() should not touch IORESOURCE_DISABLED resources
>> nor zero sized resources. The problem seems to originate from
>> pci_claim_bridge_resources() and pci_claim_bridge_resource() which try to
>> claim such resources no matter what.
>>
>> I think pci_claim_bridge_resources() should check if IORESOURCE_DISABLED
>> is set and use continue, it already has check !r->flags which probably
>> worked prior to 8278c6914306 ("PCI: Preserve bridge window resource type
>> flags") but is no longer enough to decided if bridge window is valid or
>> not.
>>
>> Do you want to do that patch and test it? (I'm quite busy this week
>> myself.)
> I managed to get the patch done:
>
> --
> From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
> Date: Tue, 3 Feb 2026 19:14:30 +0200
> Subject: [PATCH 1/1] PCI: Don't claim disabled bridge windows
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> The commit 8278c6914306 ("PCI: Preserve bridge window resource type
> flags") change bridge window resource behavior such that flags are no
> longer zero if the bridge window is not valid or is disabled (mainly
> to preserve the type flags for later use). If a bridge window has its
> limit smaller than base address, pci_read_bridge_*() sets both
> IORESOURCE_UNSET and IORESOURCE_DISABLED to indicate the bridge window
> exists but is not valid with the current base and limit configuration.
>
> The code in pci_claim_bridge_resources() still depends on the old
> behavior be checking validity of the bridge window solely based on
> !r->flags, whereas after the commit 8278c6914306 ("PCI: Preserve bridge
> window resource type flags"), also IORESOURCE_DISABLED may indicate
> bridge window addresses are not valid.
>
> While pci_claim_resource() does check IORESOURCE_UNSET,
> pci_claim_bridge_resource() does attempt to clip the resource if
> pci_claim_resource() fails which is not correct for not valid bridge
> window resource. As pci_bus_clip_resource() performs clipping
> regardless flags and then clears IORESOURCE_UNSET, it should not be
> called for not valid resources.
>
> The problem is visible in this log:
>
> pci 0000:20:00.0: PCI bridge to [bus 21]
> pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
> pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io 0x0000-0xffff disabled]
>
> Add IORESOURCE_DISABLED check into pci_claim_bridge_resources() to
> only claim bridge windows that appear to have a valid configuration.
>
> Reported-by: Sizhe Liu <liusizhe5@huawei.com>
> Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/pci/setup-bus.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 6e90f46f52af..43ea635e1ea8 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1733,6 +1733,8 @@ static void pci_claim_bridge_resources(struct pci_dev *dev)
>   
>   		if (!r->flags || r->parent)
>   			continue;
> +		if (r->flags & IORESOURCE_DISABLED)
> +			continue;
>   
>   		pci_claim_bridge_resource(dev, i);
>   	}
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
Thanks for your feedback! I've tested this patch and it functions well, 
so go ahead with it.
