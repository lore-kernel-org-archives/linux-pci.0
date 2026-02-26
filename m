Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCE372B4E
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105423; cv=none; b=XfWoNdxJnoaQqY+c6BWosXm2KytXN42KsGXZcpdS2Y/y4SRnP1dnJ+HOpT6NuqdSNbL1RrQqqoCsqI/s6JoO7SPR61RxRKncQfrbkn4D4i4O6MvMDJ/pBASBZ8okPdWRHh4zZddgh6P/iVFb2ZOu4G2jkvDZZR0kfes/P9IndCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105423; c=relaxed/simple;
	bh=gzOlBY8s8d5K60vNR7YJL060QBQtdO6FKSLNusiqquo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFkrvkuNknWf8oVfkkRU9XMYeXc2956nEL9oWMQZN0ILkklqvT94EKqbpGRrZxK4CEHa0x7H+N4tDNBrGAHHRA5Dzc7x4Z1s16/dond8rpKdYMwyf/MWp2mmfcnkFGMxK4/iI1lzfLbY9LQ+87TfZpMnmBBB+oNN4IqamIfEIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d/MbUPey; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d/MbUPey"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48372efa020so6310375e9.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 03:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772105420; x=1772710220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5blS5e/UUiqpkutZRn2hy3ZVpuHS9zAQP/d/WpTwzS8=;
        b=d/MbUPeyDFN+DfT14sNwhmtwKmxJb90sfeScVAmoZblvH+dFeVnsaXJQwxk8Eqd+rA
         gaAU2E4eTLjNSRL+TOSvqGX6cwh+pJfV8P7zppJkDr2omETr1lzw7dN/L7ddINBTB696
         RwYLO7nff1BIWbXTpQ3NT6eDnUoFnF7xBVa0oi/MrVEKQx22M/RWUXXwtegoAqN3u9OO
         DAdQldgAIEPTPlibocrE/BdFxmqhxp7OPIe7+uk601zOVXKDrQk94147pXDh60xU3LNk
         l56Lppq52AM3Bhd0C5OD7RbQiRVjARGHgyfsR7yMkhbHKt1fTS4KibdHtuLOSrmPG+lQ
         YFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105420; x=1772710220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5blS5e/UUiqpkutZRn2hy3ZVpuHS9zAQP/d/WpTwzS8=;
        b=Y2qLWyIydmR9bhc3memuWkmdnFGFy6yXCs2Iocy8gR8LpCun8Rr3elQmzygyKw4euF
         pAYM77i0KppL8C03pzOa7hl8bEDCN48Qj1Kl2NPGUJO8ME1nuTEKr13/Xbk4yeMSGlZa
         zxPGvlbakYKSzaf3B2EUD6GGhRE7eVUjIMpEmIhG3cgfsXkDr9NTLhB7y/4STANbT1pA
         S28uZDr1PWre+bj+0iR4pV/rN3DMqzvPQ+bVgDVnatxEpEZdDd4k4kjK5TagckfJ7N7U
         aAJ6WBvsG1Wn6cKEdHZ2F+GSYqBoVMKBozSJiJd26jkvZNsnjArzOYkYmq9icPO6QYmA
         O3tg==
X-Forwarded-Encrypted: i=1; AJvYcCW+aWx0b64OWEMkH9UrpqH2UyJGJGkboy1ChHr4sT8ZWELNvMsBIMSDT0z93nJM852KmAJFsKeiqDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkPC6RC8VrBLEyaJQQQaMEtDKBzOaAhXPLnQxmpCnEPH/iRCz5
	qE7AhnMkeA8e730AG8PNp1fYjS9dOFX6wEouZQrT7m8Aofonuhygs9odH9O4Q7k1+54=
X-Gm-Gg: ATEYQzwAwE90xT5B/ioZ5ydSqyz3yeIfAU+9sRcFqULhAaXh0S9dxzSji/HwSmwFnwC
	C4xFLc9hptMETWtGdMBFNktPpt+y2W2NzCYsXc8Ew9WkAe4iAHdO0L1KelDIXyUEFLBPiVpRmBC
	aYYeVejWpjY6Hk2GFTnL8S9j0fkjKkBhfVQEKqQYDXf/oRQFm2mpzC/m6FN2ZzwjkRA+2v3ZvJd
	R7eoOEG+jAFiOeRqCa+L49C57uY/hQ26iJFQFYF6Ma6JFd+wcedasR7GEmtXQkaNrnSS9mqQlWo
	GCyoI3ZY7PE+7/TJJM4K4HWJ0miFchlR3ivFI/1JkzTzsQXg35+W1SC75iyENNN/di+OeNuuyJR
	Dky8svarPqun2BVer52dwnN0BvF5IOO4Y/9S8wHlBX2Ac9etqq90e9rPKjT7fN/od8fBG+LbqP9
	ggnz8jUQ24jmlPKMOErruCcg0A7E2O4g==
X-Received: by 2002:a05:600c:628d:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-483c21a582amr59493115e9.26.1772105420441;
        Thu, 26 Feb 2026 03:30:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77abdsm34249225e9.2.2026.02.26.03.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:30:19 -0800 (PST)
Message-ID: <912673f8-fd79-4e3f-b45c-730c8629331d@tuxon.dev>
Date: Thu, 26 Feb 2026 13:30:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/16] PCI: rzg3s-host: Reorder reset assertion during
 suspend
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
 <20260219223542.6364-3-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260219223542.6364-3-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/26 00:35, John Madieu wrote:
> Reorder the reset assertion sequence during suspend from
> power_resets -> cfg_resets to cfg_resets -> power_resets.
> This change ensures the suspend sequence follows the reverse order
> of the probe/init sequence, where power_resets are deasserted first
> followed by cfg_resets.
> 
> Additionally, this ordering is required for RZ/G3E support where
> cfg resets are controlled through PCIe AXI registers (offset 0x310h).
> According to the RZ/G3E hardware manual (Rev.1.15, section 6.6.6.1.1
> "Changing the Initial Values of the Registers"), AXI register access
> requires ARESETn to be de-asserted and the clock to be supplied.
> Since ARESETn is part of power_resets, cfg_resets must be asserted
> before power_resets, otherwise the AXI registers become inaccessible.
> 
> For RZ/G3S, both reset types are CPG-controlled, so the order change
> has no functional impact.

Please drop this part as the order may impact the functionality. But with this 
fix we now follow the config order from probe, so we should be good now.

> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Signed-off-by: John Madieu<john.madieu.xa@bp.renesas.com>

With the above addressed:

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
