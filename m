Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1E43CC9E8;
	Tue, 28 Jul 2026 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270417; cv=none; b=Nk3+Qz5k93IyDA/k45MTUjBKYTP19yvnXP0uGazEjAi1VY5ZPw8W7tSUlK2AjliNVtFFjtBtSg531Rzsln1iKmpO3lleJB9B6T7XlLwZIVmPLoZIhXb/1256NFiXwLqWVpAwcf/e6467KUsUkWYny0t0LpkzEeZY9N/E3xVJnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270417; c=relaxed/simple;
	bh=qsqoBn2nwjt9x9g54GPhpDjB/5J22iOpJ9hzNSeQ15U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gwyUvwHeLcW7d93Ck5UB7eUz77Rt/iHhmIjV3NHbr3lrLSyXFHOWKMLDJltbhZXOnP86p753h+aDnI6NNS9oAfNMl2SZRXjf5I+DqKPEXKIPnwpnasZHF4bWnywGK9SE/2lAINu0fiicGHIxxvPFIM1LcguMZde8qaJsKr4a+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eps4exCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eps4exCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64101F000E9;
	Tue, 28 Jul 2026 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785270416;
	bh=CIlLTY69fyJ2pUp9AGTkIl9DwFXmJCbb3s+nYrMYgrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eps4exCU2TrdVZ13o2eMkUmPN0Fwf5lcVA7BYB5zX29f05INSLWDyxYXWKGHyEAwz
	 CaRiHYOn7MEHj/Rptpg1Z2t/rhS3qv/UYkHgpleI2lWca+XlMqJYnSSWcGeK2Zlh/I
	 FOypHY0DfNu+mP/acQ7+ZwCkSAdP2kA909zhsFa4SMJVswwR4VbhjLhIcISEHpZ3SG
	 piKyvPxt+Q8LhRRcEVlAuFmvRJKA/SshcAlMIJN9btqUdvGIB6V9jxeDYKU3ZFLDl2
	 GBzklVXCO2ragtS/4kc7SntzJURLFd0vxILOX+QTmrj1r+qosxox0VJIU6whrAWbxk
	 dyCWnw4bn5X5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB
 PCIe binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260728202044.1785986-2-sai.krishna.musham@amd.com>
References: <20260728202044.1785986-1-sai.krishna.musham@amd.com>
 <20260728202044.1785986-2-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 20:26:55 +0000
Message-Id: <20260728202655.B64101F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The conditional blocks for 'amd,versal2-mdb-host' and 'amd,versa=
l2-cpm6-host' fail to enforce the strict number of register regions, allowi=
ng incomplete or invalid device trees to silently pass schema validation.
--

--- Patch [1]: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB=
 PCIe binding ---
commit b6d71a08cf4101b94f4ec914fe86d18c5cd2b7fa
Author: Sai Krishna Musham <sai.krishna.musham@amd.com>

dt-bindings: pci: Add CPM6 support to AMD MDB PCIe binding

The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
This adds "intr" to the vendor-specific reg-names for the per-controller
interrupt register region and updates the amd,versal2-mdb-host.yaml with
separate register definitions for MDB5 and CPM6.

Link: https://lore.kernel.org/all/20260402180006.486229-2-sai.krishna.musha=
m@amd.com/

> diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.y=
aml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> index 406c15e1dee1b..d22de24b41cae 100644
> --- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
[ ... ]
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,versal2-mdb-host
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: MDB System Level Control and Status Register =
(SLCR) Base
> +            - description: configuration region
> +            - description: data bus interface
> +            - description: address translation unit register
> +        reg-names:
> +          items:
> +            - const: slcr
> +            - const: config
> +            - const: dbi
> +            - const: atu

[Severity: Medium]
Since the global maxItems for reg and reg-names is increased to 5 in this
patch, does this conditional block for amd,versal2-mdb-host need to explici=
tly
specify maxItems: 4?

Without it, could a device tree with an invalid 5th region silently pass
schema validation for MDB5?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,versal2-cpm6-host
> +              - amd,versal2-cpm6-host1
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          items:
> +            - description: MDB System Level Control and Status Register =
(SLCR) Base
> +            - description: configuration region
> +            - description: data bus interface
> +            - description: address translation unit register
> +            - description: CPM6 PCIe error and event interrupt registers
> +        reg-names:
> +          minItems: 4
> +          items:
> +            - const: slcr
> +            - const: config
> +            - const: dbi
> +            - const: atu
> +            - const: intr

[Severity: Medium]
Does setting minItems: 4 here inadvertently make the 5th CPM6-specific regi=
on
(intr) optional?

If CPM6 always requires all 5 regions, should minItems: 4 be removed so that
validation enforces the full array length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728202044.1785=
986-1-sai.krishna.musham@amd.com?part=3D1
