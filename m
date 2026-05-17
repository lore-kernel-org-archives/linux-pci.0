Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6D309F00;
	Sun, 17 May 2026 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778986128; cv=none; b=DHa/2De5ulxjZFxUty/Ms7J1Vw8mk3mkZepIR6/LDtwmCSJrOubTEMk84iXQNrcYfM03glN4ueD/w7BsxXo6iVtwRgWOqCrvilASMo7EugutmREZVh4jQ6CzivR9tPUm3njCZI+Z43yVHB5A365MQplxbGd6aZ3i6SWZqoYmZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778986128; c=relaxed/simple;
	bh=r0wa5XZ6C+Vg6UCPpqbIPy9bor/CpgC/9t4JCPUzljw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mIVOUEU6dSVYr8zN9gv19t1EqOS9m+U8D4dBz2uTPAJbLvzbpFWt18mQ9hp/H03jGLpEGxTvKxd0MbVBqOZJeOfYJI5CEC8p2fDeMuvKAcpuLZULwmILJGHJCZI+S/ntkfFvVi2q9fygW3rTMBf2iwFtlQaRyP79xuj3N3QUVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZbqR7P1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZbqR7P1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F346C19425;
	Sun, 17 May 2026 02:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778986128;
	bh=r0wa5XZ6C+Vg6UCPpqbIPy9bor/CpgC/9t4JCPUzljw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hZbqR7P1ZEH7Vi6kw+FxAfyKh1oRQz8wj4X9gLQ+1Eva1evT2Q1i+ESI4oXq3Jv2v
	 t1WIRfjBn+zr4/tlqfFhqq3xPC43q2rZUIm8ChxuJHPMdOwcGhcuEwtnfKS61EQUXR
	 xWvps9bHpm9gDiF5KMxeCVQCi9FfqPGiuQOBAjUHI18xWiKvCs+txlOQA956xFhtnG
	 zLaZctQNxQ/lXIvMmAT3dOXOV0xYxFgonAAxDfvnpMB36odZLdB+9FsYvNH12przES
	 bHQ7G+MpKv+CNsne7VWMdTctzZV98kHH+UVL8Fc+hh1re4ixsxcu2Sfpz/h6QcnPL9
	 nhDS1mZO9f95Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260517014841.254085-5-inochiama@gmail.com>
References: <20260517014841.254085-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 02:48:47 +0000
Message-Id: <20260517024848.4F346C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The binding completely omits the `interrupts` and `interrupt-nam=
es` properties for the host controller.
- [Medium] The schema omits standard legacy INTx interrupt routing properti=
es (`#interrupt-cells`, `interrupt-map`, `interrupt-map-mask`).
- [Low] The `phy-names` property lacks an `items` definition to restrict va=
lid string values.
--

commit 7b8ba34456e71d6a9cf1028caa5504d64e8f58ba
Author: Inochi Amaoto <inochiama@gmail.com>

dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller

This commit adds device tree binding support for the PCIe controller on the
SpacemiT K3 SoC. The controller is based on the Synopsys DesignWare PCIe IP
with some extra link and reset state control.

> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.=
yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> new file mode 100644
> index 0000000000000..46147a37a9ce6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
[ ... ]
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  msi-parent: true
> +

The driver implementation reads and clears interrupt status registers for
host-level events, and references registers for receiving INTx events from
downstream devices.

Should this binding include interrupts and interrupt-names properties to
document the host's interrupt routing?

Additionally, should standard legacy INTx interrupt routing properties like
#interrupt-cells, interrupt-map, and interrupt-map-mask be included in the
schema and example to support downstream devices that do not use MSI?

> +  phys:
> +    description:
> +      PHY phandle from the Combo PHY, the lane number does not depends
> +      on this, since the number of lanes provided by Combo PHY can be
> +      1 or 2.
> +    minItems: 1
> +    maxItems: 6
> +
> +  phy-names:
> +    minItems: 1
> +    maxItems: 6

This isn't a bug, but the phy-names property lacks an items definition to
restrict valid string values. The schema allows any arbitrary string here.

Since the driver retrieves PHYs by index rather than name, is this property
necessary, or should the expected string items be defined?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517014841.2540=
85-1-inochiama@gmail.com?part=3D4
