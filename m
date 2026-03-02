Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E541C0D8
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468948; cv=none; b=XIJREvnaGw4e6qj2YEjaNA/WyupQBlKM4w0JuoAabTYtW2iy0PHT4xV2tuyfW75uP8ANMFCk9WCHVqz54fHkciwjcTjT8bHMPcw2YuwPk/Pny3B1LCLr54br1e5Or/aQ50N8T8hKZ7fwKLNxvOcPb2xmfQohhaD9hQpIsKms2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468948; c=relaxed/simple;
	bh=6zebDHH0MXAjRuBUob2liKRQwdfSBVsejIj+VytuWVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsLOP38LRyohZlH2ydQEYSYYqtxLJXgL52W15eZ6TDiAE3qanmL2iY3Q1eh1NvZG4ILZeSHACxikg7GDbpkrN6BvGmtm8FB1Q+RbSPTmKsZgLoSmwwL0gtsJF6BCn0hnjmkxT2kimJla5+/xmm6j/PwsrZWbXhbSjGtEQM10zY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kNr4l72T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kNr4l72T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4833115090dso48443085e9.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 08:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772468944; x=1773073744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzuO+V2q2Kb9c67E3GUSaMIdKWjmbJeyWojduVxXxN8=;
        b=kNr4l72TlIzHpDTnHn2g5qcBw2isibg03krsRvb5hCGWMeGiPPr7JAEPqR+UGwuKqX
         5X+MXLkO62iX+qWmLYu7IDNTH/EcwaoEABIltKNNAYntkURcpel1f8paqb7Gpu1+hmN8
         X5X80c9yN8urvS0V2Ms2Ptkl6JfJIiJTtD41mR3z2dYw3eExlJ+Wtwm1IfI4Jw71ll3D
         poPU2z6LAfFTqWa6zYQcyBqVci/9qrO5sCKORYcoAgIPEgt5aCrqKXAeyZj8OVFzkPPZ
         hgJQe+C4ZVJTGequltszX7+MFU2+ZFUpM9gJRQ+RyBNFbMhuE5VwMyOAGR70SNZOFrHY
         1p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468944; x=1773073744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzuO+V2q2Kb9c67E3GUSaMIdKWjmbJeyWojduVxXxN8=;
        b=dcNt0ghbtMIPBUKPI7NlY1j0FBiv6lMwFTF6R0LK50DagtOhWDxymAtMNEx+yitkIx
         oNzJBPXTlo3reYlbCkmNGgg7XDJuIBVMy5LammBABxps71/VrIeeL5aFImFoI0uw0FGm
         0VH6T6Zgbt4dU7kjYL5vCs42MSkhnnnH5PXnejRHP6NfSO1Y2i+2yLHGYFLReBS4u+v+
         gi5KM+X4WrMSHGOTrf+DnJCNyvswxGvyQaREAs0OusaXyVZwHPMPbhsmgDCSHVz6ENu/
         57RQB19GQCvZmCTYcDFi7Otn5p0jnyBmzKG7VScS+nPZ21W2OWtN9nkEItnWGvDUgzL/
         nf4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDUwSIvRTjBPEIK908H4w/jdSfyoRKMHQabp9/57N5FaIx/VJ/u1Jf51xzWDr7mQi7TjcqE5lcuwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWhg4OOzkEPzWdUrH9kw1hBNtcqktkXMN4U8uzONpWywNCkBm
	oy5OezwJKF04QcZAGnmCFesWVVi/1aavgRLbpY0np/AummEYyjiZxirW4dn9Yv3Ug1A=
X-Gm-Gg: ATEYQzyFFkx8d4BV8U/cSoVHUJqHBLjk66IL/ew22CNVD7bCSFnROo7aB9GaAktL9CI
	46L4T+MVuOfBMAngouazVBqjNA4wvm/MTOf0qT1K5PqEU5FN3kK7zvzm5jGCML0fmB7ah3DKDql
	52/K82nFMUbZpA+vYgA+8twsx3A2WNQoK6BEHBWS9oNBk4VTfHYp9Ddns4m3OOKgLRf6gYlFkPW
	kqr2w1bmTVKTQ41W8wL6VKvJFE8/PUlKnMn8+6JggRBoXWzukFgXr4yzZGdaFRAqFx9w7YrQ7TD
	ouietgYeFotVTMKpNTLtfwsinS1P/ny42EZXUvmtIoL3DPpFntoDJdUjNvXUnZPcDZ0ZLY/2qRp
	SAuEbDwdlxRoZppCsdUD+nN5NgTOocg6Cs0Bts5yQi+U7f5QQCmntbKvQ4vMR4l7P5xN7zed0yr
	nf91g+kj+x1NSFWvrN3kyrUDpmJRNnx8IWUsMZ
X-Received: by 2002:a05:600c:1d06:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-483c9bb1e14mr220375005e9.11.1772468944495;
        Mon, 02 Mar 2026 08:29:04 -0800 (PST)
Received: from [172.19.170.194] ([213.233.104.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c35910f1sm248099125e9.2.2026.03.02.08.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 08:29:03 -0800 (PST)
Message-ID: <fccb529c-28c9-4393-bd35-921384f4307a@tuxon.dev>
Date: Mon, 2 Mar 2026 18:29:01 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/15] PCI: rzg3s-host: Make SYSC register offsets
 SoC-specific
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260227153236.55988-1-john.madieu.xa@bp.renesas.com>
 <20260227153236.55988-8-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260227153236.55988-8-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/26 17:32, John Madieu wrote:
> In preparation for adding RZ/G3E support, move the RST_RSM_B register
> offset and mask into a SoC-specific data structure. Compared with RZ/G3S,
> the RZ/G3E SYSC controls different functionalities for the PCIe controller.
> 
> Make SYSC operations conditional on the presence of register offset
> information, allowing the driver to handle SoCs that don't use the
> RST_RSM_B signal.
> 
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

As I didn't give my Rb on v6, but only mentioned LGTM, I'll give it here, for 
the record:

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thank you,
Claudiu
