Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8C30F54A
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781321; cv=none; b=AGwQlK9S/1799fwMpYIcvYylmUVv7/p4MmdYsq3agkZEF6xcvkqaiiMpWjnz15VdFCT052cmNhUx5OMxWZiWAecWuk0+qmf7k8F+NhTkypbds7XCzumDJB/yCJVNpiPKkfr/yuTR1ZVPeZmK5KRxnMtsZakHoOHA5bJbb1J9erk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781321; c=relaxed/simple;
	bh=C9BDDyHTAxvvlBSkzUj3MdBMQ9OfMDISBhPe/MWkWxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6BM4S8F5pvMO3km/xYVi1biIcTLOzcuDtpMe1UUo3FvSCXGheneNrZ4ZaEjHqSOjYwFfoCkkvYpyaRtqFPUEwRkW9CfcGp/U4+iynyGfMycBbGvh3NL8X0oD2YtBJreGwHI0mQ6Rdc8adJx1UKryvYnKjEEh4DwkMLJ4EvKW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TOm78JgU; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TOm78JgU"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-432d2c96215so1952204f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 05:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769781319; x=1770386119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1Le8LCyLcGQuvZ7tGgECGPbUrm2rSjnSYYZfcbP/cQ=;
        b=TOm78JgU1E3f/w5li/ysvA5/fGI0TGwsv8zw7aKdxRebMpCuNLsbzjP1AQGrSJIo5l
         cc+s3iImV57rIazU8r6cFmWaeXVrQVdWnv/EC8yJYALS2v6qeO7tIjCsu/Y1+CExw+yX
         Fy+/0WpHpq5H0eMyZrFCmyyAAOoaUDRBHBqMZ2xBvHbQvslETgiFCrIrdX3gVCIqYw4j
         /F7yOC07usXS5FMtp6BedJvS04xkBkdxO7gocv/apoBkXRsvh8c+quL1lA46WgfHYcfg
         K5MG9IpGS9ILZYzKsWwrzxxIOt8Df2tKSD/P12ksxZt06vv0nhgHAMnADwtoYWdyn2hs
         iv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781319; x=1770386119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1Le8LCyLcGQuvZ7tGgECGPbUrm2rSjnSYYZfcbP/cQ=;
        b=EL5cZCEL/jzLyUghkGv6ZCy31V/vp0cMJV4X7lgp171JOIGcNYujgvkwTpmhYeBZ2t
         CpDA4DgXVNMROIHXWaJzx8ZA43EVTFbXRZ/sHw6HDk6+3CCZg0pR+XeMj7XigdkulISV
         /4W3zA3s4uWKtRaz+7BHxMKsYCjRh3FxnsHdXWGSDFByFKm31YHBQ47MKq2fznxt/1OY
         7csIrjCirknV2/j1TjuqBNi8ZJuFWBScNleB4Bl6VHTiJwcMfqx2XOS4aZQh9Y9UuM5T
         0/JvPl5dHYklkKj4saI+q/UOM46DeBW3Yrk7OJziAIysvTNFaFRaJlffkAO2pLBfg1Z+
         NdFA==
X-Forwarded-Encrypted: i=1; AJvYcCVboTw4/RgT1pmC3WILpC1O3vSON9JmfXBMB6/qI41OZgWX2NSk0wX3nirV6cK9JNVzZsXriAy3Lds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3FkONIUWRFVUKqdoo1BEO+1A5i9uI9MPzTMbseOdeKk4x6T4
	vonOx2GPoCXR2ZW3KxkdTkPxXOLSR8RnIo6KRIuBwJ9MZbKrPdA+UVVQFt0ulQv14lI=
X-Gm-Gg: AZuq6aKIYuIsk4IMdm0G4R8CjPu3EXp+l3v9WvELDcuHGQwlY2FcM4/DpUy8ARQXNn3
	QXzFq9G9kZ9JW6d7h52bSTbTEo89Tt0ZXvokK8TPJECv/m8LfIOhOYXAk2qKOSQadH3BFxanNon
	r33CCRVzwQhRLHk1621lAErqmpdKCyveczAt/j2UlFZ9ZfkM027oH903ctcyKbpRwZ9/qxC2swl
	Lxt84NrDdu2hB5mp0LQZRy2WW9g6AfoI4J+WCQkLquOtfQ0hPgAKNLPCo41M9JpP23V0w+kDc9b
	HGyxHF+I9QFeY+RDjIKFMHnyNMjerou2PE4u0gLpKdaL8GC9jM+bCZfuJlWpbYESGS1fcmrYSil
	g8OAJwk5TzIPgwuefseoWmjIgc6kIP/MFlHRpUShQBiVT86A87E1hb8Zl/rUFFq9o405LrKgZy2
	aJVEtk35b4/v+NQESvEp1q8Ul0rR+B
X-Received: by 2002:a05:6000:40c9:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-435f3aaf7d9mr4567020f8f.47.1769781318602;
        Fri, 30 Jan 2026 05:55:18 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e46cesm22505217f8f.7.2026.01.30.05.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:55:17 -0800 (PST)
Message-ID: <e53b50e2-72dc-47c3-be52-cefa593dd30a@tuxon.dev>
Date: Fri, 30 Jan 2026 15:55:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] PCI: rzg3s-host: Explicitly set class code for
 RZ/G3E compatibility
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-11-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260129214130.16067-11-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/29/26 23:41, John Madieu wrote:
> Program the class code register explicitly during PCIe configuration
> initialization. RZ/G3E requires this register to be set, while RZ/G3S
> has these values as hardware defaults.
> 
> This configuration is harmless for RZ/G3S where these match the hardware
> defaults, and necessary for RZ/G3E to properly identify the device as a
> PCI bridge.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v4: No changes
> v3: No changes
> v2: No changes
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 15ccd9095a3e..76f6d940ba45 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1054,6 +1054,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
>   static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>   {
>   	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
> +	u32 mask = GENMASK(31, 8);
>   	struct resource_entry *ft;
>   	struct resource *bus;
>   	u8 subordinate_bus;
> @@ -1077,6 +1078,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>   	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
>   	writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
>   
> +	/*
> +	 * Explicitly program class code. RZ/G3E requires this configuration.
> +	 * Harmless for RZ/G3S where this matches the hardware default.
> +	 */
> +	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
> +			       FIELD_PREP(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));

According to kernel test robot report on v1 this throws a compilation warning:

https://lore.kernel.org/all/202601152104.pV9uMS76-lkp@intel.com/

> +
>   	/* Disable access control to the CFGU */
>   	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
>   

