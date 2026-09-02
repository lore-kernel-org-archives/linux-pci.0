Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0E4A0151;
	Wed,  2 Sep 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359608; cv=none; b=F+WahnzMkiTZziG5GXjg9lrvMe8blAJUFMXnD4PoXf9SqN8avE6bAiY9TIbmcQj1pRov1WH4jrtsOwIA/8QKrijU6Z4iZcByCt+7/T3B8aVYDNWG3kdX+3SufA7DtkaRbTBNXkv76X+jq/AYvnaokhkNYFIsCahCGBTbZUuoYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359608; c=relaxed/simple;
	bh=ERGuEmIIVgi4qQVISJCN0cTnnTumAYbT+jqIbYJLsrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XezCHr1RYWeNh2J83CzeUyrN88IZACfixvzfs5EDtFjNC6BTIZNRIqb8j2oxfeL0z02a/9R2vhLr8CLCxx2KUKKp2ukfQtLbPitTupsveXWB+DGDbj2OK0gi69QfX+lzcm11uG6C71julrveWOfkSStc/BrJY+qAEP4ZzarD3jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2jOF8ND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2jOF8ND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8621F000E9;
	Wed,  2 Sep 2026 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788359605;
	bh=mN1GuONGMrlXkAnLdzF0gdIDI9aIqanTxmiU7C62woA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2jOF8NDNu/gSIPJuUvpZwfyX0tkPomDtA+4K+YwfZ3yTsE3r7ADPAAWXHr7BmCra
	 Q78U4S0Gbk6CESj8Fe44O9iG7a7TKq+13svhaNBUnBdcluXIlxuCvYAlWz/qznA3a+
	 GQdvZ1LJ+bpS27+HXfxMbjcid9XLui1PmPC97Mb4hfEbzjVpp6hfViBzpJ++ULxjfP
	 zlw0H6C9fcbUPIfUGljJWS0wxiC3r/FiltdrmWZ37CL9zIVH9mC186iGD6+vRzP+NF
	 ozGkrJ9FJGhvtam6UN0wdJlPdg+MPKaWbNvd3TGL3CemjCkyzjWY2exkJ3KIf7G3+a
	 GS2LR5pnKC6jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] dt-bindings: pci: tegra: Convert to json-schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260902142449.735168-1-thierry.reding@kernel.org>
References: <20260902142449.735168-1-thierry.reding@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:33:24 +0000
Message-Id: <20260902143325.5A8621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Broken schema cross-reference to `pci-iommu.yaml`.
- [Medium] Missing `power-domains` in the `required` properties for the Teg=
ra186 variant.
- [Medium] Missing `required` array for root port child nodes, failing to e=
nforce `nvidia,num-lanes`.
- [Medium] Missing conditional requirement for `phys` and `phy-names` on ro=
ot port child nodes for Tegra124+.
--

commit 9fe702ef36ffb628e7fb46da07e21ea42a9f10b3
Author: Thierry Reding <treding@nvidia.com>
Subject: dt-bindings: pci: tegra: Convert to json-schema

This commit converts the Tegra PCIe controller bindings from the
free-form text format to json-schema. It references common PCI
bindings and sets conditional constraints for various properties across
Tegra generations.

> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.yaml

[ ... ]

> +patternProperties:
> +  "^pci@1?[0-9a-f](,[0-7])?$":
> +    description: Root ports are defined as subnodes of the PCIe controll=
er

[ ... ]

> +      nvidia,num-lanes:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: |
> +          Number of lanes to use for this port. Valid combinations
> +          are:
> +
> +          - Root port 0 uses 4 lanes, root port 1 is unused.
> +          - Both root ports use 2 lanes.
> +        enum: [ 0, 1, 2, 4 ]
> +
> +      phys:
> +        description: Must contain an phandle to a PHY for each entry in
> +          phy-names.
> +        minItems: 1
> +        maxItems: 4

[Severity: Medium]
The original text binding required phys and phy-names for root port
child nodes on Tegra124, Tegra210, and Tegra186 controllers.

By defining these as optional properties on the child nodes without an
if/then conditional in the parent node to enforce them, will device trees
for newer variants missing these PHY mappings incorrectly pass validation?

> +
> +      phy-names:
> +        description: Must include an entry for each active lane. Note th=
at the
> +          number of entries does not have to (though usually will) be eq=
ual to
> +          the specified number of lanes in the nvidia,num-lanes property.
> +          Entries are of the form "pcie-N", where N ranges from 0 to the=
 value
> +          specified in nvidia,num-lanes.
> +        items:
> +          enum:
> +            - pcie-0
> +            - pcie-1
> +            - pcie-2
> +            - pcie-3
> +        minItems: 1
> +        maxItems: 4
> +
> +required:
> +  - reg
> +  - reg-names

[Severity: Medium]
This marks the end of the child node patternProperties definition, which
appears to omit a required block.

The original text binding mandated nvidia,num-lanes, reg, and
assigned-addresses for root port subnodes.

Since the required array is entirely omitted from the child node, can device
trees omit the hardware-specific lane configuration without triggering a
schema validation error?

[ ... ]

> +unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/pinctrl-consumer.yaml#
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: pci-iommu.yaml#

[Severity: Medium]
Because this is a relative reference, it resolves against the current
file's $id directory, effectively searching for
http://devicetree.org/schemas/pci/pci-iommu.yaml#.

Since pci-iommu.yaml is actually located in the virtio directory, will this
broken reference cause dt_binding_check to fail or skip validation for this
binding?

[ ... ]

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,tegra186-pcie
> +    then:
> +      properties:

[ ... ]

> +        vddio-pexctl-aud-supply:
> +          description: Power supply for PCIe side band signals. Must sup=
ply
> +            1.8 V.
> +
> +      required:
> +        - dvdd-pex-supply
> +        - hvdd-pex-pll-supply
> +        - hvdd-pex-supply
> +        - vddio-pexctl-aud-supply

[Severity: Medium]
The power-domains property is defined as a capability for the Tegra186
variant earlier in the binding.

Should power-domains be included in this required array so that incomplete
device trees for Tegra186 hardware do not incorrectly pass schema validatio=
n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902142449.7351=
68-1-thierry.reding@kernel.org?part=3D1
