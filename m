Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891C3B1B3;
	Thu, 16 Apr 2026 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355991; cv=none; b=D2Yz8iQvCptpR/JsUiWx9MB7ZpXID43KLAvCE6U071zLV1LYVxj/pKXZ1/7e1dW/CIY9ugyP/pYuktLM2VRwU/pJY0N08gm4pSNUegYquPfWb/Ne6XCdxA+CQLviwGw+rUSchpJB9cHwdKvUtEIqTVxAd7ngunbbBDqRZcHrx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355991; c=relaxed/simple;
	bh=9tR51p0l4s/flblZnKk0MR9Vl7hTT1JTEbq0OQtufA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdywW4VKJreY8MhYthmU6vU15zZ7iUYfB1R45NYi1tFkXEQQylipjEU9JL8EUxootI7sJtBrHl8iXtgxbWiKrX5ZBQ66OksJFb2CzYnew5Ekn/sCAUKWolbBTRqJd9DqaOcZU1sIbZ+r4o/XBnjvSdFoXbGhQwjD95ZUu4OkKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iLOIt90s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iLOIt90s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092AD2574;
	Thu, 16 Apr 2026 09:13:03 -0700 (PDT)
Received: from [192.168.86.29] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B6723F7D8;
	Thu, 16 Apr 2026 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776355988; bh=9tR51p0l4s/flblZnKk0MR9Vl7hTT1JTEbq0OQtufA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iLOIt90slMti4C7NoBX3mXZi90CcmQkEFt0spI1yYWzLFepipmwED6ZkgWRLF3LvG
	 P9OTrAeeVCW8i9piORhJ6FwrqCV702UKcvfYslVCaq+RRoGFblGqCgphLz8vIfzBB2
	 vn+J6Qv44oYBUIjfW+E1bt0rD2G0vWUsbtuCUpwk=
Message-ID: <0b19a6ce-f328-4b63-a2c4-e9ee43ee7e92@arm.com>
Date: Thu, 16 Apr 2026 11:12:57 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/pci: Add PCIe TPH GET_ST interface
To: Alex Williamson <alex@shazbot.org>, fengchengwen <fengchengwen@huawei.com>
Cc: jgg@ziepe.ca, kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260415090959.53672-1-fengchengwen@huawei.com>
 <20260415090959.53672-4-fengchengwen@huawei.com>
 <518e5e0a-d0b2-4775-a32a-e2dc87c8ba4b@arm.com>
 <41d5b3ea-abe2-4583-be88-2addf6b4d394@huawei.com>
 <20260416074020.57e4ed72@shazbot.org>
Content-Language: en-US
From: Wathsala Vithanage <wathsala.vithanage@arm.com>
In-Reply-To: <20260416074020.57e4ed72@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/16/26 08:40, Alex Williamson wrote:
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
>> Thank you for the follow-up and for referencing the prior RFC
>> discussion on this topic. I appreciate you clarifying the
>> historical context of the safety concerns.
>>
>> I acknowledge the risks you’ve highlighted, but I believe the
>> risk profile in this VFIO interface is different and already
>> well bounded by existing design and practice:
>>
>> 1. VFIO device access requires elevated privileges
>>     A userspace process can only open a VFIO device node if it
>>     has sufficient privileges (typically root). This is not an
>>     interface for unprivileged users.
> This argument is NOT helping your cause.  This is not the usage model
> we design for.  VFIO usage requires that privileges be granted to a
> user, in the form of device ACL access and locked memory, but does not
> generally require elevated privileges beyond that, or otherwise grant
> the user authority beyond the scope of the device.  The root use case
> may be typical for you, but is not required for many other typical use
> cases, such as device assignment to VMs.
>   
>> 2. In the thread "[RFC v2 0/2] Retrieve tph from dmabuf for PCIe
>>     P2P memory access", applications can configure the steertag
>>     of exported dmabufs from userspace to the kernel. Kernel PCIe
>>     drivers (e.g., mlx5 NIC) then use these steertags and set them
>>     to their ST tables. Even here, userspace could set invalid
>>     steertags that impact GPU performance—but this model is
>>     basically accepted I think (refer from maillist discuss).
> It's an RFC.  It's bold to claim that it's nearly accepted.
>
>> 3. Malicious resource consumption is not unique to TPH
>>     A malicious thread can be created to forcibly consume CPU
>>     resources and bound to a specific CPU, affecting other CPUs.
>>     This is a general system security concern, not one specific
>>     to TPH GET_ST, and is addressed by existing system hardening
>>     and access control mechanisms—not by removing useful features.
> You're conflating process abuse of a CPU to a potential side-channel
> DMA attach from a device.  What *existing* hardening protects against
> the latter?
>
>> 4. GET_ST is strictly necessary for Device-Specific (DS) mode
>>     when no ST table is present on the device.
>>     For devices that do not have a dedicated ST table (a common
>>     scenario in many PCIe endpoints), DS mode requires userspace
>>     to retrieve per-CPU steering tags first, then program them
>>     into the device’s steering logic via other registers. Without
>>     GET_ST, userspace cannot obtain the required steertags to
>>     enable TPH DS mode at all—rendering TPH support useless for
>>     these devices. This is not an optional feature but a
>>     fundamental requirement to unlock TPH functionality for a
>>     large class of hardware.
> Unlocking a hardware feature does not give you authority to ignore the
> security implications of that feature.  Thanks,
>
> Alex


First vfio-TPH RFC captures some of the risks
https://lore.kernel.org/kvm/20250221224638.1836909-1-wathsala.vithanage@arm.com/

--wathsala

