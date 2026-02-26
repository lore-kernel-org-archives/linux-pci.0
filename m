Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2F28643A;
	Thu, 26 Feb 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094226; cv=none; b=ZHofSVt1PY2v/TT4SuTalD0renESZHyi90etFeVHXP11xhK814wrihdGR8IfNQjwLZbTFRsdMm8Gp9HCig/Wn294Ykf21XKutzyd4ZDJdVpawkN3iRhiuIRLfvUbt/qmjNEQ1/UxYEP0aPVdES3SJri2lCGkSzR5yyZbFpahFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094226; c=relaxed/simple;
	bh=0bFzrOp6OFZkS1cr7rSIjji1dTOcckVivGxouNtM4CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLQRV4ho49HgDnmeVTRi2GTJWFXAlcKI79JPPkpsKB1o6Kue3/fymp/3vmL8oc6W5ynG57KIT3YNTBwTLB+4DOi6bQXPTTe3StMtZ3s3gRHImsO3UqZF1OZqmMzipE8476iHiViYyTbw0MomG8Euapq57UEZPM0Jh7zSjjYoPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlRnhYN/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlRnhYN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96633C19422;
	Thu, 26 Feb 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772094225;
	bh=0bFzrOp6OFZkS1cr7rSIjji1dTOcckVivGxouNtM4CE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlRnhYN/4tX6i7QulRBFxCxgYVWMypaRnNWRheBpw1fA6HwcpfHCxzrymBFQjRoNN
	 BaHZNabJNllWKx7yA1O/6sLAWlTx8ZupJaXDJr6CA8qs6IQ4XCYSTb9mqlibJM94WJ
	 LDqo8zEuIH7IQXbg9puazf9cBmzx7qmce+/LlpKHTRsds/ay9pORdGS1XrD91EoF5Y
	 mhdJ+fOpoMMTWCgungmpjq9NC/HxQ9hrzW6Y2tPJQ69bG+isQTonTY4L1WWZpyL9Fg
	 CJjhmcTNa614om6aJpUD6mcL4MWycn01uTplgxiEkgw4P2IK+Mnd2O+Hs53KwLeStT
	 lCeaY2uNPtyXw==
Date: Thu, 26 Feb 2026 13:53:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI/pwrctrl: Do not power off on pwrctrl device removal
Message-ID: <sgxqu7oz7zoytjk6mtfnlrvyqjqjtk4w7jy2jb4iowfzxv7kly@2k2kgfsjcfdy>
References: <20260224071258.2654521-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224071258.2654521-1-wenst@chromium.org>

On Tue, Feb 24, 2026 at 03:12:56PM +0800, Chen-Yu Tsai wrote:
> With the move to explicit pwrctrl power on/off APIs, the caller, i.e.
> the PCI driver should manage the power state. The pwrctrl drivers should
> not try to clean up or power off when they are removed, as this might
> end up disabling an already disabled regulator, causing a big warning.
> This can be triggered if a PCI controller driver's .remove() callback
> calls pci_pwrctrl_destroy_devices() after pci_pwrctrl_power_off_devices().
> 

Also, we should add the devlink dependency as below so that the pwrctrl driver
becomes the supplier of the controller driver. This will prevent the pwrctrl
driver from being removed before the controller driver.

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 6f7dea6746e0..0c1cc9599b41 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -311,6 +311,12 @@ static int pci_pwrctrl_create_device(struct device_node *np,
                return -EINVAL;
        }
 
+       if (device_link_add(parent, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER)) {
+               dev_info(parent, "Failed to add device link\n");
+               of_platform_device_destroy(&pdev->dev, NULL);
+               return -EINVAL;
+       }
+
        return 0;
 }


Even so, the pwrctrl drivers should not power off the resources on their own.
So this patch is valid on its own. I just have one comment below.

> Drop the devm cleanup parts that turn off regulators from the pwrctrl
> drivers.
> 
> Fixes: b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power on/off, destroy APIs")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Hi,
> 
> I ran into this while integrating the new pci_pwrctrl_*() API into the
> MediaTek driver. I am sending this separately since this change is
> unrelated and does not conflict with or depend on the other changes for
> the driver itself.
> 
> I think this should be merged for fixes.
> 
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 12 ------------
>  drivers/pci/pwrctrl/slot.c               | 12 ------------
>  2 files changed, 24 deletions(-)
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
> index 082af81efe25..0ad920d8596d 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -59,14 +59,6 @@ static int slot_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
>  	return 0;
>  }
>  
> -static void devm_slot_pwrctrl_release(void *data)
> -{
> -	struct slot_pwrctrl *slot = data;
> -
> -	slot_pwrctrl_power_off(&slot->pwrctrl);
> -	regulator_bulk_free(slot->num_supplies, slot->supplies);

Here you are leaking the regulators as they will never get freed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
