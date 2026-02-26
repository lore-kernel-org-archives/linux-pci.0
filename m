Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69618363C63
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105084; cv=none; b=Q3nk6f7iFefKQTZYBTfuMTfL8eQoY7avBP4OwTFI3lU4NqgLWS91dMvhaacZji0E5ep1nRTgN+25RkEroq8pUboY06eVviicdQQz/JURHu25rStw3ZAfE9TbOXwUsIy/9T96B+1CE7sb8NtlyXQHk/OojnD3iDQD88Ms1iJHCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105084; c=relaxed/simple;
	bh=RKgPd/GBwQeJeiT3QoM+S4hvtbVzz7BLxXaDu5sy87Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5GBsO4HCnTRW1SU1F7t3ZHzhkqz6Lvguuxyi+ZU55UHgPOA25HIZSMhEm8pbwmZ6vfPD8cTOFyd8iO/ntXSjqXHJdwmuNeO0RkZ5wxQqPuFELl1NIGrGlF1aHE7iaEq9SgD4FHGumtMvPdzRi8HlGnYpou2AuKIljRPghGNpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CzE5ERLT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CzE5ERLT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48370174e18so4199635e9.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 03:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772105082; x=1772709882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ODkeaFlJZUdLMuXw3JdwZWoJ6IvTuZ9KgizpGtwPzs=;
        b=CzE5ERLTMmEc6DftoP6LbcsblldbUt6uAQfCSOyEY+CfE6QBFkkXjMJnfdREc75ejv
         a8q+v+qPqXEEmkL/EP9pQyn551e5UPaFeswNW9Z3hGa7L7iJuHYjJrkxoPFcxuyJOSEI
         PEs8lBQqc8p7390JmWBNh9djNhyMFLn7N2w+QyO1B69x8uVby1e5Ez0H54rsnA+Bw4hU
         H12On//9q6aav4OmsP5YH3d9GwCzfc2B3fEFQnrPx/slUqeRHFMaDGB4y2jGBeHF4dyi
         TSoPHevGPtdDm0pRp7D7y+lZs7lc4jmYJlhu3HQ6yC+gfsHqQaobvmRlQQkfOZVQLnS8
         iltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105082; x=1772709882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ODkeaFlJZUdLMuXw3JdwZWoJ6IvTuZ9KgizpGtwPzs=;
        b=Jz24/86zg63wpkJ+dmh6FV/cMjpsbuNUd2fM4zHvD47gNXRjLIvvVHhCJcxeWnXu2N
         XEd6+EW3ORWm4cHw/uFdwsBKiA3NqisJOv5o/d0cWoZeiDyN+Rxy91lAetvGWe6UA5zo
         3dX48ohkNA40mmujfoHF+zbI4OdYVzW8Q0uSw4+3dhN+l6tM0acWs8QCUAkn4XWfC5jY
         4CAzcg9lkRe0nr+VF1CQmWKNFUAWkapcG9guQss+Dr4dmGvQV1VLyuHzkl8MHaiDaXdi
         bON5imDBmNiXC8wDI0Tsz0Xvb/f2RmlLfdIPrrTxt0B7kKtxD2D2pLIWnBzvEAvNji+Z
         okpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9g1QdSOXMOW9Wqx3aDNrTu1QS7x0DQQxSGzuHKRxNjb/f3C6rPb+6alrsscP77+ubbUg9eGBZnQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1qvsxr+LRoaFdnnADz0t56GzLRTqlXEzhfpgdqBy8Ql4rcoR
	2LI8fSKf8fe4yHbX106sGM/UsJ9z1oy7n+zVSoNG6stqQ0Z/beTt72Pq7aOsp6rJ4uX0G4yUVZu
	p5PcR
X-Gm-Gg: ATEYQzzmDN+telJItKlK/EE5e3IwJtbuuwK6FQaIN37QJ3o6mEllOVM3EJFGxTgaMft
	SgE0++qPb01o45UFQrcl/Hkh24RiSbLhikrmp5GcJJIP+hQehawexro6VTdVKxc5q9y1QW/Gs03
	4fXnoXCEOBWgaXEFhkd6CF9V9OMsubaODLSze+u/O8ncc776IiOkEkbS/ON2+2twDbUnhSixjpi
	HiJ9ysJo1y9Ywjapg7vMdKPDZ6laenF7ivcsc0TyPu2arbU+Yq/rhw2quJZ3w4UtPnW7uLgBx9T
	8MzmP047IJT8PHKQ4FlYgMlUxGiTbKZe4IabjBbfpB1M5UC0CPfOyqTJCOhhTtaqTgqsvwQI8yr
	Bv2zYQVGO3t+WjHtkaiGytxipkM5wIgQtnZssfWl8uLFgvii9HlE8DFnB22Ek4LL/yNuwVlSCQz
	eoIwsgg18lDqCvvDVrDvoBCTYkieBXyw==
X-Received: by 2002:a05:600c:34c3:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-483c21bd28emr68934685e9.35.1772105081629;
        Thu, 26 Feb 2026 03:24:41 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb29715sm87738265e9.0.2026.02.26.03.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:24:41 -0800 (PST)
Message-ID: <c6230f66-3d0e-4cdd-b870-cbcdb93037fa@tuxon.dev>
Date: Thu, 26 Feb 2026 13:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/16] PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link
 speed support
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
 <20260219223542.6364-13-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260219223542.6364-13-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 2/20/26 00:35, John Madieu wrote:
> Extend the link speed configuration to support Gen3 (8.0 GT/s) in addition
> to Gen2 (5.0 GT/s). This is required for RZ/G3E PCIe host support, which is
> Gen3 capable.
> 
> Instead of relying on DT max-link-speed for configuration, read the hardware

checkpatch warning on this line:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#10:
Instead of relying on DT max-link-speed for configuration, read the hardware

Could you please adjust it?

Thank you,
Claudiu
