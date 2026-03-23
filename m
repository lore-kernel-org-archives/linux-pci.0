Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ED5398902;
	Mon, 23 Mar 2026 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774267021; cv=none; b=snkwUMxZmci9Va3mH9pqW79CuNQQCNZkEYeFPWjJbKXyAtkKUPt9yoN97+QG3xFKuWBFFTS/pmmQSip20yhrq5azQkhtkGtPv5Jh9WGtSYSeWXOV80a+GM59raRadma730s3YWsBAw9/OQ/cH5z5De9LNi66XsvZRtstxpK+XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774267021; c=relaxed/simple;
	bh=DJBlhP0sPpweiQuDqLTtyjJpn0MdAi/2iD60MXs0y5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFbMez8r/0EWMCUP4YS7TFuKdHXyfEl05jQCz6qA8dSeqRTfzaTXUGNDJ6Mw7K2N2+6MvmtpKQ4/FuEk9qzuAJb1i2qBYz363bCPHH19/rOeyDcuKVs8+MoH0e6J6BxKQRrjjVo1LCDn7dJwGak4lN9tI9G/Cn7YJd2zJp4vAKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAAKv8R4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAAKv8R4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D5C4CEF7;
	Mon, 23 Mar 2026 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267021;
	bh=DJBlhP0sPpweiQuDqLTtyjJpn0MdAi/2iD60MXs0y5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAAKv8R4Lz0rzqQ4OGVro0zQA2x0DBMAlfMroPcLlhGFgPu2lm91exoRWUxsFF98G
	 SQlwMNtHTsrY67FWHWdC3QnpXzNU0ezSdx1N3AE8rzPMIqS7K9F6sdhwOix8tlQJ1K
	 P8Ai6Ht1ibU/RMSSgeZ30XIv0joT3M6RBamoD3U2Bqj1L4cT0XCWJJYzUzCPNVbQ5Z
	 cdq3BORt6qhIr1Z50iShYgYlA5K9VFT+6UxbQfYDUPi7tpBMtVc8+NJBraICmDWYMv
	 U3Oys6GMkUxsdmAQ0uFMm2Doz/2xUBI2tVlLlNRn3sHVWa8IQaIJp93FjHOCRztqAj
	 TAx/rjxkNSeQw==
Date: Mon, 23 Mar 2026 17:26:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Chen-Yu Tsai <wenst@chromium.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] PCI: mediatek-gen3: select PCI_PWRCTRL_GENERIC correctly
Message-ID: <wlu2o3hx6yvpzs54mxsf24gmqwwudkixx7aylv4dkey744yify@eufscwyqiyhk>
References: <20260323105520.461640-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323105520.461640-1-arnd@kernel.org>

On Mon, Mar 23, 2026 at 11:55:06AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The PCI_PWRCTRL_SLOT option was renamed to PCI_PWRCTRL_GENERIC, but a new
> user showed up using the old name, which caused a build failure when
> both conflicting patches are merged:
> 
> aarch64-linux-ld: drivers/pci/controller/pcie-mediatek-gen3.o: in function `mtk_pcie_remove':
> pcie-mediatek-gen3.c:(.text+0x137c): undefined reference to `pci_pwrctrl_power_off_devices'
> 
> Use the correct symbol as intended originally.
> 
> Fixes: ff124bbbca1d ("PCI/pwrctrl: generic: Rename pci-pwrctrl-slot as generic")
> Fixes: 073a7e1b7bcc ("PCI: mediatek-gen3: Integrate new pwrctrl API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Bjorn, should I squash this fix with 073a7e1b7bcc so that pci/next will build
properly?

- Mani

> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index e72ac6934379..686349e09cd3 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -222,7 +222,7 @@ config PCIE_MEDIATEK_GEN3
>  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
>  	depends on PCI_MSI
>  	select IRQ_MSI_LIB
> -	select PCI_PWRCTRL_SLOT
> +	select PCI_PWRCTRL_GENERIC
>  	help
>  	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
>  	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்
