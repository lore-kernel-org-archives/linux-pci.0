Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4B30B517
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781282; cv=none; b=pW/3PXmUqTc/olSKNgJqMWWYhydjZQfb56L4Cqt5KGowUI/oQa6gWPaGCw+Hoy2LiJWP9Kqck9w12TS54Tbet9Hoyj24X6zJkGdIuvqD4E+Rs89p6Bs5Tie+6sj7AndVpdxK/nrQu8BUFfJqVPDiADr642VH6Uy7+28y/jBp02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781282; c=relaxed/simple;
	bh=/46oDN82LjogzmORyHLOarRQ21fOzhCRXiwBNpC4pgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQOeJeOP4GSohy0qHDeCNwNp3vlpfkgXYArVlu/nF/8hprwksjE9J2Aqbczz6gaFa5dt3jhgbdaS5b+H8oYK3fzml66BaST2FwjtK1IsM94/BI+NcdpVtdaBm3HQbvFLXDEuPDkhMYAV1leevm5ADvpZ1zUfQdoQlDmZF3pXwIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l67TSPRg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l67TSPRg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so17190795e9.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769781278; x=1770386078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2fnMBaIl3iqJIAy71Kiwyskd4MUnQ9YmeCSljhkZAw=;
        b=l67TSPRgA9OweFGD6z2maoe0ltMhaURwDY+hLfIyS/8/zfoOdumGFpZDrXzfNoFHlc
         bZRpxL95X30rTYcTyzgT2gm+FTnbM1nGV7Kpj+DbmP0ZNXia+qVAhtxsxGQIcPXuuAX9
         PmDrk3mKu4qqW0DGLH8sYQeXbhsCD9RhLj7DgQ0n3HKN8UJhRB9fdeN+Q9/mTG/2qMED
         yKkGuPT96QTj+n1EEAIgwPqfV1RXECUpSpC3PRUgkU3YYUS2zcWhI4FqRuPamiiEldRD
         P/+ekRFzeKhETYoDSS6SqHQ2AmFevXwlajZ1WOxRSg3+Xfh+C9Ny1CLBEAwY3LPuP8cU
         jkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769781278; x=1770386078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2fnMBaIl3iqJIAy71Kiwyskd4MUnQ9YmeCSljhkZAw=;
        b=tvBNyXfD04qQxyExUt6X2YyEu9xa2IFSLWbpIM2EWnI9MWNB/JXC94xFxI/pkCZM8r
         MQLF8nAOxlz24ISBYjJBvaklf048nZLU29yD8/dnDkDde/T9bIw3DGuRds7khEi9Jn2H
         +LB4v5M6EnNtC+YKErSPhRby9veHec0Y3E4zZ/DodCI9mpa7f3J9rcBz2NsOMlsU+iam
         NaBe4C5PE3BeXczsf5ZbXAgMtnOcr+/LmZmuA3NubDS/2Ww9Cl8FSebDzrYKAabk5zBn
         xqXFgDFM/MrDubPalliYSoKWDfCVGHdqpSG94C5Vnj8BwItVupTeNMxOx+dPFV7d3Hbx
         YxJw==
X-Forwarded-Encrypted: i=1; AJvYcCVGvuKJC84fKJ/wzOEQHQ85qFdSXJOkmd5cMGe290OQpmsjRgPjUQp5J9iqZl8eTPxCW+yzFdsJZwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJB/oOJK8Vrk4pMiYvsfyGHHXLwecUW4fMH0PDjeWOlOPcJ+7
	VZ1W2ivChhgJlLQmG2plRPciGYDwB7is8xhfFZk+gylarOgECoDL+rMntBwlAr3JV0Y=
