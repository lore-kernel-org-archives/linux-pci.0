Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606648;
	b=zsb2cTg07Euf+MNYV8tPunO10k+yAsyzk7kpledLci/Ji7raAJ9O4XQIF9a8df0JlUiZ
	 0mg6cNtayY8egE17LCVVFlWuacVB3mWd2U4jvWr7l1uJhmeL/jE0culVEEgL7YnpnBdWl
	 GdaYqlhtL8bfhE2b+99wKZaZuwaTvStAOsCnmayCJuxJu7ZsoEU7yp9DvXg+/jpNjff/h
	 mFWwA0oh9QPuOqUKBahxZNn48MbON+3Q1OOfIpbbfjlwzhpMSqJTk9wUk9iLBfBLeSkoA
	 7oo0VUkAm0bc/ZLjyqGqaW+jfewjp7x9Vf36GChOOczbAr4gY2woqjooWOHpeYvbjfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606648;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tj1Qy+WELiB2+JyCp1rXeDB//3sKvCYuZ5PGK0F7UYY=;
	b=1P4MOnt7aWU7nMpdl13/T7tgshYRLAiqRQW4znTSIPjYslDIDpDycRkmfQ+/PWGCqpVk
	 K6BEV+04uXSp6ftqJYypkhOuNF9XdXEwj2CdKTV0UVSnAgMMrqh6IjFEtMcVRjLJMOqA5
	 frz/qcEMPLWx3OcIDYsN6cBPdFcnotMoFKGN1gSvJ09xdS8h72ZNiSRMROEhUZ1Mctbcp
	 Cx+yc7EqQiDHEX7m1KuTwMU44uYCdsE9/SiVD6Gj3KM+85m8DxXLzMCexFFcCsIaE04F6
	 srb2e2Ktm3bXgS8Zr3qUeD6fDxcxHkGtVe+QQbLEJZ3kJgwq7gdkXc8k/WW+HDjIa6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMI2PE8V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87A606A31A;
	Wed, 21 Oct 2026 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WMI2PE8V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160361F000C2;
	Wed, 21 Oct 2026 18:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792606647;
	bh=tj1Qy+WELiB2+JyCp1rXeDB//3sKvCYuZ5PGK0F7UYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WMI2PE8V6M2jaQDdQxIYAOWLL3DBPW7CikblLNAaA4JiiFzlTawgsz0xIbmR06oKW
	 +5lnRhS0xC1CcAlhQRNCKHph4UJEcoiQGbsI84OtsCuaBbpRBHm+Uzjq/qRB7bo7xQ
	 jCMhvyXZR2hgEmmGwXAuVSPqDj/FZ7wTi6OVdz0bKB6vrjtGgprZQf/U78gYarEE3r
	 N28gARSwyYEjinEzvr0mKVsS9CFSjfTOtbkZHW7gcIF/vMeMda/a9mgDIVA/oMcCRL
	 eQemNDFXuWNXzSUlmkdhYsvDVQuf8V2PtUEyWSQtcOoFg78FVt6VO65WrBoIcOWbyT
	 4PrWZ+yaO0Ihw==
Date: Wed, 21 Oct 2026 13:17:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2] PCI/pwrctrl/gpio: Correct GPIO_TC9563 /
 PCI_PWRCTRL_TC9563 dependency
Message-ID: <20261021181725.GA2498006@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>

On Wed, Oct 21, 2026 at 11:23:52AM +0200, Geert Uytterhoeven wrote:
> The Toshiba TC9563 GPIO controller is embedded in the Toshiba TC9563
> PCIe switch, and its auxiliary device is instantiated by the TC9563 PCI
> Power Control driver.  Hence make GPIO_TC9563 depend on
> PCI_PWRCTRL_TC9563, to prevent asking the user about the GPIO driver
> when configuring a kernel without TC9563 PCI Power Control support.
> 
> Drop the dependency of PCI_PWRCTRL_TC9563 on GPIO_TC9563, which
> represents the inverse and wrong relationship.
> Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS, as this is no longer
> guaranteed through GPIO_TC9563.
> 
> Fixes: eea9a072221d97ab ("PCI/pwrctrl: tc9563: Add GPIO auxiliary device support")
> Fixes: 81ec9c22d06aea92 ("gpio: tc9563: Add support for the embedded GPIO controller")

These are still pending in pci/pwrctrl, so I squashed these fixes into
those commits for v7.4.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS.
> ---
>  drivers/gpio/Kconfig        | 1 +
>  drivers/pci/pwrctrl/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5d3f076c539b3a64..c5556b1638b8c113 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1893,6 +1893,7 @@ endmenu
>  
>  config GPIO_TC9563
>  	tristate "Toshiba TC9563 GPIO support"
> +	depends on PCI_PWRCTRL_TC9563 || COMPILE_TEST
>  	default m if ARCH_QCOM
>  	select AUXILIARY_BUS
>  	select GPIO_REGMAP
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 38aab596aa04b8b1..a2fc2a359702e861 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -29,7 +29,7 @@ config PCI_PWRCTRL_TC9563
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
>  	depends on I2C
> -	depends on GPIO_TC9563
> +	select AUXILIARY_BUS
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
> -- 
> 2.43.0
> 
