Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56C3B0AEF;
	Mon, 18 May 2026 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143579; cv=none; b=jUra29SRgY3ByJ2yLgArCynbRh/A5+JLeXJSyJALjTcx+hE4hZPtrSqUx+3yZPXqrc2R4h5QmqJZowCMLosQmqkVyZffiRPWY6HZdTnSTU20pxmrzSgD4VoTQ2c1tz67NObnMcJgyGpvH2t7yoa0W0Lt1FnE0723NEX+bQtmOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143579; c=relaxed/simple;
	bh=+IWUc1gN0mMwA6sI+/kDeZiIv3JI+PnBx26Dc78J+3I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=drcJEuRVk4JL7mX+U1pFKLnCchAdofJu1l43cJjKu5zJJbKZcSBKq2/uTm0fy880teks2C1+wb/AUgAg5IDLd+/yB7z98UDPye2463iQ4ZLanoR7ag8G/nrQn6KcwH2xCQGXHVCDq0Li0is1y6sFn2evETejyPdkblOEuuePCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poM6meqC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poM6meqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE62C2BCB8;
	Mon, 18 May 2026 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779143578;
	bh=+IWUc1gN0mMwA6sI+/kDeZiIv3JI+PnBx26Dc78J+3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=poM6meqCoGbIFtYSyD/h8psv810rwZHdJm6hdEbw8OQHXYaFq3RF1Os+q+SHvbLha
	 XG58LHMqTXkGAQtW1ZmWA4e2Yo7/IVsxkQNrfZC4ALWE5IbAjr+06W3WearckLUiLw
	 YVGJE4DqQbJsc66bewMj3vk5O2KRV8NKsuaXLtXjHFX6RQk+xFiJc0pNERcnwM+ieS
	 gO/EdFpsQ+npNeQ/XycAZv9qhImocVuAM9NyFeENIZYBkxBGvnNurCh7mcUoerFsMD
	 p+UcK8tnAvuBhNZa9zx5EJAcMUrDW8MBn6eIdkfZ+bzGM0nQEebJbwjSGqBUc4FdyJ
	 u2jkExynXy0EA==
Date: Mon, 18 May 2026 17:32:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: lock device when calling device_is_bound()
Message-ID: <20260518223257.GA649247@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518100700.47581-1-bartosz.golaszewski@oss.qualcomm.com>

On Mon, May 18, 2026 at 12:07:00PM +0200, Bartosz Golaszewski wrote:
> The kerneldoc for device_is_bound() states that it must be called with
> the device lock taken. Synchronize the two calls in pwrctrl core.
> 
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied to pci/pwrctrl for v7.2, thanks!

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
