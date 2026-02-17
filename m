Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA711A317D;
	Tue, 17 Feb 2026 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351799; cv=none; b=q9bYFHOG851iYuUW/Nj/wCKYRUdFjbDzezvzYNwcpw371hEhQ+L2/UZZB6iuOGwj++IrQJGeworhyKfa8dGMiG0lOIBBzgjKlY2uO+fFcwObljs/o0YH/8rZw/kl6Y5tK3GYG+T42dx31Eguo0EhKzdMAseEdfocSpZ4AFah9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351799; c=relaxed/simple;
	bh=NaoDLfmTaxs/N1GB34EEql1MFaxLE8IQ8fe/MwDgm2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaTuHBURf+FGWCGWpBjcvYGSmsj50Sqg9gJ0471DzD0AvBZbaAVW6i+O08GSscUX8GorKsgvZbXuSPTqdLJ+Gbswu5RUz6B/MoDljy81/JWlz23Y7jH9I+zIjQ2+bYdnIt060yWVpA4tSrA1wPD+9fF/jM1zrrzE2+fCXPVNvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKhLOm9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKhLOm9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923DAC4CEF7;
	Tue, 17 Feb 2026 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771351799;
	bh=NaoDLfmTaxs/N1GB34EEql1MFaxLE8IQ8fe/MwDgm2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKhLOm9CfWyfDy/SNQrhAAqeVMc4Zbn2BTIvi6JgFfIokzCl5Yvkf4eKPqTthmM1B
	 aA3CwgxckINN5vdBPi1WowveecpoSumJiuTH9RF32rZYslUCikIMDT0lLrTcOO3Zyi
	 44+x8OMacfxm8u9RZHukZZJg3XnvM36GDugoG6lBta6ZAoASJmZtEIw4TduxbWckKh
	 ybeHLa58fQn78nQgX1/eyCY0kI9z+yniOJ0xp5Su/6NV9HtZGk5jmPSsqGqfcNIxFf
	 inhItfD3getqHs6yHh+sXdu+pK4oc5fKpIKXTwIxN6OX6i1NSO++mIsMDwzl/zTzuW
	 q9C9JNssm+UfA==
Date: Tue, 17 Feb 2026 12:09:56 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI/pwrctrl: Only create pwrctrl device if the
 device node is of type "pci"
Message-ID: <jmy7rvoatiyvqjfhd27vqqbu64glnksyl23j2akrdb7iet3oqx@c5jxbrplubd3>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>

On Tue, Feb 17, 2026 at 03:48:47PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The PCI host bridge node can have non-PCI child nodes as well, like OPP
> tables, USB controller node etc...

Yes, but the usb-controller in my case is a PCI child and should be
pwrctrl'ed. The entity that I don't want pcictrl to handle is the HUB
child on the USB bus.

> So the pwrctrl core must check for the
> presence of 'device_type' property with value of "pci" to ensure that the
> pwrctrl device is only created for PCI device nodes.
> 
> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
> Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 8325858cc379..7404d48427ce 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -272,8 +272,9 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
>   * Check whether the pwrctrl device really needs to be created or not. The
>   * pwrctrl device will only be created if the node satisfies below requirements:
>   *
> - * 1. Presence of compatible property to match against the pwrctrl driver (AND)
> - * 2. At least one of the power supplies defined in the devicetree node of the
> + * 1. Presence of 'device_type = "pci"' property to identify PCI node (AND)
> + * 2. Presence of compatible property to match against the pwrctrl driver (AND)
> + * 3. At least one of the power supplies defined in the devicetree node of the
>   *    device (OR) in the remote endpoint parent node to indicate pwrctrl
>   *    requirement.
>   */
> @@ -281,6 +282,9 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
>  {
>  	struct device_node *endpoint;
>  
> +	if (!of_node_is_type(np, "pci"))
> +		return false;

This "solves" my problem by no longer attempting to power on the
onboard_hub. But it also ensures that Neil's added μPD720201 power
controller doesn't power on.

This is based on the expectation that I shouldn't mark the PCI device
(the μPD720201) as device_type = "pci", right? (Doing so makes dtc barf,
but the μPD720201 is powered up, and functional).

If this is incorrect, can you please help me understand how the
usb-controller@0,0 node should look like in
https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com/

Regards,
Bjorn

> +
>  	if (!of_property_present(np, "compatible"))
>  		return false;
>  
> 
> -- 
> 2.51.0
> 
> 
