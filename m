Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B890B30FC11
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781441; cv=none; b=Cvz7ZQ8CDkC5naOZTYhkngnh9ERcRytLdDbVYFRl4aeGJR4RPh6xoBS9AHsOzti3eNooZK1nj2XXlI7352O2THt7SDk56MpSzgLNvhHb/ZEeKUfIzH57N3mLBjWAy672PSo4at1ktZLiHoFgVRQTMXdqEo5WgtHvoOeH6V2fUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781441; c=relaxed/simple;
	bh=gThK4VfvUxJmquQ6aK0nMyOCOhasklaBCUQtuScjdKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsPGrZA1taXZxWcznukwE5TegUlKv6eXz5wW69RXXio4fsjME6uNms4H7ViXpjXKd0qBnVzBLjCoGjN0ueUDAI2NWAedEkznSQhTlBtNBl/DftcAsCH3KziSSQShu6FjGoHtrv5L0HJf4PvRez2UVdYqimKBckZ7GEmt9uCfbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ze6CkP7y; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ze6CkP7y"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb5810d39so1595827f8f.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769781438; x=1770386238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I40+F+E9VMc3WJ65QPLjp3haObJNkLk9zIiSJXq3k0E=;
        b=Ze6CkP7yh0Itsi26DbbjcQQy/nDQzkpVcQKaBbvYlvwgmyhl5UbEOwggBSn2egPUky
         Rpf84DEBBaJ/tTRDD8xuk2E48EKYxxqSLJPlLIjHxUCG0bsQz1hdTPJGdSc5xZqR4nfH
         cxBO182jtDZBJH2I1ThQzHpVqBjYN1axFMwL3lxIPnViUbLHjv6VXfukBeGi+QHIXTkJ
         Svduv95hLQABk4lcKt62XdG4WWkWaFYhF+798+DNEPhFyUMNjGG7F0FAncojzeSgAksH
         x8N5P9zIjNNqqQ2y2SXx6Ghyrc2lV9BxN+c//IF8xHYQ6OwBZxoPWFWctugP4QCkW8XQ
         ltcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781438; x=1770386238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I40+F+E9VMc3WJ65QPLjp3haObJNkLk9zIiSJXq3k0E=;
        b=PS4J1szPkWNRVEL3/u9ex/DTq2QSf81qxyCJx0a+pNENYOLh8MRjRG3Re0aUGP4Mq+
         PfHWLLWpGQY6/+C216eFulZTbe8BsFQUYCrqB7hHvm898dRS9BiOy526/fBdRAF77pvx
         o7tFIvo7YiY66DXSax46N9LqwmYUNWPFvbgz5uhY/JL14STT1DYIuyaMqOEpo222Aonr
         DucluwTY/93xNqA8E0YXVJV8WFx+tYkbFd7iFsBOlenu6AJMhGCTTaG+/LD6fLm6h8yF
         RW5JEJB5SRbwqFVzX+2VJuoLyC4lDqmXPHvdluuDtup0i0+MobTsfymm1tbTZruqbKN7
         +thw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqu47p5inmxGxesihO0iX5lTPc7XR5zh8sbAcFB+8D4vsyZdLhjXGDGeYOYzDpxPQKraRvy52W0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz7iLGGMgEUX57HzM7BVpARBoGaBKR++k7XX2jmvT+LS+oeJP8
	0qE5p0KaW/26XIKjvcLt3UO7gQ94i4ioSGXo/n3eA9RB+LZ2YHDn0vxRyrnRqrrjnT4=
X-Gm-Gg: AZuq6aJZCF4vPpgxd2Uojsn6oTX/f4FWXt8/FEtn7DuNyBAMspRCMi59xgzit3+Re60
	oUqXH8PDH+uFibiladGC9oJUj7BJlxFO7FKePFX5CnZJ4g7tMu3D8h+DLxWaAZI/yHzeUbV5FgA
	gKemX590SnyEghw4546Y9AEKzaSNBl04RnXJYbWr7qw5SLWi3FHtkVKTeJ9Ojj4F7+EGwg8mpXZ
	+TsM4NrlMGNB+Jd0J3uQBefirebfW2FGkveRRw9rNoAOmUoiFVCB28PpKgBvKJQkfcj+tHzKmbx
	zZQYPTCtPe+fgyLHpwz9YhORCrH+lyYYxAqyi4iQUZM5/bWDLKnTlSHHN+xSgEk4T1YHl3gUo5T
	ET+1/art+HhBgbRPGluApped1nc6wbZ0HxOfBTxJVZ//8kfFcrVFSbw8y0NtkqZcKC4v2m6J+9V
	mPZcKe5P03jyVUet0j/OcIUjB4tJ5s
