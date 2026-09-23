Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AD370ACC;
	Wed, 23 Sep 2026 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189566; cv=none; b=q5uL/oz7hlRzyoaymffAdE2HzQzmyiioS0H6qPylkUBOvOG9Ymsh9qfuUtielOEl33umKRzMAvtoaOS1vM6S72LDWFjafOps2kZuRQ2qAkqNnV9rCGm+jII22GLJ+CFQJJBND8pSmeFQYj8CEwBvERqZoiOQbGxYTl42jdfBC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189566; c=relaxed/simple;
	bh=35ME+KHJOJ3T8ySbGO9/Y3YfVXa1Z21Xuo8ylMXkhZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cvY/c6XG5ITN+wA0CXIMHOrzYHbl1bkFdFa8gI8ecfdCh6rMJOTSraxp9t85V2ZekMJZwSIz2BwgNXU2Gj1PeGm0zTCKO24aO4k1UD6vRwD/rN5SxkbN8NLuYLqeWcsPruVmNICRqFUdKo9m5cV/yoZPWfM2umEPyVS044XpTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbuBunoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbuBunoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B3E1F000FF;
	Wed, 23 Sep 2026 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189563;
	bh=lOM8/aFV+DNUfDB5GGjCMMOwWBC4e3sAZlhqh2z2aWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jbuBunoJmVgwv+WcbdhUYrhuqtSXAfK18ezP6A+r7MRnBawfYesVrBbjVJ7UATTar
	 mV6Pgll2l7t1XYLdOdCRAR6t124trAo10dPsiuv9YpX0Tw+GOesFNrHOR4M4tcu1SG
	 7KFHBhbuz7/p3YeIGNuQ964hOAS66BVrE6bGiiMEvYhotzjy181aGPAVZ80hBZnZhr
	 drLa5whp8WEtC7md9abZ4ZN1Hk8rv5TI9/1KjeUM1vqYMT0b9cYutheFWD2MDU1fJn
	 blYz63Wq5oI/9ESwS8Lguxl490cVAjAj2alKOxgxL4YLtZ1O+iB9foB/bBOlnYprqH
	 KAfK1Heb0NCJQ==
Date: Wed, 23 Sep 2026 13:52:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Alex Elder <elder@riscstar.com>,
	Daniel Thompson <daniel@riscstar.com>,
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Message-ID: <20260923185242.GA1909536@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-pci-tc9563-aux-v5-2-c9b33f56c8d3@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 04:55:54PM +0200, Lorenzo Bianconi wrote:
> From: Alex Elder <elder@riscstar.com>
> 
> Add a driver for the GPIO controller embedded in the Toshiba TC9563
> PCIe switch (and the Qualcomm QPS615). The device implements 35
> GPIOs using two register banks: three registers control the first 32
> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
> GPIOs 22-24, 27-28, 31, and 34 are input-only.

Patch [1/5] and a comment below mention 37 GPIOs, this mentions 35.
Are they supposed to match?  Maybe 35 doesn't include the two reserved
ones?

