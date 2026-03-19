Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5113E95AE;
	Thu, 19 Mar 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936682; cv=none; b=GuTzIku/kcTOrV+STZVJc4zCEcs1ezQ+fmydQZ7gQDm+Vyo4/PvFm8onjk7RCXPxWs9Y43YuP0NIrB3DJK93ZzQmWnbO7hRXBB6OGk/oLBzSjvVqVVdfMExuuqn5goKwTRObUqH0lIIEFJiUbO/IflKaImLHqngM7wzwjURSo74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936682; c=relaxed/simple;
	bh=vg1UumV6k5QeDyVUBGRbAYWZNFDa34Na9e5e2zZwlhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdsfeEDg8kOgWL7s7xH6r0EXzgnks71cOlxRvrCtjanUVIJftyYiEhXIhmRe2t69HvctyKQZyhP5PW5qFmO+RPB5O4s6Dl7i9YqM4gaC7Opv2yktMMttFEuPagLvuNWjRxfpRRCuAWxjB1wflWHxFjYsWB7ABUdGde1BNPmERdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cj2rhpuX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cj2rhpuX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B93DC2BCB0;
	Thu, 19 Mar 2026 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936682;
	bh=vg1UumV6k5QeDyVUBGRbAYWZNFDa34Na9e5e2zZwlhs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cj2rhpuXMDoK5LXQVXKFq+o4Gllw2HT76plU/UiNB4EYqlhsjDtc6IXH2xWq01zk2
	 uCW/5flYeuFOoyNPV6hWib0l3AmxLQ+FMwvyADuLwudzkc/CYxbaGBIk1jIEmpw7zx
	 uJa0Vm2FUIGi1MKFjNYm05t2Nc/6vYvTzcWK6Gr1rMyXAvsTOuGWBTaLWCcor3P7FQ
	 acw3om1B/4lqwcZnkpWwpjblcMnjaxWxlTs0sm+jk+Rl8s8t9GbP1iVyZbTbKndHEr
	 gDCtck8FLN0wfYCKs6ueFGr9fkxZDuIRc0UNwaDSxdzcvJZ22jGnO6AdKhO6zvTj0q
	 /FpidMuARFboQ==
Message-ID: <353939e0-ef52-4c8f-bf71-ff27fa2c7d7a@kernel.org>
Date: Thu, 19 Mar 2026 17:11:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
To: Thierry Reding <thierry.reding@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-4-thierry.reding@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260319160110.2131954-4-thierry.reding@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2026 17:01, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The six PCIe controllers found on Tegra264 are of two types: one is used
> for the internal GPU and therefore is not connected to a UPHY and the
> remaining five controllers are typically routed to a PCI slot and have
> additional controls for the physical link.
> 
> While these controllers can be switched into endpoint mode, this binding
> describes the root complex mode only.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> new file mode 100644
> index 000000000000..56d69de2788b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nvidia,tegra264-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra264 PCIe controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra264-pcie
> +
> +  reg:
> +    minItems: 4
> +    maxItems: 5
> +
> +  reg-names:
> +    minItems: 4
> +    maxItems: 5
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 4
> +
> +  dma-coherent: true
> +
> +  nvidia,bpmp:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Must contain a pair of phandle (to the BPMP controller node) and
> +      controller ID. The following are the controller IDs for each controller:
> +
> +      0: C0
> +      1: C1
> +      2: C2
> +      3: C3
> +      4: C4
> +      5: C5
> +    items:
> +      - items:
> +          - description: phandle to the BPMP controller node
> +          - description: PCIe controller ID
> +            maximum: 5
> +
> +unevaluatedProperties: false

This goes before example

> +
> +required:
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - iommu-map
> +  - msi-map
> +  - nvidia,bpmp
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - oneOf:
> +    - description: C0 controller (no UPHY)

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint. Don't rely on
distro packages for dtschema and be sure you are using the latest
released dtschema.

> +      properties:
> +        reg:
> +          items:
> +            - description: application layer registers
> +            - description: transaction layer registers
> +            - description: privileged transaction layer registers
> +            - description: ECAM-compatible configuration space
> +
> +        reg-names:
> +          items:
> +            - const: xal
> +            - const: xtl
> +            - const: xtl-pri
> +            - const: ecam
> +
> +    - description: C1-C5 controllers (with UPHY)
> +      properties:
> +        reg:
> +          items:
> +            - description: application layer registers
> +            - description: transaction layer registers
> +            - description: privileged transaction layer registers
> +            - description: data link/physical layer registers
> +            - description: ECAM-compatible configuration space
> +
> +      items:
> +        - const: xal
> +        - const: xtl
> +        - const: xtl-pri
> +        - const: xpl
> +        - const: ecam

All of above are part of top level.

And speaking about example - where is it? How can you then test (verify)
this?

Best regards,
Krzysztof
