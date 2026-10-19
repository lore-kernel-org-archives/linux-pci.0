Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A04F3EC9
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412936; cv=none; b=dmDeHJCqT3+rrPOc9iONlp9egz758flOBeKWOrwfGynQX4jwvWaepV+qt267ISd/bTK8rJSqCwINmCcU5P2h4ItNgyyNYaEJNKCHvzw9W8zAvhfg/0DKg9BujSsDEFDKVLdy8Rv2JpsR9BDJ4NTSFn4VHWX+Q5m/TSEmnWtKVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412936; c=relaxed/simple;
	bh=wDHb7dzaQPQ2plgxG6HfV+TCBJTGWZkoD1BwHBUXyTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RelJFjyqtADyEKe5SHqUYe46442Ifk/DfT+o8OjMeebFDQ9XtZCLnbWVKoGISugmD9xfxt9DwjpsbPB3CL1G9iF13NCTKwQtqp4LUbERG8tcJf3qwjvbfe+UKoAHCqk3iT7gtxaumIcDvCF+hKC5lvQXCAp6eCDGH6yVxHi8y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pY47HI11; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pY47HI11"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2623616a12.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1792412926; x=1793017726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUCsiNFq6vP2rgFSeWx5eYQ/F2LejIwiLiOUAjRGo4Y=;
        b=pY47HI11V6PetEkI3UgclvGDYHyaI5ZMRE9LDiKW6Tolz931QxoBq0q7XaejTD6XAn
         MXJG67G+GkUv0uBEnLuE4SwsCGfFFJ1f8CphqC7e0EnXS9QheH74dzxBXkNJtFqQCw1v
         9AAkTh2t8CcK4rhuNguSACKd98GaHjl6Wmwz6IoM+RoK5qbkMV+H9ahFmHT/+8WX2X/0
         cbXQR6xrphQGi/ddcGBKja4IGM2FVQiUuPEjHF9N3TpHKI9qwSZt/6hKhCsM5Acy+wyS
         azimIaKP7X5OgE4raxKMPFNIUUOLY+Y3XSAhzojdbWo5BwQaIOibbjvQEJlGqv0liNn0
         c5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792412926; x=1793017726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JUCsiNFq6vP2rgFSeWx5eYQ/F2LejIwiLiOUAjRGo4Y=;
        b=zyOZrL/p7GuxgFlAUwwcZ/Q0hWt58MramM+wsTvj8CLQ/HjNWpJ+ZGgAeCmQdor3HP
         U4xIA92P32RLSmxyq/tqqr2GRZyw/wXK+1D8oQE7/NAjp6WM6etQWfVQ6HR58cDR1kck
         IjAYdTnSyHkxObcnNjZUFxVnW9MZ5aBp0bvONCQ4Pt8qdlqyyoXMp106pO0eRoparo2s
         /HxgZPvNw6xylACVW7xVBKfacQqFGmSWh6HUMo20WccWdXH1zjAt8d+IyAqTeM/BTTRk
         gbXZTf2h0P317pqzR9MNH9WpGLUSTHDIsSVoh5GYqmxy7A7p0dh/5O0+zvoI0PyQgD+l
         quPA==
X-Gm-Message-State: AFq9FYIsOlPigYL8XBlagAHJuqYXGosXp9PQEClpgI0rPyOMA5k0bBWd
	qMXWE25rZAjTGw/a7owl7Mj3f9H3cdjntqFzxt6/jdQmfp+SQccozysBPuSSBNGHGLIPi7N00J1
	HL5rd
X-Gm-Gg: AYBFou0lCrTGx0ORAoJv/haepuLWfINNCkHvA3SzbfcdcHiZbot8V1E0mYqctmyw/m7
	3LFFYIpI9pAGCCgHxisZa1wxTDTWE5KV75mjCGECrnJob2wvHNxRukouTb3l6srOrwQm0HC6vXl
	TlDpKy8NC7eCjiokHQiE7yc7EDCn01nAYegXvz8tGSDSZZY//jeeLfYYJTCZ3TDoEMwy1xH/utX
	gia5akX5MZIZ9+LMNLTI4NHJw0SoPWm1pPmaeF4ksyXVkJyWZ63MIyCmkJH1ZMQ+O117htl4oJU
	ioXsMZLIiasZp+jDpbUnj0Y2rbXkIpUoQHBO2ppZ+embvYDh7NX0bKmVI/SGEk91ocnZvEpxkbP
	f6PZLs0/E27PAhI43fRyYYM01RFmMZb+0ErHCKUT+YcR9Kjomsv0F8pPRAOcuixu4tbybUgIaSy
	m78XtTGnr2wQtMVab2sCENUp5UW1TmSg79ohVyXRKONOKT3v9opwtUclT6sUL/c4r2vFzMiiNOt
	02EcDo8
X-Received: by 2002:a17:907:944d:b0:c31:b89b:213b with SMTP id a640c23a62f3a-c419e231a7dmr515664166b.18.1792412925084;
        Mon, 19 Oct 2026 05:28:45 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e3284e3sm350775466b.3.2026.10.19.05.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 05:28:44 -0700 (PDT)
Message-ID: <48889e4c-04b3-4b50-b144-0d42ad2dbbc1@tuxon.dev>
Date: Mon, 19 Oct 2026 15:28:42 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rzg3s-host: Fix NVMe resume errors after s2idle
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261005110224.17160-1-ovidiu.panait.rb@renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20261005110224.17160-1-ovidiu.panait.rb@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/5/26 14:02, Ovidiu Panait wrote:
> On the Renesas RZ/V2H platform, when ASPM is enabled, resuming from s2idle
> with an NVMe SSD connected fails with:
> 
>    nvme nvme0: I/O tag 27 (001b) opcode 0x9 (Admin Cmd) QID 0 timeout, reset controller
>    nvme nvme0: Disabling device after reset failure: -19
> 
> This happens because during s2idle, when ASPM is enabled, nvme_suspend()
> does not shut the drive down. It leaves it in D0, puts it in its lowest
> NVMe power state, so that resume only has to restore the previous power
> state instead of a full reinitialization. This assumes the drive keeps
> its context over the suspend.
> 
> However, rzg3s_pcie_suspend_noirq() doesn't take this into account and
> it always powers down the controller and asserts the controller resets,
> including PERST#. That resets the drive, and the command the NVMe driver
> sends on resume never completes.
> 
> To fix this, similar to the dwc driver, use
> pci_host_common_d3cold_possible() to check if the controller should be
> powered down and keep the controller running otherwise. Do this only for
> s2idle, as deep sleep could power off the SoC and neither the power domain
> nor the driver will restore the controller clocks and resets on resume.
> 
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Signed-off-by: Ovidiu Panait<ovidiu.panait.rb@renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Tested with [1], [2], [3] on top, so:

Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[1] https://lore.kernel.org/all/20261019065025.2146539-1-claudiu.beznea@kernel.org/
[2] https://lore.kernel.org/all/20261005111157.17256-1-ovidiu.panait.rb@renesas.com/
[3] https://lore.kernel.org/all/20261019122501.2423969-1-claudiu.beznea@kernel.org/
