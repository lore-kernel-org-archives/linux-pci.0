Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7B7344D9D
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827084; cv=none; b=cb4uymQVtLEb4bXZ3PbCtduC7pJNx68xH++aE6wqjoMeSIiuVRGBRp/BwHBMJG9ITJlyijam7JwDtR9ceHwmJV/ObATD1hqmxeRpHky/ga/89wIqq0qU053UP8hB2omv2CDfUKzvD1sd+/4ozJHyIDt9ste91B5RpVXvdz4BCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827084; c=relaxed/simple;
	bh=U4PV+otM4HvmPoIAswkhykOdXBL/F+RWVIZT2ICHNqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+XJdLi0mQTHXJU2q0MX0/B6RFenJ1N+IMfZAuachikGHJsbEP63DcVBct4YwUUdKvEV25y+Z1e8YzaaGK59l5SzxOKY2okXjN0f96v2kNxEEpCIuMP9PRpZZ/kU1ebCiCsFPI8qIgBb6kJkf9Khhz+JwcQoXFsFM7lnRi/+QSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B+CCtyzT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B+CCtyzT"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso5328735e9.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1784827080; x=1785431880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3uCiBfCgYJ/GJUlVW3+aq71LQppa6fxRulw7M0zeMU=;
        b=B+CCtyzTOR0BMz8CAz/MErXqUKjN4UXdTIzsGgkyMe1iwcNG8/A1Kx8kD6nnVi9sp2
         xQ9Jiz8aI6TS5wH1xU1IRYZAOpxFPeyCplxUAbN3t6Zd0DPeswYAsc7Yue6y6qhh5Wch
         ELzoYetSu/ykpev4cw+hLgo1/javk1CBj5vFaCkSm2stfxOvpCwdJNjy0ZmOqFoDHiEi
         Yqj/4yJxTy5Pq6EyNwWP8WneRx+52vAma6ZbXvNAdWRzZ79dTX/uG5nRZ45IiSldoVS5
         O5SsfRQuHFWlRkBqeSypqNEgqS2qK79ZA+Lh4mlJu5YVKvOhvErT+G6Q8jvn+HMuO4pL
         AfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827080; x=1785431880;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3uCiBfCgYJ/GJUlVW3+aq71LQppa6fxRulw7M0zeMU=;
        b=IgYsjrmpnVLZnnNXZRheNr1hGYD2e2e+EGyHpo4fe0DNCGuhT4vTt9bgBzsxQFOwK1
         8zBRgCyfDQZ3aBlO5D9jhjNzf+8vpK6emQDyJpDesCBMeUVXA+zkz+9VGE2P5WQPv1ac
         fBS1GCqnSTa5DH83bZYHilJ95PJB3HSzLeZH2wFlVVIBPt3tyUiFxKVwVC8Vl1EB5WmI
         Zp3ZBT+oZtOLFfDqRGs0TETAV7g+qU9sn+6aM6QWMCfQCLBgMdKdZWtQ+Q3tKdTmfgot
         shZQgDZVzL/dUlccG6XmOAuPcTRhfuDlyBEkroyb7hJFBcLYWrrDYTGW+tDLE/tUVzuf
         C+Qw==
X-Gm-Message-State: AOJu0YxIRRK/9UZc7+JnFlgve9ZlZ0Ab8BvQefKFx60zRubkFkVbWyqX
	AGIGCQvakxF0opKJWnEylu607OT4QK7cBZb37anqKL3F6dJrfXiSF/PurYfC9uRdNBo=
X-Gm-Gg: AR+sD121FMgc8+cek8zGH1Xb+z2/ZJDIyAFB5Ud2VZxESn+jTjEtSCIhMz93KKrxLQU
	rVj0pxIuBaQP2zh/oPz50U/VBlWBRoaj4aCyBBfYGuwBiGYXLbCVFh/wpXOgvJ5mjtbR3/lu9d0
	VlhvBmTUofOMqjt41rrAsG9RNMkJeGDatBO+nyEPdj6yttc8o03rEendBdEiaEOHjeC3kixSe0H
	iKBlZh2CFxPe5XngzsALjTsJL0gsFDWznZuBIja+RDDt2MrmVfJtpmZF0TW4b54mTFm/V+ooZKr
	iyBTXMHOIVSntb/saBhVZxdlcmB6H0uaojuRjizMY/2SquitFkA0KgCZvgIuTd+3HbTFstZwXuh
	+9y2OiVANs2ohX7wophNZ+Z43Qv3XRmUVra0VUj25lcNHwE2YA5ZRLnrnGQJShScZz/QKwa/CQB
	fZpL6YKktx/pemkr4FpavuzBI+Yt0+bhVMCZA5bFbnM/WwrIk1UEejN+5aMw==
X-Received: by 2002:a05:600c:55d0:b0:493:b811:e549 with SMTP id 5b1f17b1804b1-49573cff4d8mr34111725e9.29.1784827080510;
        Thu, 23 Jul 2026 10:18:00 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7700:4510:8c44:3b9e:61ae? ([2a02:2f04:6302:7700:4510:8c44:3b9e:61ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c53052sm16870489f8f.18.2026.07.23.10.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 10:17:59 -0700 (PDT)
Message-ID: <2869cdfe-0233-476e-805e-b026746b1eed@tuxon.dev>
Date: Thu, 23 Jul 2026 20:17:57 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: rzg3s: Propagate platform_get_irq_byname()
 errors
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
 <20260715223019.3002237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260715223019.3002237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/16/26 01:30, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> platform_get_irq_byname() may return specific error codes such as
> -EPROBE_DEFER, but rzg3s_pcie_init_irqdomain() replaces all failures
> with -EINVAL.
> 
> This breaks probe deferral by preventing the driver core from retrying
> probe once the interrupt provider becomes available.
> 
> Propagate the original error code instead.
> 
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
