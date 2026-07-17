Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E11926FA4B;
	Fri, 17 Jul 2026 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307524; cv=none; b=bUapgHg0t4EcM9kcCZbnpYKsS/ATnf1SV3/9mrJ8wwSz4dlBUmXg9qwFtcPcFopiJWUfG6f1XVDsD6sFvsACW58C4vKrKIBA4OhV/J77k9y5V4kBaT5RI+rJiBjyiXHqUAJUFCGUjnr0u19+2l2FEF+IOICS22cbdT2wmaV1a9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307524; c=relaxed/simple;
	bh=DUHDxqYIzuMPPS2oEyjRN/vXlo6oeD0VMnQ2EWnKft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6VC84QDNmxQj68FvTXLk4SgvJSlVD4CxtH3U6NERpqiAxcCm8H9mUgodXyDgmxqSpk/DLcISxv4YZXTJLfmVTQclhlbbsSIEVZt2EIR28TIDuUugggDqDkqf0x3LHdf5yvLAvJBCcQMe3jOmz25Zo9ti0+O0Ij9puoDwr96fvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwWMRw/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwWMRw/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C2F1F000E9;
	Fri, 17 Jul 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307523;
	bh=mSAlIOm6RegCqS6Ohwmv9taY86qckErOhF1j3XL/clQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JwWMRw/PGYNBicKXiXQS0q62FK6WsUuvkG6e+TX6K5mhT0UvXNyxV/tialJ+3d+St
	 jr1HX+eGE2l+sFcjWoM7vjMMHqA1SwMFC2i0vEP59GjdVFQURphuU9A4fzGsksnW2T
	 zcqQ5nV0/uYNx1DRRZ+m5xgVsizUsGp2HLQUXweOPomuaC+xqnil34OkrqeBtyj6sg
	 tVzKqJb4D353yAv1X81ySuSDxn/2LviX7Ta0Q/SPlU2xOc9jjbdfCuY/NFfGsxs++y
	 +YHklkuxWOrIi/hOEYW/AhSP7MBqdHcMt6sLiZRNZw/SGNZVZI9xHwfbW9NGBkodYC
	 JM6O+AWQd1ChA==
Date: Fri, 17 Jul 2026 11:58:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Message-ID: <20260717165841.GB11343@bhelgaas>
References: <20260716132532.1565340-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716132532.1565340-1-johan@kernel.org>

On Thu, Jul 16, 2026 at 03:25:32PM +0200, Johan Hovold wrote:
> The i2c subsystem currently blocks during adapter deregistration
> whenever there are consumers holding a reference.
> 
> Switch to using of_get_i2c_adapter_by_node() which also takes a
> reference to the adapter module so that an attempt to unload the module
> while in use fails gracefully instead of blocking uninterruptibly.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied to pci/pwrctrl for v7.3, thanks!

Gemini suggested minor commit log rewording, let me know if it makes it
worse.  I do like the impact being mentioned in the subject:

  PCI/pwrctrl: tc9563: Avoid uninterruptible hang on in-use I2C module unload

  The I2C subsystem blocks during adapter deregistration if there are
  consumers actively holding a reference.

  Switch to of_get_i2c_adapter_by_node(), which also takes a reference to the
  adapter module, so an attempt to unload the module while in use will fail
  gracefully instead of blocking uninterruptibly.

> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 1555e8a9b3ca..e6a8abd9da8e 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -548,7 +548,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
>  
>  	i2c_node = of_parse_phandle(dev->of_node, "i2c-parent", 0);
> -	tc9563->adapter = of_find_i2c_adapter_by_node(i2c_node);
> +	tc9563->adapter = of_get_i2c_adapter_by_node(i2c_node);
>  	of_node_put(i2c_node);
>  	if (!tc9563->adapter)
>  		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
> @@ -556,7 +556,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	tc9563->client = i2c_new_dummy_device(tc9563->adapter, addr);
>  	if (IS_ERR(tc9563->client)) {
>  		dev_err(dev, "Failed to create I2C client\n");
> -		put_device(&tc9563->adapter->dev);
> +		i2c_put_adapter(tc9563->adapter);
>  		return PTR_ERR(tc9563->client);
>  	}
>  
> @@ -624,7 +624,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
>  remove_i2c:
>  	i2c_unregister_device(tc9563->client);
> -	put_device(&tc9563->adapter->dev);
> +	i2c_put_adapter(tc9563->adapter);
>  	return ret;
>  }
>  
> @@ -636,7 +636,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
>  
>  	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
>  	i2c_unregister_device(tc9563->client);
> -	put_device(&tc9563->adapter->dev);
> +	i2c_put_adapter(tc9563->adapter);
>  }
>  
>  static const struct of_device_id tc9563_pwrctrl_of_match[] = {
> -- 
> 2.54.0
> 
