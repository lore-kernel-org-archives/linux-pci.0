Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38433644D5
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105104; cv=none; b=frHJaNNMdq7loNDF8uEGIQeU2iLmNlxd2vQlIQEU/4zVKj8NQpAJtCIoqGwghTkx6EKo3t7Izea3lLiovGecVZuI3E9vn3UitFgKWopKgPT2Ix9Eo3t8SoNeF/2VL7zdCDu89WJmrqa4PZGuVJMbbQ6qHpFRaWrPrH56vckCb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105104; c=relaxed/simple;
	bh=qoAG85cQLkPyPVkb7i8S/gUbpDBrputYuNRJ4SQGpNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR+SoE6a23jq9vvhPjtYFj7wtE7r9NrqpNPQKe893n7WW3ysjdJjKNpvFBq1iKk8WdNU1eQ6o6jnBhF8bwkhfvETuaeo10Fmol5AtfOkm8Zfwoyj+lo3drN/pB9Cr0Kl1onOIDxY9xonqkn21uCCQ77x0MSN/pNRBgreYe4D3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=n/p1+SYd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="n/p1+SYd"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48375f1defeso5416045e9.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772105101; x=1772709901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoAG85cQLkPyPVkb7i8S/gUbpDBrputYuNRJ4SQGpNg=;
        b=n/p1+SYdFrt6YgNGhj3aaQx5Cq3pxOpub5ZM3RDpqsV7UsGO0y1u2UWb+Vv4MK4Rs0
         q+f1Do0MU0XkZYJWYL5R4b1l3Sw7d2X1yF1Oi8CVjQl0Tvs1jk/kVZ3+TiIUAQgYO429
         Sadbb+U0Pt40ORsmyJMsVzwH2Vfp++5qrqk7MHSml2TLkw2vLcc6OyBLrFVtlBUKNSc9
         KpFMqlqcXGNpGDdfAVAPe1lcCn51Rdu4doc6zVFyEIh2Ctbp+hMhUXL+cdDUX1A4PeJr
         Ye/uMlA3F/P7n1VKXKgbNG3CWfOns1M30BMnmhmYC+MdDkPlRz7PGVLxCs56eT3Naxei
         ODgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105101; x=1772709901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoAG85cQLkPyPVkb7i8S/gUbpDBrputYuNRJ4SQGpNg=;
        b=JdOowpJh0quLasdtUwE1YDt8XBQxN6DG13a89KC+HI2WLOi7MPgiw8xf9fz2TyNa/q
         3Hnbf/EhzmTVs2HSzb0J9y00pqn/ULAaNnn6xLFGDog4y46Im+p2EpRrBgLvgiFM0r/S
         PPBoGCnMmvQ9Ftq3dQKft9nFr1Tu8lpFG24mi56NLBhaeFQ66xAE9yQQ/Y9idD/QFK92
         +H5SUywJJ049kDEFPiqAwIqsA6RpariLM2U6LQ2AHEmfOdXlbmyjg20q3vMrjORfhkg8
         hVM4vWKyb2kc0vrk8Vc0R2WqgCr0/ayi3PrCoB6kesJJ49eglkZygicw0/URHbXgvEy9
         8kZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNfQX4SVbbIwhxkVBLzuKh+oe0dSu9f+YQ7eS8HpnHZTVAT6l0gLJwY29gjYdNKda+TTRObRO40fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLMdgo2pgAfaaofjK1+B+v1EHyXqCFYivieiC9Me931JXAcB/
	WAX5gsnq8Gblpt6CiEQBwbSCnOAIvOZrZg4QwIgHNAzmw+E6HIYeqdkloIN+1C/FhfE=
X-Gm-Gg: ATEYQzxP5NCfOsMLOG1vXDNA+Cu0nZECE7OLFGL1eT00C7whrfMXCKxTZaApoEMWA2i
	T97mYB5223U46JsbMIsb2nkC+Xx0ZC/RXPezktPMBEJA8XJTs7z/+Ky/PXXWFiTtVDkwo2uhtKh
	SjiFNcIQMtYMB2uT+PCsZbGO+wpUKDlchFvfoz8tQaU2HvPMCWaB/CEezDFk7zEcUdwu0e6CV8t
	rDmV7GGfa4FVdsYHjsdt20QA1i7SGFKk3Git0c06k2P6f/vkXx2cC+9SRXYZG4CLD2+4UMpLN3c
	UV7AwLh+W0+H074E/79+dPsS0PtgtE0Wh8NOdadv5PsDPYXQ2aS/DNi6dlc2Vl3BSXkoJRX6zZi
	SbL8BDHL7mXPSYw4pqBm7s6r3mk4bsuoXL3ZQQcG+NyHz9tcDqLm+jCQkWN6ixVWsXMZ8SkXe3A
	SlOFsSKegPBKjonsc7wsmGNV4euuSS0Q==
X-Received: by 2002:a05:600c:5020:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-483c3da0abdmr31292235e9.2.1772105101244;
        Thu, 26 Feb 2026 03:25:01 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfbb465bsm82044185e9.3.2026.02.26.03.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:25:00 -0800 (PST)
Message-ID: <a30132d9-6966-4ac2-82af-b1a20a2b1a12@tuxon.dev>
Date: Thu, 26 Feb 2026 13:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/16] PCI: rzg3s-host: Make configuration reset lines
 optional
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
 <20260219223542.6364-10-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260219223542.6364-10-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 2/20/26 00:35, John Madieu wrote:
> Some SoC variants such as RZ/G3E handle configuration reset control
> through PCIe AXI registers instead of dedicated reset lines. Make cfg_resets

There is checkpatch warning on this line as follows:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#7:
through PCIe AXI registers instead of dedicated reset lines. Make cfg_resets

Could you please check?

Thank you,
Claudiu
