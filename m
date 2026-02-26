Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC0364E82
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105236; cv=none; b=NFY3a90cUTyf0ctjpFJ8iX0EIO2miB8V4xE4sBRj1+2bhi83BHgK/AUyKwUHNcfbUnLI52HGDcTcfalIfEZMGXfKROTvwL94ZStb9xfwWz69mWi6Bkx1rp3KOfLcEt+0V8GXJ7Mb+MUIRVLPipq07TbpM+KbbqKLxM3CRuT9DU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105236; c=relaxed/simple;
	bh=KBkXwYbNDGKJRUZJASZcErNU+Nm6SHDyJPnJvJ9mz7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8fZam5WaWqex0J1X/DusUK8ZSsdj8s3o4iog69ynHEIQzEs6DGNxGNFnpJhN8pMBvcVgHw+l4M4bfmiTCpzcI2GSLiZuSHmXfzCUh0Virmjv7rhfEcAF1l3fsEStpTOwM978vOcgK2LbZwOtJ7p7LDKLfn1OGCoeHgKLONQfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HJFXYnWC; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HJFXYnWC"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483703e4b08so6293295e9.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 03:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772105233; x=1772710033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0egD5NuFInsZp/5U44UWlazKrIJ1QnicZe5iyCaeCA=;
        b=HJFXYnWC8FvteTDcUu/0hAkuMfJmgV67g1tmL7O2eJuPNgnp8I30zSBEimYKhlgpaM
         WI6hDMRWQ2z506a/ePapXv/iAKvZa8pKZ8E0L42LFcgjgiq0auQgFn2wc0IZN2Q5ZcOW
         MKBKIkpQNCU9YGNdOdqV1NwNPuVf8fSerC9bYUMcev/4c0ulKXzmz3lfErCyJ11xE8cJ
         /Zce+qSQ+cmlQKS+5OavmdH35D145DUBr2FomP3Q5FYE4nkVfifV4B5pGLthlccbkkBX
         a0RvMqi/HyGteosuSZjY2nQ16x0g/7LOrtiWv8TZdrdAAcd2CxeokY6gfuxJYB1W36+L
         oGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105233; x=1772710033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0egD5NuFInsZp/5U44UWlazKrIJ1QnicZe5iyCaeCA=;
        b=iY2y/LbnTmwtBpGl62cEzXoUpM2N1Ca34UOOrWclu8dw6PKOpXDqy4VLx1NqJSMr75
         HNrfWaN5vNNRZrSIPvos9TTTDLPPbo3QM50MKbAuvoTXd/8SSgwKBfkF4EOTpNfHwWg5
         uBoBY9IJU2BacPF5cf6gL1gYFCsMZ4lghtIgmH9ZVKTAorAQsavq2YgPpLtFKK3YpfGS
         1MU4xdHTbMH6yRqzE356BCV+5a3kz3VvMm+uEa+37bTg371noooW0jHglt2GcFS9qXkM
         yzzybQMCYK6eu8g8vbLyrPfTYlnAQvgr0WuWaUiPcHaAYpxxA0wD1Etf+i/z61JrqXt2
         C/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLV/SYw6bqeEIaKSmwQDn/crDfuL0z6g8w9pSzcN9TBSckN7bhz1uvadwhgU1avdOpAK8fr/folhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6RBtwWKWn39hOB5d2CDih2UcvNp5+HmslNka/W79qARx7yirn
	O1asY1LMVH/Sn/ybb2g5sVHdJFWN2GarcViuM8ouOvk6VvpbvRZuxUPKK15H14tL6us=
X-Gm-Gg: ATEYQzxa96/AfRwp0MvI0VPeTG0Rb1UmV3fcx9yyc3pNxEVp1dC16diEE4tej0kAtk7
	FYeyQtyrxntHon0tbuQYGJR6O2/DhF1WJgsRkEGbytd/FBKHStxOqUpM34Ep+4LcELAH5yj4Au+
	hAVry85TcBwnDyavFf2qrijhyEtvkvLwM1jjvOGUmoYCYsVRAbF2C62gl5TCLfU+7qA7ThL+HBb
	pXrRMKIIKhN7BvqXoO3sKJIJhqb3hNnmOfa9EW+DG5b87Ul/ultd9+OjQkGYkMMkOtDhlxIPiR7
	tx/qrsntwBrVDNtmsa/97gF46b7avLlBBov0gHy1W7j6syOZacHB/oM1tln1qDDZ3Q0J9XN7JtN
	ya6pmN2rdIB78yiBL8iknOVwvEcOiE5Sbgt3OvfOQ4L4LwjXSlMxcHVZ8+4xI9zj+62KyfGCIhy
	lTj8/IKfEOxJfnncZVnvgA+qp9XxmEDw==
X-Received: by 2002:a05:600c:8b71:b0:483:7ea3:3de3 with SMTP id 5b1f17b1804b1-483c33c3606mr43779775e9.2.1772105232673;
        Thu, 26 Feb 2026 03:27:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm142865245e9.14.2026.02.26.03.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:27:12 -0800 (PST)
