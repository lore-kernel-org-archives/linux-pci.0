Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C531196F
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270465; cv=none; b=t6uM3ODViL1krt61cbW3B7yhO7aqSSjHJ6zEraOEEkcWO1sngH5F3+zOkk5qdN5d5deVGPU020790CpuIF7U2qBuaXdNW9Sr0ileDBPFqTddh2Tz4Te22yAm0oa6hwlsINyokzQs1pr5h/12hcGpGT4SyqPP4/rWT+QK+C4A2H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270465; c=relaxed/simple;
	bh=GJHIQYHdExoFgvU+cmgVz3hyDeMUKMsUNcryW43m6cw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LGOL4blSmqwvlr+yNK+Y75cm9Rv71Sat2b0wofYkWuNOeAhEPdt8838sqeRlPkyEKbBeLI1/1MPh99Gql+U9Oun6z8jBJT0iwT3qb9UjskPIuB2flCvv2ULN532LVvRmw52xO5ecBGuA/eGpFwwvfpTANN9weVEXdaQA84kwXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1PgKlEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1PgKlEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8388C2BCB0;
	Fri,  8 May 2026 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778270464;
	bh=GJHIQYHdExoFgvU+cmgVz3hyDeMUKMsUNcryW43m6cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n1PgKlEtcqsPJQdkglokQsXaKg1Gl1DcX7jgKUjwzM09LD0iTqyjhbZJQ2G1jCTyF
	 89aUJPMq2POaGYShNpBbNilKKc9tpQ9nMgEkGkLWF3bcuqR11ed3i+fqTtD4CfziQk
	 xwDiYs/sMiiYiT76WoYYFHQy6+nhjh0EQ6R1hzUkeE0OQePJCpkzC+Y4xLhZ+3fJdm
	 +vYZ+5xWDZIwTSgR5DseoCcll/3ZIdJvWjuDAIdOy6HIK3etVfPDba/zI1A3MPJTFi
	 OOQxKDmeoR3KWH6ymJw86T0FUE55kmao5+rEzy/AmGAus3FyzZqg2TwMPZOFinyZJz
	 kFcuRE8IDOHtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Handle mixed PERST#/PHY DT configuration
Reply-To: sashiko@lists.linux.dev
To: "Qiang Yu" <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
References: <20260508-mix_perst_phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 20:01:04 +0000
Message-Id: <20260508200104.B8388C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Probing fails for legacy device trees due to a GPIO request confli=
ct (-EBUSY).
- [High] Unconditional recursion in `qcom_pcie_parse_perst()` duplicates th=
e `pcie->reset` GPIO descriptor for every descendant node.
- [High] Missing `phy_exit()` cleanup on error path in `qcom_pcie_parse_por=
t()` causes hardware state and resource leak.
--

commit 1a0ea25971de08bb67bf6aea3574504602a6d020
Author: Qiang Yu <qiang.yu@oss.qualcomm.com>

PCI: qcom: Handle mixed PERST#/PHY DT configuration

The driver currently supports PERST# and PHY DT configuration on either the
RC or RP node. This commit adds support for mixed setups where PHY is on
the RP node but PERST# remains on the RC node by reusing the RC PERST#
GPIO and emitting a warning.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 9fdfc88ac1512..8235961d692f2 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -1703,6 +1704,11 @@ static int qcom_pcie_parse_perst(struct qcom_pcie =
*pcie,
>  	struct gpio_desc *reset;
>  	int ret;
> =20
> +	if (pcie->reset) {
> +		reset =3D pcie->reset;
> +		goto skip_perst_parsing;
> +	}
> +
>  	if (!of_find_property(np, "reset-gpios", NULL))
>  		goto parse_child_node;
> =20
> @@ -1721,6 +1727,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *=
pcie,
>  		return PTR_ERR(reset);
>  	}
> =20
> +skip_perst_parsing:
>  	perst =3D devm_kzalloc(dev, sizeof(*perst), GFP_KERNEL);

When pcie->reset is configured, this jumps to skip_perst_parsing, adds
pcie->reset to the port's list, and then falls through to parse_child_node:

parse_child_node:
	for_each_available_child_of_node_scoped(np, child) {
		ret =3D qcom_pcie_parse_perst(pcie, port, child);
		if (ret)
			return ret;
	}

Since pcie->reset remains set globally, does this recursively call itself
for all descendant nodes, skip property parsing again, and append the exact
same GPIO descriptor to the port's list for every descendant?

Will this redundantly toggle the same GPIO multiple times and unintentional=
ly
ignore any endpoint-specific reset-gpios properties defined in child nodes?

[ ... ]

> @@ -1778,6 +1785,14 @@ static int qcom_pcie_parse_ports(struct qcom_pcie =
*pcie)
>  	struct device *dev =3D pcie->pci->dev;
>  	int ret =3D -ENODEV;
> =20
> +	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
> +		pcie->reset =3D devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> +		if (IS_ERR(pcie->reset))
> +			return PTR_ERR(pcie->reset);
> +
> +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be f=
ixed!\n");
> +	}
> +
>  	for_each_available_child_of_node_scoped(dev->of_node, of_port) {

If there are no child "pci" nodes, this function returns -ENODEV. Does the
caller then fall back to qcom_pcie_parse_legacy_binding() which will also
attempt to request the exact same "perst" GPIO?

Since devm_gpiod_get_optional() persists for the lifetime of the probe and
GPIOLIB enforces exclusive access by default, will the second request fail
with -EBUSY and break the probe path for legacy platforms?

>  		if (!of_node_is_type(of_port, "pci"))
>  			continue;
>  		ret =3D qcom_pcie_parse_port(pcie, of_port);
>  		if (ret)
>  			goto err_port_del;
>  	}

This issue wasn't introduced by this patch, but if qcom_pcie_parse_perst()
returns an error (such as -EPROBE_DEFER or -ENOMEM) from within
qcom_pcie_parse_port(), is phy_init() successfully called before the error
is encountered?

If qcom_pcie_parse_port() returns early without calling phy_exit(), and the
failing port has not yet been added to the pcie->ports list, does the
err_port_del cleanup loop skip this port?

err_port_del:
	list_for_each_entry_safe(port, tmp_port, &pcie->ports, list) {
		...
		phy_exit(port->phy);

Could this leave the PHY active and unbalance regulator/clock enable counts
across probe retries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-mix_perst_=
phy_dts-v1-1-9eff6ee9b51a@oss.qualcomm.com?part=3D1
