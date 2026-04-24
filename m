Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D31A9F96;
	Fri, 24 Apr 2026 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776993966; cv=none; b=sP5U4VhW8gZXeBMMC7qrwwTvFcx6UX2Xg1H5nB2WJfgTM/ESIr20WEU5h30b7Id2lEZvAiLYliidEdbwvu8fjYmo2fzdUi/NOmm6GJTJtIe4uzULou+w/M8VRquSK+nE7GVAT87b6bh8AeU6kVjMUg69U4NruM2pkGHMeiGqdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776993966; c=relaxed/simple;
	bh=i4s9DTXZuzdQZ28wjVuPTCFDMD2wsf4HN3JZjaN+vOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qb+UvWN0uH3+glxFhx8eeGF+ejuSsDD9WME6W5Qc5ocD+q8NgdWBGq/FRxfagqkOik7VDDhlmcKgj9XeaXEObg6Cv97Uoxe4TUurSCfOvdAAhPx6a1gkQA4WELC3e3dkQoNK8RKswx2BYJ5KXhsh0cqy2CvQNPmUHz5+DvfO0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YbXIHNko; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YbXIHNko"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZMhYimDVN3PWm9O6wHwuFObgia/AxLaO9IAmAW5Pbk4=;
	b=YbXIHNkoivr9IXDFkQgA3MJEcKS08F7teIcG0VKxfNt2fYhfwVrVIhWyeujsi4MJYHDTuSANp
	GQRI5jNRA13PDTpOzBKA83SqYNiRaWOs20NzqGU76hd+JR+gzmSk75bis7m8c3JUEo2rG6Sebf1
	v9cnfKUgo11fu3l/XIBGbRA=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4g1w9F3DSXz1prN9;
	Fri, 24 Apr 2026 09:19:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id D863840571;
	Fri, 24 Apr 2026 09:25:55 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Apr 2026 09:25:55 +0800
Message-ID: <486a8633-437d-42d1-85f9-690a9df311eb@huawei.com>
Date: Fri, 24 Apr 2026 09:25:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] vfio/pci: Add PCIe TPH support
To: Leon Romanovsky <leon@kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>,
	<helgaas@kernel.org>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260423010851.46737-1-fengchengwen@huawei.com>
 <20260423145915.GG172828@unreal>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260423145915.GG172828@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 4/23/2026 10:59 PM, Leon Romanovsky wrote:
> On Thu, Apr 23, 2026 at 09:08:46AM +0800, Chengwen Feng wrote:
>> This series adds support for PCIe TLP Processing Hints (TPH) to
>> vfio-pci, allowing userspace to manage device steering tags for
>> improved performance and QoS in virtualized deployments.
>>
>> The implementation follows a clean incremental structure:
>> - Patch 1: Export pcie_tph_get_st_modes()
>> - Patch 2: Introduce UAPI ABI and implement capability query to
>>   let userspace discover supported TPH modes, ST table presence
>>   and size. Also add module parameter enable_unsafe_tph_ds to
>>   guard unsafe usage of TPH Device-Specific mode with no ST table.
>> - Patch 3: Add TPH enable/disable with mode selection. Restrict
>>   unsafe Device-Specific mode without ST table to be allowed only
>>   when the module parameter is enabled.
>> - Patch 4: Add interface to batch get per-CPU steering tags for
>>   device-specific mode without standard ST table. This interface
>>   is only available when the unsafe module parameter is enabled.
>> - Patch 5: Add interface to batch program steering tag table
>>   entries for standard TPH modes.
>>
>> All user API definitions are finalized in the first patch and
>> remain stable across the series. The design follows existing
>> VFIO conventions and relies on kernel pcie-tph infrastructure.
>>
>> To avoid potential security risks in virtualization environments,
>> TPH Device-Specific mode without a standard ST table is blocked
>> by default. It can only be enabled by administrators via the
>> enable_unsafe_tph_ds module parameter for trusted bare-metal
>> userspace.
>>
>> This series addresses the TPH management requirements discussed
>> in the RFC "Proposal: Add sysfs interface for PCIe TPH Steering
>> Tag retrieval and configuration".
> 
> As in the RFC, this patch series still lacks an explanation of *why* it is
> needed. Please describe the scenario that cannot be handled without these
> changes.

Thanks for your review. To clarify the necessity in two clear layers:

1. Why userspace needs the capability to control steering tags:
   When PCIe devices are fully taken over by userspace workloads like DPDK
   and SPDK, only userspace understands core binding policies and traffic
   distribution. Without this series, userspace cannot enable TPH or
   configure steering tags, leaving built-in PCIe performance optimizations
   unused for high-throughput polling I/O scenarios.

2. Why the interface must be implemented inside VFIO:
   VFIO is the only mainstream and secure community solution for passing
   complete PCIe device ownership to userspace. Existing kernel TPH
   interfaces are designed exclusively for in-kernel drivers, so VFIO
   provides the only correct, isolated path to expose per-device TPH
   management for user-owned devices.

Thanks

> 
> Thanks