Message-ID: <8352571e-a6f0-4564-a837-22f2fe15df31@tuxon.dev>
Date: Thu, 26 Feb 2026 13:27:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/16] PCI: rzg3s-host: Make SYSC register offsets
 SoC-specific
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
 <20260219223542.6364-9-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260219223542.6364-9-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 2/20/26 00:35, John Madieu wrote:
> In preparation for adding RZ/G3E support, move the RST_RSM_B register
> offset and mask into a SoC-specific data structure. Compared with RZ/G3S,
> the RZ/G3E SYSC controls different functionalities for the PCIe controller.
> 
> Make SYSC operations conditional on the presence of register offset
> information, allowing the driver to handle SoCs that don't use the
> RST_RSM_B signal.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
> 
> Changes:
> 
> v6:
>   - Introduce enum rzg3s_sysc_func_id and rzg3s_sysc_config_func() as
>     suggested by Claudiu. This replaces direct regmap calls and drops
>     the -1 skip pattern.
>   - Removed Rb tag from Claudiu
> 
> v5: No changes
> v4: No changes
> v3: No changes
> v2: Collected tag.
> 
>   drivers/pci/controller/pcie-rzg3s-host.c | 120 ++++++++++++++++++-----
>   1 file changed, 94 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 7f5ffc5c218a..a90487610b37 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -159,10 +159,6 @@
>   
>   #define RZG3S_PCI_CFG_PCIEC			0x60
>   
> -/* System controller registers */
> -#define RZG3S_SYS_PCIE_RST_RSM_B		0xd74
> -#define RZG3S_SYS_PCIE_RST_RSM_B_MASK		BIT(0)
> -
>   /* Maximum number of windows */
>   #define RZG3S_MAX_WINDOWS			8
>   
> @@ -174,6 +170,45 @@
>   /* Timeouts experimentally determined */
>   #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
>   
> +/**
> + * struct rzg3s_sysc_function - System Controller register function descriptor

Please drop register word from here ---------------------^

> + * @offset: Register offset from the System Controller base address
> + * @mask: Bit mask for the function within the register
> + */
> +struct rzg3s_sysc_function {
> +	u32 offset;
> +	u32 mask;
> +};
> +
> +

There are 2 blank lines here. Please drop one.

