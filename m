Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E941F7916;
	Fri, 17 Apr 2026 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386918; cv=none; b=iyHEG+NOj4pT0T3SDOO5gYy5ZQTov+oalPVlVaHxAMogLZRV1Mt7hfx0MZ0vKdR7WFU2T0pDk6h3abq1Pyhaj5zdauViOAPb5URNHuVshEsJpobC5m5eRxSWRoG3rXKsoGi0YRJxKe93PASTnAQ2WjMaDUNVCa5HSebYyIDieQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386918; c=relaxed/simple;
	bh=oLFcl88eWXQXucj6DoxcVHUiprn6Aw1tvz6UrxSUJLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jmsdNx+ihVHapBVXoStEzCrzNdmyqOCjIY+i/J5zg4fmzC6K3GugJsYHlKJOlbJ3hKBHWcUnaHtuRJTjxKfgbdQCBm5luNl3+Ipkq/+jUa0mL4Cy4dJT/qSp8+OR5tLjJ++ofVM1Tp5FtMCg2swr6Q/+gLxlU3jUMubPghgEdUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y+rc53sI; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y+rc53sI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Z6h+QXuK/S/F4/p4HaQdGt2hHxkqesC4Tpd9pXe/VvY=;
	b=Y+rc53sIM6B8UAazz9eEM6MREmzGx+B2DFpbH5rHlScLuNl1/X0ijDjT5le6BXNeook3DzRwd
	m0P5Ii7+f070cp7cVGRJ8+IMUrDyDjqrQ+FW+Wrhgcdg4zWhpHqfYoRkhJE0hy7yN7Q84GNdNBw
	fIc2abR3+UG79PzDla3fxTE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fxbgW4xnjz12LDP;
	Fri, 17 Apr 2026 08:42:15 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id B149540561;
	Fri, 17 Apr 2026 08:48:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Apr 2026 08:48:32 +0800
Message-ID: <5ed17a05-1dee-49c2-8d40-a1db8f67ef13@huawei.com>
Date: Fri, 17 Apr 2026 08:48:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/pci: Add PCIe TPH GET_ST interface
To: Alex Williamson <alex@shazbot.org>
CC: Wathsala Vithanage <wathsala.vithanage@arm.com>, <jgg@ziepe.ca>,
	<kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
 <20260415090959.53672-4-fengchengwen@huawei.com>
 <518e5e0a-d0b2-4775-a32a-e2dc87c8ba4b@arm.com>
 <41d5b3ea-abe2-4583-be88-2addf6b4d394@huawei.com>
 <20260416074020.57e4ed72@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260416074020.57e4ed72@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi Alex,

Thank you very much for your clear and detailed security explanation.
I fully understand and agree with your security concerns about allowing
userspace to query steering tags for arbitrary CPUs.

To completely resolve this security issue while retaining the mandatory
functionality for DS-mode devices without ST table, I will revise the
GET_ST interface with a strict security constraint in v3:

    The CPU number provided by userspace will be VALIDATED TO EQUAL
    THE CURRENT CALLING CPU of the ioctl().

In other words:
- Userspace can ONLY query the steering tag for the CPU it is currently
  running on.
- Userspace CANNOT query any other CPU.
- No cross-CPU probing, no side-channel, no attack surface.
- No ability to influence or target other CPUs.

This completely eliminates the security exposure you mentioned, while
still fully supporting the Device-Specific mode requirement for devices
without ST tables.

Thanks

On 4/16/2026 9:40 PM, Alex Williamson wrote:
> On Thu, 16 Apr 2026 09:09:50 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
> 
>> On 4/15/2026 9:55 PM, Wathsala Vithanage wrote:
>>> Hi Feng,
>>>
>>> get_st  feature is unsafe. It allows a rogue userspace driver in device-specific
>>> mode to obtain steering tags for arbitrary CPUs, including ones unrelated
>>> to the device or its workload, enabling it to direct traffic into those CPUs’
>>> caches and potentially interfere with other workloads, opening doors to
>>> further exploits depending on other vulnerabilities.  
>>
>> Thank you for the follow-up and for referencing the prior RFC
>> discussion on this topic. I appreciate you clarifying the
>> historical context of the safety concerns.
>>
>> I acknowledge the risks you’ve highlighted, but I believe the
>> risk profile in this VFIO interface is different and already
>> well bounded by existing design and practice:
>>
>> 1. VFIO device access requires elevated privileges
>>    A userspace process can only open a VFIO device node if it
>>    has sufficient privileges (typically root). This is not an
>>    interface for unprivileged users.
> 
> This argument is NOT helping your cause.  This is not the usage model
> we design for.  VFIO usage requires that privileges be granted to a
> user, in the form of device ACL access and locked memory, but does not
> generally require elevated privileges beyond that, or otherwise grant
> the user authority beyond the scope of the device.  The root use case
> may be typical for you, but is not required for many other typical use
> cases, such as device assignment to VMs.
>  
>> 2. In the thread "[RFC v2 0/2] Retrieve tph from dmabuf for PCIe
>>    P2P memory access", applications can configure the steertag
>>    of exported dmabufs from userspace to the kernel. Kernel PCIe
>>    drivers (e.g., mlx5 NIC) then use these steertags and set them
>>    to their ST tables. Even here, userspace could set invalid
>>    steertags that impact GPU performance—but this model is
>>    basically accepted I think (refer from maillist discuss).
> 
> It's an RFC.  It's bold to claim that it's nearly accepted.
> 
>> 3. Malicious resource consumption is not unique to TPH
>>    A malicious thread can be created to forcibly consume CPU
>>    resources and bound to a specific CPU, affecting other CPUs.
>>    This is a general system security concern, not one specific
>>    to TPH GET_ST, and is addressed by existing system hardening
>>    and access control mechanisms—not by removing useful features.
> 
> You're conflating process abuse of a CPU to a potential side-channel
> DMA attach from a device.  What *existing* hardening protects against
> the latter?
> 
>> 4. GET_ST is strictly necessary for Device-Specific (DS) mode
>>    when no ST table is present on the device.
>>    For devices that do not have a dedicated ST table (a common
>>    scenario in many PCIe endpoints), DS mode requires userspace
>>    to retrieve per-CPU steering tags first, then program them
>>    into the device’s steering logic via other registers. Without
>>    GET_ST, userspace cannot obtain the required steertags to
>>    enable TPH DS mode at all—rendering TPH support useless for
>>    these devices. This is not an optional feature but a
>>    fundamental requirement to unlock TPH functionality for a
>>    large class of hardware.
> 
> Unlocking a hardware feature does not give you authority to ignore the
> security implications of that feature.  Thanks,
> 
> Alex

