Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D0B43F8A9
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336199; cv=none; b=cCksyCShx4tU6eFVjHD71p2lpl/FXzSFGZmsEVesYxNYyux8Y7+aSwn48aj/zgURhaXhHJX6vjYyfZO7X9NVzMiaymdKmS8uSTzrP97rrH5jqafLdVhmMtFDKcjs+bhNfFUeDNS5RYeVYbeEwCJffQ1YJE1rX3f0FZdeDdEb2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336199; c=relaxed/simple;
	bh=ZaVZEsP120VSWFPta1neu7p2mJY5Zmr+yXJnTv26o94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spQGIWYNV+WyjvAUUqPXB8LEapq7cS+ei9pIHTqk/ugT39EIo4fqflYKWwAqX8C4esAMZqSwnzqZRIArrrJxVJjounXNnz+mlTgvIatXHObCy0ouhnm0yG9bXe6oNSOKOBbw22hScSEEEt8GT54IZVma6T17R8V/4dtLMNdJ2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt4qiSEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt4qiSEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089BC1F000E9;
	Wed, 29 Jul 2026 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785336198;
	bh=NwAOdrpDCQF1Bk96TGLkq8hkO1Y2KpsEzDtPJqeu6hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tt4qiSEZpM6Js8mivGbeNWQt6HUwmdwEFmtNYIlv0xJJYBvMycNXU2JD44d4qVRqb
	 shwxZEIDygkj4Uzwz29gx6GZIyKpe2a9OLOYU4OcpCQGvKDWiHZsvJoLZ2S4XVeTRD
	 LW6RzgTDakIDkCSOIpxFrtI9Fqx+OzE6o6ieKzhZnsYolSm3OX3CgPcQiarAzAqY/j
	 TkbkxwdFeQoS87vtw5qnUb/3/pTM4ZJ99LAQP/rPtVPRRch6tOe2GRdEcHhofog8a+
	 ptECXi9z7a1Pl5JyDRI0tqo7wetcSMcfUuBTkz4st2XgJwZsabWzlow123lefQ7NKP
	 lOOV19ulnyrHw==
Date: Wed, 29 Jul 2026 16:43:11 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/pwrctrl: tc9563: use devm-managed I2C dummy
 device allocation
Message-ID: <z6hu4e4qey5kg6vsqs2rhonhiaoz2i43py7xsxrkuwzev2fukw@qx265rzsv2k6>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
 <20260729-pci-pwrctrl-tc956x-regmap-v1-2-20ce61a3ce12@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-2-20ce61a3ce12@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 03:34:26PM +0200, Lorenzo Bianconi wrote:
> Switch from i2c_new_dummy_device() to its devm variant
> devm_i2c_new_dummy_device() so the I2C client is automatically
> unregistered when the driver is removed or on probe failure.
> 
> This allows removing the manual i2c_unregister_device() calls from
> both the probe error path and the remove function, and lets the
> i2c_client pointer be a local variable in probe instead of storing
> it in the driver data structure.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 8bccf3abd189..5b05e76f6c80 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -106,7 +106,6 @@ struct tc9563_pwrctrl {
>  	struct tc9563_pwrctrl_cfg ep_cfg;
>  	struct gpio_desc *reset_gpio;
>  	struct i2c_adapter *adapter;
> -	struct i2c_client *client;
>  	struct regmap *regmap;
>  };
>  
> @@ -505,6 +504,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	enum tc9563_pwrctrl_ports port;
>  	struct tc9563_pwrctrl *tc9563;
>  	struct device_node *i2c_node;
> +	struct i2c_client *client;
>  	int ret, addr;
>  
>  	tc9563 = devm_kzalloc(dev, sizeof(*tc9563), GFP_KERNEL);
> @@ -521,15 +521,14 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	if (!tc9563->adapter)
>  		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
>  
> -	tc9563->client = i2c_new_dummy_device(tc9563->adapter, addr);
> -	if (IS_ERR(tc9563->client)) {
> +	client = devm_i2c_new_dummy_device(dev, tc9563->adapter, addr);
> +	if (IS_ERR(client)) {
>  		dev_err(dev, "Failed to create I2C client\n");
> -		i2c_put_adapter(tc9563->adapter);
> -		return PTR_ERR(tc9563->client);
> +		ret = PTR_ERR(client);
> +		goto remove_i2c;
>  	}
>  
> -	tc9563->regmap = devm_regmap_init_i2c(tc9563->client,
> -					      &tc9563_regmap_config);
> +	tc9563->regmap = devm_regmap_init_i2c(client, &tc9563_regmap_config);
>  	if (IS_ERR(tc9563->regmap)) {
>  		ret = dev_err_probe(dev, PTR_ERR(tc9563->regmap),
>  				    "Failed to allocate register map\n");
> @@ -607,7 +606,6 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  power_off:
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
>  remove_i2c:
> -	i2c_unregister_device(tc9563->client);
>  	i2c_put_adapter(tc9563->adapter);
>  	return ret;
>  }
> @@ -619,7 +617,6 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
>  					struct tc9563_pwrctrl, pwrctrl);
>  
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
> -	i2c_unregister_device(tc9563->client);
>  	i2c_put_adapter(tc9563->adapter);
>  }
>  
> 
> -- 
> 2.55.0
> 

-- 
மணிவண்ணன் சதாசிவம்
