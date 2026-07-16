Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C4431A24;
	Thu, 16 Jul 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220489; cv=none; b=jgP1I/hHMkFe9KUwz1vuaKUOeHohNNPTaMU6yNQIVNST+7ChFfR7fdGyyfSpC4IopjAZUhNMs7RFkMRwI6lQ0FeJ1ZO0NBKE+5k4aox5QsoSxQMQcMQaxm7wkhkft6zYv5NMDYJfbY/ramdKNR4RThvqXP231kVK0GWvkA+4btQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220489; c=relaxed/simple;
	bh=wR6rS5THIP/BUvZicg7x93wFVajUXfxc51fcnvJYX/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3S6Y+SneJEnrgyE4tgG46Yf77zyMcYgLjvvKSDhB8SYOkhSuvRbkO/bTQ6jlM89hd0/NgFxCfQAkPafULrHI/Fj8GlpL0kyeivSX87FNNx5vZigN10Uc4ryupS4uA5n577tRxf3p4pXa5gba0v1aq2qrjeRmIaV5sSjwkEv1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epFFjXxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epFFjXxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F321F000E9;
	Thu, 16 Jul 2026 16:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784220473;
	bh=RX22eCKx40KnyZSuSQDcRALwWe4vFqqjZaopgJaY7K4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=epFFjXxXTih+AStQBEEqXuHL/Cd6Q+IkMrk11HRUXkqs8Jht6MrSG1MEzh0zvH4Me
	 80wt0polE1qvqU0eVOLH2T5rSUXuKhIKIw2ZqnzuoYyceR95lg7fuMXvmujuVBGy/l
	 DiFzNfSnO0qMDJ3YTe1ViNkop61v6W4CSFsTvkesO99Mp6HDg3gmR8CN+TrP6VbPHN
	 euCrbgFtgksJtlpZ71/nwI71PkZMngTCyVQbfbYXoFu6wNRZFyh+J3NfbVYueKB1Da
	 m9lna5ehpI+A+2g6mMjL7aKBTCdlwc9T1a5s6HKTa2tPEXCEoqRbWulDCd2QXNf5Lz
	 KOsApSGIxAxKQ==
Date: Thu, 16 Jul 2026 18:47:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Message-ID: <o3foffm4r4zgbybd3grhjkqs74aqu2s2nspj3oasliptbi2lln@nbq6zhoa3rvi>
References: <20260716132532.1565340-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்
