Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D384C10D5;
	Tue, 29 Sep 2026 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671687; cv=none; b=LC7R06CyX/0wya0JcQnTTAouwte3i5Z6KZfOs3XW7WdIm6O0d3WtAji95bdUJJepj17KeFG5efY3io+IvP9Wv7+sgQlpNxBuOP59VpHB7FO4EGJ4hZs/H/t2Pu0mfzI9uXrbPKedEfeGHWg9FOppl6RuXgsokI1xWiNmgiWvIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671687; c=relaxed/simple;
	bh=9TrIHSG91A+dQ2geGZGe5KCfqjkmOIEeVjkr2HmqM3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t/X6DZ54NqC95QK97zyf/WkHS5ED/0SK0qQQjBucw9PmqYBp9pp4dFGwUnBCsyD6e4l0zO6yVOfu+Qct9bcXHGcIozHMuTG5YQdYWDPWLvngLGfNCzUGbLV0COCKX5e/LCk0TL+nGVAGb2qEzohVZ0WRimtchA6O2m0RN+TkFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPKPBXpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPKPBXpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7DA1F000FF;
	Tue, 29 Sep 2026 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671678;
	bh=5H5DcXh9sdB0LXaSvFxtPpaksWjH7Yk55kkVKNhBh2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPKPBXprZf7LL7yyj/T7AaAh7LrOZGUJobKOABX55cqNXdWtttVGDDQTWJ+w1aTJ8
	 FDCXRQIJuUtqonpWdCahe5CO9kknSI3FjGLBahUknaqo8uxIgsQURM2yJBc+SeJS9o
	 MxjYotAH4X0Ymj7fPwrtjTlOeS2lqopauci2c9KenG5lU2I+8ab7rf1yy9mhC9Gmld
	 TJu8CZ7Cj0cGNhIgR0oCsfv2oYLaMYs2V1336chkt7q/oP3q04y6rf/+oqc3GxM+1y
	 pHWzGaThKii6HZfQLcQsh3IQ86zXpXOyNTpvUThzkfaAdqkaeEBMjRnFGtsCRnAKwh
	 Q6MBp8btX+23g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260929083755.458238-6-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:47:57 +0000
Message-Id: <20260929084757.AA7DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: pci: spacemit: K3 incorrectly restricted to 'msi' i=
nterrupt
--

commit f1407822dae59764a20613a52957242f9229a513
Author: Inochi Amaoto <inochiama@gmail.com>

dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller

Add binding support for the PCIe controller on the SpacemiT K3 SoC.
This controller is almost a standard Synopsys DesignWare PCIe IP,
with some extra link and reset state control.

> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.=
yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> index c4c00b5fcdc0c..af32e427c0c5d 100644
> --- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
[ ... ]
> @@ -66,6 +70,8 @@ properties:
>    interrupt-names:
>      const: msi
> =20

[Severity: Medium]
Since this top-level constraint applies to all compatible strings, doesn't =
it
prevent the K3 variant (which uses an external MSI controller) from defining
its required standard PCIe interrupts?

If a 'spacemit,k3-pcie' device tree node adds standard PCIe host interrupts,
running 'make dt_binding_check' triggers a validation failure because the
global constraints limit the list to exactly one MSI interrupt. A correct
hardware description specifying standard DWC interrupts (e.g., 'aer', 'pme',
'intx') will fail schema validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083755.4582=
38-1-inochiama@gmail.com?part=3D5
