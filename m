Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CE30DEB2
	for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2026 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774704571; cv=none; b=rW6MtATqBhIWHOIgHhw5mVRsMfmlLtSbGQl5+WVDZl97kaasrp8XYa7Q6vSh44bHACaOkgqm6P6hiDtzhFzfkv/nflTFJdInjkOVNbBD8jipH3hXxPygHvKMNVlMe0SJWDLm3WoPW51Zd6Eb9kf3QXvq7UJSdC5TyfxbrwC0fZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774704571; c=relaxed/simple;
	bh=gs8ea6OoFKHlclJ6soHRfjUp4DM9NlLcaTcs4UpBX/s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hs9/AkMOQFbyzZyeW9dZrfC2ydrou9+/ATpCJUFXAO75PVFD3Zp7OOSZ9shuYtdW3cOfLjJb+k2rpZ3F0sw/8KJqtdtAzNHpDWFt6QwR1/guJH6IgEUverYVzBW3nEFB8dbS69CzFQ8P707O41drtOY4jNqTu5MAFq71RHFKOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9wnV1e0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9wnV1e0"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8296e257735so110435b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 28 Mar 2026 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774704569; x=1775309369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yDkcQgJOLhKZhkrJdSJSHiz/kE8E9HE5xrZ9mwCN70=;
        b=B9wnV1e0LmZVqGcCA0kbS2XnlLPBY06RQRvPsC4+LzSa9lamfg1y4TznYNJ1t95AbH
         D6y1gjSrDfeF3v12dw4879A2+fVxz7Pr63FGj24NIE/g0+G8L0CYKs8nBX5oJyXEzb86
         FF+fXweayDYBrHHroUgBQCyH+gYMtOAkxnRDvIbZXh6vwULbHcqPvZmcHiSgZk21P8EH
         Ily/eI1/j2wtVJ3obE+u2ClH937altEmJxVdWVcZjifdtIdLYZb40ZAGVShDE5A1Z9nE
         DHA+ibacCD9kvjFpHemaMk3LyIdq7acmejQy/VwZz6FCYjJ51fE5NYlA0YWXF5ZdhRyL
         K/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774704569; x=1775309369;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1yDkcQgJOLhKZhkrJdSJSHiz/kE8E9HE5xrZ9mwCN70=;
        b=CkHGIKFPIQpXMXiEehEOiDdjDBl7r1SYq7Kz1uAwsXhc/8kYhKEEouQ66Cc7Xq/WzK
         hrFkSiWbicoqXci/3E9hJLGUdwdGW6qP7NlAbI5t/P0iAdV/obvADxYJIwGMBjrDAx6X
         ETJyDUDIC8bi663hiyxDPwI7R6XtHCBOZYTRz9Fr8bZVZ10zxaKTg+AedH8slyvTQ8yW
         SExapUlFAopBJyT+rMLsnECgQ+XmDcXilr2NuJ5jD1AW1oOXMLjv5nlgbpgCxyWsPC5C
         JeQIBrr7eSs7Cmz1ma0RrJmtSEB0jprX9cwcJjTrnRyCaKkCuhx8dPoZcYaAFCxMlpOv
         /12Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/EiS3c/cLirhCkfOz6SjyuYtTxqB3FtAIj0pAEDiGh+lTjLHWpDZgo+2E5GM0CgGjN6o/s8JqpeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBm3jJidiJ/0SuwCEktfw1qenaJzrQZAZwB1YYot7o+FvaCY45
	AoS+wr+8jRP3IsP1r3I8H5s/q8I7PZDEcSV6va8KhBwh2mVYXzn1YqUt
