Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF633D4FF
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408025; cv=none; b=AbuYq1dStg1C7JpWDlf01LbKJsbRioZsHt3YQKKOfCBibgLILbijY99bI47TZtatC4vEAdfR8YTTbCEzH1dGFvhh8ce9ba+li5zy7AlUj0hN02W1h9yyPlPzoZM666em33qkuT1s1GlTDofBkOtZrKXlcXvLe+GYuxQmLmt8UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408025; c=relaxed/simple;
	bh=ZyrO2BTUvvC0XGd70mrGogYUc7XQ4XFmboQrARHmUCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLOO1jy7qORJZHYkmaBtTPFIu6g7bKavhoFMSQxDGMqMYlFKb6+8n/UqPpmzfkaynRoMZn2aPq9DCzNZ/MzvW+BzDBMeDOQcT/shH6UvqvCuqk8zspYUS6z2aZJdsX+DkARCNj+Hcz7NnWpfqnTOx7tBpL12YJk9lzFACgA6aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hF0pr6ji; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hF0pr6ji"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48371bb515eso58601685e9.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 01:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1771408021; x=1772012821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/iyPc1B0BPSkZP0CkpRNAjkwIO7YfmnXVuQxXaZEPfc=;
        b=hF0pr6jiId7BdBML2N7RUk12zSTJ2+bZdjrYHWDSXIJpZSDv/EEKhEpH9cy7D/ZUff
         iVXMpFFfNTJAc2/h7/H37fl5cMP8rC5VOWZTHwe7p1dVKxgtQ+9/u2RZTJKZvldHy5/W
         ScywWZZ0i5CK0KqDk5vBRX9XP5N3MNwgEJ6ALcsLVMw/c7iA7Y+dszvXMEsTgJxilweL
         RzfcvG2VdJcwJJAsAlvfUpjPrQRNAQO9h2UWx+3uwsBlM2B1tPisPsdhQFQiLmWDv7Ja
         XrY3XFGPQlOt3KNUW4Hkjkjf7ZTZWAHEx/RZe8zbtmrX4NDmhM2+G7j0+cvS8uYRY2/c
         4xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408021; x=1772012821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iyPc1B0BPSkZP0CkpRNAjkwIO7YfmnXVuQxXaZEPfc=;
        b=LxBBvND+MGejKoUFgtAj2IrfMudBfbc0z+532ERsnnoOFHTdcQZxRRx9opRIiUMWLy
         O0oZmOlnJsy+f0p8lyxKxdPi7KBf7KBk/pEd1eAwnCajyMR1n/jrZaCNGdPDUd/coToi
         /JFWVoSKJM9he2uMYhg4ENIBGeoEVwUnzuRPfqg8YPyEiqtHghGAteGxoRH9UGzErI8S
         kIxik2FS6zxORET1l/amkPJEYNDcB3OVti0x0K1LMzhKt7UDm4npkgCQDsKUzdCC4M9c
         PvCGEo/eu2rh70uVq0AXFLB8GMV10jFVadI1t4RpOuxLCHTT2H4G8W+hc3zuU4zy9QQw
         jDiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9eCfRQGW3VIFoEn1e2ckXhjQL9VAs8K64dTNXRwsxTU3MsNGcq4Cly3TtaSu5eZhZZkKQhVmMYJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PMLA6oVdplhgv3XakzlyYKNDyaGoyHzbsTqbNW2IuyRGmRYt
	gXkaR6Fwo7hG0U+/2e41UbVnHB6NY3VH6qalc9w43n1uZwB84uWG6qIv0kshqmV3ctc=
X-Gm-Gg: AZuq6aJ6Jg7eDex8e//klYHrBuEF+AUI1KeFHqUsumM0hMNLQqII+53zIZpT8AA0rVU
	qs1Czcx4RZfFP2mlEs0gJr+KUWB+BxVp2IqAqPrbx+dB+AwJh04IGKUKK6C3UHlGm2dLHROD8Bp
	ogMncOxc9jB1ZK3UUYfCOU1DsvKYhveCF6eKcPZyI+AuCtsWjvI2+cFOvcWZmc2HJbBq4oPF3nD
	qoVDZWjcUheSH82fHFOrTIUTXg2SplDNzRbb4WuskB9cEZLi2gXjRunnIc6zbLHSlE1znu550jz
	Re+PIHnHlnSiggJpPU84+iiuj7WhW5mTo2LaAIVMCEDO2dn341vL0eqN4heKTJq5EKD7g7/fnw6
	PAyDcrChspSEjrqtaB5yiEqtZihnN0Q8mMryCYVve1mdCwPPzgq29eyi/WzFjQk8EUXlYQlISL1
	VB8akT1J0k5ENocEK8Kke4KPraBUmCIg==
X-Received: by 2002:a05:600d:13:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-4839b4c7242mr7100315e9.5.1771408020940;
        Wed, 18 Feb 2026 01:47:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839712336fsm15853195e9.2.2026.02.18.01.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:47:00 -0800 (PST)
Message-ID: <b9287c3e-8850-440d-bb08-aa3af6a6f353@tuxon.dev>
Date: Wed, 18 Feb 2026 11:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] PCI: rzg3s-host: Explicitly set class code for
 RZ/G3E compatibility
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260210113041.138430-1-john.madieu.xa@bp.renesas.com>
 <20260210113041.138430-12-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260210113041.138430-12-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/26 13:30, John Madieu wrote:
> Program the class code register explicitly during PCIe configuration
> initialization. RZ/G3E requires this register to be set, while RZ/G3S
> has these values as hardware defaults.
> 
> This configuration is harmless for RZ/G3S where these match the hardware
> defaults, and necessary for RZ/G3E to properly identify the device as a
> PCI bridge.
> 
> Signed-off-by: John Madieu<john.madieu.xa@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
