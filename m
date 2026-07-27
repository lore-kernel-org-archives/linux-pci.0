Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD93B6370;
	Mon, 27 Jul 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167982; cv=none; b=FVFDJtEkivSAHrdZR9KhFFAghE3Mry1oB3nZuqzQ2+LjoXUkplO9GbGQLAiqodlR6D0p4p0Hc9ZqCP68DSIP1yEtL4VZyt2W7dpGtez1F6i86ncD3lkNzJBkx8L1gWxVCR9/Wi6IsbGGvwu6gojfUm91Vc4gj/K0Bfob73fd+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167982; c=relaxed/simple;
	bh=1mkHuNYlLqdfBP6Lg+OkKg1hp5E2VEl9M4cZWm9gWb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0E8u5SR+9ij8o9dHYtdkzgQMfg4uuLtoqy5n/ITddzTXeV1sLcb48cMXSlMDbufCE8GX4UYVXz7E1JsKxC5JWpZOH5Ujm4yjPFXloirZNHie1aeJzFRENVMI6Rv+tZi9zKRb3pmuhtggDkx1jhIwuT3+dYgyReOxErbr9B0GBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDnCjM6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDnCjM6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93B11F000E9;
	Mon, 27 Jul 2026 15:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167981;
	bh=5b8wfR1Hw7wVsV2VMJYe6HdKTUeUidiN1KK6BCAR/Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SDnCjM6vqNMu9U8GFYd7S1mbtuft06QpqjNX14Gz/oKns05uY2LwmQWIFfSihzm3t
	 PzLCcL8sLmSWw/rzXEscLo8SUg0ut6GJQDmTZmN255/M5A8sZWa86F+Csv0CYnfuRk
	 KKtxop5aZw+sNPzZYS4dsfhNEbJV+uI621m7mvJVfctw53bAPDC07Vpb8MEvM43kvc
	 Qxw3gwR/JyGdqn7tTpkNh7nAfJhy8sHswN3Op6pjx49j+eoNwqEOOe+1Gg1h4ddsEU
	 er9eY6Esv0ERfcQna9zphXcSrKh8NVdn84zkPEn00uIRJtky/PAe6Nzu7MWzEI7lTT
	 aqB2/2pqkcg2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rahul Samana" <rahul.samana@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:59:40 +0000
Message-Id: <20260727155940.D93B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds `compatible =3D "pciclass,0604"` to the `pcie0_port=
` root port node in `kodiak.dtsi` to ensure the PCI core and slot power con=
trol drivers can associate the DT node with the enumerated PCI-to-PCI bridg=
e, which enables child node matching. However, the patch fails to apply thi=
s exact same fix to the sibling `pcie1_port0` root port node.
--

--- Patch [5]: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port=
 as bridge ---
commit 570e5e44fe4845eb64dbbfbc0bb38b9d4ae991da
Author: Rahul Samana <rahul.samana@oss.qualcomm.com>

arm64: dts: qcom: kodiak: mark PCIe root port as bridge

The patch adds the compatible =3D "pciclass,0604" property to the pcie0_port
device tree node. This allows the PCI core to associate the OF node with
the enumerated PCI-to-PCI bridge device, enabling proper matching for child
nodes.

> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/q=
com/kodiak.dtsi
> index fa540d8c2615d..12594967d2c26 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -2296,6 +2296,7 @@ pcie0: pcie@1c00000 {
>  			status =3D "disabled";
> =20
>  			pcie0_port: pcie@0 {
> +				compatible =3D "pciclass,0604";
>  				device_type =3D "pci";
>  				reg =3D <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range =3D <0x01 0xff>;

[Severity: High]
This isn't a bug introduced by this patch, but should the exact same fix be
applied to the secondary PCIe root port node (pcie1_port0)?

Looking further down in arch/arm64/boot/dts/qcom/kodiak.dtsi, pcie1_port0
has an identical structure but is missing the "pciclass,0604" property:

			pcie1_port0: pcie@0 {
				device_type =3D "pci";
				reg =3D <0x0 0x0 0x0 0x0 0x0>;
				bus-range =3D <0x01 0xff>;

Without this property on pcie1_port0, won't devices connected to the
secondary PCIe port fail to properly associate their OF nodes with the
enumerated PCI devices?

This could prevent downstream devices from acquiring essential DT properties
like regulators and GPIOs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-rb3-indust=
rial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com?part=3D5