X-Gm-Gg: ATEYQzzcMtMKfOSdotQl65Plm5f7vFKDl3JHno8M/URIgbhtup+ynXrycSYr2+YTLbw
	FHbPy4v1A3S83IwoHlBVdedSH6Q4qAq0b6ALYIu0VUY7eZi3ADJ7xIt2ia9v0Br3qoBdqMDW6xQ
	e6EHuxr14Jpa6d8SG85fA8qiwcI/GiMTOIW+nCjaE2/H7dGb+9xoKHVezZ29ny/0L0dZXdaMIdF
	mUVaXFpydVJMvo3y5nh2Q2u5Ve6qz0b47VA9wV6AAnGdIfJmx+e7ZSiZgtPSG7AbMQOJg5d0GFz
	mgY7Eh1TvZmge1x7PGDXMwoRcWDa78HnhDH44+aLGzTclZcSDLl/Xfa6fgQpW+L1fXndLz92m+3
	m0Z9HLjtt+QP6jJ9zpmYJj0IpBuH0mj7hXbEpkbzBuAD8TfomMRR4D5AiIGAcoP1N9OMM/t4NeZ
	RaY0sF93FiF7isn3YjMC4kmg3uhjlaIXjHokI2FFIC
X-Received: by 2002:a05:6a00:bc93:b0:829:a062:bcac with SMTP id d2e1a72fcca58-82c9601ff96mr3170481b3a.5.1774704569462;
        Sat, 28 Mar 2026 06:29:29 -0700 (PDT)
Received: from [192.168.0.100] ([163.125.228.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca862427asm2048911b3a.51.2026.03.28.06.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 06:29:29 -0700 (PDT)
Message-ID: <a27239fd-af18-40c9-acc1-55aa6e6e10bc@gmail.com>
Date: Sat, 28 Mar 2026 21:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: "Kagan, Roman" <rkagan@amazon.de>, "Mehanna, Fares" <faresx@amazon.de>,
 yangyccccc@gmail.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
 linuxarm@huawei.dom, prime.zeng@huawei.com
Subject: Re: [RESEND PATCH] PCI: Fix race condition between block_cfg_access
 and msi_enabled/msix_enabled
To: David Woodhouse <dwmw2@infradead.org>
References: <b7731cbbfe4144fcb411bf52d1f1002365ae0b87.camel@infradead.org>
From: Yicong Yang <yangyccccc@gmail.com>
In-Reply-To: <b7731cbbfe4144fcb411bf52d1f1002365ae0b87.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/3/16 17:56, David Woodhouse wrote:
>> Previously we use bit field for block_cfg_access and
>> msi_enabled/msix_enabled, which is non-atomic and they may race
>> each other as they share the same memory region. A race condition
>> is met between driver bind vs FLR through sysfs:
>>
>> for driver bind side in thread 1:
>> ...
>> device_lock()
>> ...
>>   ->probe()
>>     pci_alloc_irq_vectors_affinity()
>>       __pci_enable_msi_range()
>>         msi_capability_init()
>>           dev->msi_enabled=1 <---set here
>>     request_irq(pci_irq_vector(),...)
>>
>> when echo 1 > reset in thread 2:
>> pci_reset_function()
>>   pci_dev_lock()
>>     pci_cfg_access_lock()
>>       dev->block_cfg_access=1 <---may overwrite msi_enabled bit
>>     device_lock()
>>
>> The msi_enabled bit may be overwritten to 0 and will trigger the WARN
>> assert in pci_irq_vector(). A similar issue has been addressed in
>> commit 44bda4b7d26e ("PCI: Fix is_added/is_busmaster race
>> condition").
>>
>> Move the block_cfg_access to the pci_dev->priv_flags and use atomic
>> bit operations to avoid the race condition.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Looks like you dropped this... since commit c9a81f9ed6a ("PCI: Avoid
> pci_dev_lock() AB/BA deadlock with sriov_numvfs_store()") we now take
> the device lock *before* pci_cfg_access_lock(), so the second thread of
> your race description above can no longer happen, right?

yes you're right. now dev->block_cfg_access is protected by device_lock() and will not race with
thread 1, as dev->block_cfg_access is also protected by device_lock().


