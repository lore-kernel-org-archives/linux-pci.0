Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107563A6F17
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551255; cv=none; b=gf+1rNebB0D+SL5dKq0grfesp4qAlQG0lBx6HLC4Kml0BOFAF4fptxDJDMOL/uLDWVIEfviwZcy02hlUFfaTfvatJWIrIZCBt6oW95MICMRrWgGzGXNMfu3J2soTGJmOewiTET5paV3J7Q3NLSmmFfcWFUaW/GtL3SC33QY+ig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551255; c=relaxed/simple;
	bh=3IA6AOjP3L75iLGHSpmwLIkxrMGe/tIQItgSz65mkHs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lQ9/E9IaySOktNvTloSMXnvjJC/+CR50zDxizH1Zr8E5rXA4BexbGz/w/Ald7y+Fr+ZXDdd83W/uSA6L3za9OpibT8r5JwUA30hrj5GwOyj9ZztGVudKiCN+vvPq4JQtWfOLYNoNMaUZWqXH3MOXyIG/Q71HQFgBLc7gf+rDxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOMRDeNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOMRDeNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807981F000FF;
	Fri,  9 Oct 2026 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551253;
	bh=MrIJLtUc7Es0DLhcf0guFmKQw0BdcjicFekCTV0E/N4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WOMRDeNZPd5w93O4poV9Lj1bRSZ0Vgh4AX2Y3GN//Tr42e9Cf5Jme5p+TBOMB34ku
	 fFtfSV3cphvmPfOI5AMyuWiF68RaruGz7aNdJycZ73Tvdc4bW0raRz+xGc6GQ+NYlt
	 XVyXwBS10wMgoKZQNdSRU1zOhHrbmg/bkvvPEfTYB3eA6/CSqY3/wcHXuLXUbsahBc
	 Mt+apv3qRISP6nzlZxK1HqIZ0K6yOwt4At89AMJavoDI85tFZJ7jOMnJpbyRnqZuOt
	 SkB+4YRSeX7oWKJtKD9NWx8N0hzd9hujA6LcS7wy9xDIa/Lsg8RD64p2rAtbjelv3j
	 Xjq5K2xuG0x1w==
Message-ID: <sashiko-outbox-165595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable halting feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
References: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:07:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: qcom: halt registers not cleared on 2.9.0 SoCs due to ignor=
ed flag
--

commit 209095cd3cdb28151146164ab8aa7f9f0f975948
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom: Disable halting feature

This commit adds a noc_ensures_ordering flag to the PCIe configuration
for SoCs where the NoC handles inbound transaction ordering. Setting this
flag disables the PARF write, read, and BDF halt features at the
controller, which aims to improve inbound DMA bandwidth. The logic to
clear these registers is added to qcom_pcie_init_2_7_0() and enabled for
several hardware configurations.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..73eb303919c19 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c

[ ... ]

> @@ -1624,15 +1652,18 @@ static const struct qcom_pcie_cfg cfg_2_4_0 =3D {
> =20
>  static const struct qcom_pcie_cfg cfg_2_7_0 =3D {
>  	.ops =3D &ops_2_7_0,
> +	.noc_ensures_ordering =3D true,
>  };
> =20
>  static const struct qcom_pcie_cfg cfg_2_9_0 =3D {
>  	.ops =3D &ops_2_9_0,
> +	.noc_ensures_ordering =3D true,
>  };

[Severity: Medium]
Will this flag actually take effect for 2.9.0 SoCs?

Looking at the initialization routine for 2.9.0:

drivers/pci/controller/dwc/pcie-qcom.c:qcom_pcie_init_2_9_0() {
	struct qcom_pcie_resources_2_9_0 *res =3D &pcie->res.v2_9_0;
	struct device *dev =3D pcie->pci->dev;
	int ret;
	...
}

It does not appear to check the noc_ensures_ordering flag or implement the
logic to clear the PARF AXI_MSTR halt registers.

Since the flag is explicitly set here to optimize performance, it seems the
inbound DMA bandwidth improvement intended by disabling the halt features w=
ill
be completely missed on 2.9.0 hardware.

Does qcom_pcie_init_2_9_0() also need to implement the halt register cleari=
ng
logic, similar to the updates made in qcom_pcie_init_2_7_0()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-halt-v1-1-=
4a2d7899d91f@oss.qualcomm.com?part=3D1
