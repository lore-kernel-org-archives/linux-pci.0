Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B544470B
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358377; cv=none; b=mCAeApX9a+1EgI+K7VoZ5hWUFnXHRt/nQHOmM+XvM1ExIEk73R+YiaNCw6DggPv+wfbhLjTzIA5+rDYgVThgW2vb7/q0vv9ktPn/OaIsqNwz3/Hg2hNZdLjFpBvQZ3fD1baqQX4X2x5leq39Pn9aOCOnxIeMfZu5Bthq/c9nTfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358377; c=relaxed/simple;
	bh=6RRBOXunsj08FTZ3ncggluNT5gwoaY3pjLUyNt64cHI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1+4dkrrbzo8qNpS3J7kHcoeYvFKmGYYdL4W2/Ruz3OByGcvF7ke22L0jFYBk+nVsLj4vhTqk0N8M5YoJLHp65FUm7ejx1FJowGhy5kKh6eRT1uyY4nXUzf4op7UDuGQ6dxd0mARd9qMTZHYExKbL5Dk/wZK2lmlDLzrQKnRf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeoZIdSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeoZIdSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93931F00A3D
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358375;
	bh=rN6sTLCKq1WlxEf3W8MKial3cy5QDz1RxTBBozXpCms=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TeoZIdSDEA+nZ7QMx36OyM4F86Hclo+N0RYgBAOHt3ihIsWbvVekuo+A7iWnucMOM
	 F9Sv1K7QHJ9EKzseeAhF5R/JKNulv/OrWoE/5sy/ovLJNCX5DhYbBTDeKwaVU2Pqaz
	 hs74I9DB+nvNOJqHN8966Xky+bQKHzYTV32mDAQwtErFzApn1AvTFkmyxTaWdPpwz+
	 QibfIOKE6nsAoivYrerfgPhREz8EnqbVOwKHMkxVB9COeMcoOKbZsLKEbZQiGFyo1s
	 e5uJARYJcM32nEa4OC4aRVHgcbMxMSx42PgmVW89AAlLg88ZPEZsRG7RQpy0tcRF2K
	 dc0tqfmuS9sBQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b4adcce4b1so1216300e87.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 07:12:55 -0700 (PDT)
X-Gm-Message-State: AFuF++mIINkdvF+DOn1cKhLAuB3r9D/gH3tA0KYUy4YDJzhbBQSzjpy0
	R3zYLDydtH7gqZkZnzadIfryMyzMHYwFuLGQHbWbhvRr8aV/5GBVMjCz2mLpjOSA56y6qEGvyjk
	BP6GKvmNka8yU70SSNEEyohyDdNXdfoyujc6MQ0UmEg==
X-Received: by 2002:a05:6512:3d89:b0:5b6:421:a8fd with SMTP id
 2adb3069b0e04-5b6087b5051mr1993779e87.29.1788358374082; Wed, 02 Sep 2026
 07:12:54 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 07:12:52 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 07:12:52 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260901-pci-tc9563-aux-v1-3-dd9b80738e70@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com> <20260901-pci-tc9563-aux-v1-3-dd9b80738e70@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 07:12:52 -0700
X-Gmail-Original-Message-ID: <CAMRc=Meajb919ZN4QYaW3E=4AktXNs1C7KPRGmkAPMrRSnPQiQ@mail.gmail.com>
X-Gm-Features: AcwNN1UgHLMd4bA6zzWN-rQnOy4DvPk54i7L8UKWe-_sJVv321EIkRKrSQgl4uA
Message-ID: <CAMRc=Meajb919ZN4QYaW3E=4AktXNs1C7KPRGmkAPMrRSnPQiQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sep 2026 12:27:55 +0200, Lorenzo Bianconi
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
>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/Kconfig              |  2 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 78 ++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index 1952ab4f29b6..a07694fae0c9 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -30,6 +30,8 @@ config PCI_PWRCTRL_TC9563
>  	default m if ARCH_QCOM
>  	depends on I2C
>  	select REGMAP_I2C
> +	select AUXILIARY_BUS
> +	select GPIO_TC9563

I think this should depend on it, not select it?

>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
>  	  switch.
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index b0d8912690a2..ee9c26b8f5cb 100644
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
> @@ -393,6 +393,71 @@ static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
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
> +	if (!adev) {
> +		of_node_put(of_node);

This is a bit confusing. You get the node in tc9563_pwrctrl_add_gpio_adev() but
you put it here. Please either do both here or there.

> +		return -ENOMEM;
> +	}
> +
> +	adev->id = id;
> +	adev->name = name;
> +	adev->dev.parent = dev;
> +	adev->dev.platform_data = priv_data;
> +	adev->dev.release = tc9563_pwrctrl_adev_release;
> +	adev->dev.of_node = of_node;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		of_node_put(of_node);
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
> +	struct device_node *node;
> +
> +	node = to_of_node(gpiochip_node_get_first(dev));
> +	if (!node)
> +		return 0;
> +
> +	return tc9563_pwrctrl_adev_add(dev, TC9563_GPIO_DEV_NAME, 0, node,
> +				       tc9563->regmap);
> +}
> +
>  static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
>  {
>  	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
> @@ -565,6 +630,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  	 */
>  	port = TC9563_USP;
>  	for_each_child_of_node_scoped(node, child) {
> +		if (!of_node_is_type(child, "pci"))
> +			continue;
> +
>  		if (++port >= TC9563_MAX)
>  			break;
>
> @@ -596,6 +664,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
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

Bart
