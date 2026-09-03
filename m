Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB03016F5;
	Thu,  3 Sep 2026 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788470242; cv=none; b=iZTIdXZwNZc2PMTb0yj8hYpfAvUol+wemDrTVxGlOtGfWG6GddwslXigHhClkS/NHnx4bZsi+3AYu00UgV1EJo/IdBu+yTZUooUNnc9V++y3q+sXahPCLhdxX/KBwpUD7hVVMgxntW0OW3fSKamDE0tsf3rRF8tDo82XRGRavP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788470242; c=relaxed/simple;
	bh=wOlC4OiAFb+tdAGR+e0I/OWjlZCu9zCugEAUnannJkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X7fV3OSCJgJT9Lehg36Boj2/BnOGK5Uq6LiRFZVSLkBvs4Dof6nN6RulOYJhZqpL3l/NLsdlKZ8Qtgo3tWOnf6JaiV5qq+VGFnga+BxkUayALrfZkhuEOYAns3cOgCRJcUX5SPU/Ad/IdkuGr7AQK67pR+dZhszOlxU/lz7bO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvI1bJLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvI1bJLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF2D1F000E9;
	Thu,  3 Sep 2026 21:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788470240;
	bh=V8m0ufB0gU94HmeHP2HD3wJwBb2e7pW9d7U0y5D2Rk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MvI1bJLudM7LAX9QGltFJ2KdN1hgDaC7aklfNsnkJgMyTilhHJS2dnR2B9wdgHyd1
	 zDdFJrPunxTXg/ir8WW6rr+bZYZbpbKWiOBP3gISgv7Bz92LBQ7sRSSsaoHEdQlPUj
	 uMcm+AA0MpwEPukRiOmq2UAf9MPZuqza5IlIejXdynwLDiFjv+RNJUbQJa5JsUDlyy
	 9p/L18IPdvYyDbjfO2O9ddxHooiVzBoRrp8CSQ6pXJ9AVn6QjK12+0PjUAWi8W+qC2
	 0sXSWS7gulxa91dnShH7f6zSH3VhkGER3aVcQldKkaGVpm89OBjEChYz/j2vav0H/2
	 WmbikPztehJTQ==
Date: Thu, 3 Sep 2026 16:17:18 -0500
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
	Daniel Thompson <daniel@riscstar.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI/pwrctrl: tc9563: add GPIO auxiliary device
 support
Message-ID: <20260903211718.GA2247285@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-pci-tc9563-aux-v2-3-34c625b542c1@oss.qualcomm.com>

On Thu, Sep 03, 2026 at 09:52:59AM +0200, Lorenzo Bianconi wrote:
> The TC9563 embeds a GPIO controller used for per-port reset signals.
> Create an auxiliary device for it so the gpio-tc9563 driver can
> register the GPIO chip and enable DT-based GPIO lookups. Pass the
> tc9563 regmap to the auxiliary device as its platform data.
> 
> The downstream port DT parsing loop gains an of_node_is_type() filter
> to skip non-PCI child nodes such as the GPIO controller node.

"Add an of_node_is_type() filter in the downstream port DT parsing
loop ..." to match the rest.  Or even just "Skip non-PCI nodes such as
GPIO controller nodes when parsing downstream port DT".

> The pwrctrl driver does not wait for the GPIO chip to be probed. The
> per-port reset GPIO lookup, returning -EPROBE_DEFER until the chip is
> registered, is added in the next patch.
> 
> Select AUXILIARY_BUS and GPIO_TC9563 in Kconfig.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

What's the merge strategy?  I guess this depends on the previous
drivers/gpio patches because they add linux/soc/qcom/tc9563.h, which
this patch uses, so they all have to go together?

Capitalize "Add GPIO ..." in the subject to match the history, then

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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

Alphabetize in with the rest of the #includes.

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
