Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B745FFB7
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995037; cv=none; b=UUnpy6gD3tBZz9T0ySuRsZa+L2xMVfr/IWa38ukQptgO4dTdqqbicqNIuRWMUY3Ahca3Sgfs5IiJ6FzYq5ustRa7+0TYqdV5AfP2T42EOi6MyVUTVEI9oXadEz3fx39D1FLS7RY7Ofn3YNA2xjDnBYGtApEQTtklDASWNAGRSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995037; c=relaxed/simple;
	bh=cr0upiaATQA1LERxt8NucOZ1hwb2sg2RFfXOMHbu+38=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OO94/tF7lw+SqHpwL3hGDUhphZE0MVfhpT07BWx9DXmXmfStRBqAjz5nvO8Ybqf4Z5vz2hC8AlfDtinWKsCDlwl8TaSFLyQRhz/UbDEEjjJQ2H2dfznQAj7b3qOn+CG1c5WJMaZCI+7SQHZtF3TXx9gM0BE1ozPaQ7JSlI5GE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFqQYAZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFqQYAZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900DE1F000C4;
	Wed, 14 Oct 2026 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791995034;
	bh=YZKwDKWpJj1fghE3DAlKDWqQPW93MhHWZCSpuESKBec=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=cFqQYAZvFXkGnAIlkEwHFxrNI6kiHc5Dv7LmhxvCAkBqlXywfHRe2hro/p+GKE7ZM
	 JVnrbmtJ7BvCf4R+vgR+LBzPlXbnURZCsIXsj2Nsc8hcREehH0luO01wggTwA6zN1W
	 pXoFzYSK4ec+GliJAa3CLH9l9RHP6stqcp3YUcWBdoJgyintAgyMgZ/ki6Cq20Bxo3
	 akUypURkYASGFl5r+Hk9WR1/flHVhpX0WYSS5NcKZnLYb2idL+NgxVyqHjeQjIdkBK
	 QN4cKtoLDkxxC4iFQiIM4VBMrS2+bPwhix0vq1oN9mA+KwvGfJCgoQt9RNDqDk4BtU
	 qVwkClDBYT1xw==
Date: Wed, 14 Oct 2026 11:23:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Power off child devices on power-on failure
Message-ID: <20261014162353.GA1635048@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:28:29PM +0200, Lorenzo Bianconi wrote:
> pci_pwrctrl_power_on_device() recursively powers on the child nodes
> of a device before powering on the device itself. If powering on a
> child fails (e.g. returning -EPROBE_DEFER), the function returned
> immediately, leaving the sibling children that were already powered
> on in the same loop iteration enabled.
> 
> Since probe deferral is a standard boot path, this leads to unbounded
> regulator and clock enable increments across retries. The error path
> in pci_pwrctrl_power_on_devices() only powers off the top-level
> children processed before the failing one and explicitly stops at it,
> so it can never clean up the siblings leaked deeper in the failed
> subtree.
> 
> Power off the sibling children that were successfully powered on
> before a child fails, and power off all children if the device's own
> power_on() fails after its children were already enabled. Switch to a
> manual child iterator so the failing node can be tracked and its
> reference released in the error path.
> 
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Applied to pci/pwrctrl for v7.4, thanks!

> ---
>  drivers/pci/pwrctrl/core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 10d817aefb09..d29cd506972d 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -252,14 +252,16 @@ static int __pci_pwrctrl_power_on_device(struct device *dev)
>  static int pci_pwrctrl_power_on_device(struct device_node *np)
>  {
>  	struct platform_device *pdev;
> +	struct device_node *child;
>  	int ret = 0;
>  
> -	for_each_available_child_of_node_scoped(np, child) {
> +	for_each_available_child_of_node(np, child) {
>  		ret = pci_pwrctrl_power_on_device(child);
>  		if (ret)
> -			return ret;
> +			goto err_power_off;
>  	}
>  
> +	child = NULL;
>  	if (!pci_pwrctrl_is_required(np))
>  		return 0;
>  
> @@ -279,6 +281,19 @@ static int pci_pwrctrl_power_on_device(struct device_node *np)
>  
>  	platform_device_put(pdev);
>  
> +	if (ret)
> +		goto err_power_off;
> +
> +	return 0;
> +
> +err_power_off:
> +	for_each_available_child_of_node_scoped(np, tmp) {
> +		if (tmp == child)
> +			break;
> +		pci_pwrctrl_power_off_device(tmp);
> +	}
> +	of_node_put(child);
> +
>  	return ret;
>  }
>  
> 
> ---
> base-commit: 028f86457e822ab9de5b0d6d23efddc1b8b54ae1
> change-id: 20260908-pwrtctl-power-on-rallback-5c6364b080ce
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> 
