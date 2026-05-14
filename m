Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD8B3859DC;
	Thu, 14 May 2026 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755201; cv=none; b=J1fvHA5C4rsqzatjX/N4Aq+XBFh4teejadz2EBnLlLJF3Zv7O9atWWPauqdzdtPONB/NMcbRWxrXDPTx4uSI10pjetkxVBbNVHjjUAPJ+SoJzokBNY0zyEQ8OY2q0U4+qw2NEhipyFsa6ewQuJXxkpCdkD759zlJvutaduXiCuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755201; c=relaxed/simple;
	bh=19V1/DSpSPv13DRtRXEh4R7F9Fg0pMXSA4RISx5V4kE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FqpIQ++o7G8vnNc5QjMLCbyJ9E5fSNWymAJi5Z+1kBz1vfAcYot6i/hakOegpKpd+dTZibDrpxGeCZ6RUCSd0CFE9fKS1G44xLolFu0TkNwVQMRzogs3M6UnQTcPONha0g25c5JNUUni6VOoR013r5ux1ukxJPtzcCopBHdsNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfQNDW0G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfQNDW0G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02853C2BCB8;
	Thu, 14 May 2026 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778755201;
	bh=19V1/DSpSPv13DRtRXEh4R7F9Fg0pMXSA4RISx5V4kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=kfQNDW0G9BbD3pEtNuayyRcXP8XF9MNSqnaPO2y4k25HLQdnos6vvq9ApzE31r2vg
	 yUoTdYQAmqSr9k+QBrcw/5NEHYKURjVTJ55uvbg29K/jaV/VhIYPtLzS8nFCz3LEY5
	 CCpb+zfndUq4ALI/rvYWEKIHU1rGXzaXwKlwP/ktRWQxh9fzADqGCbz9/wfivZdFbw
	 q14DOFL1FSMjWUDd80lzsZVpnp6pIGjzwlUaugpRbtNgPk+Ni1ZcG/fiFHJbN5agVe
	 mA8BwLlGg9/9chBKcVWIqIaeX7Ka9EcEVqso0+6lVSgrWiXZOWVXOnrbdgWsQB7JNK
	 P2RTc8Aa2E4Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: PCI: mediatek: Add support for
 EcoNet EN7528
Reply-To: sashiko-reviews@lists.linux.dev
To: "Caleb James DeLisle" <cjd@cjdns.fr>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260513191652.3200607-2-cjd@cjdns.fr>
References: <20260513191652.3200607-2-cjd@cjdns.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 10:39:58 +0000
Message-Id: <20260514104000.02853C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The conditional block for `econet,en7528-pcie` uses `reset: false` =
instead of `resets: false`, failing to correctly forbid the standard `reset=
s` property.
--

commit 31e1455525e7bb47d92cbe65ee706b4484b25676
Author: Caleb James DeLisle <cjd@cjdns.fr>

dt-bindings: PCI: mediatek: Add support for EcoNet EN7528

This commit introduces the EcoNet EN7528 SoC compatible string to the
MediaTek PCIe controller binding and adds a conditional block to define
its specific property constraints.

> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/D=
ocumentation/devicetree/bindings/pci/mediatek-pcie.yaml
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
[ ... ]
> @@ -226,6 +227,31 @@ allOf:
> =20
>          mediatek,pbus-csr: false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: econet,en7528-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          maxItems: 1
> +
> +        reset: false

Should this be resets (plural) instead of reset?

The standard property for hardware reset lines is resets. Setting reset to
false will fail to override the global definition, which means the schema=20
might inadvertently allow the resets property instead of strictly forbidding
it for this hardware variant.

> +
> +        reset-names: false
> +
> +        power-domains: false
> +
> +        mediatek,pbus-csr: false
> +
> +      required:
> +        - phys
> +        - phy-names
> +
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513191652.3200=
607-1-cjd@cjdns.fr?part=3D1
