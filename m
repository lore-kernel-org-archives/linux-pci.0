Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161B155757;
	Mon, 23 Feb 2026 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856746; cv=none; b=hxe+n8ia4iAcc2L0sqRdjRJKIJNRzH89BD9micjwyvYMWiDs5AE7BpUfPD4YX3YFAY8MD0htOUybDd3mVKQxWNVEt65F8IwTRZ+senB0chWjLlV08yqCJAICk8W/NJi3lmBbsTQoiSC1g1WxbAJX1nmb7uAO1G1h9RkRh+mLHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856746; c=relaxed/simple;
	bh=0siPZjoiEG/WVbU9D5fahG6Mih3yK4ca+Qyvfb2Gnbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGjLGJhtRtgYBRgwato2O7ErhwQKmyUGzm4o/J/GQl2Hmles8jORTARkBGh99PNM7vpLx9Y81hrJpXwyvxRpMEaQho50Tu/uFkxkxt1jBCPLJ6xw2kdCL4RuxRNmQiw6vAz6m0zy+sLtAYP8W4k8cn7YX8lwirWKWpU8xQFxcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz0gWfmI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz0gWfmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B075FC116C6;
	Mon, 23 Feb 2026 14:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771856746;
	bh=0siPZjoiEG/WVbU9D5fahG6Mih3yK4ca+Qyvfb2Gnbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nz0gWfmIVrSFlYuOepXU7+2iPnu3YmfPyrLofnETKXb9ETBKAV7/8mGkzz9b7mATH
	 kIdj+n8HZ9qe/7n105z3X1Nim+oXachuUUmcGnh9MQxhvvMD3kmEGFH77+9rWhfXnT
	 sDLC5H7GdE00tLNZ6K3KwjDvgicZdH5l2m0tiaLqKtbHUSgr+ASiFbYYnYvdxKhOPE
	 AZi4CVOgepCxYETE/1rFz1bsjm91J35qSIKqKf2X2gbyEdkn3i1Rb5ch9LjXorqNmr
	 sk6Df7/MPxabKV5lh6YPYPtsp9xkmHc9E73UhQ/HO9sLnBBNyHF5+5N04cRFTRwsto
	 imSPQYnrenGIg==
Date: Mon, 23 Feb 2026 08:25:43 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] PCI/pwrctrl: Only create pwrctrl device if the
 device node is of type "pci"
Message-ID: <pkpyahwx2wmrefoxuhtdhuevu73qeuh4nfu6farvsko3l5t5ks@5l2ebkhz6xe4>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
 <jmy7rvoatiyvqjfhd27vqqbu64glnksyl23j2akrdb7iet3oqx@c5jxbrplubd3>
 <5qrvtbr2vnjp2qcopf3fgygto54lsma6bpz37hgjealbuso43u@ijolgjmtk2er>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5qrvtbr2vnjp2qcopf3fgygto54lsma6bpz37hgjealbuso43u@ijolgjmtk2er>

On Wed, Feb 18, 2026 at 05:54:58PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 17, 2026 at 12:09:56PM -0600, Bjorn Andersson wrote:
> > On Tue, Feb 17, 2026 at 03:48:47PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
[..]
> > > @@ -281,6 +282,9 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
> > >  {
> > >  	struct device_node *endpoint;
> > >  
> > > +	if (!of_node_is_type(np, "pci"))
> > > +		return false;
> > 
> > This "solves" my problem by no longer attempting to power on the
> > onboard_hub. But it also ensures that Neil's added μPD720201 power
> > controller doesn't power on.
> > 
> > This is based on the expectation that I shouldn't mark the PCI device
> > (the μPD720201) as device_type = "pci", right? (Doing so makes dtc barf,
> > but the μPD720201 is powered up, and functional).
> > 
> 
> Ah, this property is applicable only to bridges, not endpoints. So dt checker
> was right and I was wrong :(
> 

Thanks for confirming my understanding (about the property).

> > If this is incorrect, can you please help me understand how the
> > usb-controller@0,0 node should look like in
> > https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com/
> > 
> 
> Will the below diff on top of this series help? It checks for the presence of
> the 'pci' prefix in the device compatible, which should always exist for all
> kind of PCI devices including the USB controller and will be absent for the
> internal USB hub, which will have 'usb' prefix.
> 

It does look a bit crude, but it does resolve my issue. And I don't have
a much better suggestion at this time.

Regards,
Bjorn

> ---
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 7404d48427ce..7754baed67f2 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -272,20 +272,23 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
>   * Check whether the pwrctrl device really needs to be created or not. The
>   * pwrctrl device will only be created if the node satisfies below requirements:
>   *
> - * 1. Presence of 'device_type = "pci"' property to identify PCI node (AND)
> - * 2. Presence of compatible property to match against the pwrctrl driver (AND)
> - * 3. At least one of the power supplies defined in the devicetree node of the
> + * 1. Presence of compatible property with "pci" prefix to match against the
> + *    pwrctrl driver (AND)
> + * 2. At least one of the power supplies defined in the devicetree node of the
>   *    device (OR) in the remote endpoint parent node to indicate pwrctrl
>   *    requirement.
>   */
>  static bool pci_pwrctrl_is_required(struct device_node *np)
>  {
>         struct device_node *endpoint;
> +       const char *compat;
> +       int ret;
>  
> -       if (!of_node_is_type(np, "pci"))
> +       ret = of_property_read_string(np, "compatible", &compat);
> +       if (ret < 0)
>                 return false;
>  
> -       if (!of_property_present(np, "compatible"))
> +       if (!strstarts(compat, "pci"))
>                 return false;
>  
>         if (of_pci_supply_present(np))
> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