X-Gm-Gg: AZuq6aK8hCGJHfOOE5gEc4//JmF3dFd/mf2dfIvabPBx3RyHn7eRyrL2wkVoSJtpHWZ
	RUerduJEG3Pkpwz2/IrDSdMWbEjrhPTs2QoVwN+jYN3MzwIBLmcHv3RRppHW87F+s2x8ZKRf8ZN
	smpUUk9QAlcFqaltXoPx2/qEk45skcrw1G2cts3pAosEQlkVwJGzC7iPdTDDa9EpTpbxa0fSQCs
	l8VbZwF6xDsOAyyjdn1M6us9R+KtcyDjYke7DFjmYDRvPjuuGoWLCBB/VEN0gZ469zuf//knw2j
	QLPiCGEow8QcRPnJlw5LNyFDcRjipFr+vBxqE5B0Fy0+vynoJYqNcp6iNtHO+L2N/7D1rKw25jP
	jhwpfNBMzPxIUJnofQnXQlcFwb90ltDBO9cOJaJDZQ9N9vNpCS4XBasUiBlCvnkqbWZJKn+Psqq
	3BNaz7a8HOxo1PrWNIig==
X-Received: by 2002:a05:6000:1a8f:b0:430:f68f:ee97 with SMTP id ffacd0b85a97d-435f3aa7800mr4427461f8f.40.1769781278225;
        Fri, 30 Jan 2026 05:54:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322eefsm23255962f8f.30.2026.01.30.05.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 05:54:37 -0800 (PST)
Message-ID: <2fb06fb9-eaf3-4911-8d3e-5d5c554e5f5d@tuxon.dev>
Date: Fri, 30 Jan 2026 15:54:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] PCI: rzg3s-host: Add SoC-specific configuration
 and initialization callbacks
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-10-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260129214130.16067-10-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/29/26 23:41, John Madieu wrote:
> Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
> to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
> reset framework with dedicated reset lines, other SoC variants like RZ/G3E
> control configuration resets through PCIe AXI registers.
> 
> As Linux reset bulk API gracefully handles optional NULL reset lines
> (num_cfg_resets = 0 for RZ/G3E), the driver continues to use the standard
> reset framework when reset lines are available, while custom callbacks
> are only invoked when provided.
> 
> This provides a balanced pattern where:
> - RZ/G3S: Uses reset framework only, no callbacks needed
> - RZ/G3E: Sets num_cfg_resets=0, provides cfg_pre_init/cfg_post_init/cfg_deinit
> - In addition to that, RZ/G3E requires explicit cfg reset and clock turned off
>    to put the PCIe IP in a known state.
> 
> Add cfg_pre_init, cfg_post_init, and cfg_deinit callbacks to support
> custom configuration mechanism in preparation to RZ/G3E PCIe support.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v4: No changes
> 
> v3: No changes
> 
> v2:
>   - Renamed callbacks as per Claudiu's comments
>   - Reworded goto labels to be consistents with callbacks
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 66 +++++++++++++++++-------
>   1 file changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index a6fb2ec4a341..15ccd9095a3e 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -223,6 +223,9 @@ struct rzg3s_pcie_host;
>   /**
>    * struct rzg3s_pcie_soc_data - SoC specific data
>    * @init_phy: PHY initialization function
> + * @config_pre_init: Optional callback for SoC-specific pre-configuration
> + * @config_post_init: Callback for SoC-specific post-configuration
> + * @config_deinit: Callback for SoC-specific de-initialization
>    * @power_resets: array with the resets that need to be de-asserted after
>    *                power-on
>    * @cfg_resets: array with the resets that need to be de-asserted after
> @@ -233,6 +236,9 @@ struct rzg3s_pcie_host;
>    */
>   struct rzg3s_pcie_soc_data {
>   	int (*init_phy)(struct rzg3s_pcie_host *host);
> +	void (*config_pre_init)(struct rzg3s_pcie_host *host);
> +	int (*config_post_init)(struct rzg3s_pcie_host *host);
> +	int (*config_deinit)(struct rzg3s_pcie_host *host);
>   	const char * const *power_resets;
>   	const char * const *cfg_resets;
>   	struct rzg3s_sysc_info sysc_info;
> @@ -1082,6 +1088,18 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
>   	return 0;
>   }
>   
> +static int rzg3s_config_post_init(struct rzg3s_pcie_host *host)
> +{
> +	return reset_control_bulk_deassert(host->data->num_cfg_resets,
> +					   host->cfg_resets);
> +}
> +
> +static int rzg3s_config_deinit(struct rzg3s_pcie_host *host)
> +{
> +	return reset_control_bulk_assert(host->data->num_cfg_resets,
> +					 host->cfg_resets);
> +}
> +
>   static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
>   {
>   	/*
> @@ -1229,20 +1247,24 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   	u32 val;
>   	int ret;
>   
> +	/* SoC-specific pre-configuration */
> +	if (host->data->config_pre_init)
> +		host->data->config_pre_init(host);
> +
>   	/* Initialize the PCIe related registers */
>   	ret = rzg3s_pcie_config_init(host);
>   	if (ret)
> -		return ret;
> +		goto config_deinit;
>   
>   	ret = rzg3s_pcie_host_init_port(host);
>   	if (ret)
> -		return ret;
> +		goto config_deinit;
>   
>   	/* Initialize the interrupts */
>   	rzg3s_pcie_irq_init(host);
>   
> -	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
> -					  host->cfg_resets);
> +	/* SoC-specific post-configuration */
> +	ret = host->data->config_post_init(host);
>   	if (ret)
>   		goto disable_port_refclk;

