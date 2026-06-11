Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A09349AF5
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186428; cv=none; b=hImhN63FzNsHLzGFI22ahda5DxfUBZUgVwgQw09E8O2nemOJUZLvwwVjLZIh0+NjqE+1opM+vAa5NLzMo6bboEOAViHbUDdglYgdtG9NCYdsnl3olrLs2eflU2Kf5bo8IcCoeqVuI+mOXxDZLR6p9N4/KfpZZaVNJBIOPkp7YUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186428; c=relaxed/simple;
	bh=SCUQExsNaKgQr1fmVwFsFmI56g0dyNlPL9PaiRxSUuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxmxL7Vc518o7YbkWl7oyV8vv3hPwLPgEFKVEs/GIsnT3yDIdLq0IpUQztbWVBfRnYrGI3FF1Xb02KGa1Jfxvq2sl+tib6ny398F/X+WMn5exbw/s8+aWp4JO7P2ZqcuQJgLZ0lcs3+wdqLqh/ASBjNjHDJoM+Bxw6j3F4g1Vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XcHF7yL3; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XcHF7yL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=oOEikyuy4If26TMDHDYd8i3/PyjxUv7AZdvb+eEgKeg=;
	b=XcHF7yL3WSpqyN2fYCiH92zr0jXZ0uhrvsf3BsTogwYraqQqLIJvkzB6FfT6cc
	M4+tA8owuQa74/y7zxgjT+j/CzvAtrTOr3qwhjs0xvLQZz8CWUTu83j/RJFVV8zA
	zpjqXvjNpSr9dBs3Mde8Z5kUne0qtWBLjrrYM85kc4RVE=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgB3siFhvypqufqXBg--.40968S2;
	Thu, 11 Jun 2026 22:00:01 +0800 (CST)
Message-ID: <314c3a1d-fd82-4614-a9fd-8a126845b881@163.com>
Date: Thu, 11 Jun 2026 22:00:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] PCI: vmd: Protect root bus removal with rescan lock
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-pci@vger.kernel.org
References: <20260521161822.132996-9-18255117159@163.com>
 <20260521212024.8689D1F000E9@smtp.kernel.org>
 <r5vwd573ydynlrrax5iy6jt25dc2yiqkvlciqy366zsxxu4d7f@hyvqgsdj4ulw>
 <7e46fd05-b190-42ed-8e5e-78c8a0a6bc20@163.com>
 <xj42mezfer3jxlku3rg244skqpbxrf5dn47txnippxxsgan6mq@qhtmpolifzyv>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <xj42mezfer3jxlku3rg244skqpbxrf5dn47txnippxxsgan6mq@qhtmpolifzyv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:QCgvCgB3siFhvypqufqXBg--.40968S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4kGryxAryUXFWkXw1xuFg_yoW5ArW8pF
	Z8Xa45CF18JrWSvrs2va18ZryYqw1xGry5Xw1fWrnruFnIvw12qrWjyFWUur98WFsFya1Y
	vw18t3ySqrs8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRO18PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAIt0Goqv2ISywAA3-



On 6/11/26 14:30, Manivannan Sadhasivam wrote:
> On Thu, Jun 11, 2026 at 12:42:52PM +0800, Hans Zhang wrote:
>>
>>
>> On 6/11/26 01:28, Manivannan Sadhasivam wrote:
>>> On Thu, May 21, 2026 at 09:20:24PM +0000, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>>
>>>> New issues:
>>>> - [High] Acquiring `pci_rescan_remove_lock` in `vmd_remove()` introduces self-deadlocks and AB-BA lock inversions.
>>>>
>>>> Pre-existing issues:
>>>> - [High] SRCU structures are destroyed in `vmd_remove()` while their corresponding interrupt handlers are still registered and active, leading to a Use-After-Free in interrupt context.
>>>> --
>>>>
>>>> commit 8d5d06b67e6b02d2cc99f2151e90ba61c0d16662
>>>> Author: Hans Zhang <18255117159@163.com>
>>>>
>>>> PCI: vmd: Protect root bus removal with rescan lock
>>>>
>>>> This commit acquires the pci_rescan_remove_global_lock while stopping
>>>> and removing the VMD root bus in vmd_remove(). This is intended to
>>>> prevent races with concurrent PCI rescan operations.
>>>>
>>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>>>> index d4ae250d4bc6d..9565567026cf0 100644
>>>>> --- a/drivers/pci/controller/vmd.c
>>>>> +++ b/drivers/pci/controller/vmd.c
>>>>> @@ -1056,9 +1056,11 @@ static void vmd_remove(struct pci_dev *dev)
>>>>>    {
>>>>>    	struct vmd_dev *vmd = pci_get_drvdata(dev);
>>>>> +	pci_lock_rescan_remove();
>>>>
>>>> [Severity: High]
>>>> Can acquiring pci_rescan_remove_lock here cause self-deadlocks or AB-BA lock
>>>> inversions?
>>>>
>>>> When a VMD device is removed via PCI hotplug or sysfs remove node, the PCI
>>>> core calls pci_stop_and_remove_bus_device_locked(), which acquires
>>>> pci_rescan_remove_lock and eventually triggers vmd_remove(). Because
>>>> pci_rescan_remove_lock is a non-recursive mutex, won't attempting to acquire
>>>> it again immediately self-deadlock?
>>>>
>>>> Also, when unbound via sysfs, the core holds device_lock and calls
>>>> vmd_remove(), which then waits for pci_rescan_remove_lock. Since normal PCI
>>>> rescans acquire pci_rescan_remove_lock first, then attempt to acquire
>>>> device_lock, does this create an AB-BA lock inversion?
>>>>
>>>
>>> This is a valid concern. Since VMD is registered as a PCI driver, removing the
>>> VMD device through sysfs will trigger vmd_remove() callback and it will result
>>> in deadlock. The AB-BA lock inversion is also valid.
>>>
>>
>> Hi Mani,
>>
>> Thank you for your reply. I checked it and found that this is indeed the
>> registered PCI driver. This patch will be dropped from this series. I wonder
>> if you have any further comments or opinions regarding the remaining
>> patches. Do I need to send the next version?
>>
> 
> I will skip this patch and apply the rest.
> 

Thank you.

> - Mani
> 

