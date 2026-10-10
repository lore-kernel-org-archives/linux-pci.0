Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028C36B920
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610384; cv=none; b=TorlMP8jI9UlIZaQRvWHm+lFHzn4TLI2C0YsZAu0zdY8sRgiySOFePXnrGc/V3cQcdnlnLM0zDF82n2GIZo5lBSCNzQLtZR6UIKwZAwZpzIKp6ero4mkK4T8549TdZ3U6deONbbK/XKSNoyysoRHGPdpOFNMMUATbwMl7sDBi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610384; c=relaxed/simple;
	bh=yeIQ8TRjgRbRQMf5UrSZlwvBG/+dQ7PyXTiJE1M0g7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeZHKbFXrf80AtnpKRHp0wilHR2obbPLJJBKgs9pOU+jTzaLxC4tfUid6qAqtwDrHAo3Mlm3HNSGOMrM2MbDb6MTHIteAsmhXsAPKoQJVejwDYyc9fV3wE7OpdPqx7EFqr8jDA8XjWRnzsp2RRFV/DGTP8EQjtA8yiIkVliddH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feg0arTH; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feg0arTH"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1020950eec.0
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791610382; x=1792215182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YaahGgbfxRXflDpE/1apDkepLaLGSdKFw9q3edQJhI=;
        b=feg0arTHZjFyHCYiFUAf31kZSEcAg3sR4n1QT6ifHg0q5dwJ+I3/AiRcW4OLlM9tQO
         psmHA6Ecd0iToAQLcoV8ZDjdiRdyKONWqHEj0eGfEUcDhE3wnAMSn//fKg46Yi6JHmVy
         UDMA4097VYPQmqhkQUx/21WkxBRm8Q176aGCm9zBDI28npyx1L3XaE8wiWz1OqGE20wk
         1U8FJ+o+T53P9nDoY/K1FQ6StC9RpkmDQG1OUBgG2u0vH5bKFsyDtRQ3KYsUHz+auJIo
         sMD94sLS3TmnBdzhIFAX8w5XFKaS+D40okKv9eD23fP0kFhtI94GbYj+jErdboY2Gtug
         X0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791610382; x=1792215182;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YaahGgbfxRXflDpE/1apDkepLaLGSdKFw9q3edQJhI=;
        b=VL1DASWTQJTEEbYyc6vnV+ms8SxUpVNqgjj7wdMP41TX+xMs+LGx/IZMTH2NoqAQSu
         b9pQhSGYEzLfq0cPS+KsjfE5nlGbL2smfRuInGsCxyuGcnaEtCumwmmW2aDCLYc78lqC
         Q8jSDXOQXM87xDLRjpTzBYzCvXgnb+VkbignEiu6Awhyb5rD0LRdFM2Rd74hySAwNEee
         F9Oiw2fjRJ1rMEv9LbwXANtNnJXZxziY/G5GQcyHK1mn/qYS/rGFv8WAZbH2RAosJdMq
         DeIMWFugOdRdS31RsiI9yGYgchHrZhDjAE2FIKLY2tI/MWw0rXRla2vieSYdqcTG+/++
         l0bg==
X-Forwarded-Encrypted: i=1; AKwUvBw0UyU69L109NUXVHqJJeYzGx22aAy72/C67EF+f2KNOTNPqY/vjySOfya1D5yZss1wovRYfQmmFGQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvkjFN4+nWIlV/8VOJ3dUAIGGqqQKeTYpHj8+O5HIxivmoJhAv
	GcGDqbO+P7repKCP7CmI9jfP9JgVnhbhaSS8bj8jkOIpTYIUEkAnFQnS
X-Gm-Gg: AYBFou3HzvM+CkfPqLwnFCMgDT/FAXp3QiZ1eZuH3VabVupB51801Ms3vo/Vsxdsj2U
	rzgQRSJF4opJfGLS53et68fLEySUW8kd6ea7ICkP3XQiduAWHBf4jvCe3AxaoBtOicCGBqdBelf
	msXHZmOXbGzO5xV42rV6X9oFoz5290MNtNvBYkH/BCozBQl5RzmDTjaDoymHN+cYKRrB3VcyvDF
	UEIm4VX07MFdgBSHZFcX4zhj6KRKapyidJcnO9TqASqg1EhbPBae1Y5hlWKu6PZ4UWICfI1TOQ1
	ga3lUGsAIuYuziNisN2a9egZaIa/7bH7oUOJL/CXUbVfYvoqNVyCNE+xA/W/O283cMNBQUZQX2J
	B03Z+4ysRvRO2crfs2IevS4drB5VfBKeKNCumi5DaN2VWDIdXH2e7MJdE6RMZ8NiLqK0FbwZJP6
	WRwHBHQsqudJOq050pOxApxREbYrer8YOO6FmkF1Hw9nNgOrUYfgzapxfZwyA0qX1SiSQGAiHzE
	D/RYxJA8Ov9tsQ=
X-Received: by 2002:a05:7300:aca5:b0:358:1f59:48c9 with SMTP id 5a478bee46e88-3581f594a27mr2495399eec.24.1791610382039;
        Fri, 09 Oct 2026 22:33:02 -0700 (PDT)
Received: from kernel ([45.251.35.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-354a52463casm8634256eec.22.2026.10.09.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 22:33:01 -0700 (PDT)
Date: Sat, 10 Oct 2026 11:02:55 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com, alex@shazbot.org
Cc: skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Message-ID: <asnOB-It_udVEw06@kernel>
References: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>

On Thu, Sep 03, 2026 at 10:16:15PM +0530, Mohamad Raizudeen wrote:
> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 = 0x18 bytes)
> 
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary. This violates the API contract.
> 
> Fix this by increasing the mapping size to include NVME_REG_CSTS. Also
> change sizeof(cfg) to sizeof(u32) to make the intent clearer.
> 
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
> Changes in v3:
> - Changed sizeof(cfg) to sizeof(u32) to decouple it from the mapping
>   size as suggested by Alex Williamson.
> - Updated the commit message to use "violates the API contract" instead
>   of "undefined behavior" to avoid overstating the risk.
> 
> Link for v1: https://lore.kernel.org/all/20260817092448.4395-1-raizudeen.kerneldev@gmail.com/T/
> Link for v2: https://lore.kernel.org/all/20260903040049.5460-1-raizudeen.kerneldev@gmail.com/T/
> 
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..06436a96db30 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
>  
> -	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	bar = pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(u32));
>  	if (!bar)
>  		return -ENOTTY;
>  
> -- 
> 2.53.0
>

Gentle ping on this patch. It received a Reviewed-by from Alex a month
ago, but I didn't see it queued or applied in the PCI tree yet. Just
wanted to check if there is anything else needed from my side, or if it
is pending for the next merge window.

Thanks,
Mohamad Raizudeen
