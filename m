Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1173B8124
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535085; cv=none; b=bScfGrl9ssusT74kIj085tLCfRQpZnEklBjpfaB8i4hgEMPEgzQLADn8CKopvd2wmUpapiRyvHybArfPk7MzLv2uApDIEJSZ3LbK9BS5KEBUJ2UA+Q4E/d5b1JqkJ5myzk2vS6NwNi5Jb1sDevf+gVbAoUZYuyWNlx/EdSmG3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535085; c=relaxed/simple;
	bh=rn/8q9InG+VhLfH0A/e3sk2fAb7dfuGR1Rw5Zadp070=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2cLL2bFixdVQIQ9lAgX1gfU3qsb1xIMsY3e/1a2IXl8PbVsr0cYy1ahBZnVa1eRhonazSkOXTamEr3+U+TN9iphx/8CyqZtFQUiuJ/Mt/qVXtHIn5NBCoTcTStEIh3m0/hrEtMoeXEJiMs/nVQ2Gf4ivkhf5tw0RYkhA0yRWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho4yOlQl; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho4yOlQl"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so533861a12.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 22:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789535083; x=1790139883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GDJS5DFeVTVtny+nVZ5eyJn66Zw4xkQyysEKwAXUmnY=;
        b=Ho4yOlQleEVK5FoQ9EAIVbIiUIWcSTzxXymBLmR9AXGlmT3dX2RTww59oDM3hkBPYo
         BMsgdORX1EjplV+XUU124ICHRK1ah7NAsuynTgXBX2zhuWOSWbowIgC9VmvkbY4RVJc/
         lqiRmgWuVuGee+YEA7BXSq49Fc8CEZWWp3LZ4rwwJrFUTifu7wTCMWSNjqAe2Xv+Wo+R
         79GUpLKJQoUXozM9e/9pH42uSKLHhASLksX7JlFnj2W0jT/rlxfi60LkfPWbjkyHup1m
         /ojJYCr63TtlYKOmy4z+Vh9re2DlYco6PphmzulIeiCqzfakvXD3tPAqBzm/33Ddc+nI
         9ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535083; x=1790139883;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDJS5DFeVTVtny+nVZ5eyJn66Zw4xkQyysEKwAXUmnY=;
        b=kqQnm+NHqM+VtHx64P6Mf++bWiWCI0tlLZ2hwYZVFEaaIibuOS5HpqYOIRie9UgTMg
         6jmJQaq9ruwUYT/it5A0lzihXu8ehIgSjIGP/5+mc/Cf1JsyYVBrTebi6/JV03JpCmeI
         RGbTt/BTlP3AENPnbTpb+3ZMBpnQmB/N1WNy25/gvQALEnmbVzDvcVoimUQMB2D6ei//
         N1UlMqvmPigtsyAqJTFN1CFSKc8HzeMvCAhTLjoQ9O7B9O/c7C/roLzILi3ooK+4e5NN
         a5oLWB5LrcKcNXJvvP6Xi0PNR6i6gHuBE86OZCr39SADBkrZrnsYtnCmIyGHNajcdJLz
         DS9w==
X-Forwarded-Encrypted: i=1; AKwUvBx1O/A8kS/pJbJAD/1WqUrOW1/k65nxSop82JiZaY3r2XWMayHdwUfTlqVPwg/no7Qfx2++ml11bqA=@vger.kernel.org
X-Gm-Message-State: AFuF++n86QjZqiQPFzoeGJ0KY6UOsbSReQGSqmhc0Tlg1NdYZye3Vsxi
	7+SZc+RJ7438YBjSCWchfO/Unm6exzkHBn1KgDAgSg59bwbmmQUdg0snNiqOE3sv
X-Gm-Gg: AYBFou3ORyRg1V/ieJ0z835bz7KXwNC3u4uGZORH8DZSwAKKFmGF/0e6ZsZO3Zvwzp6
	BXHZ1lgf812bA+G75kV7zZ6cFU0oVsmRE9k7+gS2J7P1E32LXIq73YJEFX/StC7SfvUhBMxBfWs
	afc6iKi95duGC87f5vugYnjPdxHtxlyYn0D8GN9x0jTPA/UOvB/Z6RBeARLC/uwlOMqSsz3x2NT
	MXsHCeirYVoUII7w9Iho2RfcV0IxKJTu5CrRigOA7cBIPZEhMk1hBvXoscepHjFKwWNNYC9ZpsO
	keIjcWffVBH+k04gwNUuaOIk2kV2u841NmqMq3mz+eekUjHYbd9zn59NeqMiY3eNdo2T3E5xZQ+
	M99dBWH8x6E3uOrgKJ3IWsK9A3VDxY6UeL19TOnjskUfxdbctSnMR7EHedHZYxi5tHJpHlJf5uA
	4CjTGCLMf5bhDAaGRNK/i1QvZTtlZqhX18u5iMdqAFW4b+goUY5OJeEwFoF0ntxQLhl45viSoWo
	RcJ1adyM4qNbnU6VtcF0Ziq6at5
X-Received: by 2002:a05:6a21:6da4:b0:3da:e50c:5039 with SMTP id adf61e73a8af0-3dd5f732f0emr2967834637.15.1789535083045;
        Tue, 15 Sep 2026 22:04:43 -0700 (PDT)
Received: from kernel ([45.251.35.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af6593sm3823746eec.25.2026.09.15.22.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:04:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 10:34:36 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: robh@kernel.org, gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
	jkoolstra@xs4all.nl, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix unmasked value in pci_generic_config_write32()
Message-ID: <aqojZEJDp3wHIW6e@kernel>
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

Thanks,
Mohamad Raizudeen
