Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5C471CE0;
	Fri,  7 Aug 2026 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107207; cv=none; b=LEGwLqG7XClfNsFYcdelmBRFnrF+isB5iJZ2y/jUP21oXZVsGnNbn0Ga40FA1Az/OVPRba+YNczO2bXR3KYC2CzuDBrBdZbf3sp2KCUb/JTp+gWKv7E472wJDD709AWb6J48zWYANP20ETGQQwS8qn6/qH/p98D2T0mI/5jue7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107207; c=relaxed/simple;
	bh=r56eOpp5RCb51X57ehttxOMpfytw0fAbFpNyNS1NxNs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RVUhdFl9PxAIEvBtqeIixgdzscgQRVaJ12aD/qOXPwZM3Tf1agZjzcVDDwEsycGv+dirW9trMeJvBRFKAIVDOvU9pRAm28+mvnqJ4FH1wTWhkufJyG8QVphQnVZn2VWGaWrUg+vMvualQKhanv9YZ4TAcHSTIpa3qCu1mmCriNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLsoBh0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLsoBh0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29C51F000E9;
	Fri,  7 Aug 2026 12:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107197;
	bh=sXn6NtG4vdFcGPStct9XrU9UwnGiw0iX4iaYZrrPMVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLsoBh0V4AYLQgQeTWr0PB9QsSXTc2guiSy+a+ub00uqJKFlrdvImdXPzLexlUOCC
	 hmPSFlGbS2Tv+s9Kh3icJ0UuqFh5dfPUA9Zb2aTfp7UVtljEkMHWzV7KjOk0CzzQAJ
	 oSFxFNS6/6tLBXwFrSzZ+HM4Bq52FHBzdi5L8PzhE9vU08pH4sOkfq9Qitm2ANiZZ1
	 QJuKFId9dccC2paLDITCqxPS1UcStnPpPeSBTtXpCmEAXN66BKVuBA+cErTIlK4Li4
	 LO7Na4s42wVidCKu9Z45DkhGUAYq5AdalNv8+/9+4yJ8FbTD3y50B40v7s2fKdnxxE
	 ktgpOKdcLiLDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260807123507.3418671-3-sai.krishna.musham@amd.com>
References: <20260807123507.3418671-1-sai.krishna.musham@amd.com>
 <20260807123507.3418671-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:53:15 +0000
Message-Id: <20260807125316.C29C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect gating of the PCIe reset sequence leaves the endpoint pe=
rmanently in reset if only the PERST# GPIO is provided.
- [Medium] Using mdelay() instead of msleep() for a 100ms delay in a sleepa=
ble context busily hogs the CPU unnecessarily.
- [Low] The explicit declaration of `pcie_port_node` is completely shadowed=
 by the macro `for_each_child_of_node_with_prefix`.
--

--- Patch [2]: [PATCH v8 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERS=
T# signal ---
commit 1f7ff063bcead5bbf6ae44c2226031dc6d2d092c
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>
PCI: xilinx-cpm: Add support for PCIe RP PERST# signal

This commit adds support for the PCIe Root Port PERST# signal using the GPIO
framework, along with the PCIe IP reset. Both the reset GPIO and the reset
controller are made optional to maintain backward compatibility with existi=
ng
device trees. It also updates the interrupt controller node parsing to use
of_get_child_by_name() instead of of_get_next_child().

> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/contr=
oller/pcie-xilinx-cpm.c
> index d38f27e207619..040d37643991a 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c

[ ... ]

> @@ -469,6 +476,22 @@ static int xilinx_cpm_setup_irq(struct xilinx_cpm_pc=
ie *port)
>  	return 0;
>  }
> =20
> +/**
> + * xilinx_cpm_pcie_reset - Reset the PCIe controller and deassert PERST#
> + * @port: PCIe port information
> + *
> + * Reset the PCIe controller and then release the PERST# signal so that =
the
> + * link can train once the bridge is enabled.
> + */
> +static void xilinx_cpm_pcie_reset(struct xilinx_cpm_pcie *port)
> +{
> +	reset_control_assert(port->rstc);
> +	udelay(PCIE_T_PERST_US);
> +	reset_control_deassert(port->rstc);
> +	gpiod_set_value_cansleep(port->perst_gpio, 0);
> +	mdelay(PCIE_RESET_CONFIG_WAIT_MS);

[Severity: Medium]
Since this is in a context that can safely sleep, as indicated by the prece=
ding
gpiod_set_value_cansleep() call, should this be msleep() instead of mdelay(=
) to
avoid busily hogging the CPU?

> +}
> +
>  /**
>   * xilinx_cpm_pcie_init_port - Initialize hardware
>   * @port: PCIe port information
> @@ -480,6 +503,9 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_c=
pm_pcie *port)
>  	if (variant->version =3D=3D CPM5NC_HOST)
>  		return;
> =20
> +	if (port->perst_gpio && port->rstc)
> +		xilinx_cpm_pcie_reset(port);

[Severity: High]
If a platform provides the reset GPIO but omits the optional IP reset
controller, port->rstc will be NULL and this condition will be false.

Since the PERST# GPIO is acquired with GPIOD_OUT_HIGH in
xilinx_cpm_pcie_parse_port(), it starts asserted.

Could this leave the endpoint permanently in reset for platforms that only
provide the GPIO?

> +
>  	if (cpm_pcie_link_up(port))
>  		dev_info(port->dev, "PCIe Link is UP\n");

[ ... ]

> @@ -512,6 +538,43 @@ static void xilinx_cpm_pcie_init_port(struct xilinx_=
cpm_pcie *port)
>  		   XILINX_CPM_PCIE_REG_RPSC);
>  }
> =20
> +/**
> + * xilinx_cpm_pcie_parse_port - Parse the PCIe Root Port child node
> + * @port: PCIe port information
> + *
> + * Read the PERST# GPIO from the Root Port child node.
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_cpm_pcie_parse_port(struct xilinx_cpm_pcie *port)
> +{
> +	struct device *dev =3D port->dev;
> +	struct device_node *pcie_port_node __maybe_unused;

[Severity: Low]
Is this explicit declaration of pcie_port_node necessary?

The for_each_child_of_node_with_prefix() macro internally declares a scoped=
 loop
variable with the same name, which completely shadows this outer variable.

> +
> +	/*
> +	 * This platform currently supports only one Root Port, so the loop
> +	 * will execute only once.
> +	 * TODO: Enhance the driver to handle multiple Root Ports in the future.
> +	 */
> +	for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, "pcie"=
) {
> +		port->perst_gpio =3D devm_fwnode_gpiod_get(dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807123507.3418=
671-1-sai.krishna.musham@amd.com?part=3D2
