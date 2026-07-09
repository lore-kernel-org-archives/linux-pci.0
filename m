Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF33D8114
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579487; cv=none; b=iHcGUjRMctUSz5YCO+ZC6BZhg8FMHKy9ralltKeb0qwcsWS/jCSVKpWUjBQU/htPG1kkTtxd3FZR05g1lztvjcNEhgRHtRKLW1wIsX7Zce0Aj0sQj1oeQoiW0PGdV70abUqvY/xG8eoU0fCWvP/zsn5BA6+V9Y6DXjL9dr2Edgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579487; c=relaxed/simple;
	bh=gSXTxHYBKNl+Pd8lxNaaLGfCLNZGpzv5ppqm59uCS9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fBRydtaeBZ9mD4ln3aTPme+yd5b858c9T96UpEryBk6AoEqD9byTvHdVbqsQ0czIsl9XIwvDgHfsiAMMnL4HEft9N6CN0F5yuHwRAdC8fbdn06JUILXiTTBE3qLXwGXwDT2qNSrLaZpRqvl1PLS03zL4YWz1HVFwxf6xy12SitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxEquNZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxEquNZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C061F000E9;
	Thu,  9 Jul 2026 06:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783579481;
	bh=IUVWvhNPIaZ+7XtVmSCRJuMBGIhbUO0xM76uHWOqbo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxEquNZCvoZqpLZpKbvXaur1GosEBnQxB91VbJ5ruj8pF94Jl+E3PpZtW9Ti3kLCE
	 cnwNv6HLcSNtjRnhhE5kX6EQUIVDCleLEsKFv1kyPJoFXzNocJi+FGduVxC+A6tT4F
	 dynk71IQlnoNWfPyRap4HyPH05Spu2weF0y/yD5Ly5fIq43T8CK0KUs6eJYFIf36kR
	 VN6UV/Ltb/YfzDw38ySEQ3jH9UCCgFl99o/LZXk3dqMBUbdorRdLB3vTLBrm0gFXJy
	 hEUQZFWVpnssGSWZdQp6DETUdz69Xn7Kxpb+RJx42xLBIspDavS41kdeu6/zI/zViH
	 YeBWU+qI2tFGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] PCI: qcom: Keep PERST# GPIO state as-is during
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, neil.armstrong@linaro.org, vkoul@kernel.org, linux-pci@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260709-link_retain-v3-2-81a9d187bb61@oss.qualcomm.com>
References: <20260709-link_retain-v3-0-81a9d187bb61@oss.qualcomm.com>
 <20260709-link_retain-v3-2-81a9d187bb61@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:44:40 +0000
Message-Id: <20260709064440.C5C061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Requesting the PERST# GPIO with GPIOD_ASIS leaves it as an input i=
f not configured by the bootloader, causing subsequent reset toggles to sil=
ently fail.
--

--- Patch [2]: [PATCH v3 2/4] PCI: qcom: Keep PERST# GPIO state as-is durin=
g probe ---
commit 9e74f48a37d93ad22a1ec71470af58b05c07c912
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom: Keep PERST# GPIO state as-is during probe

This commit changes the PERST# GPIO request from GPIOD_OUT_HIGH to GPIOD_AS=
IS
in order to preserve the existing GPIO state configured by the bootloader or
firmware during probe.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1841,7 +1841,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *=
pcie,
>  		goto parse_child_node;
> =20
>  	reset =3D devm_fwnode_gpiod_get(dev, of_fwnode_handle(np), "reset",
> -				      GPIOD_OUT_HIGH, "PERST#");
> +				      GPIOD_ASIS, "PERST#");

[Severity: High]
If the bootloader does not configure the PERST# GPIO as an output, does
requesting it with GPIOD_ASIS leave the pin configured as an input?

If so, later when __qcom_pcie_perst_assert() attempts to toggle the reset:

	gpiod_set_value_cansleep(perst->desc, val);

Will it silently fail to drive the pin, preventing the PCIe link from being
established?

>  	if (IS_ERR(reset)) {
>  		/*
>  		 * FIXME: GPIOLIB currently supports exclusive GPIO access only.

[ ... ]

> @@ -1918,7 +1918,7 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *=
pcie)
> =20
>  	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
>  		pcie->reset =3D devm_gpiod_get_optional(dev, "perst",
> -						      GPIOD_OUT_HIGH);
> +						      GPIOD_ASIS);

[Severity: High]
This appears to have the same issue. If the GPIO defaults to an input and
is not configured by the bootloader, will gpiod_set_value_cansleep()
silently fail to drive the line later?

>  		if (IS_ERR(pcie->reset))
>  			return PTR_ERR(pcie->reset);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-link_retai=
n-v3-0-81a9d187bb61@oss.qualcomm.com?part=3D2
