Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997843C871D
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752785; cv=none; b=RjOzqa5bCtmP7sVFGhayh00oU9RjkUQ69LQIdmMfrnx/j4pdFk8mwfBTKFkukkNZQULn9yi45OqJz2ntGmefjA0SPpASLdU7SHd6j58MJQGrIY4Fm0S9TntwdTQxX+cE9JsaFkx5mD138Qpqed5JvPNpX2nTc+nHTK+TzP/mQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752785; c=relaxed/simple;
	bh=GA5WZ9+UnKMbVk3/FvqlALydMizE/7ulE4pdZue6ul0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcMng1S3/ZcZsSS1cT0HaRIDmdkAmn7Iw4IFiX88YKESCi11DVKDE0Tv78B0nuzxyTp6GUFjjMnxYaMlK85JHibQL9WKD2NxVtvL3XqF4Cw5ZHaP2lGns1cUl/H3WlMYEvQ/dN3YR5xQAg6J1NHmLFBk+dNDVY+fj8ey2aWnIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgjyZHye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgjyZHye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC0BC2BCAF
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752785;
	bh=GA5WZ9+UnKMbVk3/FvqlALydMizE/7ulE4pdZue6ul0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=JgjyZHyeTiE8h78SdFEQQ79VMv6SEbpkYYrN6HffgO/xd4DGaMA1o2RbWW/4vMLT/
	 Y2y3dzjb3o2NeqD2pHxTyPni2+8vZQucYxRPVJRxbIETFlFn7uJFrnvWy50oo+P7Ke
	 /Awda2NetjQsMSaByH2Jf9mvRad0QRWn8FyCI2ysLREu1pgCFQfQI0c+hXWgd5VmXg
	 /KcaFXuoiis6FR0aT3PLhgTC99X8YvJAZn5LmodAbgJ/F0GY5SgJUNZlalbxU3nrCH
	 VcRIj2VCt9UbU2lU+hhDV5K2pW8dXmzTAyb88U85ePp9VNJMTPrTu9wBJWCEQTEaqu
	 g1+xeZVgKNg4Q==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so23147e87.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 06:06:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEm2R7wnscd9+Z2wQmdZA/halL0RReWBRnpqvhyl3jrJez6zUbay1jeBIWW/Q9gJEty4y7j8rkuKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpKsg8qgc04dQxX1kBroPa+Pr1+qQ6eMlb8ROcfEwhfy7SPr5
	shHrUicnTnqEKUnaqSpXIMjkCrjYC7son9dFfollFCwjXQL/Tc3dOAm5ksZLWwS1ttrR6UBiAkt
	VchV5VkITyQfgvgCjYpRPmmVNWbj0ZNv0ZkTefv1mcg==
X-Received: by 2002:a05:6512:24db:b0:5a1:44d3:7601 with SMTP id
 2adb3069b0e04-5a162afb717mr3868690e87.20.1773752782759; Tue, 17 Mar 2026
 06:06:22 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 09:06:20 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 09:06:20 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260317-pci-m2-e-v6-9-9c898f108d3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-pci-m2-e-v6-0-9c898f108d3d@oss.qualcomm.com> <20260317-pci-m2-e-v6-9-9c898f108d3d@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 09:06:20 -0400
