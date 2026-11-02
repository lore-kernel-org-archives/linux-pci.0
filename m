Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650715;
	b=2zbsEjqkFsJwg3RicM4SbmpEaHowLDP9kClaLDQMVfUT8JKfoxDqVOeclPag/bU8wCcp
	 6QJjmG3qHi7bSjw7ypyyEkViAjavDeh6FcyL5dQRdo/cJZElbjGc7AgY+WPssLMg3pIp4
	 pvP+N2z6oRqo4hNCOVZlMVOtjrojqMEIMSnmIBObuKHJZERg9MF1meU3tWnXp/jx/t7Cn
	 PMCF/Oxak+qnk5FmU+4ZqmOCQn+y5xFS5BzmKyiPGQbHPGktTfFT4/dDqp3gUStalNTk3
	 9vN7Z/N+WG3kKprhVYqToGRyb+Laxjl8C4R6OnjNdnl37GpH68ZHE0GFfN9HCv0K9ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650715;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hXX2GG9LofGhkgvbkMHFZ4qhS5HLRZFRNTe4hW+MggA=;
	b=HYKwihGBE8pu6huK7aFPaUj/rxiu8/SSVlXfCEOFygzl+EikPZ24hwikdorwaAUcpRwE
	 qcj4s1Ww3qUnDbO14Kh5Cnw+9YILIkR1D9w+x32IdAKB+yqvi3MZwzC9b16+BcPuxq+AY
	 SfwEMynwI9yOTvnzHSLRfy78yJRFm8/LRIgZOrzlG0mdUQC+l60XDylmWKIO4g/4o68EE
	 CukKZVd2u4qCsfM0zMk9X3Uwd39+KNE2G/su0oCWWcxurbGEEL1qGvcEoyRGEWqgE2dEu
	 CFbbEXf5xKudA/STQRDsaghLayXG024EKoQhpHHz3LoEYR32SA8AvNg7O9D+7ul3Krw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQynNZq4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A027F606A332;
	Mon,  2 Nov 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQynNZq4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492851F00A16;
	Mon,  2 Nov 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793650715;
	bh=hXX2GG9LofGhkgvbkMHFZ4qhS5HLRZFRNTe4hW+MggA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mQynNZq4RAEoU+zaL7vxiT3LkD/6Ep7CBvvo2yKgOuR4aYYFbLmejFWhbG6TwIJjN
	 NeSSk+OkVnmPYIVT6orCq42Qcoe0GJSJcLu+23Z3nBQdbsLTy5WYQY8l31g8Tin2em
	 BTVkMY1Utz7N4/K8LHXscOoHGOjLLwWauvSZidN91AbaAR6acmavjLyAbGzNVT8nTL
	 INE5OM72qTUySSRpEXXKhFRrKQRm8Aq1ECBgiBLrhe7kH6IKTB9ypL4RUlH17rUw9w
	 iJOnkCA63IAoqTMG4WGpH5U4JwXYOL0kPamsu7OAYbBtlAn/q0UptX/a+cgCA9VmIl
	 cseBnJM5nj0IA==
Date: Mon, 2 Nov 2026 14:18:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leak on clock error path
Message-ID: <20261102201834.GA974502@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>

[+cc Markus]

On Sat, Oct 31, 2026 at 01:49:08AM +0800, Felix Gu wrote:
> The devm release action for the slot supplies is registered after
> devm_clk_get_optional().  If clock acquisition fails, probe returns
> immediately, so the resources eallocated by of_regulator_bulk_get_all()
> is never freed.
> 
> Register the devm action right after of_regulator_bulk_get_all()
> succeeds, so the resources are released on any subsequent probe failure.
> 
> Fixes: 9cb64f61ec7a9 ("PCI/pwrctrl: Add PCIe M.2 connector support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Applied to pci/pwrctrl for v7.5, thanks!

Fixed the eallocated->allocated and is->are commit log typos.

> ---
>  drivers/pci/pwrctrl/generic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
> index 4b6cbbb52248..85d568b381e2 100644
> --- a/drivers/pci/pwrctrl/generic.c
> +++ b/drivers/pci/pwrctrl/generic.c
> @@ -92,6 +92,10 @@ static int slot_pwrctrl_probe(struct platform_device *pdev)
>  
>  	slot->num_supplies = ret;
>  
> +	ret = devm_add_action_or_reset(dev, devm_slot_pwrctrl_release, slot);
> +	if (ret)
> +		return ret;
> +
>  	slot->clk = devm_clk_get_optional(dev, NULL);
>  	if (IS_ERR(slot->clk))
>  		return dev_err_probe(dev, PTR_ERR(slot->clk),
> @@ -101,10 +105,6 @@ static int slot_pwrctrl_probe(struct platform_device *pdev)
>  	slot->pwrctrl.power_on = slot_pwrctrl_power_on;
>  	slot->pwrctrl.power_off = slot_pwrctrl_power_off;
>  
> -	ret = devm_add_action_or_reset(dev, devm_slot_pwrctrl_release, slot);
> -	if (ret)
> -		return ret;
> -
>  	pci_pwrctrl_init(&slot->pwrctrl, dev);
>  
>  	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->pwrctrl);
> 
> ---
> base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
> change-id: 20261030-pwrctrl-6a85275b0c97
> 
> Best regards,
> --  
> Felix Gu <ustc.gu@gmail.com>
> 
