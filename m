Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45D1A6807;
	Fri,  3 Jul 2026 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044948; cv=none; b=ScykuGt/qFDXFU1VFBquVK0VT/n3zH3ih5Wvg5VjC4FbVDzqlUSvHYjjCI8rNZA6ux0VYL9XV5DrIJx5jaNFXa58Qrut9SByfNHS6wA9nsSbv0+xlN3e0XpFrYEbnFyyMJQu4ML6Hhw/LzlGXcrvkw/d25XML4IVgGw+c43yKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044948; c=relaxed/simple;
	bh=ZScr7eso4MSk3i504sLUbF8wo//QaZiflm9F6Uy5QOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U50j24rTsxnwiX98cLxxEktHhSzRS2BFf7Dy3kl5ptnKcrwNpZn0p+Vw0SP0NLscu0G+XhZOlE6jYCebx+V5l5DtOEgaU379fMEjZnUt6/uLdZHIsROlH4ZIEsfiNLiBOT8Z/u6zZ2o+XcJ3BcwlNcU1t7CJooU1MSqisIvLxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNfgdoik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNfgdoik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464041F000E9;
	Fri,  3 Jul 2026 02:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783044946;
	bh=yo9vzHAZ30lkIejw2heMqOI/XZh3fWUEgCJH+NtGgew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNfgdoikzaPpbRs2FHLNf2taWkBVvgVMRSuxvCdN2gJTsoFYdXc3Z1CHqU44tBE5z
	 Y7WCIerpMhnu69PUK5VXaidZU4rsQj4lYr1e9DI73pX7P6txO7CzLN8KX5vaoA/s/O
	 c2Yc1TjsFY4AcbONr2tc1cGZReMCVdCSKR11Wit9DjZs4qL2/oOoWV/PIoQgj87qbb
	 HfzHhosZWpRusD3aFHm1HGhR46tfVbOl1Al1/PIbY4NJkiHpbr8r86Ui4kBBtFFmC4
	 UoMdrHyHARYNoSMCjYAWUGqxmJQ+dGoDhSx2dt6l07FbnALSy01ijJp8ENUFvDJZSC
	 G4wQS7Y3bG49A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit
 K3 PCIe host controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260703020003.485436-6-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-6-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:15:45 +0000
Message-Id: <20260703021546.464041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `interrupts` and `interrupt-names` properties were incorrect=
ly removed from the schema validation requirements for the older `spacemit,=
k1-pcie` variant.
--

commit 5291e523faf87db00be6f9789a94fd879ec4c554
Author: Inochi Amaoto <inochiama@gmail.com>

dt-bindings: PCI: spacemit: Introduce Spacemit K3 PCIe host controller

Add binding support for the PCIe controller on the SpacemiT K3 SoC.
This controller is almost a standard Synopsys DesignWare PCIe IP,
with some extra link and reset state control.

> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.=
yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> index c4c00b5fcdc0c..720951b4ba77e 100644
> --- a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
[ ... ]
> @@ -96,13 +102,39 @@ patternProperties:
> =20
>      unevaluatedProperties: false
> =20
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: spacemit,k1-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 4
> +
> +        reg-names:
> +          maxItems: 4
> +
> +      patternProperties:
> +        '^pcie@':
> +          properties:
> +            phys:
> +              maxItems: 1
> +    else:
> +      properties:
> +        reg:
> +          minItems: 5
> +
> +        reg-names:
> +          minItems: 5
> +
>  required:
>    - clocks
>    - clock-names
>    - resets
>    - reset-names
> -  - interrupts
> -  - interrupt-names

[Severity: Medium]
Will this removal cause incomplete device trees for spacemit,k1-pcie to
silently pass schema validation if they omit the interrupts and
interrupt-names properties?

Should these properties be added to a required list in the if-then
block for spacemit,k1-pcie to preserve the previous constraint?

>    - spacemit,apmu
> =20
>  unevaluatedProperties: false

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703020003.4854=
36-1-inochiama@gmail.com?part=3D5