X-Received: by 2002:a5d:5848:0:b0:435:bdc0:48e9 with SMTP id ffacd0b85a97d-435f3ab4bdcmr4450347f8f.55.1769781438006;
        Fri, 30 Jan 2026 05:57:18 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee078sm22643822f8f.16.2026.01.30.05.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:57:17 -0800 (PST)
Message-ID: <34251dc9-5d09-43c6-b71e-a25785f6e662@tuxon.dev>
Date: Fri, 30 Jan 2026 15:57:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] PCI: rzg3s-host: Add support for RZ/G3E PCIe
 controller
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-13-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260129214130.16067-13-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/29/26 23:41, John Madieu wrote:
> Add support for the PCIe controller found in RZ/G3E SoCs to the existing
> RZ/G3S PCIe host driver. The RZ/G3E PCIe controller is similar to the
> RZ/G3S's, with the following key differences:
> 
>   - Supports PCIe Gen3 (8.0 GT/s) link speeds alongside Gen2 (5.0 GT/s)
>   - Uses a different reset control mechanism via AXI registers instead
>     of the Linux reset framework
>   - Requires specific SYSC configuration for link state control and
>     Root Complex mode selection
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v4: No changes
> v3: No changes
> 
> v2:
>   - Restructure as per Claudiu's comments
>   - Properly wrap multi-line statements
>   - Removed driver-specif code for init-off reset. This is now Document
>     from CPG driver.
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 167 ++++++++++++++++++++---
>   1 file changed, 146 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 985414076a85..240635dafe69 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -111,6 +111,16 @@
>   #define RZG3S_PCI_PERM_CFG_HWINIT_EN		BIT(2)
>   #define RZG3S_PCI_PERM_PIPE_PHY_REG_EN		BIT(1)
>   
> +/* RZ/G3E specific registers */
> +#define RZG3E_PCI_RESET				0x310
> +#define RZG3E_PCI_RESET_RST_OUT_B		BIT(6)
> +#define RZG3E_PCI_RESET_RST_PS_B		BIT(5)
> +#define RZG3E_PCI_RESET_RST_LOAD_B		BIT(4)
> +#define RZG3E_PCI_RESET_RST_CFG_B		BIT(3)
> +#define RZG3E_PCI_RESET_RST_RSM_B		BIT(2)
> +#define RZG3E_PCI_RESET_RST_GP_B		BIT(1)
> +#define RZG3E_PCI_RESET_RST_B			BIT(0)
> +
>   #define RZG3S_PCI_MSIRE(id)			(0x600 + (id) * 0x10)
>   #define RZG3S_PCI_MSIRE_ENA			BIT(0)
>   
> @@ -183,9 +193,13 @@ struct rzg3s_sysc_function {
>   /**
>    * struct rzg3s_sysc_info - RZ/G3S System Controller function info
>    * @rst_rsm_b: Reset RSM_B function descriptor
> + * @l1_allow: L1 power state management function descriptor
> + * @mode: Mode configuration function descriptor
>    */
>   struct rzg3s_sysc_info {
>   	struct rzg3s_sysc_function rst_rsm_b;
> +	struct rzg3s_sysc_function l1_allow;
> +	struct rzg3s_sysc_function mode;
>   };
>   
>   /**
> @@ -1124,6 +1138,49 @@ static int rzg3s_config_deinit(struct rzg3s_pcie_host *host)
>   					 host->cfg_resets);
>   }
>   
> +/* RZ/G3E SoC-specific config implementations */
> +static void rzg3e_pcie_config_pre_init(struct rzg3s_pcie_host *host)
> +{
> +	/*
> +	 * De-assert LOAD_B and CFG_B during configuration phase.
> +	 * These are part of the RZ/G3E reset register, not reset framework.
> +	 * Other reset bits remain asserted until config_post_init.
> +	 */
> +	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
> +			       RZG3E_PCI_RESET_RST_LOAD_B | RZG3E_PCI_RESET_RST_CFG_B,
> +			       RZG3E_PCI_RESET_RST_LOAD_B | RZG3E_PCI_RESET_RST_CFG_B);
> +}
> +
> +static int rzg3e_config_deinit(struct rzg3s_pcie_host *host)
> +{
> +	writel_relaxed(0, host->axi + RZG3E_PCI_RESET);
> +	return 0;
> +}
> +
> +static int rzg3e_config_post_init(struct rzg3s_pcie_host *host)
> +{
> +	/* De-assert PS_B, GP_B, RST_B */
> +	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
> +			       RZG3E_PCI_RESET_RST_PS_B | RZG3E_PCI_RESET_RST_GP_B |
> +			       RZG3E_PCI_RESET_RST_B,
> +			       RZG3E_PCI_RESET_RST_PS_B | RZG3E_PCI_RESET_RST_GP_B |
> +			       RZG3E_PCI_RESET_RST_B);
> +
> +	/*
> +	 * According to the RZ/G3E HW manual (Rev.1.15, Table 6.6-130
> +	 * Initialization Procedure (RC)), hardware requires >= 500us delay
> +	 * before final reset deassert.
> +	 */
> +	fsleep(500);
> +
> +	/* De-assert OUT_B and RSM_B to complete reset sequence */
> +	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
> +			       RZG3E_PCI_RESET_RST_OUT_B | RZG3E_PCI_RESET_RST_RSM_B,
> +			       RZG3E_PCI_RESET_RST_OUT_B | RZG3E_PCI_RESET_RST_RSM_B);
> +
> +	return 0;
> +}
> +
>   static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
>   {
>   	/*
> @@ -1268,6 +1325,7 @@ static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
>   
>   static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   {
> +	const struct rzg3s_sysc_info *sysc_info = host->sysc->info;
>   	u32 val;
>   	int ret;
>   
> @@ -1284,6 +1342,16 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   	if (ret)
>   		goto config_deinit;
>   
> +	/* Enable ASPM L1 transition for SoCs that use it */
> +	if (sysc_info->l1_allow.mask) {
> +		ret = regmap_update_bits(host->sysc->regmap,
> +					 sysc_info->l1_allow.offset,
> +					 sysc_info->l1_allow.mask,
> +					 field_prep(sysc_info->l1_allow.mask, 1));
> +		if (ret)
> +			goto config_deinit;
> +	}
> +
>   	/* Initialize the interrupts */
>   	rzg3s_pcie_irq_init(host);
>   
> @@ -1636,11 +1704,25 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   		goto port_refclk_put;
>   	}
>   
> -	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -				 sysc->info->rst_rsm_b.mask,
> -				 field_prep(sysc->info->rst_rsm_b.mask, 1));
> -	if (ret)
> -		goto port_refclk_put;
> +	/*
> +	 * Put controller in RC (Root Complex) mode for SoCs that
> +	 * support it. These can operate in either EP or RC mode.
> +	 */
> +	if (sysc->info->mode.mask) {
> +		ret = regmap_write(sysc->regmap, sysc->info->mode.offset,
> +				   sysc->info->mode.mask);
> +		if (ret)
> +			goto port_refclk_put;
> +	}
> +
> +	if (sysc->info->rst_rsm_b.mask) {
> +		ret = regmap_update_bits(sysc->regmap,
> +					 sysc->info->rst_rsm_b.offset,
> +					 sysc->info->rst_rsm_b.mask,
> +					 field_prep(sysc->info->rst_rsm_b.mask, 1));
> +		if (ret)
> +			goto port_refclk_put;
> +	}

