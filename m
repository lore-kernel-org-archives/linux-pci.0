Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70512561A7;
	Thu, 26 Feb 2026 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098240; cv=none; b=mVD0mSqdwO2iD86vXBoIl0bibqIPqyOLII1t/2L2Jw22kZo4wY3FuFCCU9teq6XtP/RrsZWOod8sTqWrexxjP2MSyG4iE+UG5BH2ojRo+I0AihIgElckZAgvCxKvKF0OzXdkdFwc4CoZIQ5ft/EJqh89dwHa4a8o+8EGZIHKnn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098240; c=relaxed/simple;
	bh=RmOtEtA1WX8F5PeA6l5ZPdlLmxFHYfoorlfsg8Xr5ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPvdqPowNFZRYz9kxWG4U6IaKit/Nbl5MaldEICxWYVVqYsfawOeTTEeF+gVLDKm8Lk1T7W8z+kWlSREAUfrfq+amXI7NCOuPF+yuzeHk3d0n1ox95URgRXWm+NuypLHnQGwDfn1NnlzX655fwt7zsPHhRYdZSkBqEYT5NOd/1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAU5yetJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAU5yetJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3DBC19422;
	Thu, 26 Feb 2026 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772098240;
	bh=RmOtEtA1WX8F5PeA6l5ZPdlLmxFHYfoorlfsg8Xr5ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAU5yetJpbCE0l6bGDk28tXibWKhvP0iCd4BN7l768IdyMM+sI4GqVrtUux1/IwU4
	 VoFqqsN692T/mq8p+9Nw7BzO31VaRhdRWsJXObco9z6dSRtol/Fvl4532xcOiCFMSP
	 UfqUus/Xijimfw0XYaDlUh1o35i05vGcFy07VWREVTcKCLJNEP60u2yS4PydGTitXV
	 pJFGiAujQwdClAK7ceCzPUc+MNYs9xmRo1237c1Dx76+iQ/yZTSEHqVkbDsqTbvU/l
	 GURrmc9tDirXorZoOgtOgvGICZWzDWqpu7ydUPov9NHh7Zx5eOuyyqxu7vV84Fo3fB
	 Ey3twswEzwywA==
Date: Thu, 26 Feb 2026 15:00:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2] PCI/pwrctrl: Do not power off on pwrctrl device
 removal
Message-ID: <yvvkujtpo5fxca7yzw6w7afi64zdwuq4kdd6hdvnpqomazd62o@luhjytailsow>
References: <20260226092234.3859740-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226092234.3859740-1-wenst@chromium.org>

On Thu, Feb 26, 2026 at 05:22:33PM +0800, Chen-Yu Tsai wrote:
> With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> the PCI driver should manage the power state. The pwrctrl drivers should
> not try to clean up or power off when they are removed, as this might
> end up disabling an already disabled regulator, causing a big warning.
> This can be triggered if a PCI controller driver's .remove() callback
> calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices().
> 
> Drop the devm cleanup parts that turn off regulators from the pwrctrl
> drivers.
> 
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> ---
> Changes since v1:
> - Keep the release function for the PCI slot driver to free the
>   regulators
> 
> I ran into this while integrating the new pci_pwrctrl_*() API into the
> MediaTek driver. I am sending this separately since this change is
> unrelated and does not conflict with or depend on the other changes for
> the driver itself.
> 
> I think this should be merged for fixes.
> 
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
>  drivers/pci/pwrctrl/slot.c               |  1 -
>  2 files changed, 13 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> index 0d0377283c37..c7e4beec160a 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> @@ -68,13 +68,6 @@ static int pwrseq_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
>  	return pwrseq_power_off(pwrseq->pwrseq);
>  }
>  
> -static void devm_pwrseq_pwrctrl_power_off(void *data)
> -{
> -	struct pwrseq_pwrctrl *pwrseq = data;
> -
> -	pwrseq_pwrctrl_power_off(&pwrseq->pwrctrl);
> -}
> -
>  static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
>  {
>  	const struct pwrseq_pwrctrl_pdata *pdata;
> @@ -101,11 +94,6 @@ static int pwrseq_pwrctrl_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
>  				     "Failed to get the power sequencer\n");
>  
> -	ret = devm_add_action_or_reset(dev, devm_pwrseq_pwrctrl_power_off,
> -				       pwrseq);
> -	if (ret)
> -		return ret;
> -
>  	pwrseq->pwrctrl.power_on = pwrseq_pwrctrl_power_on;
>  	pwrseq->pwrctrl.power_off = pwrseq_pwrctrl_power_off;
>  
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 082af81efe25..b87639253ae2 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -63,7 +63,6 @@ static void devm_slot_pwrctrl_release(void *data)
>  {
>  	struct slot_pwrctrl *slot = data;
>  
> -	slot_pwrctrl_power_off(&slot->pwrctrl);
>  	regulator_bulk_free(slot->num_supplies, slot->supplies);
>  }
>  
> -- 
> 2.53.0.414.gf7e9f6c205-goog
> 

-- 
மணிவண்ணன் சதாசிவம்
