Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEC49C4C8
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356138; cv=none; b=p9wWTLmzXY9MbhSupgmEgUKZ/htpwXfjiIYN4xFIbBhWGhTFIDmIEyb5vkvmj2wAE+/mIrmvdIHSjw/vtGaHHB37ExtDjksJxxxu8EXKiWYSbxl7dJRM9IBM0NefvSZeJ/e4mr5z0R/NgJjPuusk9yMa2YHBr89zzbTZGP/YEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356138; c=relaxed/simple;
	bh=0PFLOfaq+6WWQHWvWbWt6REJWyhMeiHkv+gzlMFNkYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3S4RYyZ6wAlOw7PiXAzjr4rIt71TnowJq5dFb+tS+cgQZ9aP3YCAzcMEKSySEfcJzQgxnrxAtNlPWYrih8hoRSznp0Los+LFPJnrX2N5JKyj2yW7JvRSdQ/yIFmR6EJIDr0PeLxxDQqypWCPE1cNCu38xDcepwUW171mDruDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHOjaqrU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHOjaqrU"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1008917a91.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788356136; x=1788960936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udAsg3MzvsGGwXFF/k2qzXa7u9St7I6Sux5aMHxyI0M=;
        b=VHOjaqrUfVfUYlUOGirjFDu5P5KltBaBJikm4xS+fxzDj5w6GKqfM6YUKMCgNMwGc4
         YRo5iaEiMNlyS1thlyJgFuOxFte3YklIIjDL8EB5SHTHty++VTIHHGHpG7eKx7h8brQC
         J7lg5OnC9q9P5qX3vsAVkNw5oY7iJApCrT2yzAwM+pV36cyLU3AHXQFGphUQuA2zb32j
         5TRAHFwkBO3GpJCg6PHf6H+KMsUWkWgMTqIVkgldran8iRSWFbafrLXUIjVKRAV0rMHm
         hDTKjcuFHTIfUDy10Bt2/1/f34KSs+ExPzPNwXkIXG5T+lH+S8lcm75HUa7+rbhOCm/V
         ofuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788356136; x=1788960936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udAsg3MzvsGGwXFF/k2qzXa7u9St7I6Sux5aMHxyI0M=;
        b=ifRUL4BflFW9PXmeKZQ2bXQrw74GCCCROuQ6eI7pv7RaNNnQX0MyrByaOscZy/YVX5
         9vsnQtlyiPSHtLi4vbj8XSFW1O5r5SZxbcQtzeO5UHT01n1RwBd2wb1LeA1iqS/BmDTM
         IpupZmzqwT1TcimNpMWo9EmRUBR2oI/c0irocI4w7XdV0vACDQ9+u0+8x4+wh9pl4C89
         6rb7ELMKrOv+0Wrr0epuCVwy098MSmhQGKM7UByDxAiCrtIDxVazobJ96RhU1v5Kvh+d
         tqkERn6RBWRTbr9ksOkaOwARK0/jifOQcgNG0wi68wi5cOETWuUvpGzJqKHh2LTZoDjv
         j0tQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHDa1Of9cXiM+1tfu5+Ddqi7Ieqb/PFaPlNVAh/MzC69wyVGeJeli3eCQRaKnR8ymWu0WvZYEGXlE=@vger.kernel.org
X-Gm-Message-State: AFuF++noFq06zAIBR5r2NHkLN81Fgu+THrF5Uj1k9YrhauqGTpAJ6/em
	CkYsBoBIcsoTfJy8YcnQicHYGuWaf5rB9TUZacH/Su+Z2DQCkVHtcXOc
X-Gm-Gg: AYBFou1IUSfJKxHFtGpFFw8gKuMNZqixZjI2fbaARp5oekbkMpXlGqu3ZQ8AqPCCMtz
	4yxaO96REfADvr7gPRoT73+mb1ps2Ysil0UtYwExRnnkJf4czUKdhV9fhgNbOMk2uf7z5UyoG3z
	9VVc5W1yLOVDGVkbKZFGkna2pbepYLylU85+osPSKW7MWjpzD9PJnLKbkUtbMoa0zHjZvCYvTyi
	GOgSWuec6uZrsWT7iFgXSxqsqJTF1W5+gfwvjGjLpxw4zjrPzGg/Z4Tu/ne5cjnzwmu+uU1h0Eq
	ke7WHj/eR5zZOvp8dGxFxcC6+fCU7KpHcWMo3hvQmppKtPoRhOoTnv3m+zeIt19ZAmmqI3yiqlS
	nvkWfOs0XBpL8lNb7l2UV3eYruGeCCVMJ6zUNrZ7mI4ghdZTzxOAroPrTI5rI06CA0tc6JjiIhT
	8yvpcgx3eAcvxr55aTHX/Jz8JHyRSZBfkX5F8aE5SjZ7/zRhhzq4n4GVKLxGMAuipuuCZNvUgM3
	b6D6Aw=
X-Received: by 2002:a17:90b:3c04:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39aedf5571fmr8246529a91.9.1788356136413;
        Wed, 02 Sep 2026 06:35:36 -0700 (PDT)
Received: from kernel ([45.251.35.126])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07be25fesm7214644eec.29.2026.09.02.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 06:35:35 -0700 (PDT)
Date: Wed, 2 Sep 2026 19:05:29 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: robh@kernel.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Message-ID: <apgmIcFylNj4Fn_6@kernel>
References: <20260727080643.4949-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727080643.4949-1-raizudeen.kerneldev@gmail.com>

On Mon, Jul 27, 2026 at 01:36:43PM +0530, Mohamad Raizudeen wrote:
> When writing less than 4 bytes, pci_generic_config_write32() uses a
> read-modify-write sequence to protect adjacent bytes. The code comment
> states the goal is to "merge in the <size> bits we intend to write".
> 
> However the code does not mask the incoming 'val' before shifting it.
> Since the function 'pci_generic_config_write32()' accepts a 'u32', a
> caller could pass a value with extra bits set outside the intended write
> size, those extra bits will shift into the adjacent bytes and corrupt them.
> 
> Fix this my masking 'val' before the shift so only the target bytes are
> written. This makes the code do what the comment says and matches the
> read function, pci_generic_config_read32().
> 
> Fixes: 1f94a94f67e10 ("PCI: Add generic config accessors")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
>  drivers/pci/access.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63b..47b38d01694c 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -176,7 +176,7 @@ int pci_generic_config_write32(struct pci_bus *bus, unsigned int devfn,
>  
>  	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>  	tmp = readl(addr) & mask;
> -	tmp |= val << ((where & 0x3) * 8);
> +	tmp |= (val & ((1 << (size * 8)) - 1)) << ((where & 0x3) * 8);
>  	writel(tmp, addr);
>  
>  	return PCIBIOS_SUCCESSFUL;
> -- 
> 2.53.0
>

Hi Bjorn,
Gentle ping on this patch. Is there any further changes needed?

Thanks
Mohamad Raizudeen
