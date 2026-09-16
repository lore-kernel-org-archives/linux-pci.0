Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6F35DA41
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535416; cv=none; b=akZybB0fjnBcU/NMlaq+qNmBpY99Y2NFtQEXcN7VRmLGbw/UnbUQ6rXG2R16JE839y5IWkPZv9+rkd+9ZJA+ibiisdZ9Zd+5L/rMTgZgmIziagiOtg0AnTgexLrp/QkINqw/j4N3RRp2sLA698jIWYXpqc/BgGdrLvK1zKMFCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535416; c=relaxed/simple;
	bh=qluvmwuV83emM/3nJsE43LICI3P8DdmTIbeH+hWLj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NF8JVCPH2PawtiJMiYcGmBACfIkbm6WwTmNyhR+RgRzw/kb+ySCdOz6i3ZuBPAtxAGlX6jDZN51gBhnEAMXr31n965MHWuTy4bP6wQ+N/t7/BHEsZvHppPOHFY6/spmQRy6+nk1FcODbDpFCX2k4MCRvYL4nZWI8FJ6OAzftiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk71uPjA; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk71uPjA"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39d654f02baso413052a91.3
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 22:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789535415; x=1790140215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCSj073xDjVE5V/nmEXAKgguDBgTKgJjsaGKUYFcD28=;
        b=Lk71uPjA748GMNOBRwwx7CzDUrHhAUVte9H+V3pTb03yMvIDCdmLL4VrZrRAxA0fpk
         oMMFvav4mhFoot/vwf4CJLVc215JirItwK3F4V89Lau1epmam9E4AM5NWESVvUStv2ut
         Yd4+xeiZsGYdRXAJam3CqqYpvA+ILsLZKpuzxwTWRjpM8PIA6h9WwcTCftyA6LyR8pQ0
         RvsGo6G+jIwIF7EioRJj3r+oOubY0ceNZtZSoulifdtIvAmPQ41GYo34p6wHhGuCjIT7
         HYLhl6cmK1vwd4bGiQ2mC7H8UeLfJ+U8dzsWEYrChJcudLlGvEXzfiQQhXKHR+TL8zyt
         VDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535415; x=1790140215;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCSj073xDjVE5V/nmEXAKgguDBgTKgJjsaGKUYFcD28=;
        b=arcsHr6Z9+8hvNxGUQIeRFPBA42jH5k/2/UzUPbcfiZ5E4zNs9hzVQKQqhObbW9Zyg
         zm4KRU7oJlpscptJX18QCak/2zbQM9emyWCKoXsFuSkPsT6O2VkgegBG/N/8U4SElqpr
         K+TOhx/SaD6zWWL14nvwG5VQxpRJhf6pLawHKDH9GAvNeYAAs1o9YSRYXDq5SNH7zCAA
         itS7bkbX7GxxXO996QK2mf9BeZm6G60dCMxqMKXA88lrLdtr2QMrwOK15BFBtnHsX51Q
         JEJA29s/hv06F3wkGJGb/rtI/EFJ32YxkeZAl71P+UKYGSRrlVr6JnnmUWQtsFfTNpNM
         hFug==
X-Forwarded-Encrypted: i=1; AKwUvBz8Wbsq24MYzfXZxPeHsVqXWS9u7vr+SbNvQ5NOKZPrYin+VSR+EgW2qmldzVieJSTstsSEQtuRFG4=@vger.kernel.org
X-Gm-Message-State: AFuF++kXOcBI86o8cWq4Of2KL6BAdOtdOQjutapjZycbympnpHE+9z/Y
	iXDOSVMDy0KiSAiUK4KUEyMpko+G02Wetx41AkDKU1ayrBM3gkwt85x/
X-Gm-Gg: AYBFou2VG7TEGsyHo7Fo2ageDTWHDbqPM3VcJBB89RCiK/bD1gPIEVAjywyscd3Lpvu
	VH6eAaykDWbQLFYvEoYH9TsmgvppQ7GvS04fCbNgpAyzVspRVOFQ/C6oNCyx26hF1OPTDhQ/kdh
	jWzDHQeTgix2WEnGyG2Kc2FJD+4G5OvSlPUywZX+WOpZtnpDOUQWOrayGN21VXZYiP3yGYbs5FO
	ip6SRABkXyMSd3ezTYyV5QGARvHlDkS4b6z0zQUte8BE8X1CKboTGsFe/mBd54ox4s5B9vtSB4y
	1sKUi3Uq1soSij9bqn4znSqArarh6sRQHXTT7/q4WMQ0kp9rQh5MDWNunB5CPHlZ8c/s00laTSx
	ItVOG9QdIlo29KGAVCPlvmwFZRqdwrnW2DuaxINOuwuUBpSL9bzbAj/Oqx1jgjJL58qQLwcDs0O
	SMRD99hv9bbHqPMzGRPGsjFzWr9QHJT5Y2EaVizKo/Ak7zeTTwTUuoZsKuD97WOOBxmfUenvhtR
	ecPRVSkmTxqFqOx5g==
X-Received: by 2002:a17:90b:1f84:b0:39d:f064:3a76 with SMTP id 98e67ed59e1d1-39e1e45e49amr3002570a91.15.1789535414426;
        Tue, 15 Sep 2026 22:10:14 -0700 (PDT)
Received: from kernel ([45.251.35.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ac978esm3932878eec.18.2026.09.15.22.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:10:13 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:40:07 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, yinghai@kernel.org
Subject: Re: [PATCH] PCI: probe: Fix 64-bit limit truncation in prefetchable
 window
Message-ID: <aqokrxTEO1BVAyK7@kernel>
References: <20260814164652.43501-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814164652.43501-1-raizudeen.kerneldev@gmail.com>

On Fri, Aug 14, 2026 at 10:16:52PM +0530, Mohamad Raizudeen wrote:
> In pci_read_bridge_mmio_pref(), the code checks if the 64 bit base
> address is truncated on 32 bit pci_bus_addr_t. However, it misses this
> same check for the limit address.
> 
> If firmware sets a window that starts below 4GB but ends above 4GB, the
> base check passes. But the 64 bit limit is silently cut down to 32 bits
> and wraps around to zero. This makes the base larger than the limit,
> causing the kernel to silently disable the memory window instead of
> printing an error.
> 
> Fix this by checking if the limit was truncated, just like the base.
> Also, update the error message to print both the base and limit
> addresses to make debugging easier.
> 
> Fixes: 7fc986d8a9727 ("PCI: Support 64-bit bridge windows if we have 64-bit dma_addr_t")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
>  drivers/pci/probe.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..0cf2d1d35146 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -479,9 +479,10 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>  	base = (pci_bus_addr_t) base64;
>  	limit = (pci_bus_addr_t) limit64;
>  
> -	if (base != base64) {
> -		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010llx)\n",
> -			(unsigned long long) base64);
> +	if (base != base64 || limit != limit64) {
> +		pci_err(dev, "can't handle bridge window above 4GB (bus address %#010llx-%#010llx)\n",
> +			(unsigned long long) base64,
> +			(unsigned long long) limit64);
>  		return;
>  	}
>  
> -- 
> 2.53.0
>
Hi Bjorn,

Just following up on this patch. Please let me know if you have any
feedback or if further changes are needed.

Thanks,
Mohamad Raizudeen

