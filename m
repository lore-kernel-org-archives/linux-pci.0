Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34478514740;
	Thu,  3 Sep 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472995; cv=none; b=Xbc9UnCCD9i7EchwyDrovzMWMdtMhMGcW4rFzcqG1ug9ObvXGzF6cBZjRMbpWJnGXZIXmkwAaRX6yna+quLTmgNCCeI5D7E0XlJ/T19VUdNlCxdcT/Fhq+BTTdyJINlqDBqBA0TKN05C4gGoVeDYFnm+w6zGsRaKqBsrpCBSvl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472995; c=relaxed/simple;
	bh=iMjV+PySMecpFIGXhocjjdd8O4G07udSOKtkjYgMaYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FX7rolKEiRGcYNOQbTFiDPZurTSZ4nGFkUjrRaW1xP9e64hqnC83kZzA5sbSt/B18gkXTy83kfTAixkUgGPWdT4Q+J1uULWH64mIwHx4WVnTCH61YzQp7khnGelcjPujebAyoQDhyiTMx/ZMxqiryH5MMqmM2/7STl96Vfo3an4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK6WRinG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK6WRinG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0891F00A3E;
	Thu,  3 Sep 2026 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788472992;
	bh=2aV8BC4TBR3SilVwjgPaPrbeJhHDjfEx1Toy4R5CeZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=oK6WRinGKqpHRcubHbxpyZ4DDG15lncilAgwU9zARNHgpvGPQE06bfI2wPJ21rb+X
	 iyfQyxNlj9NCP3vQSY1HrERClJkFf+XJrKfETIp8fAVN4zB8nuN5dOSgDKYVL7EsZj
	 E5ABRP6oxUQqTI+ztXbntqH+8oYgtilh+WYmsQjvchPblRyy8x2EQuZQ6H3vo3CxMM
	 krnUSyfAQq7oufEgs+K2eP11tTvbrvR+GjO79DRaJqLGEMxjouflxLqthriYXgRWgr
	 aukrKWsp67ynQapxJsrpbf/7cRUJ7XNPD2sC67Df0k6fL9LmYHpsxNWNFsPOnFkVOf
	 0bbQBec/KCv7A==
Date: Thu, 3 Sep 2026 17:03:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI/pwrctrl: tc9563: switch per-port reset to
 GPIO descriptor API
Message-ID: <20260903220311.GA2250435@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-pci-tc9563-aux-v2-4-34c625b542c1@oss.qualcomm.com>

On Thu, Sep 03, 2026 at 09:53:00AM +0200, Lorenzo Bianconi wrote:
> Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
> definitions, which are no longer used after switching to the GPIO
> descriptor API.
> 
> Replace the direct regmap-based per-port reset logic in
> assert_deassert_reset() with gpiod_direction_output() calls, falling
> back to the legacy regmap approach only when no reset-gpios DT
> property is present for a given port.
> 
> Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
> tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
> PCI downstream port child node. The lookup is done lazily at the
> beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
> is registered.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Capitalize "Switch per-port ..." in subject.

Question below.

> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 85 +++++++++++++++++++++++++++-----
>  1 file changed, 73 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 6df512d78b54..09ab4718db8a 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -57,9 +57,6 @@
>  #define TC9563_POWER_CONTROL		0x82b09c
>  #define TC9563_POWER_CONTROL_OVREN	0x82b2c8
>  
> -#define TC9563_GPIO_MASK		0xfffffff3
> -#define TC9563_GPIO_DEASSERT_BITS	0xc  /* Clear to deassert GPIO */
> -
>  #define TC9563_TX_MARGIN_MIN_UA		400000
>  
>  /*
> @@ -85,6 +82,7 @@ struct tc9563_pwrctrl_cfg {
>  	u8 nfts[2]; /* GEN1 & GEN2 */
>  	bool disable_dfe;
>  	bool disable_port;
> +	struct gpio_desc *reset;
>  };
>  
>  #define TC9563_PWRCTL_MAX_SUPPLY	6
> @@ -349,16 +347,40 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
>  static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
>  						bool deassert)
>  {
> -	int ret, val;
> -
> -	ret = regmap_write(tc9563->regmap, TC9563_GPIO_CONFIG,
> -			   TC9563_GPIO_MASK);
> -	if (ret)
> -		return ret;
> -
> -	val = deassert ? TC9563_GPIO_DEASSERT_BITS : 0;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tc9563->cfg); i++) {
> +		int err;
> +
> +		if (tc9563->cfg[i].reset) {
> +			err = gpiod_direction_output(tc9563->cfg[i].reset,
> +						     !deassert);
> +			if (err)
> +				return err;
> +		} else {
> +			/* Fallback: legacy DTS without reset-gpios */
> +			switch (i) {
> +			case TC9563_DSP1:
> +			case TC9563_DSP2:
> +				err = regmap_clear_bits(tc9563->regmap,
> +							TC9563_GPIO_CONFIG,
> +							BIT(i + 1));
> +				if (err)
> +					return err;
> +
> +				err = regmap_assign_bits(tc9563->regmap,
> +							 TC9563_RESET_GPIO,
> +							 BIT(i + 1), deassert);
> +				if (err)
> +					return err;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
>  
> -	return regmap_write(tc9563->regmap, TC9563_RESET_GPIO, val);
> +	return 0;
>  }
>  
>  static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
> @@ -393,6 +415,41 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
>  	return 0;
>  }
>  
> +static int tc9563_pwrctrl_parse_reset_line(struct tc9563_pwrctrl *tc9563)
> +{
> +	enum tc9563_pwrctrl_ports port = TC9563_USP;
> +	struct device *dev = tc9563->pwrctrl.dev;
> +	struct device_node *node = dev->of_node;
> +
> +	for_each_child_of_node_scoped(node, child) {
> +		struct tc9563_pwrctrl_cfg *cfg;
> +
> +		if (!of_node_is_type(child, "pci"))
> +			continue;
> +
> +		if (++port >= TC9563_MAX)
> +			break;
> +
> +		cfg = &tc9563->cfg[port];
> +		if (cfg->reset) /* Already discovered */
> +			continue;
> +
> +		cfg->reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
> +						   "reset", GPIOD_ASIS,
> +						   NULL);
> +		if (IS_ERR(cfg->reset)) {
> +			int err = PTR_ERR(cfg->reset);
> +
> +			cfg->reset = NULL;
> +			if (err != -ENOENT)
> +				return dev_err_probe(dev, err,
> +						     "failed to get reset\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void tc9563_pwrctrl_adev_release(struct device *dev)
>  {
>  	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> @@ -480,6 +537,10 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
>  	struct tc9563_pwrctrl_cfg *cfg;
>  	int ret, i;
>  
> +	ret = tc9563_pwrctrl_parse_reset_line(tc9563);
> +	if (ret)
> +		return ret;

Seems like this call would fit better in
tc9563_pwrctrl_parse_device_dt() since it already handles similar
properties and nothing in DT is changing.

But I guess this is because the GPIO chip may not be registered at
tc9563_pwrctrl_probe() time.  Could tc9563_pwrctrl_probe() itself
return -EPROBE_DEFER?  Returning it from tc9563_pwrctrl_power_on()
seems a little weird.

>  	ret = regulator_bulk_enable(ARRAY_SIZE(tc9563->supplies),
>  				    tc9563->supplies);
>  	if (ret < 0)
> 
> -- 
> 2.55.0
> 
