Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018807;
	b=W8wWfyOZPNY0WTN0FOJcA13IFyfotNQq7+eTKGPqU/o4Dd+5tOjGR+TaRTaFyhvmosyl
	 yG66pkjHI3khdYalnMuPi/5p2rpzw82K0vE8ltjjbAevm83TaQf8fODxwPM9k/TOQxg8+
	 FNArgf7boggWBWJCTo2tjzqant/9BJR7siCDXh5kyMdMREnOTaFBUqa/LlMYq+Wq3ql7t
	 JhK183vNYGzQA3+8XQD1FGbhS5mDLFIva9yIFyyCtcwHokMrrLekn0RgnMc87st6psw/E
	 E+lSyO3d7W7TcrtaZIREf9K6GIvcIVcRmfoS5MZSpnZU6OIevGnt1uHlIv55EZs6khw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018807;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ArmRsnsIQvKvAMge3n6tqu/iNcVRkVbInJbH5fsb0aQ=;
	b=qGQKnWiwMBKZVSuKMdZGP/vsT8vO7xvvW00stslzehlsA2a2SijBLBhxKidSokom7HmL
	 VcynC7FGM5L5POvPnAWW+OT/E+lMh+ADJ1FnDPorj0R3hUsBaS3NDFEGZtnXFQycLEQiX
	 xMOIzisLi1p+64Vcay6lg7ZyN5JiOUEWmpdDX7HUwOCcn0Jtz8RCgPaZiSIMayqDQH287
	 7lq6odWnF47o2/yubkJvYhtGKMMM/KbhykRYLj6ulNfhcjPwE2izCWOA9khO3QAzrUBfW
	 JxRRcklgf7KZQyDbfYHTzvK0HuOCPmeXtR3v95U3+UPPClftMpmDqm3Wnkqu3WzFzFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/Ol83yr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D627606A31A;
	Mon, 26 Oct 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/Ol83yr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15EA1F01828;
	Mon, 26 Oct 2026 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793018807;
	bh=ArmRsnsIQvKvAMge3n6tqu/iNcVRkVbInJbH5fsb0aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D/Ol83yrI6KJhaHiruMzDiB/zN9MfS423xwj7GvkkhXVbRAqy2KLHydZW73w/BCXs
	 yAXd+YmsjQarrq2+Yr+ieSCOmbTixojIu2+Z32a61tSlBdha4ercIsSXRFR67U3As1
	 xS7L+oXSm4mMQ+0mr9y1SFLg1Qf2VwqMf3VPqckWjT/jvUrS9UT6II2wfWJuot5eG5
	 n2ErsVl2xHxbSCEVL959d/PcSGi9SvK3ZSvZGRcl0vBjJ5kYgDLg3wKspayc4boeZB
	 eSqkXv468SdurUr1TsTuO9EK45qtNM/DYAFIiP67ilXjK6csCvWVPy4tOLrd4GaOEA
	 2nyIKXAQwS79g==
Date: Mon, 26 Oct 2026 18:16:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: William Bright <william.bright@imd-tec.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Drive the Key E SDIO_RESET#
 signal
Message-ID: <at9KREB4Fyf-Jl5S@debian>
References: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>

On Mon, Oct 26, 2026 at 11:38:38AM +0000, William Bright wrote:
> The pcie-m2-e-connector binding describes sdio-reset-gpios, but the
> driver never requested it, so the line was left to pinctrl or to its
> reset state.

Do we have SDIO pwrseq consumer driver in mainline?

> 
> Request it asserted, like W_DISABLE1# and W_DISABLE2#, deassert it once
> the connector supplies are enabled and assert it again before they are
> disabled. The card is then held in reset through power-up, and the
> line is never driven high into an unpowered card.
> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
> The pcie-m2-e-connector binding describes sdio-reset-gpios, but the
> driver never requested it. This holds the card in SDIO reset until the
> connector supplies are enabled, and asserts it again before they are
> disabled, matching how W_DISABLE1# and W_DISABLE2# are handled.
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index cafa642a4b6b..5f5a116063da 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -39,6 +39,7 @@ struct pwrseq_pcie_m2_ctx {
>  	struct notifier_block nb;
>  	struct gpio_desc *w_disable1_gpio;
>  	struct gpio_desc *w_disable2_gpio;
> +	struct gpio_desc *sdio_reset_gpio;
>  	struct device *dev;
>  	struct list_head pci_devices;
>  	struct mutex list_lock;
> @@ -47,13 +48,23 @@ struct pwrseq_pcie_m2_ctx {
>  static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> +	int ret;
> +
> +	ret = regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +	if (ret)
> +		return ret;
>  
> -	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +	return gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 0);

You should not add GPIO control to the pwrseq_pcie_m2_vregs_{enable/disable}()
callbacks. You should create a new 'sdio-enable' and populate
pwrseq_unit_data->enable/disable callbacks for the SDIO_RESET# control.

Please take a look at the 'pcie-enable' unit and W_DISABLE1/2# GPIO control.

But before that, you should explain how the SDIO consumer driver is making use
of pwrseq.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
