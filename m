Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E3344DAE;
	Thu, 30 Apr 2026 03:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521379; cv=none; b=dd3oWS0/Y00O3N+p+7oj6FUo2NTQLheoS7FzZnonNbxrrhZNm4PVJJfKeT/1VGVTqo3yzRFGM46Uwd9RtGVjqSlAnXXCobuKt0EH0UdaH9n/b0GbgdidV0+Nlap8XNUIZmTNGwKtiYt7ofUikXRNmL0pym9ZNA7D5k0kv6vuVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521379; c=relaxed/simple;
	bh=waO2FwHxleweiMjE/hRMA8KRvVq4MRMBvcLSg3c/l/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d+WXSFbWDuolubIRhXeR9iL78cDimCJw7GBUC64qYtee6lHLoZU0JllN5SBs7lgqB2Cg6Q+PX8elZnH525uRjaI009HlHgvG6hnpvxfAVRrWwWehLBwHFOGKHw1JJ0Wd8gQB90V+Il3hh7+obZc0/A/2y8Bu7rZrR9bwJSrLKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q7w1LMtJ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q7w1LMtJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=02PrlUS5LgGI5+LTmWoGaLpQeXwdbIGaRh5aBk4cSDA=;
	b=q7w1LMtJWmSpCR18qrn2HpM2IbKtpl9u1e3Qr3s4v2ia5jei2++DPtcLHoGnFhuVgj30Bk5Tr
	Regl4kzm3k32psrvsFn068UCPbPWjoGFBvVSWBeDo+DArC7GyjTpoou2mtooerwjTlsjxTCUoHN
	L7RIsK4/op+LIq59pn3XmB8=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4g5gCk3GFSzmV7x;
	Thu, 30 Apr 2026 11:49:38 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B4CC4056C;
	Thu, 30 Apr 2026 11:56:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Apr 2026 11:56:06 +0800
Message-ID: <67904037-da69-47c2-980c-6a6266981d06@huawei.com>
Date: Thu, 30 Apr 2026 11:56:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] vfio/pci: Add PCIe TPH support
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, <alex@shazbot.org>,
	<wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260423010851.46737-1-fengchengwen@huawei.com>
 <20260423145915.GG172828@unreal>
 <486a8633-437d-42d1-85f9-690a9df311eb@huawei.com>
 <20260424223010.GB804026@ziepe.ca>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260424223010.GB804026@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 4/25/2026 6:30 AM, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 09:25:54AM +0800, fengchengwen wrote:
>> 1. Why userspace needs the capability to control steering tags:
>>    When PCIe devices are fully taken over by userspace workloads like DPDK
>>    and SPDK, only userspace understands core binding policies and traffic
>>    distribution. Without this series, userspace cannot enable TPH or
>>    configure steering tags, leaving built-in PCIe performance optimizations
>>    unused for high-throughput polling I/O scenarios.
> 
> So far we have generally had the position that vfio should not enable
> device specific steering tags because it is impossible to provide the
> expected level of isolation.
> 
> I think it is OK to have a unsafe module option to allow use of
> device-specific steering tags, and it is reasonable to have an ioctl
> to query what the tags are for various CPU scenarios.
> 
> It is not OK to allow direct userspace control over the safe TPH in
> MSI-X mode. The kernel should continue to exclusively control these
> and the userspace should request to load differnt things into them,
> presenting some kind of security context to prove it can use the
> things it requests. It should not require an unsafe parameter.

Thanks very much for your review and valuable points on V3. I fully agree
with your position regarding isolation and user-space control policy.

In V5, I have reworked the entire series to address all your concerns:

1. For **Device-Specific (DS) steering tags**:
   - Now guarded by an **unsafe module parameter** as you suggested.
   - Only enabled when explicitly allowed by system administrator,
     fully respecting kernel isolation requirements.

2. For **MSI-X / Interrupt Vector (IV) mode**:
   - Kernel retains **exclusive control** of safe TPH mappings.
   - Userspace only passes trivial input: **target CPU ID and memory type**,
     without exposing any internal hardware or security details.
   - All hardware programming and validity checks are handled strictly
     inside the kernel.
   - No unsafe module parameter is required for IV mode.

The V5 series now aligns perfectly with your isolation and security
expectations. Could you please take a look at V5 when you have time?

Thanks.

> 
> Jason

