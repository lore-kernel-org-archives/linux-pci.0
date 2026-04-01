Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCC35BDAA
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775056937; cv=none; b=BLgFQK/saYRWwINqHaUveWQNItaL4hcyJU4SbJ/8UWLSAM8Z1DsqtG5NRoB98tI5gVn+fgDBHQFOF7exMVxHtg7zEL6X4/8n6J+/rb76IELoF/TAgYSlnE4ee1qSOCOA2QTcKQX5tIas5q1HRIAXeu1Abe02s3WlIOcNZ1yyukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775056937; c=relaxed/simple;
	bh=mz/6XSKEQvWVakb/B9VwWSerZa3ZCo7z3B8Ucb8XDsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EM9zv8kful4Auko6Mrthwe8kj+eOsI/WWn4dRSq4UVoQqJxMJljlkgWgcGRyi33427/lU0AC8Y+XvV7TQ/F0X9yHLNCvzwpn0wy3wGqf9lZePcBvtNlOfYwibBYklAKaecMpwzL7oqgpNr2vBOGBPuyM3dqqho52D1IkomP70HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FeJx3dzc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FeJx3dzc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486b9675d36so57756415e9.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775056933; x=1775661733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOBGuHFIMrZTBevCjGxHETGuPLUyx6fAMEiWAck+cW4=;
        b=FeJx3dzcz7qq0PDzbTPJYYEXLLVefoaIOsVhFqQMA1NUHvUYX47D2XxMviTaynX+/l
         tjfrBsVWdTGkfHahpgYQdICgBj5b1NRFmQPY2uBCOnsCdas/r0KnXuQw//ouQjRUufIx
         X4j4+efwrAD40xS4txHkAkaYrRHxJFceKD5FbMy6ipEpBZL4TNrm+Ah15qA4Bayl9Rmq
         CO76wvBk+HbNg2jQdvH6gC2V2wB/8oD5cDYkF1yHaMPYIaL4c1Mflg88ZSpb4QPK8IPo
         QyC26bKR+wMB7xDSve0NPGhEZfTt4vM7DXq5hr8Vs2acmvOEVgu6qpkDhcJSfqqcpiUM
         c5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775056933; x=1775661733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOBGuHFIMrZTBevCjGxHETGuPLUyx6fAMEiWAck+cW4=;
        b=I/vfmncVolHf7NwlnAnW6W9yojW62A6og/XIZkPWh9YI308jTE4mVZC9M7hej8DgF3
         FQnr+JXR2q9hsvpbJF4DV5tZR53FGMxxDegMmZqPuAM0l65TI+aw3LofxJEvUf18BByW
         JfQzFplpF+Ri1/HWHbHC0o0DbCOH0RS4Au3bGqPTD4jZL1DtuQUzdx/ARfb44UHW/Rf7
         tk/OiOHgPdpI+uiiP09PfNX6c5lDGJqW22Fp2hiN4omtulBa6NrwyvmLryU5ZChGSI9l
         EUrYz74mJegqwDXsJ2CmtiTFHe8PhdIuU9Sr9cOyc/fxIWKHRMfTjBw64FoTTf6X3oR5
         GRDw==
X-Forwarded-Encrypted: i=1; AJvYcCUhPpxyYCW88oFRHzgfjX9oLCwylOTvtRAq/FD/8TLoqDxuHJ3hFLugiWztawShwEyzfCUYdnrvhtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+hxflnD1EPJlfz0O6AudPgBDZsWr0kZ9BqfHpTYLExZrfvuT
	X3Xfm4VmrI6eRFjpQuvay+uYH5x9+LCoPcxXfCN+F41HWWpvWApsbKuWv9++KoehSUw=
X-Gm-Gg: ATEYQzzaYrjQavBPu1rdF7dlRs5kSY+X3XPUCUfkK+vUFxJz7++yH+GYnfpkzlok9q5
	9X8EVjG5QmBOW6C0RxN8sbjBx4/pyYvBA/TeAhb//BpqP2zu1v/oh9lApn+cJlukJIrMfhZEaAy
	1cB9useWFzamvu8c8D3Z65gINnK4lW1jb1jzH4pjzXWhGB66nYVofT8sssur4lDcQcfYaRmGPri
	458RUHhLH8XON2hu+pF/VRlS0q7pxWWlxlHUzUeuAQMEnwWvY0O1hndpq8Mn05IXGfJIQ2DP0TN
	O4kQSMEVQa3KqKB6fphVUxLe9112ySyBjg87W1PnmCPS1qoocgz6dpJoJojqfbTrnaOcmBmDCbz
	lauBqPCc56eOfHeY5eVygKx2purtu2BlTephyRBdptzphw2xFFrCXSpCoV2/juOtJ0J3TwnYjuw
	DFu95lPcW+TV32NST0pRI63q7FXVn9tYXM5GY2J/fAxA==
X-Received: by 2002:a05:600c:45d0:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-4888355ec51mr65757245e9.6.1775056932471;
        Wed, 01 Apr 2026 08:22:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c963sm5807005e9.4.2026.04.01.08.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 08:22:12 -0700 (PDT)
Message-ID: <532d1691-f5b6-4fbf-8236-8861e3853ae6@tuxon.dev>
Date: Wed, 1 Apr 2026 18:22:10 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rzg3s-host: Treat link-down as -ENODEV instead of
 error
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org
Cc: robh@kernel.org, john.madieu@gmail.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401143347.8463-1-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260401143347.8463-1-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 4/1/26 17:33, John Madieu wrote:
> rzg3s_pcie_host_init() failing to establish a PCIe link does not
> necessarily indicate a hardware or driver error; it may simply mean no
> card is inserted. Demote the message from dev_err_probe() to dev_info()
> and return -ENODEV so the driver defers gracefully rather than printing
> a spurious error.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index bfc210e696ed..03be10aa5b54 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1653,9 +1653,10 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to init IRQ domain\n");
>   
> -	ret = rzg3s_pcie_host_init(host);
> -	if (ret) {
> -		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
> +	/* Failure to get a link might just be that no cards are inserted */
> +	if (rzg3s_pcie_host_init(host)) {

However rzg3s_pcie_host_init() can return other error codes not related to a 
link being down. In that case the error will be masked.

If this link down message is necessary then maybe move it in 
rzg3s_pcie_host_init() itself or move the link up specific code outside of 
rzg3s_pcie_host_init().

Thank you,
Claudiu

> +		dev_info(dev, "PCIe link down!\n");
> +		ret = -ENODEV;
>   		goto teardown_irqdomain;
>   	}
>   

