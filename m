Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242E1A9B24
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546770; cv=none; b=U6slOcrAPBBVi+dVhbYUzlyRTFKYV47RkmfQkWUvKoIA4DTXjyFdfseavffQV27/+mX9pXnyX2pBpam4ScT5OpjjxrYDiwAsWuieEhXUgnFNmhNx/y1TzrgkAm4mtlJV/f56Xt6kNKF5K2LikrxNTOxHRhQdmPP/8JYGJXPo52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546770; c=relaxed/simple;
	bh=xE4vkaMk5lE+B0S8YaszX+ozSsx9d4gTmBXg8P1TonI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzD1KbFuFM+tkpCwrLD7/i/K1maBQZr9oaDum+fBqFLnf/CBOAQWm4b477BI5tMRQ5lv/67ifr9o4ILgE36b2HGBSVBKlAmcQbaFfeSaSTkgzSo+9JXlvXUeAMVy0ZWGnNClGMwpM3MczQG2dK3Py7M3dcpVvyw8S7mirGz9gzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j6vcLSG4; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j6vcLSG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=+skjbmQLDZgwLVaOtZ8JrPlL7Tx42Vts5r4FyPVp1qM=;
	b=j6vcLSG4dX5lzREXH8TlUfVXHdaM51rrQlq10wnP9keQVDvi5wVBZun3ArDM9s
	3A1i32kapYqeUnjsi2Ehi/4vt9Dl3L1BKACYnsHC3Nl2D5mfQsZzpQBR6MAuhCPn
	faRzKWVjIpnG+DPeyL+VvVEVB660gqM44YrGxYPKcKikI=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3qgs2eAJquqyVEA--.4962S2;
	Tue, 12 May 2026 08:45:42 +0800 (CST)
Message-ID: <982ada81-7f17-47f8-9b23-6e5c59f627eb@163.com>
Date: Tue, 12 May 2026 08:45:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] PCI: Add pci_host_common_link_train_delay() helper
To: sashiko@lists.linux.dev
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
References: <20260511055923.37117-2-18255117159@163.com>
 <20260512000723.2F382C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260512000723.2F382C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PSgvCgC3qgs2eAJquqyVEA--.4962S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWUAr1UXFyxCryDur17Jrb_yoW5Zr4Dpa
	yrGa42yF1kJw1Yvws7X3W8Za4Ygan5JayUCrn5G3s2yrnxZ3savrWF9ayS9F1xur4DZF1Y
	va15K3ZxArsYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pN388UUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBZG6WoCeDYyNgAA3f



On 5/12/26 08:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Negative error codes passed as `max_link_speed` silently bypass the mandatory PCIe delay.
> - [Medium] Architectural modularity violation by placing a generic PCIe helper in an ECAM framework header.
> - [Low] The helper API relies on raw integer values for link speed instead of the typed `enum pci_bus_speed`, creating a brittle interface.
> --
> 
> commit 47720e87ef05a9f0115d64b2e2d6eaa190242b88
> Author: Hans Zhang <18255117159@163.com>
> 
> PCI: Add pci_host_common_link_train_delay() helper
> 
> This commit introduces a static inline helper to wait 100 ms after link
> training completes if the maximum link speed is greater than 5.0 GT/s,
> satisfying the PCIe r6.0 specification.
> 
>> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
>> index b5075d4bd7eb3..d709f7e3e11a3 100644
>> --- a/drivers/pci/controller/pci-host-common.h
>> +++ b/drivers/pci/controller/pci-host-common.h
> 
> This isn't a bug, but this places a generic PCIe helper inside an ECAM
> framework header. Unrelated host controller drivers will have to include
> an ECAM-specific header just to use this delay function.
> 
> Should this generic helper be placed in a more widely accessible internal
> header like drivers/pci/pci.h?

No, Mani suggested placing it in the pci-host-common.h file.

> 
> [ ... ]
> 
>> @@ -20,4 +23,18 @@ void pci_host_common_remove(struct platform_device *pdev);
>>   
>>   struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>>   	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
>> +
>> +/**
>> + * pci_host_common_link_train_delay - Wait 100 ms if link speed > 5 GT/s
>> + * @max_link_speed: the maximum link speed (2 = 5.0 GT/s, 3 = 8.0 GT/s, ...)
>> + *
>> + * Must be called after Link training completes and before the first
>> + * Configuration Request is sent.
>> + */
>> +static inline void pci_host_common_link_train_delay(int max_link_speed)
> 
> This isn't a bug, but relying on raw integer values for link speed instead
> of enum pci_bus_speed creates a brittle interface.
> 
> The PCI subsystem uses enum pci_bus_speed for link speeds, where
> PCIE_SPEED_2_5GT is 20 and PCIE_SPEED_5_0GT is 21. If a driver mistakenly
> passes an enum pci_bus_speed, the condition greater than 2 will evaluate
> to true for all speeds, applying the delay unconditionally.
> 
>> +{
>> +	if (max_link_speed > 2)
> 
> Will negative error codes passed as max_link_speed silently bypass the
> mandatory PCIe delay?
> 
> Drivers retrieve the maximum link speed using of_pci_get_max_link_speed(),
> which returns -EINVAL if the max-link-speed property is missing from the
> device tree.
> 
> If -EINVAL is passed directly to this helper, the condition evaluates to
> false and the 100 ms delay is skipped. If the hardware supports greater
> than 5.0 GT/s, skipping this delay violates the PCIe r6.0 specification.
> 
>> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
>> +}
>> +
>>   #endif
> 

