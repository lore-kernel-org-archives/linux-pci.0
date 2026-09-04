Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7011A2C04
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536178; cv=none; b=pcx/sZJ+mgAbSTVkQwUcu9KWUnxkeqHQQxB4oeTGIGoFpH9YdR6CtZH9QMf0gwGCOB7vL3RZX8J1UGXqU9DkZh7fXLzzkzZ2wml6LtOf3tqgLvgHw+Oq+GlSUp1/9f7QtAoYNTpbXOBT3/pIoCbc+7P34aLWoOeFqJc+YLuYq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536178; c=relaxed/simple;
	bh=kKrI3qMSFCWJeV4bwT6pExN7KhvycqA4trfwSHseajU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSBtpK4mRNN+ITh/uZDRRS+z8L+HeMlFl5J4Bq187fXHMRZo+Xa5ZtLeAm0sx8C/rAk9puafiJ9HpJXg32CwEGD9SUimah7fwBz8d+e5D9zBDjxklXLSm4xJKOJnHi5IDwYGMKlUpU29I9e/FpmL7qdZYccwZvftzzwO/85+jFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=VCSIjzxu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VCSIjzxu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so13318925e9.2
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1788536174; x=1789140974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KZFGyur2mmP2KYGddhk9G5uPJrbNoRsh9kodzw0N+Vk=;
        b=VCSIjzxuvGDo8GDLGXYnF1QrRm2XHznqHEwi48xCFvy9dvkWcGxD1iFCV6+5Jpg4Ee
         w+r9EZfizeC0dDfs+Ol8OXpHQj9W/Vw04FY8jdhsLOK3v/wwElIVwqJQ3fHg9tmb9h3C
         5HJhguRx4+jWMvwoIKRPXuW5Em2QPBmYEXOsUH5JRhE5lp51b08E/9y6TXE9HxZTsdbS
         mT3dM5KhlI3rywKsfREevD8D0NuxO4kXz4wuznCz+I/OEghOj1D+ChI/Lqq2zkTR82ok
         KpBAtCkcVEx9zZvCvPVab7mlj0w+1gh+TkGfRNWFgZKbzOl0Uln1+9SYMdLhZpH6reNT
         ot0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536174; x=1789140974;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZFGyur2mmP2KYGddhk9G5uPJrbNoRsh9kodzw0N+Vk=;
        b=AeQJ6A8kc5FnLXT+8eTdC+iZMzXvUTv6nrHgxeGlJ0Std6B5lALta7qxRS/6m794Ku
         SdxjUvrYQXJO0aVFnUpbSDKrnsjnX5PQoX2A37DgQqjw17LbD/Wv/OTsPUsal5FpZCFf
         rmPLsjRNSMhuanIlX0eVGlJonxQtpltmDhLCkL/mSz1AyK4PYRoY+CeHrdh2taKYQj6y
         H+5rIyscQXGavxl3dczPrLQrA4Zp/tIpRhpsFZo+hY7EHsXVsmzcYLnCj6MUakXlKHco
         CrEb3708q9tFLu1A5oHJrcwxNF0GX+o/IN+hX39OFC5Fptz5NT+YXIh17Hpkp1YiBJUd
         2dew==
X-Forwarded-Encrypted: i=1; AKwUvBw3R5IoQJpFRlOy/o7bE7vf2vieMxGMofTHzsmpMF56q0R1q7coM1R6f9dfgPNDC6f3xOLxZm8ZOLw=@vger.kernel.org
X-Gm-Message-State: AFuF++mnR0fPLXDg/No4tLGAuHHOk/SLYzPuAKNCR1RsdWFpzzv4gh6N
	XwVK0N9s8rfA59l197W+FlpRW7jcCSA7rJieALvIOnTt872GHQdo+SSQni87jCdZAA==
X-Gm-Gg: AYBFou0nOVKJyN4yGRW01Yv6sfLzzg81he9Bpw1d5yEL6M2g0GFE3i2NCNqL58K8j+E
	oFbl981FHwJqDxFiT7F2sZQy2Ft3zMLCXfdHOEVehPZ1KtRroH7e3QGzfpngQagNxh+PB1GtDp0
	TODYJXnlwVF0NzfUqCcBZRzi5XsZzb6QLOIt8Kx9T4fQzSMwUwM9A1pBCMG8AQfKV0JPY6NvlXT
	ZVw1w1DrpC4o7W+D5OTvbH1+fqRH/g9BFpZJrRtiSjd44wA3j+k8HEUJf9eT3VBqrk9rAMMKeba
	kD+L08pveMO27dKiWFxAV0Y7UkB7GJhRsu0XZIII7vdoSxw2N+3ASP6PJvWk7qG6uKqLKmzeuxH
	uTX0dzDAgUr90Q1rWZDCXAAvvXpI1Ee2iQHVTnAr2CZpynB7WbYt5qIrRS8TiODwxVmV+XEBedK
	/KDXy1vdMYI4vsE3NhgOA0erlkuGYSscp5E2HvVht92R4lXvurfOXv81TDreOn9CQ/xINo8AM=
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49cfc6e8e51mr42088835e9.24.1788536174321;
        Fri, 04 Sep 2026 08:36:14 -0700 (PDT)
Received: from [10.83.43.186] ([82.141.220.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7739b7asm73481455e9.13.2026.09.04.08.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:36:13 -0700 (PDT)
Message-ID: <6f916404-63b5-40a3-a429-befe42a08629@arista.com>
Date: Fri, 4 Sep 2026 16:36:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, James Sewart <jamessewart@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
 <apq3kd9_qsURNpKu@wunner.de>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <apq3kd9_qsURNpKu@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

what to you think about this check:
if ((pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta) ||  
PCI_POSSIBLE_ERROR(lnksta)) && pci_dev_is_disconnected(pdev))
     return -ENODEV;

On 9/4/26 13:20, Lukas Wunner wrote:
> On Fri, Sep 04, 2026 at 11:13:18AM +0000, Yury Murashka wrote:
>> With a nested PCIe topology with multiple layers of hotplug, a link can go
>> down near the bottom of the topology shortly before a link above it goes
>> down. In that case, pcie_wait_for_link_status() can wait for the full
>> timeout while every read of the link status register fails because the
>> device has disappeared.
>>
>> Return immediately when reading the link status fails so event processing
>> can continue.
> [...]
>> +++ b/drivers/pci/pci.c
>> @@ -4580,7 +4581,8 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
>>   
>>   	end_jiffies = jiffies + msecs_to_jiffies(PCIE_LINK_RETRAIN_TIMEOUT_MS);
>>   	do {
>> -		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>> +		if (pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta))
>> +			return -ENODEV;
>>   		if ((lnksta & lnksta_mask) == lnksta_match)
>>   			return 0;
>>   		msleep(1);
> It might be clearer if you check for pci_dev_is_disconnected() directly
> instead of relying on a PCIBIOS_DEVICE_NOT_FOUND return value which is
> generated as a side effect of the device being gone.
>
> Thanks,
>
> Lukas

