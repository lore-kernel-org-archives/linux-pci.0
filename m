Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE930B517
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781209; cv=none; b=D1o0tZJL/ma3QAVT3WS9V5F5VKvXdRUFWsbRj1yoshTGbLwN/WCm0tpj8fSF06D/HVm+/ajtGpy8+CfShak41LMLH53fWVEKJvaGM3B+IC0+2C3KzLOIsJnbQDkGUiYqYh3bX4yUSpIlB6wNvibY6Xx07rYPPAc4hWYiyj1uejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781209; c=relaxed/simple;
	bh=zXXCIiWd1aTcZ02PDg2t9frtKz0qB1Gapb4nnXth2zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IibZGkw54CLJ2hVd2DKIJlKnTihzPEwZcVnBN239SYaPfqdg2TMhryzYooMePqYbG9N0NTZmWB16UQeyVEtverc0gtF+SIMGKcot5BlI601is+gkszPIEL+U+iRnvlD7g/AimOCf3q/gTgxXCeQPh/XeCLEFSaSlh1X8liafe9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ebWxdQAx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ebWxdQAx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so17778465e9.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769781205; x=1770386005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4o04psgLUgXFpASZX7kNJzQcWYqB5cygy+rbJIoQuwI=;
        b=ebWxdQAxmXB1uKGQ+VwDCzICNWBdd2wVb+i7lLKS5ozbaz9SW4TzE9B37zhS9yrpsj
         YzJ9UsQGtwWOYP1oTc5+h+27gxpkvYxee/2o14kjpraR44v4PV3WMIG0U7hfNg833jcS
         w+h6BGb3Eo3d2uZj05tM9wIhFPQkmgGWu/0qACZiI4kgSqbyz+JJTqhefNiZH3fDNipx
         g6veTx+wH2w+hX+K+6tyDEooi1SbSPleCTAHCCMMDRdybXkwzm7ReT0MB//WN1knEqVt
         OWmLMIixxCD/YdnEpWloZ8MNSxJgNVVUgkEIIrR9KcExcZJwU8ugk4ZDddY/l6vc/Fm5
         hRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781205; x=1770386005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o04psgLUgXFpASZX7kNJzQcWYqB5cygy+rbJIoQuwI=;
        b=WTy4teRaJ7klSahbqfu5KcSaKnnOOoU25s3lvojrJL+XK3EGbSIfEWRSuiFq9jGP+c
         ErxLmyjiPRKgWdwW4tbqJuvzZxg03z5HV4EnzKcMVtCela3UPA4ptV8W1R7KPsM5V9J6
         H7X8UUfCdhnk8+5nkcOBKWwUdDhi1Dm5PkLRVK9x/ZWv669zxGA2/VTM8yXVYI3uBVdo
         KolH5RPvk2OssJt4jb9i0zWOUVFZF19CTIjAUZzar3kPiNcttVP4PblwLj0doHY5pH5B
         2Pt+nJ3lAA8vT0O05PSmRqIfpLI/fFi7unVqtxQrZPMBnx1D866wpgfn4y6Ka2fPUJzV
         p8HA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4a0oTTVnAdXr+C0pQIH8zU+T1mfI3aJf4+YZmicU0fvldAYLhs68gu+GDg4sbodf5dlfwAW8iv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAlt973oLtFEPcxvknOOZZQ9ArLRTV9DtCq7378TAXoXxYDMr
	OIirgXgi3fyqYYfBZn+XHGGnZuAFAHrLmT2p8nfpa0eHy8PLfTAlWId16CfiDebZsf4=
X-Gm-Gg: AZuq6aJdD25AuPh62JFH+uupI92cxeCH8GG+v/1px/ZNYeRzSNuyHhC+kHj4Ou205IT
	0kVFXHRssDlwcO9pm/FVAD1HDSW3J2UEiU7EW5WJRsKYjYWnkZzaGICr6qk34FelQqrYHhDX5bU
	Fo911UpNLWOZ6zMSCLt878+1/ksoePY62l9GR6khijodGXxJTjxv9YIbU6QR9BJwH9AByvXco7w
	Cy52trZhniLooH63A3HYeFsLotbYbK/utPikA62rspSeRKDDMnfaRFGVOoL4sgNV5ytkf+40aZp
	4AFwvBTudO9nULha92Vl7tz0Ksc32NaS/0YkVaxEGeZ3FCPWipNbVFTDrbuAiHrSaVoCUrLbyRo
	E6fvp/OJ6nhKnrHlKEfDl+PkolquGWXIn4Ik9woKRSPK9XlzHd1fMHjSnpkTphQfKc6vK8w0PPG
	AksJf0vvzBIXXZRVMA7w==
X-Received: by 2002:a05:600c:3586:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-482db45237cmr39757035e9.4.1769781205391;
        Fri, 30 Jan 2026 05:53:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066beeaf9sm281652035e9.6.2026.01.30.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:53:24 -0800 (PST)
Message-ID: <377dfea9-83fd-4e76-b469-c2336118f964@tuxon.dev>
Date: Fri, 30 Jan 2026 15:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] PCI: rzg3s-host: Make SYSC register offsets
 SoC-specific
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-8-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260129214130.16067-8-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/29/26 23:41, John Madieu wrote:
> In preparation for adding RZ/G3E support, move the RST_RSM_B register
> offset and mask into a SoC-specific data structure. Compared with RZ/G3S,
> the RZ/G3E SYSC controls different functionalities for the PCIe controller.
> 
> Make SYSC operations conditional on the presence of register offset
> information, allowing the driver to handle SoCs that don't use the
> RST_RSM_B signal.
> 
> Signed-off-by: John Madieu<john.madieu.xa@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

