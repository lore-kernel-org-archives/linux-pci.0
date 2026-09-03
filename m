Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E34B1B41;
	Thu,  3 Sep 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444290; cv=none; b=euSpBCPPfBhKa3nRUgqtdHpgcyt7facJNQupGw7ZO+Ty0aRq+9RXNT9PQbaBP8uLmz9sz514+TSjuujBx99QCOemdkeRdVvoMj6d7BrgZ0I4ERbyel5MADsObiWh2942oNjnvvAVlX8le1bT48WfV0xoZ3WuI4GaA7AsqSKQqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444290; c=relaxed/simple;
	bh=MZP6hP8rd91/K4S3Pn8MLF8V/Tt5zYIAnML3hUEtVbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGVkklC/lD2yd/XclNv7L0SPgVOURiXeILc3flm66MpdFRtlH3f3PVXRHYnMb0ILmXHManA5IUnQziuPzEL9sDlnE4ReY+He9vGrzT/idiDiSbXTnWAmPdlSVQsBtnqEeF7WfkcUlGPUAbC/y9mKirBgZytQ1SfwfSmrjmArFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP5K1Mwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP5K1Mwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B41F000E9;
	Thu,  3 Sep 2026 14:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444275;
	bh=g4mXt9iRVDXINxrOOrDAeMi6YhwipTD2z6eOlh/OfqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KP5K1MwlpnmNXBzYNaKiTl9Bddzh6L05dRYfsmH6J60wkql/+C0qWrgjwZPtflWD+
	 XBWH3AE17891s3puAiSnV0WiQ6zlAjPZTdx56Zn8pFuAAfHTh95eD6oePvf7YE4BW0
	 yCv9ia2nm81lCH8tmoZvbnvjRu7n74f66nIQLkLXkq1nhw4Pqvf14cfl31O3UGEO9p
	 5pmALcssc43PmkJj1KqkmFw3Nd2CEnuqOCzoOIDFUXIiSFLsXAfcpkblrVIzgFsi7q
	 j6qJiBFBvCLZnk+iUZGtFTZDelPlV0MHSHky9S/fOdBPTlswqebvrGlJJ+LfrBx7Uz
	 lu7yOBMTEeLiw==
Date: Thu, 3 Sep 2026 16:04:16 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>, 
	Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device
 support
Message-ID: <3nlsilckqt673fs2qikpnniius7gxwxfit2xbwldp5ac74objo@yr5yhp267f3r>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
 <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>

On Thu, Sep 03, 2026 at 09:52:59AM +0200, Lorenzo Bianconi wrote:
> The TC9563 embeds a GPIO controller used for per-port reset signals.
> Create an auxiliary device for it so the gpio-tc9563 driver can
> register the GPIO chip and enable DT-based GPIO lookups. Pass the
> tc9563 regmap to the auxiliary device as its platform data.
> 
> The downstream port DT parsing loop gains an of_node_is_type() filter
> to skip non-PCI child nodes such as the GPIO controller node.
> 
> The pwrctrl driver does not wait for the GPIO chip to be probed. The
> per-port reset GPIO lookup, returning -EPROBE_DEFER until the chip is
> registered, is added in the next patch.
> 
> Select AUXILIARY_BUS and GPIO_TC9563 in Kconfig.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

> ---
>  drivers/pci/pwrctrl/Kconfig              |  1 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 80 ++++++++++++++++++++++++++++++--
>  2 files changed, 78 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 1952ab4f29b6..38aab596aa04 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
>  	depends on I2C
> +	depends on GPIO_TC9563
>  	select REGMAP_I2C
>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index b0d8912690a2..6df512d78b54 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -4,11 +4,13 @@
>   */
>  
>  #include <linux/array_size.h>
> +#include <linux/auxiliary_bus.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -20,12 +22,10 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/soc/qcom/tc9563.h>
>  
>  #include "../pci.h"
>  
> -#define TC9563_GPIO_CONFIG		0x801208
> -#define TC9563_RESET_GPIO		0x801210

These definitions are still used in this patch and only removed in 4/5.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
