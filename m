Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473656;
	b=y9UrrkW/c4uipgIM0aQUjtWxKqiH1atTjRsA8qsY+etWPzLlj70zx1RUfgIfHpayIMqN
	 FFxjNx5qHr9W9rbSA7FJJsjpMk8PV9qW9MxaGkImDMo4ztSolxzIG6qcsMOKb9rdqakKQ
	 oQybPAcWILlzK4qr/scoWYvtvXyQk7d6YXbVZPhI4EkZ14yqr24jOpuVbYl8Yuqw6zblh
	 BxrKMwXMd9rpbklK7bUD1Bh6gDPs0vHwboEfpJOmDWeole7PfO3q9zyzm9lUcrNMQSMDN
	 Vxd1hwqRETncztc7Lv+0AcacWuPSycTsejetgkDRduSYeNzkOGyEKdTsyy1jaW+nhkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473656;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v9ksNp+RvMBYbN46k8kUwVWmrxWA39ceETTXWzBueLs=;
	b=W0YQmUy6REqNtlDrc/K48+aafNtC/tjrM0rCW1Z5vP0NZ7q38rByajCHNRIzPmIjlKTf
	 /21FuWnqzx5pBX8poTn+qUj55rlIa8jDU4iUbEBQ4+KiNqGxZn2gBgND2qiU377O4nsNh
	 Pv6A9+PTciMJuBp8o/rX6pDJcpZ2J+I171jzeM6buj4pR2/zd4LNTdMg8aBVR9fSTOCyM
	 0OZZ39sNSzbnI+sbaLdPclvs01NVxB+MYlelMCQ08/nznIlGpEH2R8x2C1JRzCza0kxt6
	 PrI7Hj7FYsfkZxob6TW/y8alaGFzzIUBH7E8BUQkWhC/shOkKRflyVpFUxzqbooXcXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqxDc4eF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E15606A33C;
	Thu, 12 Nov 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XqxDc4eF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804241F00A0C;
	Thu, 12 Nov 2026 08:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473655;
	bh=v9ksNp+RvMBYbN46k8kUwVWmrxWA39ceETTXWzBueLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XqxDc4eF03kzcZzrw6EYo/qUCU2Biyb9dJIk1YyLYXx214hTHv3224bFXdWHXwkSS
	 0oHHOP7UQflqWOOZy7Z2wKy7hj94QhvSlN2NLjI8Rx69tBOS81kEiQaVg6dOdMKEHr
	 orZAcXlK+8E2OxytG6rsiqXJs4OpaRq1dx1OBvdn6frwNdp1Ra61/4TKdkpltRMiDW
	 crTjQkWkmzruBIcg9b7FplZ0E0B9Iv17VHweZS+216hRp90RMtjVEiZfAPPzAlh+f5
	 HgfGs4s51/glELNb4EXy8P/wYpjSqAK0OD/AsZXhNhNhaLQrsH8BXwJBeWe34+20G4
	 pemzgHYli2Rhg==
Message-ID: <sashiko-outbox-210797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: PCI: qcom: document the Shikra PCIe
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linghui Wu" <linghui.wu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261112083355.3884737-2-linghui.wu@oss.qualcomm.com>
References: <20261112083355.3884737-1-linghui.wu@oss.qualcomm.com>
 <20261112083355.3884737-2-linghui.wu@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:54:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Low] dt-bindings: PCI: qcom: legacy qcom,IP-SoC compatible order for
  Shikra
- [Low] dt-bindings: PCI: qcom: wrong interconnect slave and tags in
  Shikra example
- [Low] dt-bindings: PCI: qcom: dt-check-style strict violations in
  Shikra example
- [Low] dt-bindings: PCI: qcom: inactive maintainer email in
  qcom,pcie-shikra.yaml
--

commit 283a34a0a4cfab50d007b36100271b61fd8ac267
Author: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

dt-bindings: PCI: qcom: document the Shikra PCIe controller

This commit adds a Devicetree binding schema for the Qualcomm Shikra PCIe
root complex controller and registers its compatible string in
qcom-soc.yaml.

> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Docume=
ntation/devicetree/bindings/arm/qcom-soc.yaml
> index 179aadc86a9f0..72e0f1a824c69 100644
> --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -43,6 +43,7 @@ properties:
>          - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
>          - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
>          - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|=
milos|nord|shikra)-.+$"
> +        - const: qcom,pcie-shikra
> =20
>          # Legacy namings - variations of existing patterns/compatibles a=
re OK,
>          # but do not add completely new entries to these:

[Severity: Low]
Should this new binding use the qcom,SoC-IP naming order (qcom,shikra-pcie
and qcom,shikra-pcie.yaml) instead of legacy qcom,IP-SoC?

Documentation/devicetree/bindings/arm/qcom-soc.yaml requires new bindings
to use the qcom,SoC-IP format, and the pattern immediately above already
matches qcom,shikra-pcie without needing a one-off exception.  Other Shikra
bindings (such as qcom,shikra-gcc and qcom,shikra-qmp-gen2x1-pcie-phy) and
recent codename PCIe bindings (such as qcom,hawi-pcie and qcom,maili-pcie)
follow this convention.

> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-shikra.yaml =
b/Documentation/devicetree/bindings/pci/qcom,pcie-shikra.yaml
> new file mode 100644
> index 0000000000000..69463dae9f183
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-shikra.yaml
> @@ -0,0 +1,192 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-shikra.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Shikra PCI Express Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[Severity: Low]
Should Manivannan Sadhasivam's email address be mani@kernel.org here?
Commit e3d7fda088c3 ("dt-bindings: PCI: Update the email address for
Manivannan Sadhasivam") replaced the inactive linaro.org address across
the PCI bindings.

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,shikra-gcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/interconnect/qcom,shikra.h>

[ ... ]

> +                interconnects =3D <&system_noc MASTER_PCIE2_0 QCOM_ICC_T=
AG_ALWAYS
> +                                &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWA=
YS>,
> +                                <&mem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_A=
CTIVE_ONLY
> +                                &config_noc SLAVE_PCIE2_0 QCOM_ICC_TAG_A=
CTIVE_ONLY>;
> +
> +                interconnect-names =3D "pcie-mem", "cpu-pcie";

[Severity: Low]
Does the cpu-pcie interconnect path point to the wrong slave on config_noc
and use the wrong interconnect tag macros?

In include/dt-bindings/interconnect/qcom,shikra.h, SLAVE_PCIE2_0 (29) is a
system_noc slave ID; on config_noc, index 29 is SLAVE_PKA_WRAPPER_CFG
(&qhs_pka_wrapper in drivers/interconnect/qcom/shikra.c), while the PCIe
config slave on config_noc is SLAVE_PCIE_CFG (26).

In addition, Shikra uses the SMD-RPM interconnect driver
(drivers/interconnect/qcom/icc-rpm.c) and
dt-bindings/interconnect/qcom,rpm-icc.h.  Passing QCOM_ICC_TAG_ACTIVE_ONLY
(0x3) from qcom,icc.h sets both RPM_ACTIVE_TAG (0x1) and RPM_SLEEP_TAG
(0x2), causing qcom_icc_bw_aggregate() to vote for both active and sleep
states instead of active only.

> +
> +                iommu-map =3D <0x0 &apps_smmu 0x800 0x1>,
> +                            <0x100 &apps_smmu 0x801 0x1>;
> +
> +                resets =3D <&gcc GCC_PCIE_BCR>;
> +                reset-names =3D "pci";
> +
> +                power-domains =3D <&gcc GCC_PCIE_GDSC>;
> +
> +                max-link-speed =3D <2>;
> +        };
> +
> +    };

[Severity: Low]
The example triggers several scripts/dtc/dt-check-style --mode=3Dstrict
warnings:

- pcie@45e8000 has an unused pcie: label.
- Properties inside pcie@45e8000 are indented by 8 spaces instead of 4
  spaces relative to the node, which also pushes several lines past 80
  columns.
- ranges is placed after #address-cells and #size-cells, and standard
  properties such as num-lanes are placed after the vendor-prefixed
  linux,pci-domain property.
- Continuation lines inside interconnects are aligned with the opening '<'
  instead of the first cell value after '<'.
- There is a trailing blank line before the closing brace of the soc node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112083355.3884=
737-1-linghui.wu@oss.qualcomm.com?part=3D1
