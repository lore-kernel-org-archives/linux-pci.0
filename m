Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25437472539;
	Mon,  7 Sep 2026 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781088; cv=none; b=TCK5ywhkl+tbHKAX6x+Q1VKunw74OccmGoeC7jfokYqbR8qAbDYM5hRRgj7jsQXqI8gDBsgsYW+WJaNVIncVvUdKFqv4ubIwu4oYCvo1IVZdFnHdCAxxZMD8nb1MZ69N+SidwSD4VHqMCGMEkCD8T7DbX6iLT4wwnPXM70uazeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781088; c=relaxed/simple;
	bh=kqva3rYFwEfBC/Srwt8NyVyATDE5/p8C9Ihef6Wh+Ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YeqqeIfdD1dlW5jNB6rX9Pb+iq7nKrWCTcBAL5XJEYAVQjsKLO5Afxdcn/DMXJj+NY4lES3XTjH8kyZ9fzCmfrvMauFR0HDy/CI+CZNmaNF0JMeoN0i8StNL5xQneo7qwbfm8fHBZtzJICx+B73ClOD0g0Tu0XSE46wB44WKkIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhhI+EUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhhI+EUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DB31F00A3A;
	Mon,  7 Sep 2026 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781086;
	bh=s6ahpzfDAlhvUb6HUbVjlgBRhGo59IwJgBU3EuSBPUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XhhI+EUvlvQ1oYmHDyIo0CgSoS9Guo63toYBMxjXdd/KREO43dHMmh24/AFMn3j55
	 u/hsB5fAl44x5SMcc7MI9F+3N810xt00/LBb4k420HwGycqvW+9RkNYzg6cH5DUOiN
	 uccPQUjyLKMzjHkt5v/e786b9Yg3ylYakJhsFbWc/MNL3IcOHcM/80hYuqicSu4CWp
	 8YEArlLvS5/8O36w6V90ICVd0387QvtHhfYsfvPkAhjUdWc8pv8CaImJfywdk7bBVQ
	 pYV3WFls4LXM4Pv0WcnFoMDkPynh7klJ+SBfcG0nQhq8/YTlYIwH0YncdpreCXp+3F
	 /SQY63L+Qqang==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260907112606.465778-6-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:38:05 +0000
Message-Id: <20260907113806.55DB31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `spacemit,k3-pcie` compatible string lacks a requirement for=
 any interrupt mechanism, allowing incomplete device tree nodes to silently=
 pass schema validation.
--

commit 92cb9c20a16a6dc1a934eea83a6f78a972ade969
Author: Inochi Amaoto <inochiama@gmail.com>

dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller

This commit adds device tree binding support for the SpacemiT K3 PCIe
controller, modifying the existing K1 binding. It splits register
constraints and interrupt requirements between the two hardware generations.

> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.=
yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> index c4c00b5fcdc0c..54817d6fd9afe 100644
> --- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
[ ... ]
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-pcie
> +    then:
[ ... ]
> +      required:
> +        - interrupts
> +        - interrupt-names
> +    else:
> +      properties:
> +        reg:
> +          minItems: 5
> +
> +        reg-names:
> +          minItems: 5

[Severity: Medium]
Does the spacemit,k3-pcie compatible lack a requirement for an interrupt
mechanism here?

Because this patch removes interrupts and interrupt-names from the global
required list (moved to the then block above), a device tree node for
spacemit,k3-pcie that completely lacks interrupt or MSI routing properties
like msi-parent will silently pass schema validation.

However, the system will fail at runtime because the PCIe host controller
requires an interrupt mechanism. Should a required list including msi-parent
be added to this else block to ensure incomplete device tree nodes are
caught during validation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907112606.4657=
78-1-inochiama@gmail.com?part=3D5
