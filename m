Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48A42EEC9
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425264; cv=none; b=Kip5OADXdhPCKnBWoK9/BXb1MaErQ17eyfKcpCaM6KIBsT0RXrkkawOLnVHjadb2m4ob3cWNWYL0Zr6fbuIWQvg3cM7/gMw23uHlCh1hJVElcJbZLkl7cbj5amCPg9oq9oJIO9hK3f0UKArZ/lHoKOjiOzsxAHgumsbT5+0JNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425264; c=relaxed/simple;
	bh=M7J6iZ+DDWsNVdCjahCrCY47a7y+n2CcoOosL5Xp8Kk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJbEqNKaDQ1wMoBB6AsF77o4iYla01UnO3uSSo8KGk1yBbQ7ta6OMBaBHfJQNHIRV71EyO2I0LQnt7cNc9Lcvr2cWQ4cFcU72rFMJ3pxWOZW3WPxTWzFC//FRuqBsnp2usLauDJDtfDDLmdWRHb5YcnqOF2z6oSpvgAopf3HqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f93pKcVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f93pKcVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A321F00ADB
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788425262;
	bh=rUZuDzuerz9HTSNz5FjflHQQ0xAjPFwqwzxl7IPdHbU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=f93pKcVN+gHTQdD+paQnjjkhRE+sHMYpzOtQjrfGYXyMpi0tEUzPKNvWKx7kEc1B4
	 fjX6tK14zCNlCWCk5zQhxJnFTp+WHWNAQuDmw4Gm8qpYnJ8P8WSL8ka9jE4Yw8A/g8
	 uSWv3uj43kLzE0n4Yw5M6lg/eJeAk5AvWZzg/yDP3X1euCuH6D0+/RalCO+kwToemF
	 1TwAf2ABM+eO7iItTz0U4SR4Pcj9z0WpzcZpo0QN8zQItE3M5Elj9I5VTOAJST2VCS
	 808B1EFd4F72tmAF7VDqTmrRhxUjODv4HsMG21FA8Mg4XRpyGNCO3bVRQNvaFpE9Kk
	 qNFZOiFVjC1wg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so14535071fa.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 01:47:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByrUnKfSkpUJ28gI6rxfdRwKHxBX5v4o+VpP6X7p41zpK6j9Ausds7sswWIo6CvBrYC8EVNjtLSoGk=@vger.kernel.org
X-Gm-Message-State: AFuF++lfP1gRkkbkslRwnRa9NPbqUqewM01l2isBfpCTd2wU2gnAy0pF
	fvLPVP0yZ1/BF67a/8jpMmELG35BLbm9ItN5xkR7imY8hYexWyksoUneroKxCVAKzmRnvC0iNIQ
	whABLW+1jyYDy9zGpIMDcyUv/wDwOeyx+zy52+DhFTQ==
X-Received: by 2002:a2e:a98d:0:b0:3a1:8510:cbab with SMTP id
 38308e7fff4ca-3a34fd3b9f5mr20178881fa.12.1788425260597; Thu, 03 Sep 2026
 01:47:40 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 01:47:39 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 01:47:39 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com> <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 01:47:39 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdpUaJ8sJczbN592wncBZvdhaUW2rcA3CjyxS8fPKAoGw@mail.gmail.com>
X-Gm-Features: AcwNN1W4N5MlwjhagTYwb_RNFsJKpxi_ErCQwMyDXxajkEh9gtHOtruNUgarkj4
Message-ID: <CAMRc=MdpUaJ8sJczbN592wncBZvdhaUW2rcA3CjyxS8fPKAoGw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sep 2026 09:52:59 +0200, Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> said:
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

It's no longer true and also, it's clear from the patch so we don't have to
have it in the commit message.

>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
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
> -
>  #define TC9563_PORT_L0S_DELAY		0x82496c
>  #define TC9563_PORT_L1_DELAY		0x824970
>
> @@ -393,6 +393,73 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
>  	return 0;
>  }
>
> +static void tc9563_pwrctrl_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	of_node_put(adev->dev.of_node);
> +	kfree(adev);
> +}
> +
> +static void tc9563_pwrctrl_adev_remove(void *data)
> +{
> +	struct auxiliary_device *adev = data;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static int tc9563_pwrctrl_adev_add(struct device *dev, const char *name,
> +				   u32 id, struct device_node *of_node,
> +				   void *priv_data)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev = kzalloc_obj(*adev);
> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->id = id;
> +	adev->name = name;
> +	adev->dev.parent = dev;
> +	adev->dev.platform_data = priv_data;
> +	adev->dev.release = tc9563_pwrctrl_adev_release;
> +	adev->dev.of_node = of_node_get(of_node);

Ah you're doing it because .release() will be called if auxiliary_device_add()
fails. It's fine I guess.

> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		of_node_put(adev->dev.of_node);
> +		kfree(adev);
> +		return ret;
> +	}
> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		return ret;
> +	}
> +
> +	return devm_add_action_or_reset(dev, tc9563_pwrctrl_adev_remove, adev);
> +}
> +
> +static int tc9563_pwrctrl_add_gpio_adev(struct tc9563_pwrctrl *tc9563)
> +{
> +	struct device *dev = tc9563->pwrctrl.dev;
> +	struct fwnode_handle *fwnode;
> +	int ret;
> +
> +	fwnode = gpiochip_node_get_first(dev);
> +	if (!fwnode)
> +		return 0;
> +
> +	ret = tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0,
> +				      to_of_node(fwnode), tc9563->regmap);
> +	fwnode_handle_put(fwnode);
> +
> +	return ret;
> +}
> +
>  static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
>  {
>  	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
> @@ -565,6 +632,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	 */
>  	port = TC9563_USP;
>  	for_each_child_of_node_scoped(node, child) {
> +		if (!of_node_is_type(child, "pci"))
> +			continue;
> +
>  		if (++port >= TC9563_MAX)
>  			break;
>
> @@ -596,6 +666,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	tc9563->pwrctrl.power_on = tc9563_pwrctrl_power_on;
>  	tc9563->pwrctrl.power_off = tc9563_pwrctrl_power_off;
>
> +	ret = tc9563_pwrctrl_add_gpio_adev(tc9563);
> +	if (ret)
> +		goto remove_i2c;
> +
>  	ret = devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
>  	if (ret)
>  		goto power_off;
>
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
