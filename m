Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023010;
	b=a89ig6BJFUh7a/XdyrWL9XAC+a9A3EnN7qxJvPLXEXWd6mk880IzUdpcWkVhNzwwQK3d
	 cAAHAgqFPTcqlibOul27Kc3tNtodOJLTBPPdtihjAd0+BCqc7Hn7PUUy4CKiIKsA4vlVT
	 I58WNjUizlIbZEvuEvVIVa1PfjuUKLE/+LJ7fKtZfNZ2RxLpo+6Qc1/V6WYQCVoO4JEqW
	 rgRmBSq8kE3+pIxNxhum8bHU0+NsbWNwYsi8D5rWqSeOq3JI1LP9ughlS0yr7KJeoqyJb
	 lL1WbRuXhAPhZAUo2T8LH0NfLYRhHxpwuDjjOkv5fSFWXckL5M7YCZKaxd8UqKl9QTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=2GkOj5GONDON7Vlx9Y8BowP7/PlsCg9Zwi4Dy0PdP9M=;
	b=HXTOU1tyVYeDZbfaTRf/Z2xULCWBvTB0kUbb4XBJV17qr0qs7w2VscA/E1mJHyoAK8mQ
	 ImRAeRYWRT57P/d9/SXq47CYxVJR8Ao1OPSYAASBpsUydNE3D/ZooBeI0Oq41u97mhKt/
	 3HFCCHERbPpvLXRhxeOrnyNSe0NajMWdR9F13cWjDPzlSPYKBbyeHFCh7JldlaSbOUVRH
	 9LnZKSwlr5VG0hQ67xeeTSEEnU1QCoh6BwU59krdaFhRlxr0s4xZX/u7pZPVWxET2iAP3
	 8LQRMYCHuzp6xyyEIi+oKSqenQJX15mWmE0UyNCsomxqVRJFA+UOxbfiS8E0kuwEg6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imd-tec.com;
	spf=pass smtp.mailfrom=imd-tec.com;
	dkim=pass header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256 header.s=google header.b=Ln5oe8Ma;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9195606A31B
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 13:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9195606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256 header.s=google header.b=Ln5oe8Ma
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso19497455e9.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 06:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imd-tec.com; s=google; t=1793023005; x=1793627805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2GkOj5GONDON7Vlx9Y8BowP7/PlsCg9Zwi4Dy0PdP9M=;
        b=Ln5oe8MaVAIjRmSq+wS00CVQ0mE1zqk5Kl+HHNONwDL/+8h/N5zNyGLfdcBr9VfTym
         zsVI77jFWr/+LiFXD7hBj4+cXEPBQwgQ7BILMy3J1oydU7K1KmnmVbxHV42r7+rNQfd7
         jlHin+ajvQynYAG6PITI6nOoRT1ADZ3xiZnNOJSIczjOXTq1gTKfU2j5y+W3NShNBRfO
         WfKYz17ryVFcboPYo4LDBJb9ggsMT2JdueG+zAUkQk5FXgSy36vcyiNCdbpZFA4QmGuz
         8QkB/xbnDgBQhHiynp25EAouSFD89mNme5SBvP5OIpvLMmK6ybn7KxcUexTJfA34VbNw
         5k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793023005; x=1793627805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2GkOj5GONDON7Vlx9Y8BowP7/PlsCg9Zwi4Dy0PdP9M=;
        b=Ww7auDT5Tm7am/h6MqOC0H24uWI6qUL31SISYqjTAAgPv68vYm7vBP4OrRIXxG46o5
         G8W1400jaHpwD9yn93EzqYXNlXIysByVNW0mNCLtsoXpkOeMqhI/URpaNLVVJ8/+hmvU
         /glAUqxnDFPxWXiVL4RgNzhUo1AY4kL7YycuH7TyNkGwdynH2paDRzr+lqV4aJdGaYbG
         NIjoMrlWmJi6cWi51UTEQdqQNNub9n1nEIHb8LcLKwt3JbxE+cK9EUJfLEVVMC7GlSXQ
         CpzgHI+M8Koog4klpJUBj0KKHZXMaL/vuBxTR0F/Ln445YN7iIvEnJhupuljcswt2CIj
         2xFg==
