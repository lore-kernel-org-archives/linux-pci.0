Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317423;
	b=e01BBPeSofseDVo0aOPNFHmkz1KKrXUBBB0c1hf7DPPKj86QfFMOAWsnK0RSWsfU9aVi
	 PGgjrMxSZob3/wRwujpRiS1j2Ctx5rYmUmCVZK7Ki9cu7jfoBNLR5E/EHMltH6DEFTQ1r
	 xn2Y24OJXYI1N7ajqHOcEY3QVMzcDVPfA12xhLOQ0HtyNT9SPNp0vA1ZJqeT3MDHK+sxu
	 zRFd/eOzdBrZJv2EgOAUWv9tzdEkJWyXMUhRCRa57UDXXYg1SvTlky6Ud7sRJZ1XMp0h7
	 JGbxcuE6plQMA3+Ysw5eXbvkjtKfkZXq30MW93It3sC1ZzTsWpjVW2kl5WcSyZj/EpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317423;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tGMqlisNNFYRCn7cyGPujhdz7ZkfSSOP0/Y3sOEE+Ks=;
	b=XAf6EGDMBtJ+5DurDCVlDYYIL5vEwdQ3zb0ScuR8X+gSbE+XSSmW9Ysou/268SVk8Mwn
	 2q6TKixPdHlSb/EgAqiYY/wFVWz+5PhU1x5v+YzkdA6Sm+deiScR2AU7PaZUWdYo5KHFD
	 kV/lA6KU0tI2E632W5G52JY2epSIOcam9Ra8ONi6oTI0D2bdJ5cpxzCbdQFScAKyrti8p
	 VpvjN818z1bLzIVFVRlPAVUBFlyV/6krmXwUtghdEFGPFX3rajIDsAv3zDsK8ephkIhSN
	 v7GDOXGrdU3fE0Wbly4QCEBZ7czHGtqZWjflvgpFqGeFgyF2L6DmSKMNqp0ozzURNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ki00k1M0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9625606A320;
	Sun, 22 Nov 2026 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ki00k1M0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809F21F000C4;
	Sun, 22 Nov 2026 03:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795317422;
	bh=tGMqlisNNFYRCn7cyGPujhdz7ZkfSSOP0/Y3sOEE+Ks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ki00k1M0xgMk5qa53lP+ao7e83VfgALfLVkZCqcZBALEwYZttqYXY5fTclH/6YH5K
	 PGSHtXhDYDUOiesfCs4aK/v85TZ5Y7VNv4x8FAfQG5QJpbxvHga9/G+ScRcULk0mAD
	 d4eZpy+GgQRJRbBplNUpOnp4EsZlQn8dQ09gjDB2skzouLvY2a0sYKuPdr+ePfBn+N
	 FwEG0nrSIIJRwItTZNUkUoiBrsxlhTXJcnyVJTUpjLV99u3i9zGcNcD15GZYsaTgk7
	 /U8w0KIpfpLxcD8Mt5Z5hAZUgdrkfvCNp33ZKUAJOrZcT5ankRZmuUGzNntNYgYTrw
	 1vrjsNiyx32oQ==
Message-ID: <sashiko-outbox-227667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] arm64: dts: qcom: nord: Add PCIe endpoint nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261122-nord_ep-v1-11-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
 <20261122-nord_ep-v1-11-6d8839ffa9aa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 03:17:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] arm64: dts: qcom: nord: overlapping atu and msix reg regions in
  pcie0_ep
- [High] arm64: dts: qcom: nord: non-power-of-2 msix BAR size in
  pcie0_ep
- [High] arm64: dts: qcom: nord: missing msix reg region in
  pcie1_ep..pcie3_ep
- [Medium] arm64: dts: qcom: nord: missing num-lanes =3D <8> property in
  pcie0_ep
- [Medium] arm64: dts: qcom: nord: 1 MB addr_space reg size in
  pcie1_ep..pcie3_ep
- [Low] arm64: dts: qcom: nord: missing gpio.h include in
  nord-embedded.dtsi
--

commit 2599e7213b15292427fa12c65b538dbb750cb433
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

arm64: dts: qcom: nord: Add PCIe endpoint nodes

This commit adds the pcie0_ep..pcie3_ep endpoint controller nodes and
their pin control states for the four PCIe instances on Nord.

> diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boo=
t/dts/qcom/nord-embedded.dtsi
> index e6d0bd21744e2..829fc63681c1d 100644
> --- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> +++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
> @@ -1638,6 +1638,287 @@ pcie_phy: phy@1b00000 {
>  		status =3D "disabled";
>  	};
> =20
> +	pcie0_ep: pcie-ep@1b80000 {
> +		compatible =3D "qcom,nord-pcie-ep";
> +
> +		reg =3D <0x00 0x01b80000 0x00 0x00004000>,
> +		      <0x00 0x40000000 0x00 0x00000f20>,
> +		      <0x00 0x40000f20 0x00 0x000000a8>,
> +		      <0x00 0x40010000 0x00 0x00020000>,

[Severity: High]
Should the atu region size in pcie0_ep be 0x00010000 (like
pcie1_ep..pcie3_ep) instead of 0x00020000?

With a size of 0x00020000, the atu region spans 0x40010000..0x4002ffff and
overlaps the msix region at 0x40020000..0x400213ff.
dw_pcie_get_resources() claims the full range in iomem_resource via
devm_ioremap_resource() and sets pci->atu_size =3D 0x20000, which causes
dw_pcie_iatu_detect() to probe unrolled iATU indices 128..255 at
0x40020000..0x4002ffff and write test patterns (0x11110000) into the MSI-X
BAR memory space.

> +		      <0x00 0x40100000 0x00 0x0ff00000>,
> +		      <0x00 0x01b84000 0x00 0x00001000>,
> +		      <0x00 0x40030000 0x00 0x00010000>,
> +		      <0x00 0x40020000 0x00 0x00001400>;
> +		reg-names =3D "parf",
> +			    "dbi",
> +			    "elbi",
> +			    "atu",
> +			    "addr_space",
> +			    "mmio",
> +			    "dma",
> +			    "msix";

[Severity: High]
Does the 0x00001400 msix region size cause pci_epc_set_bar() to fail with
-EINVAL?

pci_epf_mhi_bind() records resource_size(res) of the "msix" resource as
epf_mhi->msix_size, and pci_epf_mhi_epc_init() passes that directly as
msix_bar->size to pci_epc_set_bar(), which requires a power-of-2 BAR size:

drivers/pci/endpoint/pci-epc-core.c:pci_epc_set_bar() {
    ...
	if (!is_power_of_2(epf_bar->size))
		return -EINVAL;
    ...
}

[ ... ]

> +		phys =3D <&pcie_phy 0>;
> +		phy-names =3D "pciephy";
> +
> +		reset-gpios =3D <&tlmm 2 GPIO_ACTIVE_LOW>;
> +		wake-gpios =3D <&tlmm 0 GPIO_ACTIVE_LOW>;

[Severity: Low]
These nodes introduce the first uses of GPIO_ACTIVE_LOW in
nord-embedded.dtsi, but neither nord-embedded.dtsi nor nord.dtsi includes
<dt-bindings/gpio/gpio.h>.  Should nord-embedded.dtsi include
<dt-bindings/gpio/gpio.h> directly so it does not depend on inclusion order
in board .dts files?

> +
> +		pinctrl-0 =3D <&pcie0_ep_default>;
> +		pinctrl-names =3D "default";
> +
> +		linux,pci-domain =3D <0>;
> +
> +		status =3D "disabled";
> +	};

[Severity: Medium]
Is pcie0_ep missing num-lanes =3D <8>?

On Nord, pcie0 in nord.dtsi is the 8-lane port of the quadfurcated PHY and
specifies num-lanes =3D <8>, while pcie1_ep..pcie3_ep below specify
num-lanes =3D <4>, <2>, and <2>.  Without num-lanes on pcie0_ep,
dw_pcie_get_resources() leaves pci->num_lanes as 0 and
dw_pcie_link_set_max_link_width() skips programming PORT_LINK_CTRL,
LINK_WIDTH_SPEED_CTRL, and PCI_EXP_LNKCAP_MLW.

> +
> +	pcie1_ep: pcie-ep@1b88000 {
> +		compatible =3D "qcom,nord-pcie-ep";
> +
> +		reg =3D <0x00 0x01b88000 0x00 0x00004000>,
> +		      <0x00 0x50000000 0x00 0x00000f20>,
> +		      <0x00 0x50000f20 0x00 0x000000a8>,
> +		      <0x00 0x50010000 0x00 0x00010000>,
> +		      <0x00 0x50100000 0x00 0x00100000>,

[Severity: Medium]
Should the addr_space size in pcie1_ep, pcie2_ep, and pcie3_ep be
0x0ff00000 (255 MB, matching pcie0_ep and the full outbound slave window in
nord.dtsi) instead of 0x00100000 (1 MB)?

dw_pcie_ep_init() passes the addr_space size to pci_epc_mem_init() as the
total outbound address pool, so a 1 MB size limits outbound iATU mappings on
pcie1_ep..pcie3_ep to 1020 KB after reserving ep->msi_mem.

> +		      <0x00 0x01b8c000 0x00 0x00001000>,
> +		      <0x00 0x50030000 0x00 0x00010000>;
> +		reg-names =3D "parf",
> +			    "dbi",
> +			    "elbi",
> +			    "atu",
> +			    "addr_space",
> +			    "mmio",
> +			    "dma";

[Severity: High]
Does omitting the "msix" reg entry on pcie1_ep, pcie2_ep, and pcie3_ep
cause pci_epf_mhi_epc_init() to fail with -EINVAL on those instances?

In drivers/pci/controller/dwc/pcie-qcom-ep.c, "qcom,nord-pcie-ep" maps to
cfg_nord with .msix_capable =3D true, and qcom_pcie_epc_get_features()
unconditionally reports msix_capable =3D true without checking whether an
"msix" resource exists.  When pci_epf_mhi is bound to pcie1_ep..pcie3_ep,
epf_mhi->msix_phys is 0 and pci_epf_mhi_epc_init() fails on PERST#
deassertion:

drivers/pci/endpoint/functions/pci-epf-mhi.c:pci_epf_mhi_epc_init() {
    ...
	if (epf_mhi->epc_features->msix_capable) {
		if (!epf_mhi->msix_phys) {
			dev_err(dev, "MSI-X BAR address not configured in DT\n");
			return -EINVAL;
		}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-nord_ep-v1=
-0-6d8839ffa9aa@oss.qualcomm.com?part=3D11