This will have to jump to the config_deinit_and_reclk label (see below).

>   
> @@ -1253,19 +1275,22 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
>   				 PCIE_LINK_WAIT_MAX_RETRIES);
>   	if (ret)
> -		goto cfg_resets_deassert;
> +		goto config_deinit_post;
>   
>   	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
>   	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
>   
>   	return 0;
>   
> -cfg_resets_deassert:
> -	reset_control_bulk_assert(host->data->num_cfg_resets,
> -				  host->cfg_resets);
> +config_deinit_post:
> +	host->data->config_deinit(host);
>   disable_port_refclk:
>   	clk_disable_unprepare(host->port.refclk);
>   	return ret;
> +
> +config_deinit:
> +	host->data->config_deinit(host);

This should be like:

config_deinit_and_reclk:
	clk_disable_unprepare(host->port.refclk);
config_deinit:
	if (host->data->config_pre_init)
		host->data->config_deinit(host);

To avoid asserting CFG resets on RZ/G3S when they weren't configured.

> +	return ret;
>   }
>   
>   static void rzg3s_pcie_set_inbound_window(struct rzg3s_pcie_host *host,
> @@ -1631,7 +1656,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   
>   host_probe_teardown:
>   	rzg3s_pcie_teardown_irqdomain(host);
> -	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
> +	host->data->config_deinit(host);
>   rpm_put:
>   	pm_runtime_put_sync(dev);
>   rpm_disable:
> @@ -1666,32 +1691,31 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   
>   	clk_disable_unprepare(port->refclk);
>   
> -	ret = reset_control_bulk_assert(data->num_power_resets,
> -					host->power_resets);
> +	/* SoC-specific de-initialization */
> +	ret = data->config_deinit(host);
>   	if (ret)
> -		goto refclk_restore;
> +		goto config_reinit;

Shouldn't this jump to clk_prepare_enable(port->refclk) ?

Also, you've changed the reset order here. Please mention it in the patch 
description or add a separate patch for that.

Thank you,
Claudiu

>   
> -	ret = reset_control_bulk_assert(data->num_cfg_resets,
> -					host->cfg_resets);
> +	ret = reset_control_bulk_assert(data->num_power_resets,
> +					host->power_resets);
>   	if (ret)
> -		goto power_resets_restore;
> +		goto config_reinit;
>   
>   	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
>   				 sysc->info->rst_rsm_b.mask,
>   				 field_prep(sysc->info->rst_rsm_b.mask, 0));
>   	if (ret)
> -		goto cfg_resets_restore;
> +		goto power_resets_restore;
>   
>   	return 0;
>   
>   	/* Restore the previous state if any error happens */
> -cfg_resets_restore:
> -	reset_control_bulk_deassert(data->num_cfg_resets,
> -				    host->cfg_resets);
>   power_resets_restore:
>   	reset_control_bulk_deassert(data->num_power_resets,
>   				    host->power_resets);
> -refclk_restore:
> +config_reinit:
> +	data->config_post_init(host);
> +

Here

>   	clk_prepare_enable(port->refclk);
>   	pm_runtime_resume_and_get(dev);
>   	return ret;
