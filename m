Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB733D6F7
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153001; cv=none; b=lYjADLbDQHDQLAvOh3r41imofbKcpf9KeoPU9ftooMyaL8BbiuEnZzYFXWgdUmtJyUoWosd7k/BUmXP+2V5YdvsP4KFzQDzCeBEExKuGeLNil8DrMJaYvOc2WqwPOM969I/eqYa5213vbTebJ2PyCuP7+F2yzqv6vQxG1CRwzl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153001; c=relaxed/simple;
	bh=51fwaAf64FzofFfgwzNCWoO/6ksD1+r+yYyCpLXZNBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Km+5/3X7sbUTi/m4wQgyayX3OXSvluU6crvTrgrf9gQLYcnQD/frVL0wZIQgPhaffO2d0cjCrp9ZESSTOUFNgI5rk7DN5KX4PoPD4TaC77HLxN4In/GoSuT46Lf8zTAhQnfap3YOY6Z3FxJVPN6zu+DplGFDvAHfAEfSb5m8FnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i7jLg2Us; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i7jLg2Us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wbbAdaq+l2HzeM3t/FWYy9MmfznYHb7o3G8GQlqGv80=;
	b=i7jLg2UsCLHRKSBa/pCA2WHKYWHwcF0sW40AEM4GWOWJhoh1asdgWwRWr2xba8
	mXKOi3NC8rZM5NrCjWEd7yV6CL4cJDn0D0r+ijslxtZ1py2Fz4X/vcriYxY4t+Kh
	xlw0+j3U++VqO8yAsidwW5vbT546f1kakv0KZNYWmSFs8=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD334_PPCpq34DzCg--.22715S2;
	Thu, 11 Jun 2026 12:42:56 +0800 (CST)
Message-ID: <7e46fd05-b190-42ed-8e5e-78c8a0a6bc20@163.com>
Date: Thu, 11 Jun 2026 12:42:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] PCI: vmd: Protect root bus removal with rescan lock
To: Manivannan Sadhasivam <mani@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260521161822.132996-9-18255117159@163.com>
 <20260521212024.8689D1F000E9@smtp.kernel.org>
 <r5vwd573ydynlrrax5iy6jt25dc2yiqkvlciqy366zsxxu4d7f@hyvqgsdj4ulw>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <r5vwd573ydynlrrax5iy6jt25dc2yiqkvlciqy366zsxxu4d7f@hyvqgsdj4ulw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD334_PPCpq34DzCg--.22715S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kZF47KFyUCFyUZFWxtFb_yoW5Gw1DpF
	ZxXa45ur18JrySvws2va18Zr90vwn7GrW5Xw1fWrnrWFy3Z342vrWYyFWjvF90gFsFva1Y
	vr1kt3yftrs8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRO18PUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xBoDGoqPNAOZQAA3Y



On 6/11/26 01:28, Manivannan Sadhasivam wrote:
> On Thu, May 21, 2026 at 09:20:24PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Acquiring `pci_rescan_remove_lock` in `vmd_remove()` introduces self-deadlocks and AB-BA lock inversions.
>>
>> Pre-existing issues:
>> - [High] SRCU structures are destroyed in `vmd_remove()` while their corresponding interrupt handlers are still registered and active, leading to a Use-After-Free in interrupt context.
>> --
>>
>> commit 8d5d06b67e6b02d2cc99f2151e90ba61c0d16662
>> Author: Hans Zhang <18255117159@163.com>
>>
>> PCI: vmd: Protect root bus removal with rescan lock
>>
>> This commit acquires the pci_rescan_remove_global_lock while stopping
>> and removing the VMD root bus in vmd_remove(). This is intended to
>> prevent races with concurrent PCI rescan operations.
>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index d4ae250d4bc6d..9565567026cf0 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -1056,9 +1056,11 @@ static void vmd_remove(struct pci_dev *dev)
>>>   {
>>>   	struct vmd_dev *vmd = pci_get_drvdata(dev);
>>>   
>>> +	pci_lock_rescan_remove();
>>
>> [Severity: High]
>> Can acquiring pci_rescan_remove_lock here cause self-deadlocks or AB-BA lock
>> inversions?
>>
>> When a VMD device is removed via PCI hotplug or sysfs remove node, the PCI
>> core calls pci_stop_and_remove_bus_device_locked(), which acquires
>> pci_rescan_remove_lock and eventually triggers vmd_remove(). Because
>> pci_rescan_remove_lock is a non-recursive mutex, won't attempting to acquire
>> it again immediately self-deadlock?
>>
>> Also, when unbound via sysfs, the core holds device_lock and calls
>> vmd_remove(), which then waits for pci_rescan_remove_lock. Since normal PCI
>> rescans acquire pci_rescan_remove_lock first, then attempt to acquire
>> device_lock, does this create an AB-BA lock inversion?
>>
> 
> This is a valid concern. Since VMD is registered as a PCI driver, removing the
> VMD device through sysfs will trigger vmd_remove() callback and it will result
> in deadlock. The AB-BA lock inversion is also valid.
> 

Hi Mani,

Thank you for your reply. I checked it and found that this is indeed the 
registered PCI driver. This patch will be dropped from this series. I 
wonder if you have any further comments or opinions regarding the 
remaining patches. Do I need to send the next version?

Best regards,
Hans