> +/**
> + * enum rzg3s_sysc_func_id - System controller function IDs
> + * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
> + * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
> + */
> +enum rzg3s_sysc_func_id {
> +	RZG3S_SYSC_FUNC_ID_RST_RSM_B,
> +	RZG3S_SYSC_FUNC_ID_MAX,
> +};
> +
> +/**
> + * struct rzg3s_sysc_info - RZ/G3S System Controller function info

Please drop function from here ---------------------------^
as we may add other data in it at some point.

> + * @functions: SYSC function descriptors array
> + */
> +struct rzg3s_sysc_info {
> +	const struct rzg3s_sysc_function functions[RZG3S_SYSC_FUNC_ID_MAX];
> +};
> +
> +/**
> + * struct rzg3s_sysc - RZ/G3S System Controller descriptor
> + * @regmap: System controller regmap
> + * @info: System controller info
> + */
> +struct rzg3s_sysc {
> +	struct regmap *regmap;
> +	const struct rzg3s_sysc_info *info;
> +};
> +
>   /**
>    * struct rzg3s_pcie_msi - RZ/G3S PCIe MSI data structure
>    * @domain: IRQ domain
> @@ -203,6 +238,7 @@ struct rzg3s_pcie_host;
>    *                power-on
>    * @cfg_resets: array with the resets that need to be de-asserted after
>    *              configuration
> + * @sysc_info: SYSC functionalities

s/functionalities/info

>    * @num_power_resets: number of power resets
>    * @num_cfg_resets: number of configuration resets
>    */
> @@ -210,6 +246,7 @@ struct rzg3s_pcie_soc_data {
>   	int (*init_phy)(struct rzg3s_pcie_host *host);
>   	const char * const *power_resets;
>   	const char * const *cfg_resets;
> +	struct rzg3s_sysc_info sysc_info;
>   	u8 num_power_resets;
>   	u8 num_cfg_resets;
>   };
> @@ -233,7 +270,7 @@ struct rzg3s_pcie_port {
>    * @dev: struct device
>    * @power_resets: reset control signals that should be set after power up
>    * @cfg_resets: reset control signals that should be set after configuration
> - * @sysc: SYSC regmap
> + * @sysc: SYSC descriptor
>    * @intx_domain: INTx IRQ domain
>    * @data: SoC specific data
>    * @msi: MSI data structure
> @@ -248,7 +285,7 @@ struct rzg3s_pcie_host {
>   	struct device *dev;
>   	struct reset_control_bulk_data *power_resets;
>   	struct reset_control_bulk_data *cfg_resets;
> -	struct regmap *sysc;
> +	struct rzg3s_sysc *sysc;
>   	struct irq_domain *intx_domain;
>   	const struct rzg3s_pcie_soc_data *data;
>   	struct rzg3s_pcie_msi msi;
> @@ -1161,6 +1198,31 @@ static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
>   	return 0;
>   }
>   
> +/**
> + * rzg3s_sysc_config_func - Configure a single SYSC function
> + * @sysc: SYSC descriptor
> + * @fid: Function ID to configure
> + * @val: Value to set
> + *
> + * Return: 0 on success, negative error code on failure
> + */

Other similar functions in this file don't use documentation. I think the 
function name and its arguments are descriptive enough to drop this documentation.


> +static int rzg3s_sysc_config_func(struct rzg3s_sysc *sysc,
> +				  enum rzg3s_sysc_func_id fid, u32 val)
> +{
> +	const struct rzg3s_sysc_info *info = sysc->info;
> +	const struct rzg3s_sysc_function *functions = info->functions;
> +
> +	if (fid >= RZG3S_SYSC_FUNC_ID_MAX)
> +		return -EINVAL;
> +
> +	if (!functions[fid].mask)
> +		return 0;
> +
> +	return regmap_update_bits(sysc->regmap, functions[fid].offset,
> +				  functions[fid].mask,
> +				  field_prep(functions[fid].mask, val));
> +}
> +

Could you please move this function before rzg3s_pcie_update_bits()? In this 
patch it is b/w rzg3s_pcie_host_parse_port() and rzg3s_pcie_host_init_port() and 
I would prefer to keep these 2 close togheter.

The rest LGTM.

Thank you,
Claudiu

>   static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
>   {
>   	struct rzg3s_pcie_port *port = &host->port;
> @@ -1521,6 +1583,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	struct device_node *sysc_np __free(device_node) =
>   		of_parse_phandle(np, "renesas,sysc", 0);
>   	struct rzg3s_pcie_host *host;
> +	struct rzg3s_sysc *sysc;
>   	int ret;
>   
>   	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
> @@ -1532,6 +1595,13 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	host->data = device_get_match_data(dev);
>   	platform_set_drvdata(pdev, host);
>   
> +	host->sysc = devm_kzalloc(dev, sizeof(*host->sysc), GFP_KERNEL);
> +	if (!host->sysc)
> +		return -ENOMEM;
> +
> +	sysc = host->sysc;
> +	sysc->info = &host->data->sysc_info;
> +
>   	host->axi = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(host->axi))
>   		return PTR_ERR(host->axi);
> @@ -1545,15 +1615,13 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	host->sysc = syscon_node_to_regmap(sysc_np);
> -	if (IS_ERR(host->sysc)) {
> -		ret = PTR_ERR(host->sysc);
> +	sysc->regmap = syscon_node_to_regmap(sysc_np);
> +	if (IS_ERR(sysc->regmap)) {
> +		ret = PTR_ERR(sysc->regmap);
>   		goto port_refclk_put;
>   	}
>   
> -	ret = regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> -				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> -				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
> +	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
>   	if (ret)
>   		goto port_refclk_put;
>   
> @@ -1605,9 +1673,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	 * SYSC RST_RSM_B signal need to be asserted before turning off the
>   	 * power to the PHY.
>   	 */
> -	regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> -			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> -			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
> +	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
>   port_refclk_put:
>   	clk_put(host->port.refclk);
>   
> @@ -1619,7 +1685,7 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>   	const struct rzg3s_pcie_soc_data *data = host->data;
>   	struct rzg3s_pcie_port *port = &host->port;
> -	struct regmap *sysc = host->sysc;
> +	struct rzg3s_sysc *sysc = host->sysc;
>   	int ret;
>   
>   	ret = pm_runtime_put_sync(dev);
> @@ -1638,9 +1704,7 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   	if (ret)
>   		goto cfg_resets_restore;
>   
> -	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> -				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> -				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
> +	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
>   	if (ret)
>   		goto power_resets_restore;
>   
> @@ -1663,12 +1727,10 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>   {
>   	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>   	const struct rzg3s_pcie_soc_data *data = host->data;
> -	struct regmap *sysc = host->sysc;
> +	struct rzg3s_sysc *sysc = host->sysc;
>   	int ret;
>   
> -	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> -				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> -				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
> +	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
>   	if (ret)
>   		return ret;
>   
> @@ -1697,9 +1759,7 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>   	reset_control_bulk_assert(data->num_power_resets,
>   				  host->power_resets);
>   assert_rst_rsm_b:
> -	regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
> -			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
> -			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
> +	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
>   	return ret;
>   }
>   
> @@ -1722,6 +1782,14 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
>   	.cfg_resets = rzg3s_soc_cfg_resets,
>   	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
>   	.init_phy = rzg3s_soc_pcie_init_phy,
> +	.sysc_info = {
> +		.functions = {
> +			[RZG3S_SYSC_FUNC_ID_RST_RSM_B] = {
> +				.offset = 0xd74,
> +				.mask = BIT(0),
> +			},
> +		},
> +	},
>   };
>   
>   static const struct of_device_id rzg3s_pcie_of_match[] = {

