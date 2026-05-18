Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05F23EBF04;
	Mon, 18 May 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100188; cv=none; b=nmgplg1DN3hmdRnolfzxYECS084uTwzvT2nCQOy3bjum5TTwJAsuKsicpiTZT3S1f2AdWAZRPz2oNeb7Ka+uwrnzl7fM6mWSW8I0LjkYV5BxJluEJIX/YkCWJGdD+TI2niIvbjjeHCW82OZBgq35sz+Ty+ZtVwG9lh1fRS0iqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100188; c=relaxed/simple;
	bh=b5XaSFM4Gu7wo+De12pHlflAfIst6aIF3A0eU6HrYMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpZLxGFuaOAMbK+q2qbl/EZ2/gNJiNt78P5KAb53JhT16U3ycAqhNUsYsfvRg1e2XAnGkfTOuPh12KWEW2ry+lglghLDDQS1P76yvY2d47lOmAc5YIQeJvQYef+DRJv+Q8SiNzfBpzEkW0XY7d91RiwvleEyT4l9eshor4wZsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHhKr2rm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHhKr2rm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07FDC2BCB7;
	Mon, 18 May 2026 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779100187;
	bh=b5XaSFM4Gu7wo+De12pHlflAfIst6aIF3A0eU6HrYMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHhKr2rmQGrEPC+PnWEL+0ZaW1Qhz5z3yVy3ZhMfbNJZzZ6zOhwd8qCdOSCpi+Y2/
	 JYcYj3JgsIe9DrXuxLB9zS0i1HEpgHtFtI3TTGGJRiF6JVc2KHj5F5M0rGUEGfiHcO
	 NnQdQ09Hr665MY02lj9j9ANuYB5td+X7mIOJdvTc+xp8h6FukCbh/y/TDdN2AoKihQ
	 ahnWYeniNCKLGfqsBz1osLtk9O6LiqFj7jcSJZXj9zX20zk9KG6kCTGbOSZPVmPtVk
	 QtV70ZjuWFFhCu+5U4hBloAgiWtaMKsLBydsnpRLLttQhCMdFVnAH2eZRbUQqaquJz
	 ZMlONAJV89E3A==
Date: Mon, 18 May 2026 15:59:36 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: lock device when calling device_is_bound()
Message-ID: <4oz6tpma3be53kn4ndtsabcudl7ln2nzbzutcdf6idolkddwct@v4k4k6bua3l5>
References: <20260518100700.47581-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260518100700.47581-1-bartosz.golaszewski@oss.qualcomm.com>

On Mon, May 18, 2026 at 12:07:00PM +0200, Bartosz Golaszewski wrote:
> The kerneldoc for device_is_bound() states that it must be called with
> the device lock taken. Synchronize the two calls in pwrctrl core.
> 
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/pwrctrl/core.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 97cff5b8ca88..cd08d590483b 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -161,10 +161,12 @@ static void pci_pwrctrl_power_off_device(struct device_node *np)
>  	if (!pdev)
>  		return;
>  
> -	if (device_is_bound(&pdev->dev)) {
> -		ret = __pci_pwrctrl_power_off_device(&pdev->dev);
> -		if (ret)
> -			dev_err(&pdev->dev, "Failed to power off device: %d", ret);
> +	scoped_guard(device, &pdev->dev) {
> +		if (device_is_bound(&pdev->dev)) {
> +			ret = __pci_pwrctrl_power_off_device(&pdev->dev);
> +			if (ret)
> +				dev_err(&pdev->dev, "Failed to power off device: %d", ret);
> +		}
>  	}
>  
>  	platform_device_put(pdev);
> @@ -205,7 +207,7 @@ static int __pci_pwrctrl_power_on_device(struct device *dev)
>  static int pci_pwrctrl_power_on_device(struct device_node *np)
>  {
>  	struct platform_device *pdev;
> -	int ret;
> +	int ret = 0;
>  
>  	for_each_available_child_of_node_scoped(np, child) {
>  		ret = pci_pwrctrl_power_on_device(child);
> @@ -217,12 +219,14 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
>  	if (!pdev)
>  		return 0;
>  
> -	if (device_is_bound(&pdev->dev)) {
> -		ret = __pci_pwrctrl_power_on_device(&pdev->dev);
> -	} else {
> -		/* FIXME: Use blocking wait instead of probe deferral */
> -		dev_dbg(&pdev->dev, "driver is not bound\n");
> -		ret = -EPROBE_DEFER;
> +	scoped_guard(device, &pdev->dev) {
> +		if (device_is_bound(&pdev->dev)) {
> +			ret = __pci_pwrctrl_power_on_device(&pdev->dev);
> +		} else {
> +			/* FIXME: Use blocking wait instead of probe deferral */
> +			dev_dbg(&pdev->dev, "driver is not bound\n");
> +			ret = -EPROBE_DEFER;
> +		}
>  	}
>  
>  	platform_device_put(pdev);
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்
