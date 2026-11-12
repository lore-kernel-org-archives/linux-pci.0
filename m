Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473231;
	b=4vuSPdiR02cQTmGxoBpSiUJ8sqA/pLsr7rnC3G/NpG6HbEHE+XH9Nwvu0kQm42DTVcc/
	 tV18A+tHHC1Y54QquGKXZ9biL0IuQeENNqhuDjRqhbUuHNz/Mw5amPyIZ1wXECy7ZEZMe
	 /P/Ovn4yROuuuFiiJh6sAjOdWmo8PrKZ1ZCAcuWAk2Kn0Ttbe9PZYx3EhQ0xrQMIjbfpz
	 e0sij3qSLapRB39A5Mx3pq5U6atuG9/pVvSQT6h9nFZXlHLXHnVstpecpOuTX/62dRgbj
	 iceC2XxGAfKNztV9XGVUej1PYijB6OIEkCLAHE7QLSWzFc0cS5LzaloIOkKhyzoI/AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473231;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CBjT5MDSt7nx+9riU9wHHUIpsoMbyC2iDwqrDzV81Vs=;
	b=dh7sB0Um8JkSiRHnNDF+Qsv3wO1T1cfpVlU8jGaXgi+g+6qBhEsKPNLuHDVuoDRVOQJK
	 fgfaSEpIcLHtw3dahVLGS7XrXC8Mm3OeKoBN6JtMObOmlT4m2RSuYHTATE15hzl9Q6aaD
	 WNlVzJAorZIJI9XFdFf3qa3WkiDYPhuNc/CKljrGiZ7Crd2+uE2PSQV+gxb/ME8ljbwj2
	 vuoFo69i9kikMCWCLp8YxKuU+QejhqlliTecu4gJyMRlD2l1cX+Tw9KBRVNvk7cn4Y/K9
	 tv1lnpEETAfO+NzMX8wFjAgDOzr2doJ87W0ydx+4hfcDDyMcG1GqQcxNpg3Y4pBXAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECEbvKVo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFA3606A8A0;
	Thu, 12 Nov 2026 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECEbvKVo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA241F00A05;
	Thu, 12 Nov 2026 08:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473230;
	bh=CBjT5MDSt7nx+9riU9wHHUIpsoMbyC2iDwqrDzV81Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECEbvKVowcLDOvF+JWO6NIFHxFGT2rVdr/F4Xlodx3W/HPf/3a726zHa4E8bKbM1K
	 9c3HQgCAg5ovkaIp+eg0z/xETlM09bjhS+FFj6AvbPHyIDhWR7VO95ggD2yNpkJe/4
	 slAQD8/I2qwFZ5q+CCEeMeWjGaJWxuP3CPWBayAG2JVrjH/HiAav+kecv/b1S6bOvG
	 VeC+ArhoTO6zeaG98Aovp49tKfCLbhh+pcYignDmsAs77E3mzAx9GCkDi8PIgu/GM1
	 nj26fMh2V1uy638ddE+Kfu5j6MYe5wWA48dBKhW4T2vzYZ4Q8i+X4KwcfuG5BkIpOk
	 TU+Ei2HGKrfHw==
Message-ID: <sashiko-outbox-210783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] PCI: qcom: add support for the Shikra PCIe
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linghui Wu" <linghui.wu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261112083355.3884737-3-linghui.wu@oss.qualcomm.com>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
 <20261112083355.3884737-3-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:47:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: qcom: legacy qcom,pcie-shikra compatible naming in
  qcom_pcie_match
--

commit 929cee16b1f49a3c3c6d6d911e16e73ada7cd7fc
Author: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

PCI: qcom: add support for the Shikra PCIe controller

This commit adds the qcom,pcie-shikra compatible entry to qcom_pcie_match
using cfg_1_9_0.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index eba1b2cb30f0a..7573c509d7ce6 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2623,6 +2623,7 @@ static const struct of_device_id qcom_pcie_match[] =
=3D {
>  	{ .compatible =3D "qcom,pcie-sc8280xp", .data =3D &cfg_sc8280xp },
>  	{ .compatible =3D "qcom,pcie-sdm845", .data =3D &cfg_2_7_0 },
>  	{ .compatible =3D "qcom,pcie-sdx55", .data =3D &cfg_1_9_0 },
> +	{ .compatible =3D "qcom,pcie-shikra", .data =3D &cfg_1_9_0 },

[Severity: Low]
Should this compatible string be "qcom,shikra-pcie" (sorted at the top of
qcom_pcie_match alongside "qcom,hawi-pcie" and "qcom,nord-pcie") instead of
"qcom,pcie-shikra"?

Documentation/devicetree/bindings/arm/qcom-soc.yaml marks qcom,pcie-* as a
legacy pattern that must not be used for new entries and already includes
shikra in the preferred qcom,SoC-IP pattern, so using qcom,pcie-shikra locks
in a non-conforming DT ABI name and required adding a one-off const excepti=
on
to qcom-soc.yaml.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112083355.3884=
737-1-linghui.wu@oss.qualcomm.com?part=3D2
