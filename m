Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEFC3BD22B;
	Thu, 15 Oct 2026 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049090; cv=none; b=e+Nvgm2rAPtAx1ZUmtkBlZe9OiqHEjReX+Xmye3r7bjHy0ZqbO6T4RUSbN8/mU0Yy7f9LqL0b7YR3VRZsEZIG78fdhh6da5hIFgBL5d47JcSeZj1qemveqnsmfFbYsk1zMJLVUaxx98TyKKrTYhurcE8pnDrU0ZaXhcNd9Lw5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049090; c=relaxed/simple;
	bh=1ple6o8vZJ1pE0cikq5UbnzwXT2e63w6Y53L6jAbN5Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ugjKIxn6u3UTQUHrgazqq+Sge/FEPHr+G8PBXSgowcqcFJ3pPPL6v5Wx+JcfFOEcoq9pEAx7NH9zhir3HMC++tTID6A0DMEq7AnE5CNBCHVAkkQEoB7GQh9E/3ud99f0DQu6DSPbwCcN+ms0bxB/EekL8rBw/dr9hxTLWWQlNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKrU5LVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKrU5LVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C51F000C8;
	Thu, 15 Oct 2026 07:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792049081;
	bh=Q1Z9za6oo29nkHNpozCOQDYhnQmB0oWf5hl1iKUQ2ZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKrU5LVcJG3X21vU4st6SKX6r0ukhsIOh9vPvjBa4qUheJYYDgsgqBm16+QG1EHE9
	 tDb5A6OxYcZOkAFACtVrB6/qLlEUvCS+9/KMs6EqIYLqTzKrfzIGKsgPoZIvn1SKfF
	 G8P3dn4HpxEaqZWBeEj6/XvcIM6CmEAE197YBPLEXO8SxQom4pKigjPBmYwAZFUEzh
	 BtDENveazQKp6LorzokRCEuqGA/aikZA3uU4kIUrKSANfj+J7acImZ3SMq3sOKGkjl
	 CIYndGwk0QA1LQwnNoVPnD9JIvKeXMorRzmGwWlkF2TQQJLb8mIpZxUPTyehasLPsc
	 UG8orUzEDN7bw==
Message-ID: <sashiko-outbox-172406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/24] dt-bindings: PCI: Add ZTE ZX279128S host
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Navid Ghahremani" <ghahramani.navid@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261014072109.1759502-13-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-13-ghahramani.navid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:24:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: pci: custom enable-gpios bypasses regulator framework
--

commit 4e7065d52cc5c001e2bd9b479582baa2dabea3c6
Author: Navid Ghahremani <ghahramani.navid@gmail.com>

dt-bindings: PCI: Add ZTE ZX279128S host controller

This commit adds the Device Tree binding for the DesignWare PCIe host
controller on the ZTE ZX279128S SoC. It defines the required registers,
interrupts, clocks, resets, and PHYs. It also introduces optional board-lev=
el
GPIOs for resets and enable lines.

> diff --git a/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yam=
l b/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
[ ... ]
> +  reset-gpios:
> +    maxItems: 1
> +    description: Optional board GPIO reset line for downstream endpoints.
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: Optional second board GPIO enable line driven together =
with reset-gpios.

[Severity: Low]
Does this custom enable-gpios property bypass the regulator framework?

In Device Tree, board power or enable lines should typically be modeled usi=
ng
standard regulator bindings (such as vpcie-supply) linked to a regulator-fi=
xed
node, rather than using hardcoded raw GPIO properties directly in the PCIe
controller node.

A review of existing PCI bindings shows no other uses of enable-gpios. Could
this be modeled with a standard regulator instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014072109.1759=
502-1-ghahramani.navid@gmail.com?part=3D12