X-Forwarded-Encrypted: i=1; AKwUvByjTRnuNUO2hwBuDTvEX88Gd3l55dzay6ZwMO+ugOtrv2kMw+yQG1qPvdL7VZ98oJdtmn5OHJ13aWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqi5oNrmJVWctBofuz2ViMgQW75H0M93HJxUVu0WRbpatTg5Tx
	yloU51TkVttEdJ8Gm9yeZUzFPZ3AM6A8QdPVJg53xOFwAclk2PlvIEUzdbAuh9TQf6Y=
X-Gm-Gg: AYBFou1yqebN4fsrl3awmqWjMMiBgO/kFMZs+3shZwcQZawPUXm4+OzPS10c39Yg4ie
	KgF5nRjAQdJ47Jx+oIv1cBwnn9KVgtR+dA18BSX8NOi62wPQAn3BvWIkj75G2wYTGge2SH1gye5
	riHQF6q/b4Cmlx3ex+gsKqofnILnb4Q13eNrNtj6Cu3MqbDgdIiqLYJIvKcnkhr9pznCRGMV4if
	7iMTzZyKHKSADXEvfqJi/hOPOWppVCYl2MvsbS52Dbr1fu0peTwhsp7fej29McWv0uJB2FleIhp
	FDIJAjmmeaZp6V5AMfJESfqPnOwTgGidCvK9MZ3HFp4z3NvTgvjDRxn0ZKmHG6DRySlJVWr0vfj
	Bi2HZxFjwk/fmOpEk2U/S/kLmmCsnHFEaH2JcwWDDrsfsidgdLAukr+xMIWibJuEg8RUwTmQ9jM
	BfCmFl4eguGfdsCOvTs5JUmHDNqeQ3lSrV6dgcZfLyr+JZxd393Aypwd2jXfeqYJrLkiREnIXNh
	/TVbGw4w+RMYROGXZPpQXytQ7aWLA5vTIvc6EpoXoHhakDm4+PrRSFLTY1BDp1IjeXf9iIhg3z0
	KsYEyEbFpvry9AqQEYuCuS3zhTdbcLv6x5KjXkPDMNKeNXZ+YuvPIFbCd3Mqkw5VAIA2kqgS2eH
	VjovALNOEZo+ABzySQ/HJkLk=
X-Received: by 2002:a05:600c:8b66:b0:4a2:a8c:22b0 with SMTP id 5b1f17b1804b1-4a35ac3b3d9mr120893705e9.1.1793023005302;
        Mon, 26 Oct 2026 06:56:45 -0700 (PDT)
Received: from will-Legion-Slim-5-16APH8 ([82.71.135.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a0e2sm245169285e9.13.2026.10.26.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:56:44 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:56:43 +0000
From: William Bright <william.bright@imd-tec.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Drive the Key E SDIO_RESET#
 signal
Message-ID: <at9cGzb2p4VB8EfW@will-Legion-Slim-5-16APH8>
References: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
 <at9KREB4Fyf-Jl5S@debian>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <at9KREB4Fyf-Jl5S@debian>

On Mon, Oct 26, 2026 at 06:16:38PM +0530, Manivannan Sadhasivam wrote:
> 
> Do we have SDIO pwrseq consumer driver in mainline?
> 
> 

No. MMC still uses its own mmc-pwrseq framework.

> You should not add GPIO control to the pwrseq_pcie_m2_vregs_{enable/disable}()
> callbacks. You should create a new 'sdio-enable' and populate
> pwrseq_unit_data->enable/disable callbacks for the SDIO_RESET# control.

An sdio-enable unit wouldn't ever be called until MMC gains a consumer.
Should I add the unit anyway, or drop this patch until an SDIO user
exists? Maybe I should switch to working on this first? But it looks to
be quite a big task.

> Please take a look at the 'pcie-enable' unit and W_DISABLE1/2# GPIO control.
> 
> But before that, you should explain how the SDIO consumer driver is making use
> of pwrseq.
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்k

Regards

Will
