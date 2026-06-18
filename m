Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09683DB319;
	Thu, 18 Jun 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775088; cv=none; b=W4EQw4APziGRxRyfBUs+QwIPOQiAuxCIgh41Chh6hwL07bU/OWNgpqQkZT2DNCczLTzs66v14kZJXrw2rrDn0hVYtbKKLK7hDQT5VfnjijSkWhTXAUO9/mOe5IIJ7L6kYAoWEPD+y5C10aBwfoyxHUubrHBiyNtpvw7jA9q9yI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775088; c=relaxed/simple;
	bh=4Bv2Xy0zjVDUabyK1NxW/sMDz2HiZVhY4EFrZaj68T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qYw51M/GocIr8Vn/5g38sxC6+pKaKT2imUyRJZI4ix3dofu0vCUKoAjOSou4mDprUJ0dNFZA3KTB44RSoMrq6FplTipIOAGwxyZWFLunPBU+iLgqA/VMQd+MuyOjYtcu+n00taFvjvj2KdLv5X26NcK7RLTnGgykAJrLpEQOEss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToLO7AD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToLO7AD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C2F1F000E9;
	Thu, 18 Jun 2026 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775087;
	bh=W0qq6/DOKl61xL9w6gSC1AHT2CZxfOS5bJTrwgR3PTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToLO7AD3x/siL4fFHy0EUcDfnEMRY4UmlPoVbTaZlAgAn3e7lQsCl+/MqJYNRPpOg
	 w7ppjwe44yNZzNlkGh5e/KgKBo7Dt/3Lrv/q9hHVUwbyOEXAXf7Jf9yjQrLm1YdByY
	 1Ji6iSSzdmUBsLUcH/qU9LiYrgl+EQt1UadOSYYsZirA0m4fGP+eqjIJqP5MhffBZb
	 65ngxFx02JPnQR13bEi6320QKfwtxC9+gfnj6Jor8Pe2kAYd9SXYxx/jV4GfWGBC9e
	 6NSMx4HIdlPcQMU1zHojR1S3ZR/YpfY0OLWgUBiNZzqpbe5V499BSh6anJ5/7hwg+M
	 c7vCCdCs+oC/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: imx6q-pcie: Add optional
 intr/aer/pme interrupts for i.MX95
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260618092100.3669556-2-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
 <20260618092100.3669556-2-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:31:25 +0000
Message-Id: <20260618093126.86C2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Strict positional matching for optional interrupts prevents their i=
ndependent omission.
--

commit 9eb344928f835976645ead8f4c2aff3678bedbd2
Author: Richard Zhu <hongxing.zhu@nxp.com>

dt-bindings: imx6q-pcie: Add optional intr/aer/pme interrupts for i.MX95

The i.MX95 PCIe controller introduces three additional dedicated hardware
interrupt lines for specific events. These interrupts are optional on i.MX9=
5,
so the binding is updated to allow up to 5 interrupts for i.MX95 while
restricting earlier variants to a maximum of 2 interrupts.

> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index e8b8131f5f23b..4f56e8e4f1008 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

[ ... ]

>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme

[Severity: Low]
Since dma and the new interrupts are optional, what happens if a valid spar=
se
configuration provides msi and intr, but omits dma?

The items list creates a strict positional tuple. Wouldn't a device tree
that provides msi and intr fail validation because the string intr at index=
 1
will be incorrectly checked against const: dma?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618092100.3669=
556-1-hongxing.zhu@oss.nxp.com?part=3D1
