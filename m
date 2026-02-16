Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A0A2C0F8C;
	Mon, 16 Feb 2026 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259257; cv=none; b=HBmZq/4p7WCIHjV6lfMv11KCoIRMkzE7ZE3UZJwPxORWT6k2heLawUxci89zJp5YrjWD4W9bsNKAtq7m04x+7gLdZgk2OoOOav7fn/tn/C2tK7E2N+ARNh9O0w+yT4oYVJBDpeM3t27RntnS+QRPLAMLEOz7Turzg39NJ3dDzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259257; c=relaxed/simple;
	bh=+H5mKMCDJNc/qLxDERdZhixKg4LKT1aSL3hlRSk0nms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAPR/tML3G/M8OoFnKequHKQvoUoA3T9BpYTcu3e2tTIkn7IK2RJdlwtuS8fmHOCExbb3fQXljP7Yib4ZtxBg/2kyPAjGn1sdHfasvI9pzq5i8GsX0hjgZrWVaNOBR7qaUq0SxBOzoRQRHCEC56ZiU8UH9CT6zjl4VxeY5l30ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DH2SgyPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DH2SgyPc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E482C19423;
	Mon, 16 Feb 2026 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771259257;
	bh=+H5mKMCDJNc/qLxDERdZhixKg4LKT1aSL3hlRSk0nms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DH2SgyPcTjIShNu2OspU97jjLkn10EGuspVaZEYyGfyEhbBCrpV7WtR0MAkhpxNgH
	 +Th7sQX1+mio563yxt5C7CZM5CaYOEuzBI5HYARp3hpGGF39dRFZ+q1LlFDgIkw94W
	 9ge/NSVWYaRn8HK8sKNrjXe/r4+CiajQU+gfZqWqM24UdVJKoE0gr9C3/ZnmDOV+EK
	 nBoRVbYtIhGTaVrZ2+I4Xinc5zwtHOJjtuB6LWSZ4ws6lymdXiUmjKAOy9GBg7r34l
	 00NHCfem916fuCoG1Jk1nLIMCXtjann65OA9V70afR+McV9juCINMEnaNMFWek8FnQ
	 obBQcHnRvZ0kQ==
Date: Mon, 16 Feb 2026 21:57:20 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/9] pci: pwrctrl: slot: fix dev_err_probe() usage
Message-ID: <ly73vzmdqmk6xml2kz2u3klglmuscnttu4j6seguofdezqhjfh@vsrtpt2enetk>
References: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-0-802c82795431@linaro.org>
 <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-2-802c82795431@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-topic-sm8650-ayaneo-pocket-s2-base-v4-2-802c82795431@linaro.org>

On Mon, Feb 16, 2026 at 03:21:46PM +0100, Neil Armstrong wrote:
> The code was not returning dev_err_probe() but dev_err_probe()
> returns the error code, so simplify the code.
> 
> Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/pwrctrl/slot.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 3320494b62d8..08e53243cdbd 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -40,17 +40,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  
>  	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
>  					&slot->supplies);
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
>  
>  	slot->num_supplies = ret;
>  	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
>  	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
>  		regulator_bulk_free(slot->num_supplies, slot->supplies);
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
>  	}
>  
>  	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
> @@ -59,10 +56,9 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	clk = devm_clk_get_optional_enabled(dev, NULL);
> -	if (IS_ERR(clk)) {
> +	if (IS_ERR(clk))
>  		return dev_err_probe(dev, PTR_ERR(clk),
>  				     "Failed to enable slot clock\n");
> -	}
>  
>  	pci_pwrctrl_init(&slot->ctx, dev);
>  
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