X-Gmail-Original-Message-ID: <CAMRc=MeNZGr=zDVQYd1YgeUNdaenpbDEgmT6h7CuU89sHQuMcA@mail.gmail.com>
X-Gm-Features: AaiRm532I8Vph1JG9CGlFyj5TdvDVc6_kc40vvUgmGYOmNjWZCkNvD4VOMtLLTs
Message-ID: <CAMRc=MeNZGr=zDVQYd1YgeUNdaenpbDEgmT6h7CuU89sHQuMcA@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] power: sequencing: pcie-m2: Create serdev device
 for WCN7850 bluetooth
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Mar 2026 05:29:59 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> For supporting bluetooth over the non-discoverable UART interface of
> WCN7850, create the serdev device after enumerating the PCIe interface.
> This is mandatory since the device ID is only known after the PCIe
> enumeration and the ID is used for creating the serdev device.
>
> Since by default there is no OF or ACPI node for the created serdev,
> create a dynamic OF 'bluetooth' node with the 'compatible' property and
> attach it to the serdev device. This will allow the serdev device to bind
> to the existing bluetooth driver.
>
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/Kconfig          |   3 +-
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 178 +++++++++++++++++++++++++++++-
>  2 files changed, 177 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> index f5fff84566ba..55aeef125e6f 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -37,7 +37,8 @@ config POWER_SEQUENCING_TH1520_GPU
>
>  config POWER_SEQUENCING_PCIE_M2
>  	tristate "PCIe M.2 connector power sequencing driver"
> -	depends on OF || COMPILE_TEST
> +	depends on (PCI && OF) || COMPILE_TEST
> +	select OF_DYNAMIC
>  	help
>  	  Say Y here to enable the power sequencing driver for PCIe M.2
>  	  connectors. This driver handles the power sequencing for the M.2
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 3507cdcb1e7b..77357439ba81 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -12,9 +12,11 @@
>  #include <linux/of.h>
>  #include <linux/of_graph.h>
>  #include <linux/of_platform.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwrseq/provider.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/serdev.h>
>  #include <linux/slab.h>
>
>  struct pwrseq_pcie_m2_pdata {
> @@ -30,6 +32,9 @@ struct pwrseq_pcie_m2_ctx {
>  	struct notifier_block nb;
>  	struct gpio_desc *w_disable1_gpio;
>  	struct gpio_desc *w_disable2_gpio;
> +	struct serdev_device *serdev;
> +	struct of_changeset *ocs;
> +	struct device *dev;
>  };
>
>  static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
> @@ -172,13 +177,176 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>  	return PWRSEQ_NO_MATCH;
>  }
>
> -static void pwrseq_pcie_m2_free_regulators(void *data)
> +static void pwrseq_pcie_m2_free_resources(void *data)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx = data;
>
> +	serdev_device_remove(ctx->serdev);
> +	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
> +	of_changeset_revert(ctx->ocs);
> +	of_changeset_destroy(ctx->ocs);
>  	regulator_bulk_free(ctx->num_vregs, ctx->regs);
>  }
>
> +static int pwrseq_m2_pcie_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
> +					struct device_node *parent)
> +{
> +	struct device *dev = ctx->dev;
> +	struct device_node *np;
> +	int ret;
> +
> +	ctx->ocs = devm_kzalloc(dev, sizeof(*ctx->ocs), GFP_KERNEL);
> +	if (!ctx->ocs)
> +		return -ENOMEM;
> +
> +	of_changeset_init(ctx->ocs);
> +
> +	np = of_changeset_create_node(ctx->ocs, parent, "bluetooth");
> +	if (!np) {
> +		dev_err(dev, "Failed to create bluetooth node\n");
> +		ret = -ENODEV;
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = of_changeset_add_prop_string(ctx->ocs, np, "compatible", "qcom,wcn7850-bt");
> +	if (ret) {
> +		dev_err(dev, "Failed to add bluetooth compatible: %d\n", ret);
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = of_changeset_apply(ctx->ocs);
> +	if (ret) {
> +		dev_err(dev, "Failed to apply changeset: %d\n", ret);
> +		goto err_destroy_changeset;
> +	}
> +
> +	ret = device_add_of_node(&ctx->serdev->dev, np);
> +	if (ret) {
> +		dev_err(dev, "Failed to add OF node: %d\n", ret);
> +		goto err_revert_changeset;
> +	}
> +
> +	return 0;
> +
> +err_revert_changeset:
> +	of_changeset_revert(ctx->ocs);
> +err_destroy_changeset:
> +	of_changeset_destroy(ctx->ocs);
> +
> +	return ret;
> +}
> +
> +static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
> +			      void *data)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
> +	struct pci_dev *pdev = to_pci_dev(data);
> +	struct serdev_controller *serdev_ctrl;
> +	struct device *dev = ctx->dev;
> +	int ret;
> +
> +	/*
> +	 * Check whether the PCI device is associated with this M.2 connector or
> +	 * not, by comparing the OF node of the PCI device parent and the Port 0
> +	 * (PCIe) remote node parent OF node.
> +	 */
> +	struct device_node *pci_parent __free(device_node) =
> +			of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);
> +	if (!pci_parent || (pci_parent != pdev->dev.parent->of_node))
> +		return NOTIFY_DONE;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		/* Create serdev device for WCN7850 */
> +		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> +			struct device_node *serdev_parent __free(device_node) =
> +				of_graph_get_remote_node(dev_of_node(ctx->dev), 1, 1);
> +			if (!serdev_parent)
> +				return NOTIFY_DONE;
> +
> +			serdev_ctrl = of_find_serdev_controller_by_node(serdev_parent);
> +			if (!serdev_ctrl)
> +				return NOTIFY_DONE;
> +
> +			/*
> +			 * Bail out if the device was already attached to this
> +			 * controller.
> +			 */
> +			if (serdev_ctrl->serdev)
> +				return NOTIFY_DONE;
> +
> +			ctx->serdev = serdev_device_alloc(serdev_ctrl);
> +			if (!ctx->serdev)
> +				return NOTIFY_BAD;

