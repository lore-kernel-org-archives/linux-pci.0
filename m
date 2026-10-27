Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137214;
	b=YraHjxCi4jrADFs6Q6Jan7Cp7qyaopHah08OMJ0uhbCBX9O85xIZSKO2YU4LAMGFResq
	 28YVdEdIE6Xwz+eqg+I0BxEmpiw1dylwzouAKaUtOz+tiGml/4aklZo62Qg1XJsIK01EO
	 8lgpiO3g9mor0MgWmMfhKZydG5p7uLFeuV/aiX2HzEGw8Npw7x01jdDgwi3dxhx3xF2Y2
	 b1r2UBgVVkFc9xRaTWHxDQox8WeVyYEXfZglOygZpKKX9/jOlMSwryg6ZnfDVI/n+3nmS
	 b9IIw4cET6pcvc4GjhullRhV9pGCREzDyLlaG4EYjJhkkffKO3f4uHfsfxvXwV8i26w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137214;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F9FEofSoUSLMuDf15+WCUoOYCD7og7XvQVtByxgDU1A=;
	b=wrDe9eqmzXx86yFLBcfT6ukLqQkzhpozUoIvKV6B6Bz3AvI2Mckt7wInKyNFcNGHIvRx
	 tLVaM6ZHOpivp4FGjKrdD5Mv8Sxd9uzjucJPeuT9p7P0ebV895VkOOy0+vV6sN2d5RNwR
	 B43eamTpr6UeZqSP3guR8BIMfTrmK/+3BCeqYg8goFHkC2dxxDb8TkICLJT0HEOog5I0L
	 3aHg37r8X3PB71m2iz9mEH5AxyEnUaKziDPMnLvYum4633dMMhZjIZPl/zQ92U60PD8mt
	 jAE3GsB1L3ZX0uwdK8OKFwVONFhEYXrSSZhX1HjaVxuXv0Eh2q4Z64J6eUw/o+y4/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IujTEz5i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69992606A31A;
	Tue, 27 Oct 2026 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IujTEz5i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD01F01825;
	Tue, 27 Oct 2026 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793137214;
	bh=F9FEofSoUSLMuDf15+WCUoOYCD7og7XvQVtByxgDU1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IujTEz5iUJJ8fLWRNgswwtRnTCYdpMxhrlitVPuCT32SzFTcFnPci0d0/lWxLkKcA
	 +pSqNESCKFi9kTJHVm4lxMoirRODOdyNoYPKN0u173eEpwFVUq4xy4GRzfQ2bo6D8D
	 1fQcKGu84IbHFNMxkTvuyMxGSc//Dl52HSfcusk1KtCE8USl9jkVtmd8Oo9nYEPLsv
	 KGPH38edv/r7PQ8aGHwnWAMiGAUarLTbX2RAG6iL0vfeKxJUUCNhkZ7g5xovCEYg0Z
	 h0XYI/mkZnv53QJ/b31UGrsg/sTekZe2+wxwOVhMUYkMcyNfXs8ZOgr3xEL6kQLsmr
	 2hOR2siSQGkmA==
Date: Tue, 27 Oct 2026 16:40:10 -0500
From: Rob Herring <robh@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	stefandoesinger@gmail.com, krzk@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/24] dt-bindings: PCI: Add ZTE ZX279128S host
 controller
Message-ID: <20261027214010.GA1212169-robh@kernel.org>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-13-ghahramani.navid@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014072109.1759502-13-ghahramani.navid@gmail.com>

On Wed, Oct 14, 2026 at 08:20:52AM +0100, Navid Ghahremani wrote:
> Add Device Tree binding for the DesignWare PCIe host controller on the
> ZTE ZX279128S SoC, using standard clocks, resets, and phys properties.
> 
> Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
> ---
>  .../bindings/pci/zte,zx279128s-pcie.yaml      | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml b/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
> new file mode 100644
> index 0000000000..dc0214511f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/zte,zx279128s-pcie.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/zte,zx279128s-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ZTE zx279128s PCIe host controller
> +
> +maintainers:
> +  - Navid Ghahremani <ghahramani.navid@gmail.com>
> +
> +description:
> +  The ZTE zx279128s has two PCIe host controllers based on the Synopsys
> +  DesignWare PCIe IP, each with one lane. Their clocks, resets and PHYs are
> +  controlled through the SoC's Top CRM blocks.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: zte,zx279128s-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers
> +      - description: Controller wrapper registers
> +      - description: PCIe configuration space region
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: ctrl
> +      - const: config
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PCIe controller clock
> +
> +  clock-names:
> +    items:
> +      - const: pcie

Drop. No point in -names for 1 entry.

> +
> +  resets:
> +    items:
> +      - description: PCIe controller reset
> +
> +  reset-names:
> +    items:
> +      - const: core

Drop

> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: pcie

Drop

> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Optional board GPIO reset line for downstream endpoints.

Is this for PERST#? If so, make that clear.

> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: Optional second board GPIO enable line driven together with reset-gpios.
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - '#interrupt-cells'
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +
> +unevaluatedProperties: false