sysc configuration pattern is repeated in different places. I think it could be 
replaced by something like:

static int rzg3s_sysc_config(struct sysc_info *sysc, int mode, int rsm_b)
{
	struct rzg3s_sysc_info *info = sysc->info;
	int ret;

	if (mode > 0 && info->mode.mask) {
		ret = regmap_write(sysc->regmap, info->mode.offset,
				   field_prep(info->mode.mask, mode));
		if (ret)
			return ret;
	}

	if (rsm_b > 0 && info->rst_rsm_b.mask) {
		ret = regmap_update_bits(sysc->regmap, info->rst_rsm_b.offset,
					 info->rst_rsm_b.mask,
					 field_prep(info->rst_rsm_b.mask, 1));
		if (ret)
			return ret;
	}

	// l1 allow configuration could be added as well.

	return 0;
}

And call it here like:
	ret = rzg3s_sysc_config(sysc, 1, 1);
	if (ret)
		goto port_refclk_put;


>   
>   	ret = rzg3s_pcie_resets_prepare_and_get(host);
>   	if (ret)
> @@ -1690,9 +1772,12 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	 * SYSC RST_RSM_B signal need to be asserted before turning off the
>   	 * power to the PHY.
>   	 */
> -	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -			   sysc->info->rst_rsm_b.mask,
> -			   field_prep(sysc->info->rst_rsm_b.mask, 0));
> +	if (sysc->info->rst_rsm_b.mask) {
> +		regmap_update_bits(sysc->regmap,
> +				   sysc->info->rst_rsm_b.offset,

This can fit on the previous line to save one exta line of code.

> +				   sysc->info->rst_rsm_b.mask,
> +				   field_prep(sysc->info->rst_rsm_b.mask, 0));
> +	}

