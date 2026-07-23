Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82B374169
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827017; cv=none; b=Lay7t7ez3srbFKqVs+4xkcsjqWtZ6IPF8XLgtI/7r6fvaO/myAvVXm/VrP/TvQpITRbORT5HwpK3pydqiKRWPJwDHYJuTPB+7Bxwpbw0+5Ek2ZbohUkJl7ngPKvnnkrPXwHo1xyY+JV4Q1B5Ie15QhYZp9OInMvoUL5Mjk/0C7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827017; c=relaxed/simple;
	bh=87U2BF7ROJcMGMAeiwhiFsxW9By6AUV2MKfXm6mNaOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj38wM4KCht7ZH5s+VVYFG32XW2o6uqhrsyQ71n3vfRhx+bxHAdw3jMzfMbo8io15+5jngDHPIqib2Sp4xxO2pyWxeK6Y6eKv0Bf6Q5oebBcEr8HU6+pd0HCIBBAAdl1s4hVg+hfx9QQ363pDxXCOjHKDq73SabZtrCx4EOaTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=daXLjxxw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="daXLjxxw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so974171f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1784827013; x=1785431813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OC6Xay4C+LNUcYvkyvApDsvmE+T9wiOzrVP6RhbK/vU=;
        b=daXLjxxwwFhAeRGwjgfBLmkYZom89ClhHTjPum88oyNhbTPYfp5z+ezIh1Nz38vOLF
         O6PY4jea8ab2pbfGVA/3eKLMeKLv8oq9ITtGPFaP/IIIB6wiUwDX0BSGiOKfBHSz2FxG
         zXYX2Yj0j+0Ow5GRBq8lkiAYlaxkkChgBKWO9yGSCzNvffEJAh4R6kjGrHuC7wOjzRO2
         qp4mOAD+X/ZIp+KXlzwAaniNHTLO/S8xxsqicQggXED8Y+nShN4NxTqz35tnSxEkYxuf
         yr75zSNudxibqn11cW52HaXZ6lUoqJbcGVvcuLPosU76B972lir1criVgdfz0KfpGAuy
         VgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827013; x=1785431813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OC6Xay4C+LNUcYvkyvApDsvmE+T9wiOzrVP6RhbK/vU=;
        b=Uj6XNmrxPZmgZT09nnRDoBWvkb9jAfgH5dCJyfKOTRigUKN2eWKHuxwuKg6QR6zbxJ
         zuITdIYGeQVTS61Ed4rz11wFfigGVtOhKKCjduvTP4lGa2LroYw0B6inQSAN1UgN3nEj
         WWFbfSnK6kqPhNUoMI+9kMy1MkYJZKjcPxVWGNG5pnDSAsU0SEX/5hhrqPRECYDc2kWH
         OV7irONpBPCSTYI3JGRRjYi1PHfXx9Lck1ioMO6i4/holMEqso8j37EdZ9+S9sXEuJSb
         wbDYhDs1hEesdTluffvOUFCEmIJQb8RWa47e5GJwfoDFjmtCNHY9mJDo6jUVrJ+OGSdF
         +Dlg==
X-Gm-Message-State: AOJu0Ywf6jfChdJ0+d48mNGapBpTmitkFrWBDjB+ln7wj6UvMtibR220
	TLApxlsiLNn9InDLHHEdaFeU3WYgCS47T0nDZK4VODa80FCsCY/XZTn6Zva54tkmu/E=
X-Gm-Gg: AR+sD13sPzwL4aO0uV9fwueqF9v5TdY54HUi9vzAw0fRMCrsNMoVXJ6w48oOpHW+ZmA
	3tK6sZfD+Vfu5Vj0NaAvny3TlBvjeGo9s2TWM5Y0M8xfqh+8tgO6ByYfmJcLITEa9SjesQTO3O0
	KKOfvg+wge2snMhX070N6XH5G+W/8rd7fjEwm6IS3Gj27gdnaLCr2LRdEU9gJDtKj5HJ6vYfTle
	r1PU6HLZHRf7BpVF2G3lLj1kQBLdm4er2T41na2xQo/NgOI5xHEQ6b82sjVUJpM7SwB/FOUdOyQ
	pzqEgoC+x5wlrwQUCXvCmy1TD8uteA9TQ4C6Mx6oPZ9ymK86rpEsHXEh43BS+Jgj7a8P5IKlipf
	Aahgtj5HQtBKTOfsLPqzzpAj8DurVIp96m9uHkhr5eNd4ZkzmvkRD5ko5oTeanfWtbwbRn9TUbL
	4MDDP+pH9F6mDxQpBRCRSvWFED0Km9sS6G4jTJp0sMO8be88x2BmUYE/N8I8pG488n1jmz
X-Received: by 2002:a05:6000:2287:b0:47f:837a:aa1b with SMTP id ffacd0b85a97d-47f8dc8cf8bmr5028600f8f.36.1784827013320;
        Thu, 23 Jul 2026 10:16:53 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7700:4510:8c44:3b9e:61ae? ([2a02:2f04:6302:7700:4510:8c44:3b9e:61ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm16373400f8f.10.2026.07.23.10.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 10:16:52 -0700 (PDT)
Message-ID: <14727860-74c2-499e-b59c-f1bff48bb855@tuxon.dev>
Date: Thu, 23 Jul 2026 20:16:50 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: rzg3s: Disable refclk on probe failure
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/16/26 01:30, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> rzg3s_pcie_host_init_port() enables the PCIe reference clock using
> clk_prepare_enable(), but if rzg3s_pcie_probe() subsequently fails, for
> example because pci_host_probe() returns an error, the probe error path
> only releases the clock handle with clk_put().
> 
> Balance clk_prepare_enable() by calling clk_disable_unprepare() in the
> probe cleanup path before releasing the clock, ensuring the reference
> clock is properly disabled on probe failure.
> 
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
