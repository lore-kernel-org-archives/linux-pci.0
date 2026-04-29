Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A93A3A4F3B;
	Wed, 29 Apr 2026 07:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777447784; cv=none; b=jg5lUEpSqKvT6OhiPRYqKbskGg3XHqAWb2x4Nx3jx4o1D4jFhB5/Myjda7KQwg+zV+XqNHY+4nkr4QLaBRf2kfLetxzpPUUl12/huOkCxqNRQbv7MaC4x4aiOhRdj1AFUMPCxjcavHfV31ZJLZ6CfcETuNpW/RcyzYyiuyT3WlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777447784; c=relaxed/simple;
	bh=P35hfQSMr2+9auGQr2wxXAwA/zR1P0H1IWOnM0Oirxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5L2eujaADRHE55UDrwLQVCdCwdQiAPF03/28sTWC3AggVqjLKBuMvrrvVjmZ5WTaJ0jqoFQlHX3jrPbxD0/tYnNR1NOhF9PGU2DKDya7zVaxaI4TEEPG5z7bu6DK4y3jicJ1Gt1wCkzMAoeT9eSfx/uZReP8MgZMC+wwSOOw1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaVXj7nO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaVXj7nO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF09C19425;
	Wed, 29 Apr 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777447783;
	bh=P35hfQSMr2+9auGQr2wxXAwA/zR1P0H1IWOnM0Oirxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XaVXj7nO+UtL6HDIlPWdU61sZVvhPyBBiQAvW3cBwJFehEnrZjwhenHFB6n4ELEEJ
	 3vFCJaCM5jib2cTDIsQqDcsJnHZLmDWSs7WHXMD0tfk3i2kvZTLZBFsBYrvRpNGr9N
	 GjwdvSO+xlhzqz2aaU15CNgHFegA4xEdt+V2FprJKd5tABLAlsDY3ZKJqqT7ge3HVG
	 RAC2xV0kSjIscXevWZ3trSoovhx7UqNlXm1hbC/19NiRY7nF+/tPpleN4WiodCncdb
	 RceFEOPDnE1JarButwSsgUjrmfYKpzyO6kTb3TglgM14GM5dGmqnNHzm9k4T18fGQr
	 mGcjzpdhakP7A==
Date: Wed, 29 Apr 2026 09:29:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Message-ID: <20260429-curvy-amber-boobook-ac5693@quoll>
References: <20260428075030.1626440-1-hongxing.zhu@nxp.com>
 <20260428075030.1626440-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428075030.1626440-2-hongxing.zhu@nxp.com>

On Tue, Apr 28, 2026 at 03:50:28PM +0800, Richard Zhu wrote:
> Add 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q PCIe
> binding to support PCIe event-based interrupts for general controller
> events, Advanced Error Reporting, and Power Management Events
> respectively.
> 
> These interrupts are optional for most variants but required for
> fsl,imx95-pcie, which must specify all 5 interrupts (msi, dma, intr,
> aer, pme).
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b422..0913c3312ed26 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupter line.
> +      - description: builtin PME SPI standalone interrupter line.
>  
>    interrupt-names:
>      minItems: 1
>      items:
>        - const: msi
>        - const: dma
> +      - const: intr
> +      - const: aer
> +      - const: pme
>  
>    reset-gpio:
>      description: Should specify the GPIO for controlling the PCI bus device
> @@ -231,6 +237,21 @@ allOf:
>              - const: ref
>              - const: extref  # Optional
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx95-pcie

Why do you need another if: block? Why can't it be part of existing one?

> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5
> +          maxItems: 5

Drop maxItems. You need also constraints for all other variants.

> +        interrupt-names:

Best regards,
Krzysztof