And it could be replaced by, if any:
	rzg3s_sysc_config(sysc, -1, 0);

>   port_refclk_put:
>   	clk_put(host->port.refclk);
>   
> @@ -1723,11 +1808,14 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   	if (ret)
>   		goto config_reinit;
>   
> -	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -				 sysc->info->rst_rsm_b.mask,
> -				 field_prep(sysc->info->rst_rsm_b.mask, 0));
> -	if (ret)
> -		goto power_resets_restore;
> +	if (sysc->info->rst_rsm_b.mask) {
> +		ret = regmap_update_bits(sysc->regmap,
> +					 sysc->info->rst_rsm_b.offset,
> +					 sysc->info->rst_rsm_b.mask,
> +					 field_prep(sysc->info->rst_rsm_b.mask, 0));
> +		if (ret)
> +			goto power_resets_restore;
> +	}

Same here, if sysc config is done through the above proposed code:

rzg3s_sysc_config(sysc, -1, 0);

>   
>   	return 0;
>   
> @@ -1750,11 +1838,21 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>   	struct rzg3s_sysc *sysc = host->sysc;
>   	int ret;
>   
> -	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -				 sysc->info->rst_rsm_b.mask,
> -				 field_prep(sysc->info->rst_rsm_b.mask, 1));
> -	if (ret)
> -		return ret;
> +	if (sysc->info->mode.mask) {
> +		ret = regmap_write(sysc->regmap, sysc->info->mode.offset,
> +				   sysc->info->mode.mask);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (sysc->info->rst_rsm_b.mask) {
> +		ret = regmap_update_bits(sysc->regmap,
> +					 sysc->info->rst_rsm_b.offset,

Same here, this can fit on the previous line.

> +					 sysc->info->rst_rsm_b.mask,
> +					 field_prep(sysc->info->rst_rsm_b.mask, 1));
> +		if (ret)
> +			return ret;
> +	}

And this block could be replaced by:

	ret = rzg3s_sysc_config(sysc, 1, 1);

>   
>   	ret = rzg3s_pcie_power_resets_deassert(host);
>   	if (ret)
> @@ -1781,9 +1879,12 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>   	reset_control_bulk_assert(data->num_power_resets,
>   				  host->power_resets);
>   assert_rst_rsm_b:
> -	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -			   sysc->info->rst_rsm_b.mask,
> -			   field_prep(sysc->info->rst_rsm_b.mask, 0));
> +	if (sysc->info->rst_rsm_b.mask) {
> +		regmap_update_bits(sysc->regmap,
> +				   sysc->info->rst_rsm_b.offset,
> +				   sysc->info->rst_rsm_b.mask,
> +				   field_prep(sysc->info->rst_rsm_b.mask, 0));
> +	}

And this:

	rzg3s_sysc_config(sysc, -1, 0);

Thank you,
Claudiu
