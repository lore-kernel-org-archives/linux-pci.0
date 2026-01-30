Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A230B517
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781195; cv=none; b=bUk5+AHr+Ap0XadjThp2+io9U7cGOJZcGdw8HP2pilkjCS/uYi08OUtNxmnPuZ2s8bBgkWTlKDn+b6HjUzaZlKtaXBAtTCEPvLUh0gIl57HDbt+xyM6DKd0fGwaQVUcWjVBYpR4rUkLlg0kDW/ZQGmdhsLBBJSfPuPtQr4I/EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781195; c=relaxed/simple;
	bh=lwHSW4yFYrq7C7ukeFfwIsI3wJJGF+4yOoFIz+TjZ5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLEECtTJhbZPjZEAuSI2PL9oexPZCXN2D9rPAWvOYbXj/49yv1ylSHdeOFAOZQ/xbYlYQ5aV2GxXH53x74AGC9nD4YkMscD29xX+mlssqu+zBSe+8rHgweWWhZjBlmBP+lsq8KjkPZWtDxXJs1hoHz5xnkfEuSGJZkahBeQL4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j9p9aum1; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j9p9aum1"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d28870ddso1320470f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 05:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769781191; x=1770385991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNa01vI1UZD/5USaqCSEKUoS+bCUzsBbRR38Izr8E/4=;
        b=j9p9aum103ASP3lhsVEfnlwSIoGAyxtiSTo6tkByhWegAU0mxqrwxFE3d5vVTHk2vI
         4CoEWn8ekznsO9E2gt85BFVSFAPNjSKf4myuLEdPHVC4oJlv2YBIixcRFwpeH4Gt20E9
         HsazsICOEjJw68HX+GKbQeH2caRhcQyEDy8o8vdGvhKj1Zh3xq+SLg6tO2Tvq+TzbO9Z
         0bPJ4nsoFskMkaP7iWelAxix1SYRGsCtk0QU5Zf1XbEvey3OXZ98FRGCGScn25q1B4mB
         85aH4pU680PVXKpEELD1r7kFUFAvHm/cY8+zb/KkVjlGRMHLB20y0HwBhH9Z1liLsjuP
         ggYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781191; x=1770385991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNa01vI1UZD/5USaqCSEKUoS+bCUzsBbRR38Izr8E/4=;
        b=Q8gATxIwTiDWpgo6Cm6Zab8/peIxJpdTEBQoyBJ1TfyOBIIvwD1CbJvPffbj4ChNi5
         +8h1apcV1cRZKmYMiqANUNTYlKqu+FniwN8Vw3a057eeHB8+jsrj96gXA8ih8VkczX66
         NVYQJMMkgwvuRDLbDtzYXLvYPYY8ylBS9t9mcIZzl0ol+kvjjVFc8SnSbVgoPilm5GoE
         OuM2xVQmRSW7bluq3CpuZX3OkwkSIlQ3QDl3+w3NX7ZcPZAZAbvozbB/Md8kfIXG4fNF
         PMd2ZKnbuj84NMoY0b6G5mz8fJ4mUHPlJVua/vkRdTv7UB5yqhRSLUTlXhvyCDnXOeiA
         80zg==
X-Forwarded-Encrypted: i=1; AJvYcCWGr7qFN6eoNyaRmAipNm9cWMVO0VILnilblFB6a2ha5bfUkayOauAFkuvC30QwEzDSg9zPRVE5PBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeCPYgpA08YnxzNRmtUJeHU7kKc+QqwNdD7XH7NEM507dd3xN
	IF8d/oBCPvFG/6g2oGeJ4teha5PckB9wE+Wf1jRn/DmE3NF71LG7mma/+vmvlVMkVEY=
X-Gm-Gg: AZuq6aI8IsLjLgQP+I897fkBbwmleZNKAcEP/qWsgFQSl0Ut372wPxmaEgOXS0STX/b
	mOMDomOJyFyO6vOFOVdT7Q0Yu0MAGfoY4Nac37vIExUrYoGTCHo+p3rjV23iP/PXTaQUfrObIx9
	4eKXOaGFXFT16yHOZPYqjPhP9mT9jcDTtNJAP9yWaEpOSQpqub//ZMw+51KDo0C0Nr/xqWm5wom
	F9ueZrHK9GPZF1pxj+CefLkfhhlvY7WjHHYaMMoexDnpE53Y3qq/VOjcbfsbJqge0n6JzME4qhL
	BPIlj91MeYn+yU2x+RPtcn/yaTGL5Sdo/SnVqEFDteGy8Eo73lkY/dIPhEeXR4D+ylhPMrbGT9n
	Bpm7A0Foq/ZYwQ43nTiYGmUt9fbwk/ba/fHvla1zj3nJun4oIfcvwP6g/SO6KhN2xBxRI2lGd85
	kpTU0lhsbQMyxGooA39SvAgyVfSHWo
X-Received: by 2002:a05:600c:a00d:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-482db465e44mr31524145e9.14.1769781191115;
        Fri, 30 Jan 2026 05:53:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cefdsm22444151f8f.23.2026.01.30.05.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:53:10 -0800 (PST)
Message-ID: <d962357d-13bb-4ea1-8eae-e5efa1b9c965@tuxon.dev>
Date: Fri, 30 Jan 2026 15:53:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix
 naming properties
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 john.madieu@gmail.com, Conor Dooley <conor.dooley@microchip.com>
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-6-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260129214130.16067-6-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/26 23:41, John Madieu wrote:
> Fix a typo in interrupt-names: "ser_cor" should be "serr_cor" (System
> Error Correctable).
> 
> Also convert interrupt-names, clock-names, and reset-names properties
> from "description" to "const" to enable proper validation with
> dtbs_check.
> 
> Fixes: e7534e790557 ("dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC")
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Thanks for fixing this!

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