> The driver is registered as an auxiliary device driver. The TC9563
> power controller creates the auxiliary device and provides a regmap
> that gives access to the GPIO registers, so the gpio-regmap helpers
> are used to implement the GPIO chip.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/gpio/Kconfig            | 11 +++++
>  drivers/gpio/Makefile           |  1 +
>  drivers/gpio/gpio-tc9563.c      | 99 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/tc9563.h | 16 +++++++
>  4 files changed, 127 insertions(+)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a48586bb8edb..2179eaffcc48 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1830,6 +1830,17 @@ config GPIO_LTC4283
>  
>  endmenu
>  
> +config GPIO_TC9563
> +	tristate "Toshiba TC9563 GPIO support"
> +	default m if ARCH_QCOM
> +	select AUXILIARY_BUS
> +	select GPIO_REGMAP
> +	help
> +	  This enables support for the GPIO controller embedded in the Toshiba
> +	  TC9563 (and Qualcomm QPS615).  This device connects to the host
> +	  via PCIe port, which is the upstream port on an internal PCIe
> +	  switch.
> +
>  menu "PCI GPIO expanders"
>  	depends on PCI
>  
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index dc9e6d643b5b..792faa2668c9 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -182,6 +182,7 @@ obj-$(CONFIG_GPIO_SYSCON)		+= gpio-syscon.o
>  obj-$(CONFIG_GPIO_TANGIER)		+= gpio-tangier.o
>  obj-$(CONFIG_GPIO_TB10X)		+= gpio-tb10x.o
>  obj-$(CONFIG_GPIO_TC3589X)		+= gpio-tc3589x.o
> +obj-$(CONFIG_GPIO_TC9563)		+= gpio-tc9563.o
>  obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
>  obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
>  obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
> diff --git a/drivers/gpio/gpio-tc9563.c b/drivers/gpio/gpio-tc9563.c
> new file mode 100644
> index 000000000000..68c20c8cba79
> --- /dev/null
> +++ b/drivers/gpio/gpio-tc9563.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
> + */
> +
> +/*
> + * The Toshiba TC9563 implements a PCIe Gen 3 switch that connects an
> + * upstream x4 port to two downstream PCIe x2 ports. It incorporates
> + * an internal endpoint on a internal PCIe port that implements two
> + * Synopsys XGMAC Ethernet interfaces.
> + *
> + * 37 GPIOs are also implemented by an embedded GPIO controller.  Three
> + * registers control the first 32 GPIOs (other than 20 and 21, which are
> + * reserved). Three other registers control GPIOs 32 through 36. GPIOs
> + * 22-24, 27-28, 31, and 34 are treated as "input only".
> + *
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/qcom/tc9563.h>
> +
> +/*
> + * There are two sets of registers, each representing (up to) 32 GPIOs with a
> + * stride of 4 bytes (IN1 is 4 bytes past IN0, EN1 is 4 bytes past EN0, etc.).
> + */
> +#define TC9563_GPIO_COUNT		37
> +#define TC9563_GPIO_PER_REG		32
> +#define TC9563_GPIO_REG_STRIDE		4
> +
> +static int tc9563_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	/* GPIOs 20 and 21 are reserved */
> +	bitmap_fill(valid_mask, ngpios);
> +	bitmap_clear(valid_mask, 20, 2);
> +
> +	return 0;
> +}
> +
> +static int tc9563_gpio_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct gpio_regmap_config config = {
> +		.parent = &adev->dev,
> +		.ngpio = TC9563_GPIO_COUNT,
> +		.reg_stride = TC9563_GPIO_REG_STRIDE,
> +		.ngpio_per_reg = TC9563_GPIO_PER_REG,
> +		.reg_dat_base = GPIO_REGMAP_ADDR(TC9563_GPIO_IN0_OFFSET),
> +		.reg_set_base = GPIO_REGMAP_ADDR(TC9563_GPIO_OUT0_OFFSET),
> +		.reg_dir_in_base = GPIO_REGMAP_ADDR(TC9563_GPIO_EN0_OFFSET),
> +		.init_valid_mask = tc9563_gpio_init_valid_mask,
> +	};
> +	DECLARE_BITMAP(fixed_dir_mask, TC9563_GPIO_COUNT);
> +	DECLARE_BITMAP(fixed_dir_out, TC9563_GPIO_COUNT);
> +
> +	config.regmap = dev_get_platdata(&adev->dev);
> +	if (!config.regmap)
> +		return -EINVAL;
> +
> +	/*
> +	 * Only some of our GPIOs are fixed direction:
> +	 * 22, 23, 24, 27, 28, 31, and 34 are input-only.
> +	 */
> +	bitmap_zero(fixed_dir_mask, TC9563_GPIO_COUNT);
> +	bitmap_set(fixed_dir_mask, 22, 3);
> +	bitmap_set(fixed_dir_mask, 27, 2);
> +	set_bit(31, fixed_dir_mask);
> +	set_bit(34, fixed_dir_mask);
> +	config.fixed_direction_mask = fixed_dir_mask;
> +
> +	bitmap_zero(fixed_dir_out, TC9563_GPIO_COUNT);
> +	config.fixed_direction_output = fixed_dir_out;
> +
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&adev->dev, &config));
> +};
> +
> +static const struct auxiliary_device_id tc9563_gpio_ids[] = {
> +	{ "pci_pwrctrl_tc9563." TC9563_GPIO_DEV_NAME },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, tc9563_gpio_ids);
> +
> +static struct auxiliary_driver tc9563_gpio_driver = {
> +	.name		= TC9563_GPIO_DEV_NAME,
> +	.probe		= tc9563_gpio_probe,
> +	.id_table	= tc9563_gpio_ids,
> +};
> +module_auxiliary_driver(tc9563_gpio_driver);
> +
> +MODULE_AUTHOR("Alex Elder <elder@riscstar.com>");
> +MODULE_AUTHOR("Daniel Thompson <daniel@riscstar.com>");
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>");
> +MODULE_DESCRIPTION("Toshiba TC9563 GPIO Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/soc/qcom/tc9563.h b/include/linux/soc/qcom/tc9563.h
> new file mode 100644
> index 000000000000..0dfd25747b9a
> --- /dev/null
> +++ b/include/linux/soc/qcom/tc9563.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> + */
> +
> +#ifndef __QCOM_TC9563_H
> +#define __QCOM_TC9563_H
> +
> +#define TC9563_GPIO_DEV_NAME	"tc9563-gpio"
> +
> +#define TC9563_GPIO_IN0_OFFSET		0x801200
> +#define TC9563_GPIO_EN0_OFFSET		0x801208
> +#define TC9563_GPIO_OUT0_OFFSET		0x801210
> +
> +#endif /* __QCOM_TC9563_H */
> 
> -- 
> 2.55.0
> 
