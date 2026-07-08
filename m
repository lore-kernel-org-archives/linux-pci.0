Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262BD408013;
	Wed,  8 Jul 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502105; cv=none; b=rE8wttTTrFV1s3ZLr1W5S9vs0+EyA2AKO2lWQ7VFn/hb3bZh7LFntPUCRfWVs3Iqsj9zDEeQCg3W/PzP+AG34fWcBtUvJc4aKq6qWlmfah/u794vAJUsrQb3Ql6dv9ITkoja4ODtJyTGZh7UXsqoGwqQOCke41yeOfyJOYVdEoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502105; c=relaxed/simple;
	bh=P+fTFIc3zTm4lUnoS2JEv0wFkbM6kjmvHvTpDQem5xA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lxKFR7voyOqhsX0z2ASEKIZNuF2tvDsST6wrnZsJ9OJ4xeb3oBYYPc0gXykSL4W8Fj3/t3vv/LJgyj5jmD8VuWMymP1ovrzOu+Vm+m3j10CzLpFaeVJTuVLoJYGJzp+EEAME6iijAm7Mxm2hYlchLZ4BSODBNm7AZ5PeeLb1xz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnfTUp/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnfTUp/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963861F000E9;
	Wed,  8 Jul 2026 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502103;
	bh=FAUSVtqet6fcAno27B29SrZvJs6MkDjI+0dDg//GFcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EnfTUp/72nwZY8Y6b49Kh9tdCkddabdE0ig7Jz7gxtC0HX09Tc0/odJMO8gmcM+g2
	 OTjqnDVkAQLB84/dadve3uSJF5g7VfyyXHvqHR4lP5V3PRVrGSQaSWB8G/TyDXgyB5
	 fBvZKQcw58xKQllEVoffZLSkNoNS6qM56tKOHrVjw9mqgHeqdvvEWPb+c1w9I1KCki
	 srFwbG7HyIvpp+39hLt1oloFOpu9Le5wmYwGTWg0eucB8dTt6Jc1sJgVfmIRVjm1Io
	 9Sqe2JLNPvuwuyT1LLuxWryD0YHDl7fUlj04hOIE1L8jGo2Mcght/NeV4rCPEsUzAT
	 xxtpWOjVt8pQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: mediatek: handle optional reset for perstout
 for AN7583
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708090533.19734-2-ansuelsmth@gmail.com>
References: <20260708090533.19734-1-ansuelsmth@gmail.com>
 <20260708090533.19734-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:15:02 +0000
Message-Id: <20260708091502.963861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing T_PERST delay between PCIe PERST# assert and deassert.
- [Medium] Fails to handle non-EPROBE_DEFER error pointers from devm_reset_=
control_get_optional_exclusive().
--

--- Patch [2]: [PATCH 2/2] PCI: mediatek: handle optional reset for perstou=
t for AN7583 ---
commit 78554414cf365c230ecb9c4411ea14d8c699dd5c
Author: Christian Marangi <ansuelsmth@gmail.com>

PCI: mediatek: handle optional reset for perstout for AN7583

The commit adds support for a dedicated perstout reset line for the Airoha
AN7583 SoC to avoid glitches. It introduces the pcie-perstout[slot] reset
name handling and asserts/deasserts it during AN7583 specific startup.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 8b57c3d75b942..3d4de9d694071 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
[ ... ]
> @@ -865,6 +867,9 @@ static int mtk_pcie_startup_port_an7583(struct mtk_pc=
ie_port *port)
>  	size =3D lower_32_bits(resource_size(entry->res));
>  	regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
> =20
> +	reset_control_assert(port->perstout_reset);
> +	reset_control_deassert(port->perstout_reset);

[Severity: High]
Is it intentional to omit the 100ms T_PERST delay here?

Without a delay between assert and deassert, the endpoint device will recei=
ve
a zero-width reset pulse which violates the PCIe CEM specification. Because
the AN7583 quirks likely include MTK_PCIE_SKIP_RSTB, the standard 100ms
delay in mtk_pcie_startup_port_v2() will be skipped, leaving no delay at all
before link training begins.

> +
>  	return mtk_pcie_startup_port_v2(port);
>  }
> =20
> @@ -1020,6 +1025,11 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pc=
ie,
>  	if (PTR_ERR(port->reset) =3D=3D -EPROBE_DEFER)
>  		return PTR_ERR(port->reset);
> =20
> +	snprintf(name, sizeof(name), "pcie-perstout%d", slot);
> +	port->perstout_reset =3D devm_reset_control_get_optional_exclusive(dev,=
 name);
> +	if (PTR_ERR(port->perstout_reset) =3D=3D -EPROBE_DEFER)
> +		return PTR_ERR(port->perstout_reset);

[Severity: Medium]
Will this silently leak non-EPROBE_DEFER error pointers (like -EINVAL or
-ENOMEM) into port->perstout_reset?

If devm_reset_control_get_optional_exclusive() fails with something other
than -EPROBE_DEFER, the error pointer will be stored in port->perstout_reset
since IS_ERR() isn't checked first.=20

When this pointer is later passed to reset_control_assert() in
mtk_pcie_startup_port_an7583(), it will trigger a WARN_ON(IS_ERR(rstc)) in
the reset core framework.

> +
>  	/* some platforms may use default PHY setting */
>  	snprintf(name, sizeof(name), "pcie-phy%d", slot);
>  	port->phy =3D devm_phy_optional_get(dev, name);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708090533.1973=
4-1-ansuelsmth@gmail.com?part=3D2