If you bail out here, on driver unbind you'll call serdev_device_remove() which
uncoditionally dereferences the serdev pointer.

> +
> +			ret = pwrseq_m2_pcie_create_bt_node(ctx, serdev_parent);

If this doesn't succeed, ctx->ocs remains set to NULL (correct me if I'm wrong)
and you end up calling of_changeset_revert() which will unconditionally
dereference the of_changeset pointer in __of_changeset_entry_invert().

> +			if (ret) {
> +				serdev_device_put(ctx->serdev);
> +				return notifier_from_errno(ret);
> +			}
> +
> +			ret = serdev_device_add(ctx->serdev);
> +			if (ret) {
> +				dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
> +				of_changeset_revert(ctx->ocs);
> +				of_changeset_destroy(ctx->ocs);
> +				serdev_device_put(ctx->serdev);
> +				return notifier_from_errno(ret);
> +			}
> +		}
> +		break;
> +	case BUS_NOTIFY_REMOVED_DEVICE:
> +		/* Destroy serdev device for WCN7850 */
> +		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
> +			serdev_device_remove(ctx->serdev);
> +			of_changeset_revert(ctx->ocs);
> +			of_changeset_destroy(ctx->ocs);
> +		}
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port, u8 endpoint,
> +					     const char *node)
> +{
> +	struct device_node *remote __free(device_node) =
> +			of_graph_get_remote_node(dev_of_node(dev), port, endpoint);
> +
> +	if (remote && of_node_name_eq(remote, node))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * If the connector exposes a non-discoverable bus like UART, the respective
> + * protocol device needs to be created manually with the help of the notifier
> + * of the discoverable bus like PCIe.
> + */
> +static int pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, struct device *dev)
> +{
> +	int ret;
> +
> +	/*
> +	 * Register a PCI notifier for Key E connector that has PCIe as Port
> +	 * 0/Endpoint 0 interface and Serial as Port 3/Endpoint 0 interface.
> +	 */
> +	if (pwrseq_pcie_m2_check_remote_node(dev, 3, 0, "serial")) {
> +		if (pwrseq_pcie_m2_check_remote_node(dev, 0, 0, "pcie")) {
> +			ctx->dev = dev;
> +			ctx->nb.notifier_call = pwrseq_m2_pcie_notify;
> +			ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to register notifier for serdev\n");
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -218,7 +386,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>
>  	ctx->num_vregs = ret;
>
> -	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
> +	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_resources, ctx);
>  	if (ret)
>  		return ret;
>
> @@ -233,7 +401,11 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
>  				     "Failed to register the power sequencer\n");

If you bail out here, you will call bus_unregister_notifier() before your
registered it. Kernel docs are not clear on whether that's a bug but it still
looks fishy to me.

Am I not seeing something or is the error path broken? I'm doubting myself
here. :)

This is why I advised to split pwrseq_pcie_m2_free_resources() and only schedule
individual devres actions after their allocation succeeds.

As it is now, you're better off providing a remove() callback with NULL checks.

Bart

>
> -	return 0;
> +	/*
> +	 * Register a notifier for creating protocol devices for
> +	 * non-discoverable busses like UART.
> +	 */
> +	return pwrseq_pcie_m2_register_notifier(ctx, dev);
>  }
>
>  static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
>
> --
> 2.51.0
>
>
>
