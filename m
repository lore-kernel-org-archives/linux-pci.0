Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1E318EC8
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408009; cv=none; b=W7lhLX8HPVevq2TFrfBKCFoLLUYfO6cmEWFJMb6pukF53fmkovLTLLz5eMc2pdgyiZ138FZZAjTjxmJEVlmLt4Y12L0R6wdLJLQ1RlE0FyG7tcVf7gYQz1gJC+ba3HmgkZO1AFrW46zSGIafWiNHF4u9QbPLXVlQPTT6kWsJ91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408009; c=relaxed/simple;
	bh=UihvISNIk9+AOhaYYMFDhcd9vzZsN2SB6ysEO9pCpvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3QD4ShvNootkqCMRakQGbasY62593dLLx5cR0ArJbiotBq5lr87FcFA6zcd/TvjsyY/4BJ6JAMnVQJngtKCbe2ALTik/3PnmPsxTv4DY5uVXxIU3GM6l/1W2BV515HDsVoUSwOBYH1sS3HLweZ2Q4BRLdXwlC0/hXWCLC6lszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oTZen1MD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oTZen1MD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so46101785e9.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 01:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1771408007; x=1772012807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrnaX1knvD4GFXc1oYDQOQO8+n1c4cjNYq3Cxczmod0=;
        b=oTZen1MDAQQcvZTJnuUYikrpxj5meLZa+/QtzlCTESyt5cfGGGSgMnduc7cq4uqPx6
         geLD4qIee/6fraQUh+9ddfHew99YiJRYQKzyhXug4dUO4IRnlVGGu6vofNc4G1en1TyX
         SNg0BuCipsCOqawesEiVzuog8tj06SA/srUg9sRYUN7DqdLH2g1Gi+y+1O/CcqMTVBSS
         CHQSIdFV7yrFqm5ZGIWk53wOilzqbRYTshcxFuIVzmw17XK1JQuhGr5eiKk4jfqvaXv9
         OFU9G8RPfhwSAm0qEapqJXXGxLsTAl8bgwKhmbIizKhgWLc7pgFDMKDP0FZK7lhY+0ry
         LDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771408007; x=1772012807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrnaX1knvD4GFXc1oYDQOQO8+n1c4cjNYq3Cxczmod0=;
        b=NbRPJKqx+82uvAoh9ORr/1se02khHX00Pl9efsBYk6+qN62GICzEkJzu6wTXYU4A9Z
         A1i6sNoSsNBPCwUh8CuCB/Q1pTPjeg7s9Pf6Zw41b8PjoWVTPCY9HOUeLWWfTApArouI
         tRLMwOxWKsUxbPr2i4Y3Q8pzgptalC24Sx+YD3kGvu+bBrsQjheZbXDlTgv3tDqOgWUF
         ss+EJePmg8wNxzYSRt4sOVhwnSFtvN9EXDIV2TE+YH4dHvDZhhc2bSePhcz5EITQGv1W
         mhmkrzEVnC+GFMWD1sEVy6MDHOas3w7ocfVvKAhoeAuUUUj1y4IV2t6P8hdnUowuDQUw
         obbg==
X-Forwarded-Encrypted: i=1; AJvYcCWplOXEyuFBxGkmMah8SUE7HFPj0Bt4kKQWlzShbK7Db0CMKZj/dS5VB6tiN+x6oKp9V2IFa4oE290=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4pzx9RlWRvPJRCD7HYa1s6ZK9tIJSWa5fOsbLZEyV50BGl/s
	wYSo2Oe0y9vbPtjTi4ecVSGNgFS0JYF5T8Y4RXT6WddZV/Oaa5CWRL/Xj9fAa/xIPB0=
X-Gm-Gg: AZuq6aLIN/Z1rGg1P1W/gskH+NleGXT2JD0pAUPeCHxOt27hXd3s215LTNKwiQ3ss64
	CdvU+fV1X6trK3J2lzMBywqYjH06XY+35w7n+97J98yGomMQ4wLRY8CW5OxAIZR/qb9XB6q6T6r
	Dk2O/nWT6UWwH366aI/Nv12MmXTxlmzWw/r9otxQaXDxc6gzupo/IhLGxTAxInF/VDbKFBgJSqF
	D2ZLMRn6MbUByaSzMx7FpJtd9GOBexZ9U9FJU6/S8adL2QvSqSyFoh/uvuZokXFjyK2c9CiOoco
	I3iR5HNveDyML17KkuY7EKYzHgsDQK4vdK+G7cpIi+A4QLQXg50BD788RBSWwIbrx3lxoz1NBSg
	e0lLeyIj9+grmsDA5ciD0m31YEVtYAJtHijRV6SmtrfbunL4WZSxk6nv6hRouZmcnYj60VxO0cf
	9HeSXm2ZoPjTE6ytlV8+rs4mBSIIBSfg==
X-Received: by 2002:a05:600c:314f:b0:483:6fe1:c057 with SMTP id 5b1f17b1804b1-48373a3f3bcmr271059935e9.21.1771408006823;
        Wed, 18 Feb 2026 01:46:46 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd34sm620399235e9.7.2026.02.18.01.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:46:46 -0800 (PST)
Message-ID: <5dc39d5a-7de0-49e1-9cf9-da1bac765d0f@tuxon.dev>
Date: Wed, 18 Feb 2026 11:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/16] PCI: rzg3s-host: Add SoC-specific configuration
 and initialization callbacks
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260210113041.138430-1-john.madieu.xa@bp.renesas.com>
 <20260210113041.138430-11-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260210113041.138430-11-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 2/10/26 13:30, John Madieu wrote:
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
> v5:
>   - Roerder got labels as per Claudiu's requirements
> 
> v4: No changes
> 
> v3: No changes
> 
> v2:
>   - Renamed callbacks as per Claudiu's comments
>   - Reworded goto labels to be consistents with callbacks
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 59 +++++++++++++++++-------
>   1 file changed, 42 insertions(+), 17 deletions(-)

[ ... ]

> @@ -1662,15 +1686,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   
>   	clk_disable_unprepare(port->refclk);
>   
> -	ret = reset_control_bulk_assert(data->num_cfg_resets,
> -					host->cfg_resets);
> +	/* SoC-specific de-initialization */
> +	ret = data->config_deinit(host);
>   	if (ret)
>   		goto refclk_restore;
>   
>   	ret = reset_control_bulk_assert(data->num_power_resets,
>   					host->power_resets);
>   	if (ret)
> -		goto cfg_resets_restore;
> +		goto config_reinit;
>   
>   	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
>   				 sysc->info->rst_rsm_b.mask,
> @@ -1684,9 +1708,8 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   power_resets_restore:
>   	reset_control_bulk_deassert(data->num_power_resets,
>   				    host->power_resets);
> -cfg_resets_restore:
> -	reset_control_bulk_deassert(data->num_cfg_resets,
> -				    host->cfg_resets);
> +config_reinit:

If I'm not wrong, you need this, here, as well:

	if (data->config_pre_init)
		data->config_pre_init(host);

Thank you,
Claudiu

> +	data->config_post_init(host);
>   refclk_restore:
>   	clk_prepare_enable(port->refclk);
>   	pm_runtime_resume_and_get(dev);
> @@ -1755,6 +1778,8 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
>   	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
>   	.cfg_resets = rzg3s_soc_cfg_resets,
>   	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
> +	.config_post_init = rzg3s_config_post_init,
> +	.config_deinit = rzg3s_config_deinit,
>   	.init_phy = rzg3s_soc_pcie_init_phy,
>   	.sysc_info = {
>   		.rst_rsm_b = {

