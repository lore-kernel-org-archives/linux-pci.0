Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F590495052;
	Wed, 12 Aug 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786575252; cv=none; b=ggP0uKRQRqxIpxYV4jp6+WHO4AcshdvTsBZzx+0P71XG1jkEFwujgHbkJorEr9b8kt1f1T120pB26pyU/y8VPrZusOhce/EMDUyzkngLhwnaBEWWBrjS9WjXfl8i1cI5xaaFQwsEFLNYi01/LNYFvgrXo3r/XU5BPscY6inLkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786575252; c=relaxed/simple;
	bh=Z+BlFzL42UHq3s6yBOAGpnFfyovsEVLookkGR5gaLBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+QsIjxpUFQpxAmzmcT5b+fEx4SM43GAuO/ZEyQMcqvBMFr1fTE/KzelWD0ntZLcv221bpctxrhwuYnS4Tcv5FFNcpf5UDWZu6vXH01ziEV9kmWHdC36U5uncuRmdvIcJ3eo7uW9Qe4N8NwRcJ5KI2B2xGWsZ77ffbVeqPwSN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhVXLyH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhVXLyH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F87F1F000E9;
	Wed, 12 Aug 2026 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786575250;
	bh=t9GkVCbM5tANZpxDO6kfsuO1LlzKLQuqkJkuibxVzoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NhVXLyH1dNtOZjiiEZVksyLCigW70hzqnkUqbT694S4SdjIaFxoIoXMcVZaWFL0tQ
	 OWRlaXWQWee3YoDGIHbpaaGLQXeRFw8XPkYMOUcnCvbQ7+n27NBvtuCpyMfwO47nrY
	 p62Qhmwj1SEAtWnyykDw7A/c7cKimo3ovtXf/nxjrSHdfiSYhKaLWW/auN8M5R491l
	 d0nxfIOGFaiAfuR+jmmdvuZnjbIytBI9RKJUi/EpCrVWMTR26ipIg9oeXJvsKNcC4H
	 m8XtpPb7BWePQQXFLKDp+89GNctCQMavnE9RM3U9fxvFVLRdLCu9JHsX6Da+KXXmH3
	 a1mtOlTHDZSIQ==
Date: Wed, 12 Aug 2026 17:54:09 -0500
From: Rob Herring <robh@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cassel@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	thippeswamy.havalige@amd.com, pranav.sanwal@amd.com
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Message-ID: <20260812225409.GA1363147-robh@kernel.org>
References: <20260808105256.3705889-1-sai.krishna.musham@amd.com>
 <20260808105256.3705889-2-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808105256.3705889-2-sai.krishna.musham@amd.com>

On Sat, Aug 08, 2026 at 04:22:55PM +0530, Sai Krishna Musham wrote:
> The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe IP.
> Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
> per-controller interrupt register region used by CPM6.
> 
> Update amd,versal2-mdb-host.yaml with separate register definitions:
> - MDB5: 4 regions (slcr, config, dbi, atu)
> - CPM6: 5 regions (slcr, config, dbi, atu, intr)
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
> Changes in v4:
> - None
> 
> Changes in v3:
> - Update subject to match history.
> - Move allOf to the end, after required block.
> - Drop the CPM6 example.
> 
> Changes in v2:
> - Update the CPM6 device tree binding and example.
> 
> v1 https://lore.kernel.org/all/20260402180006.486229-2-sai.krishna.musham@amd.com/
> v2 https://lore.kernel.org/all/20260728202044.1785986-2-sai.krishna.musham@amd.com/
> v3 https://lore.kernel.org/all/20260803144412.713639-2-sai.krishna.musham@amd.com/
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 45 ++++++++++++++++---
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> index 406c15e1dee1..672589066854 100644
> --- a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> @@ -9,27 +9,30 @@ title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
>  maintainers:
>    - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-host-bridge.yaml#
> -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> -
>  properties:
>    compatible:
> -    const: amd,versal2-mdb-host
> +    enum:
> +      - amd,versal2-mdb-host
> +      - amd,versal2-cpm6-host
> +      - amd,versal2-cpm6-host1

What is host and host1 difference? Please explain somewhere.

>  
>    reg:
> +    minItems: 4
>      items:
>        - description: MDB System Level Control and Status Register (SLCR) Base
>        - description: configuration region
>        - description: data bus interface
>        - description: address translation unit register
> +      - description: CPM6 PCIe error and event interrupt registers
>  
>    reg-names:
> +    minItems: 4
>      items:
>        - const: slcr
>        - const: config
>        - const: dbi
>        - const: atu
> +      - const: intr
>  
>    ranges:
>      maxItems: 2
> @@ -92,6 +95,38 @@ required:
>    - "#interrupt-cells"
>    - interrupt-controller
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,versal2-mdb-host
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4

Drop. 4 is already the min.

> +          maxItems: 4
> +        reg-names:
> +          minItems: 4
> +          maxItems: 4
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
> +          minItems: 5
> +          maxItems: 5

Drop. 5 is already the max.

> +        reg-names:
> +          minItems: 5
> +          maxItems: 5
> +
>  unevaluatedProperties: false
>  
>  examples:
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> index b3216141881c..21f86609ddb6 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -117,6 +117,8 @@ properties:
>                enum: [ ecam ]
>              - description: AMD MDB PCIe SLCR region
>                const: slcr
> +            - description: AMD CPM6 PCIe error and event interrupt registers
> +              const: intr
>      allOf:
>        - contains:
>            enum: [ dbi, ctrl ]
> -- 
> 2.44.4
> 
