Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC631716E
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551856; cv=none; b=ldHA7OUzW5umaIYIbU2LW054LZlYd6bdONg3L+wrX1tvDZl6XuV+MhRU0WGh/q3gkrtXUVMrBp3lUY87icKio//r9AqdHK3Zr/vxLpdg2bTL7YOajz7noYSwdDM/UC7qmLNI/vhfPW4DzRFR6AzmIGdwf+NHG5b+6i5Y8y6VBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551856; c=relaxed/simple;
	bh=wc7FCP8WORYw2lNoc35F37YWJ7YSmYOF+dnbTHTVOS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNBwnPdc7B8enxvB557OREel36SDbk1p1UaluTEo33+eb2l0pa5TZWoPWeIEtR2lN1rBX5B3k0yMrVV0r7Z3l7YN0/pluoxHs0uLjnpYJQEBRe6IBuiD9hKLMAVSkSWEvVUuMeeLA9rsQyXw+S9r7bWWMnFG6ZI2K6M3y92z62g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRNtOC/Y; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRNtOC/Y"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13721dfd471so4153578c88.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781551854; x=1782156654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4IpH5LEDaSFvAvPiFPbj5ZjEkRtPbLsUPqVa2w6YN4=;
        b=hRNtOC/YYaAi+8E8S61K3rjmSiWqJlAWvx7YxNE4ZCJuiArnmTMQlGPC9293sUNSM4
         I1uqbAhD7UfAnLTlDKzvNy33EQJQ2Z7kwIjNDzCY8sYHd92EzMs48NiK77tix+T6/lcl
         vsh+VjBw0c5kmFmvwSOQURvf1EAR1Box1T7xTy6utiE4T/QE4YQFS5nCfOIAL1vEbn5G
         fk8eAadN/y58nTv1tGKbq+8rZwddh8qz9eODRJgnH23lmcB6kqNFOUIeSy6utqwqrnCY
         8nDc3pwg9RrwP5rPhLkAP+Gt0PdAacO5jKGWik6l1Nf7OzQtSseK9MaMmsmsTGa239L5
         BfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781551854; x=1782156654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4IpH5LEDaSFvAvPiFPbj5ZjEkRtPbLsUPqVa2w6YN4=;
        b=E0i5o/xIgCl55cNViFPtTQItcq0HJjq8MJAUsrd5Y6+cjwJakMdQeXGaS6YC3Ul5a8
         zg5QKmCW9kON8wMpvo7UoFsMyPVLhlZa9wERtkHISxmhO7/GK9y8VyTOXh0Nl5CcflxX
         3qMya7+pVOLMLBUyzK4JLuJLYb60PP9mjGFXRJ2g244aRGMNsWeuBvJRFeNgS7yGcUy7
         kqO4JCErSxf31HjyoFpVsAPGIMc0byvnXP9D7vqm5uSX34pG7UlIyqXWUWV8V92tpI0U
         qy7SaGpszIAS5Z2j+slIhv91Xei5EEoSqCiev3AINERAL3KY3W/X0oRqOq7k4pA0f88b
         Ru5g==
X-Forwarded-Encrypted: i=1; AFNElJ/McO0JmsXbblV9VnaZc1MXKrmsiIKWAJJ74KjfilbwX8W2HwMh4UAU7dIqNgAdEUQCLmYy9Z+V5Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WYl3sbd8S9coSqQIoWakpcZ5DZBfaFctlzeVXOdnglKOTDfv
	V5ZHJqAUuCNNwXFAyYCwT50MQEFpMXgVzxfVEN2IILAkiLX+1h0h6iF6
X-Gm-Gg: Acq92OEM8Dnj+6wE/zfiMEkhXGNumX7yCJiLWEA7QvRf2uk0E61gY7RIw16a2ztj0fO
	WPx+T30unfNC2XkLvzgBHSoKoSvvHm1KmVj8bblE61jvhD6fqO/8H3iwUYtLjehx2qB/Rs2o5pE
	v+IKDc8oct4NCxm1WqYYEtiF5Khkspnm2V9xdJU6SBvAnS313ikW9xJ/eyaqj3Pyptp93hsHnMO
	WxnEwaffMndEv9PHY2TI6BYeSSQ8Xz8xnNWNOtKQ1YV6KueGLuC3GhI0k7jI714Bvbp7KHMDxJs
	GtNvAaNmzSttOp89ZLJ4s2G2O8hOPt25nBvtY68Z/06sGm73XbQF9VvVMicrJZRccKBap7hMqNs
	vA6evVUST/y/HWFIl6YoPlcZgGiW5/u/X1NsGqNZlLD9wm+gVrWWwb5Er6Tak8ZzEBJVlXbWfya
	hwJVI5j+09T6fnm8mSn4wJ
X-Received: by 2002:a05:7022:60e:b0:136:e639:9c22 with SMTP id a92af1059eb24-1386f39567dmr5125138c88.21.1781551853685;
        Mon, 15 Jun 2026 12:30:53 -0700 (PDT)
Received: from geday ([189.115.92.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97570asm10735958c88.12.2026.06.15.12.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:30:53 -0700 (PDT)
Date: Mon, 15 Jun 2026 16:30:38 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] PCI: rockchip: drive at 2.5 GT/s, error other
 speeds
Message-ID: <ajBS3tGp0wqLyVq7@geday>
References: <cover.1781207474.git.geraldogabriel@gmail.com>
 <4ac5cd7d2271df375ed6307f5c394247721395d9.1781207474.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ac5cd7d2271df375ed6307f5c394247721395d9.1781207474.git.geraldogabriel@gmail.com>

Hi,

On Thu, Jun 11, 2026 at 05:04:22PM -0300, Geraldo Nascimento wrote:
> Configure the core to be driven at 2.5 GT/s Link Speed and ignore
> any other speed with a warning. Also drop the 5.0 GT/s Link Speed
> defines from Rockchip PCIe header.
> 
> The reason is that Shawn Lin from Rockchip has reiterated that there
> may be danger of "catastrophic failure" in using their PCIe with
> 5.0 GT/s speeds.
> 
> While Rockchip has done so informally without issuing a proper errata,
> and the particulars are thus unknown, this may cause data loss or
> worse.
> 
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
> 
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> 
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 16 +++++++++-------
>  drivers/pci/controller/pcie-rockchip.h |  3 ---
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 0f88da3788054..5a2876d7c8547 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -66,8 +66,10 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	}
>  
>  	rockchip->link_gen = of_pci_get_max_link_speed(node);
> -	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
> -		rockchip->link_gen = 2;
> +	if (rockchip->link_gen < 0 || rockchip->link_gen >= 2) {
> +		rockchip->link_gen = 1;
> +		dev_warn(dev, "invalid max-link-speed, limited to 2.5 GT/s\n");
> +	}
>  
>  	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
>  		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
> @@ -147,12 +149,12 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		goto err_exit_phy;
>  	}
>  
> +	/* 5.0 GT/s may cause catastrophic failure for this core */
>  	if (rockchip->link_gen == 2)
> -		rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,

Sashiko caught unreachable dead code rightfully here. It looks like I
had got it right in v4 and then the fix regressed.

Will address this for v7 after I get more comments.

Thanks,
Geraldo Nascimento
