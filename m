Received: from mail-m155110.qiye.163.com (mail-m155110.qiye.163.com [101.71.155.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109E1A682B
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791607605; cv=none; b=KkHn9eJpKy0ZoAQEeY1BgqaS9fLtHJL26c2ni5hIlKnkk/Pznh05jHZoBSylP2nnlL7DkE88IRAUeVCHGxsS5t/ZceAurr2/weGNdLXmfWoHFfyiKiHFKXbGNZlAUEE8apSkt84MwYkmDazvAlqoQPEGsF137qmkfhaBlJ5xVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791607605; c=relaxed/simple;
	bh=XMxGW0xaJZQeL/KjGG4KZmFQcr7o0ydm0ul4O5LUEhY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nj7suybAudhuFqwMlvSSSJfO4BmSczOVjbnbIPyPEm/RgHQVvem3PIw+ZDp/3z0F0+yDqSKJ/sibYPxXgGpabVfLTdyDalGUCToKViNqs4HNOsFDxp4bRIlsu3v3rmKnEDX5zRxefL/ghSxFHkb4LjEuaY62MgHYa50SL2HvlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NMcUG1Vk; arc=none smtp.client-ip=101.71.155.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NMcUG1Vk"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5085e5e31;
	Sat, 10 Oct 2026 11:30:57 +0800 (GMT+08:00)
Message-ID: <1a06c07e-b29a-4c27-a4eb-9513567c2c8d@rock-chips.com>
Date: Sat, 10 Oct 2026 11:30:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Fix NULL pointer dereference in sysfs
 show/store callbacks
To: sashiko-reviews@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <mani@kernel.org>
References: <1791596305-153177-1-git-send-email-shawn.lin@rock-chips.com>
 <sashiko-outbox-166236@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <sashiko-outbox-166236@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa123dd249703a4kunm659ca1ca5c97b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx5LVkwZThoZQk1OSR9IHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NMcUG1VkONXj6A3vtf018GozHOqVVHLoxpnOl+DAWKZFHfhUSESE4LRqQo60Sm0t5lViwvJupIhktArMQ9PPO0/fPdfrQRqUayK1ziaGScSGobkJhsjHm4RbpKKl4cnMxeFod2voKLtem0FfLMNYkSQFr6aCBGBDRxYNMXdMwS0=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=TV3G4zHmwkxbumtMUjsoCVMj2L0MmWuDDCVqX9Zax7A=;
	h=date:mime-version:subject:message-id:from;

Hi, Sashiko and maintainers

在 2026/10/10 星期六 11:01, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] pci/aspm: use-after-free race in sysfs callbacks due to lockless pcie_link_state check
> --
> 
> commit 9e5cf0a1d40aaa7028d286ec96a1c08c4a3dfd68
> Author: Shawn Lin <shawn.lin@rock-chips.com>
> 
>      PCI/ASPM: Fix NULL pointer dereference in sysfs show/store callbacks
>      
>      Reading or writing a link state sysfs attribute after the upstream
>      bridge's pcie_link_state has been freed triggers a NULL pointer
>      dereference.
> 
> Cc: stable@vger.kernel.org
> 
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index f8e64971c6c3d..0e0ba0e677e50 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -1777,6 +1777,9 @@ static ssize_t aspm_attr_show_common(struct device *dev,
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>>   
>> +	if (!link)
>> +		return -ENODEV;
>> +
>>   	return sysfs_emit(buf, "%d\n", (link->aspm_enabled & state) ? 1 : 0);
>>   }
> 
> [Severity: High]
> Does this locklessly fetch and check the link pointer, leaving it exposed to
> concurrent freeing?
> 

Sashiko, thanks for reporting it.

This is not a regression introduced by my patch. Both the NULL
dereference and the use-after-free pre-exist in the original code, where
the link pointer is fetched and dereferenced without holding aspm_lock,
while pcie_aspm_exit_link_state() clears and kfree()s the link state
under aspm_lock. My patch only covered the NULL dereference (the part I
could reproduce); it did not touch the existing UAF window.

The UAF window is extremely narrow and is not reachable by a plain
userspace sequence, so I'd prefer to keep this patch focused on the NULL
dereference, which has a reliable reproduction. Serializing the lookup
against aspm_lock would be a larger change and is not suitable for
backporting to stable. It can be addressed separately if needed.

Hi Bjorn,

Please let know if you'd prefer to address UAF issue in the same patch?

> If another process triggers the removal of function 0 of the downstream
> component concurrently, pcie_aspm_exit_link_state() could acquire the locks,
> clear the link state, and free the link after the check but before
> sysfs_emit() dereferences it. Can this lead to a use-after-free regression?
> 
>> @@ -1788,6 +1791,9 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>>   	bool state_enable;
>>   
>> +	if (!link)
>> +		return -ENODEV;
>> +
>>   	if (kstrtobool(buf, &state_enable) < 0)
>>   		return -EINVAL;
>>   
> 
> [Severity: High]
> Could this cause a similar regression here?
> 
> The pointer is validated locklessly but dereferenced inside the lock. It can
> be freed by a concurrent thread while the current thread is waiting for
> pci_bus_sem or aspm_lock further down in the function.
> 
>> @@ -1836,6 +1842,9 @@ static ssize_t clkpm_show(struct device *dev,
>>   	struct pci_dev *pdev = to_pci_dev(dev);
>>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>>   
>> +	if (!link)
>> +		return -ENODEV;
>> +
>>   	return sysfs_emit(buf, "%d\n", link->clkpm_enabled);
>>   }
> 
> [Severity: High]
> Does this code have the same use-after-free race condition?
> 
> The link pointer is validated outside any locks, but could be freed by a
> concurrent removal before it is dereferenced in sysfs_emit().
> 
>> @@ -1847,6 +1856,9 @@ static ssize_t clkpm_store(struct device *dev,
>>   	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>>   	bool state_enable;
>>   
>> +	if (!link)
>> +		return -ENODEV;
>> +
>>   	if (kstrtobool(buf, &state_enable) < 0)
>>   		return -EINVAL;
>>   
> 
> [Severity: High]
> Does this demonstrate the same race condition as aspm_attr_store_common()?
> 
> The pointer is validated locklessly, but dereferenced inside the lock. It can
> be freed by a concurrent thread while the current thread is waiting for the
> locks further down in the function.
> 

