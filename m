Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE827467F
	for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2026 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786768597; cv=none; b=cJmqpODdPLaJZw2mfA2XE2Z3phsC76fKzzrp4PujiRx9eWUjiO/xp4BXo1OuIAGzo46sfGiZc21nAn+NYJ675NOyvuAkLggxi/iV1FMdrOhycxv/H5eYZXTpx3zx8olqk3kTcrHt+I60l4nZghUeNjLy9ZoxxkTCheLj+CXH2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786768597; c=relaxed/simple;
	bh=U3YF5gQM0fRB0EYS6wGpgz66bdBH6Bj9CyUtCO3F/uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izZ7rlVKWo+ORp8OnCwkx3z+iEtd17m7ygbBjvtUl+l/3NtoI79ALIv8CDz0xFmQ2YEoG7De3kQ0mR+PpAOqzlysnTx1mMWPZvc3DTrZYeKPtuArcgWRdj/aXQO6cQckc9UGHAKwfT4DVd/lgNq//obvrYVRW+oFTvegKC7KHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P84t1OLW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P84t1OLW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbedda4c154so993496a12.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 21:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786768595; x=1787373395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5cL+aQR6lk06dah4vjBQVvkuGrWm3DCOTDyKF+lumcE=;
        b=P84t1OLWCBkDnn6nORuJjvmNojXia++GIsi3V4CHl1FVQTGL32+tHpyLFHNNe1jyM1
         SYCYlQbnL+pElk1fNPEMm/0AWu5HOc9Ij/RD7pxO2Z4sSMU27fS5vFVbzivYoWLRF+Xu
         zyPi1w946d183P47bg7uQj82Av+M1dVGw/F4ZuhrLWyLtQvFMaBAM1DqCGqTaexPwAW7
         uT5zOgIx9KIx8VvnacpFRAkppDtivHhVB8fkI2pBxuWL895GvDimCOWe+h/N9KV7/bwa
         JH/s1Fv2fdxoBwnowxBooS3KT+4v6m8WJfgjXWThUUsT1GuJV2k7h6V3ah3gA8OrDUva
         39fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786768595; x=1787373395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cL+aQR6lk06dah4vjBQVvkuGrWm3DCOTDyKF+lumcE=;
        b=CIC9RmvnRYSmxijVxcrT06fedxedhkmEebNT3HT2Nd4kTfF1E4EPTFGy4vFL2r9BI9
         fVWjna934zQ/Xn8aqoiNhbP2CMJG1P5stSfIH4zxzxtStIMRUSPfXA1U+z3xTsr8PRVk
         fmPaWU1OiSPeOf1blcvl5IMv0VnIYinE/ChqBLZhbz5MzjPg59M+7YTkYA9friTOitmb
         T3Lhk5uwzERLUICuxiAPgLGzuc4jFRGRnPI+pb+iuztEeqz7wQ6QEQfZp0AFTCUKsXYz
         cIxuf+mmv9vobcHkwteP0GUAwQsOmvXHLCrIhdLtRvrTAfGewH/S01BW3LChJEhEik8n
         fs/A==
X-Forwarded-Encrypted: i=1; AHgh+RptI6SwMDmB4W+KJOYs8OcG3ye09aylTYOBEyuE350YJkQxkBHCONR3k9jgto0Tfrmrp4R3TZGvhTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OdzIjwyH5YQzVDe6fFVMUWJitaOyH+rMZ//UQjRIH+82KTDw
	UNmZRbiaHWAfDh4nSeNZgjDhEA1VyLJVq7Rz+HnH6iDz5glgmzXBMAfz
X-Gm-Gg: AR+sD11w/fXnBpJ4J67L337t5pN1Ok0ahXA47cUyY1ESGREnTTw9G1R2QHp9iYRMFE7
	bxL2moRF2ugzQ+lBYOA9Q8LCLFFv204pS1L+TGAAjwHBwTwulkx5F4+g/w0xkwJdLNg1+n8/vnF
	tV3NDrfl6R5gmOtYMB+d7GVa493o1uOCw/rR0Kmi5qc5iKFZCxxjJQi3IbkbTtsxi+OW3bD07am
	NdPM13wW5VuXgTU4u5fuTlOVpQgo9jcQf41LPFjkzCgj6GafLUArGIRSALWG2yi6mW5eiDH1ALT
	gBNpv0leeJGOs01WWp8C2juJ5LFPEB7MmGQHBsmlV1ogngFDwwZDes17/v8VX/dpo8gVz9/a8m/
	sRVvEgQSuLbqI+uFVkOTlBtasKKTpD6Zs9xqzpiRaXUbAk+lzNDLl0yxeWIjYzhysFaq50zL5Ly
	J3RRWpx6t5qNW2dd9H60uKTtZSd6BApp9pegWlk4lgY//yfbNC9N60wYPM7migcQuEWnCws8PvE
	oDSq5bi9Q==
X-Received: by 2002:a05:6a20:6a1e:b0:3c3:7cd0:fc27 with SMTP id adf61e73a8af0-3cc719fe4a1mr12461569637.3.1786768595448;
        Fri, 14 Aug 2026 21:36:35 -0700 (PDT)
Received: from kernel ([103.219.206.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea302649sm9930160eec.24.2026.08.14.21.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 21:36:35 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:06:29 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: robh@kernel.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Message-ID: <an_szXMhsSag-cgJ@kernel>
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

Just following up on this patch. Please let me know if you have any
feedback or if further changes are needed.

Thanks & regards,
Mohamad Raizudeen
