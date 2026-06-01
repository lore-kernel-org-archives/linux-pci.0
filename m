Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBC391850;
	Mon,  1 Jun 2026 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307977; cv=none; b=KnAtEjf+6Khu2zkbdE60DCGsDBXFaT9ATcgSHKbexODl3cFTjO818pdiOlWKl43VUUR/+cwgTjsZkB8b20ewwxVg8taXHSoNECFB0+pqPSp59uEzhkzQ6K+BCBNKXSNfFt5PM7dO04sjcIhUnKZdlRmNJPKYClp/ePv0FXOt9RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307977; c=relaxed/simple;
	bh=cmB0WB57eV8hvZoXZgL2VUpRf5Tko8Zgifrd1TcDyss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFeSoTA4rLPMpSuJa2QKZxU/MLntG21loWSLPbTj8rLN4TTE79mu7CP4GRh9CY9DmmbduybdG6T2JeF4bWKcWPdMch+MEjzzBIQ//SzPBx3OSipewfXM2Gh+TBJkh9epGW23k19nD18BGWODklOKlCLECJUTfgnnxRKvy+GdVvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXpJNDe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXpJNDe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAFF1F00893;
	Mon,  1 Jun 2026 09:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307967;
	bh=7JiUq0f15ZNm29JmL4+7a0AVpiq8zNtF+xhweVyH0/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dXpJNDe0Srr0v5FVpP7Qk3DORq5GrJddjc93HpnaJM/XzrJ2UdemiI490WxEqG7rH
	 pffqDE9MIasRJmpcHsCrrUpkUxGBkF2rqQHewlOk5yc7zHgZmu+zDYAFPlxcfq+6JK
	 V8e8VG3iMmiFDGNhXpyI06D4DJX7pN64Ld4vovPzs3vk3O/h8U0oA/NoGDEtkJOUDp
	 rLdwiJPN0PYe2TnvipFJlDSqDAyS+Ob6EAR1BB7Xb4vrbQYWTU8bK5ChJKLAhDEH1G
	 Mkcyxw0f6HYztUCRnp0+RIRi3kTarENCLQ7PB1VLODLIsXgJTE1o3SphsjHL05BNHQ
	 fdceVDXdYVpfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] PCI: qcom: fix parsing of PERST# in the legacy case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260601-sm8350-wifi-v1-1-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-1-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 09:59:26 +0000
Message-Id: <20260601095927.5AAFF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct return on devm_gpiod_get_optional failure in qcom_pcie_prob=
e() bypasses PM runtime cleanup.
--

commit 40b8aa014962b990fbbdd6f190bcea40db01e096
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

PCI: qcom: fix parsing of PERST# in the legacy case

This commit moves the parsing of the RC's perst-gpios to qcom_pcie_probe()
to handle both mixed and legacy device tree configurations without acquiring
the same GPIO twice.

Closes: https://lore.kernel.org/r/gieaybsg2ckxpctvqj77nlwu7utama2yeyvebkonm=
exsxrra3v@v3fobqasxnmy/

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 11fc604898926..7664c7c28c0e3 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -2107,6 +2093,15 @@ static int qcom_pcie_probe(struct platform_device =
*pdev)
> =20
>  	pp->ops =3D &qcom_pcie_dw_ops;
> =20
> +	if (of_find_property(dev->of_node, "perst-gpios", NULL)) {
> +		pcie->reset =3D devm_gpiod_get_optional(dev, "perst",
> +						      GPIOD_OUT_HIGH);
> +		if (IS_ERR(pcie->reset))
> +			return PTR_ERR(pcie->reset);

[Severity: High]
Does this direct return bypass the PM runtime cleanup?

Earlier in qcom_pcie_probe(), pm_runtime_enable(dev) and
pm_runtime_get_sync(dev) are called successfully, which increments the
device's PM runtime usage counter.

If devm_gpiod_get_optional() fails here (for example, with -EPROBE_DEFER
if the GPIOs are not yet ready), returning directly leaves the PM runtime
usage counter leaked because the goto err_pm_runtime_put path is skipped.
This will lead to an unbalanced pm_runtime_enable warning during probe
retries.

Should this be updated to assign the error to ret and use goto
err_pm_runtime_put instead?

> +
> +		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be u=
pdated!\n");
> +	}
> +
>  	ret =3D qcom_pcie_parse_ports(pcie);
>  	if (ret) {
>  		if (ret !=3D -ENODEV) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601-sm8350-wif=
i-v1-0-242917d88031@oss.qualcomm.com?part=3D1
