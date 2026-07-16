Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EE42A7AF;
	Thu, 16 Jul 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212059; cv=none; b=ENJhVh0Y8mQdymOFz3d1oI/Vva+my0PO+lQZB07bqED3ZEEJbcLDa0EEVv8MOUMUm35P1eMHawkWvPUPR4s22vF8o6TFHVeHe0w1kAjWn0+LyjJshqnEN/AnYhjahB7eMKSgTQ9bLvj5WkocECbcrz81eOh5EpE4pMzbDpy3MGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212059; c=relaxed/simple;
	bh=1kJPsUhjqQy7HL6f355QrtUA/EB1oBtabhfwUM3eI2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/OS9a1mBRRwh8sOE/C86YfU+nSMtQnn9lqJBvJoyzfn05qeM+kRfZ1mj8EkdI8FGRi86FTqMGkG42kF4vQ/Xwxt9gx3uIwdM+LADkrwRkL7S98yXVxwZP89Hfne9z6ydGEGUNU1HB4OLE10iG68n5BooSNWDUd0/TQFuUeqcjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFAa2WZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFAa2WZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F511F00A3A;
	Thu, 16 Jul 2026 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212058;
	bh=wDjHvX2K3HpCs9NBajlM2JHwmELJGRbPoXUJ7ZuL9TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XFAa2WZJSAYIoiLx2V6HfT894RE7MeN/DxcfjTJ7kUaL1TdDsPqdU7HPdWpQF8TgB
	 xIiS0TIpgD2n0y+AgkYhDwW2gdYaCFEf5Te7UolGHT3CwBr2K6HwAYx4i5tO6h7o47
	 kyRvcYVxu3cqj8kU16aLYjmJY3muB6vi+MQ+HXU10zKiMsCJxs/HTJj6OM5E3QTi2R
	 hVNCy1zt9j/ZFKVhFfkTf0bP3DAJsmBTJHtJ/Ha9hmmb+3H0Ranqscz3Uc9tXKfBRC
	 PoC/d8ojQO/0qv5+hGvj7s9NrqXQj400RSiggupkZ7dUpN/+bXjb7HBH20v5I7Zy7J
	 l9o+BqcqzOgzg==
Date: Thu, 16 Jul 2026 16:27:19 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v3 04/11] power: sequencing: pcie-m2: Report power
 controllability
Message-ID: <txl2wo47ftsaqwh32x63kmhqwqjx5xpszoazccyeqdqmjzh2rv@ocev6u7vzdiq>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-4-46253587af64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710-monza-wireless-v3-4-46253587af64@oss.qualcomm.com>

On Fri, Jul 10, 2026 at 11:57:30AM +0200, Loic Poulain wrote:
> The M.2 Key E connector gates its functions through the W_DISABLE1#
> (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals. When a signal is not
> routed to a host GPIO, the corresponding enable/disable callbacks are
> no-ops, so the host cannot gate that function's power on its own.
> 

I think it is misleading to say that if W_DISABLE{1/2}# signals are not
available then we cannot control the function's power. Power to the function
only comes from the core 3.3v regulator, and these signals only enable/disable
the radio (WLAN/BT) as per the spec.

- Mani

> Implement the per-unit .is_controllable() callback on the "uart-enable"
> and "pcie-enable" units so that consumers can query this per instance
> (based on the runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) via
> pwrseq_power_is_controllable().
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..4bcd5078609da1be966ab30c73cffae5e578934f 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -84,11 +84,24 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
>  	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
>  }
>  
> +static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +	/*
> +	 * The UART enable is driven through the W_DISABLE2# line. When it is not
> +	 * wired up on this connector the enable/disable callbacks are no-ops, so
> +	 * the host cannot gate the Bluetooth function on its own.
> +	 */
> +	return !!ctx->w_disable2_gpio;
> +}
> +
>  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
>  	.name = "uart-enable",
>  	.deps = pwrseq_pcie_m2_unit_deps,
>  	.enable = pwrseq_pci_m2_e_uart_enable,
>  	.disable = pwrseq_pci_m2_e_uart_disable,
> +	.is_controllable = pwrseq_pci_m2_e_uart_is_controllable,
>  };
>  
>  static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
> @@ -105,11 +118,24 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
>  	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
>  }
>  
> +static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +
> +	/*
> +	 * The PCIe/WiFi enable is driven through the W_DISABLE1# line. When it
> +	 * is not wired up on this connector the enable/disable callbacks are
> +	 * no-ops, so the host cannot gate the PCIe/WiFi function on its own.
> +	 */
> +	return !!ctx->w_disable1_gpio;
> +}
> +
>  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
>  	.name = "pcie-enable",
>  	.deps = pwrseq_pcie_m2_unit_deps,
>  	.enable = pwrseq_pci_m2_e_pcie_enable,
>  	.disable = pwrseq_pci_m2_e_pcie_disable,
> +	.is_controllable = pwrseq_pci_m2_e_pcie_is_controllable,
>  };
>  
>  static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
