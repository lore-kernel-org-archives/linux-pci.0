Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9033DEC2
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407932; cv=none; b=PPS1W/tY3KsWSyoLgopSjxcoTSihKmU5hxFAqo7k2JuOhSkIeVxFtBOCMs2YyFmMavhV34XbXv3P3U/EQcMACLGBJGx4euWvs554VPDgBpHXV0EYmoc4scOGcsasjMKSXmh1Hzpjfpon3vCZgn6DNznl22ybQXJZ8qsbq3GbXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407932; c=relaxed/simple;
	bh=YCOAmjsN9kXhrTZWAk2E6nDj/ynlM1w5oRr4v/Klx9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnpQpcDRR+C/3JrG5juCOXU/4U6C6I/2SJpeNLQXQ0euSJVrzoIdNvy0Z1S2FT5pVcUK3FCEIVsyDFhX9675itpJgEPmM3v/X5opWV3c+6/VI96TYVAWJp8VVjmlC8Mvip+oAtpfBohu4qdEyBZR/D9LdS9KGNZlexhWL8bX2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kgVamzm9; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kgVamzm9"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso35559505e9.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 01:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1771407928; x=1772012728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pC1HV6hNu4TvzuNURJRScNNBHM+A82AzqED9Tu3H9rI=;
        b=kgVamzm93D4C107pIWRwEo3xrXbFkob1dh9XXrLjFd2K1n/nrOGrbqTwpzkanj/+Pn
         Q+zq7qABpEQqO1J9NOhPZDkl4JWEoA74unu+Qqc0N8ljecqOMX+Ihp6OjaVvuZGTK4fa
         tEL8gAZkEaYLsU9mLblA6XDk8zHPq277sAzkBrRYc66+54js4GebTBRt1+Zl2vnMcsxX
         x4kF6AZq4KrARUQOsK5oHNsqCuccpDQNJSilwDUtxirGhXKn0mcJKrFAC8SGrkG52BTV
         z03RlBcFilYW7gNeH4pRGQu63dEnJX2No6nz+fcH/XMy6HKp1an6gy7TRTJWKFgC7U08
         GCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771407928; x=1772012728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pC1HV6hNu4TvzuNURJRScNNBHM+A82AzqED9Tu3H9rI=;
        b=RDVtCyTFnkIrHudMskMTdwzQKqfpiUuxPBv59E3vl6B9SE1YO03kmZ4CHCWcPo4RuR
         /0x/u+5u4z/r2O7z+pc/gXoCR2255eklcplT2Qz40f1Xi0Rojq3HQ7csTpswRRoDKnvR
         rRSp/E+Ac7xXhZ3ri/9zzBvemwljYUMiv5YtIl9GnLL78nRr6B7JuewlrmfKRWh49dwr
         bc1YFNV+3OY5uRNF0gjxhXYxFq7rwXKvyQ/kcB5ywvLvVLUdaMziCJ6Xax6cS4mGcJW1
         TVGrdfzenFHr3ugeDA9Er+vKKCIibAgL2qQtJNAuZQBx8qd1kszg8CU22GINhQZG22Q+
         3UTQ==
X-Forwarded-Encrypted: i=1; AJvYcCURp9Jeu6X1cq77MQ1cMR3t9zcKeVGQ2ZZ0QXgmNwZY6E6ahpG3ba1ypTC4y6AmkW4ee4knh0N+6CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIzud5x9i/sTOevxouOZpVs7QLnAzQhp4z3yhlnAfE/wn2MzAm
	D0+Xh0kf9UC775wSWSNFvs7oER+XfW1y45zPJpn/XNP+J9vaHhzRH+y92H/CLEQdG7I=
X-Gm-Gg: AZuq6aIkLLCs5jNPQDWy0FWbUjm1ssyIo5J3RCCrIAFhRohVhFUZMwhvBF+ZKn66Y+S
	WcqosXP7dUFOVtzCo+FzGECir1gcq7mTNM0gnPtH9N/T3EkLO6HloMut09Sgd4t2mzqXhd1TBOQ
	f+W4IRSTgd70SMm+N335YlFj+GdhLagyvKr5yphDJPpq7z6j3J3Bi45+Iv/6fkQ7meOTUuNunao
	36C3X7a3yejZ+KxBo53aG4EcZIKCnSxF0gointyody3mDV2QkywV5QrNDoWZp6jKLBqtA1hEM7P
	jjdWpA+LrDeahyPI5B8zZhrvGSPAvQyim45pTjGOvbu4boCzbJ/sEwN31sg9ZO2FdjQ6Favy4HB
	txTKwDMW7X4FqAqPlfSWrFofuAh6ZmlnhK4eZNDuhXwlbVGVT+YBLD/ojtmlh0LoFiHpswbpWEz
	uOQhNZr+1AjPTNf9bhnz3P7zysqO25cw==
X-Received: by 2002:a05:600c:3110:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-48398af0206mr29610415e9.35.1771407928313;
        Wed, 18 Feb 2026 01:45:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm39808839f8f.25.2026.02.18.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:45:27 -0800 (PST)
Message-ID: <4156e321-af86-4794-98be-f64235dddab0@tuxon.dev>
Date: Wed, 18 Feb 2026 11:45:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/16] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260210113041.138430-1-john.madieu.xa@bp.renesas.com>
 <20260210113041.138430-7-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260210113041.138430-7-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/26 13:30, John Madieu wrote:
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3E (renesas,r9a09g047e57-pcie) PCIe
> controller. The RZ/G3E PCIe controller is similar to RZ/G3S but has some key
> differences:
> 
>   - Uses a different device ID
>   - Supports PCIe Gen3 (8.0 GT/s) link speeds
>   - Uses a different clock naming (clkpmu vs clkl1pm)
>   - Has a different set of interrupts, interrupt ordering, and reset signals
> 
> Add device tree bindings for renesas,r9a09g047e57-pcie compatible IPs.
> 
> Reviewed-by: Rob Herring (Arm)<robh@kernel.org>
> Signed-off-by: John Madieu<john.madieu.xa@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
