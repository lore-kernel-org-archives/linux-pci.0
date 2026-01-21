Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0663F23DC;
	Wed, 21 Jan 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013605; cv=none; b=Ark/3GjldilsoZ6nVtsWjuA9FJxTqFLMPmOkyxXsUbTOCOHyYZT45/qGlmiHCdiyvsn3HG8ilOdcHXS044y8Xd+yS4AzDDoPVZ6pZLCIJwmaB1Xb1O1ZkzXWzRnXS4+kie96O4xyVX+l30b07ftKbAQHeQkaYm8ZsrUphHsxkPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013605; c=relaxed/simple;
	bh=9IgrqPWxeBy8ibhvm0nRZ1r4OdMUq85UFWTGCaiFkAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWuOoKv9HGeZsu1QqPFpPt7ovwlcqNvjSwIDthCeeNzcw2AlnfkehBCxeN4oSuqNodW2fZazshX9L9dey+oIuM9isWoUrFfP9ikEfVhjkMi+DYMOkKQ/mBqDQS9hlhqwC0+nVuEyeGfGA6ebWv6Jh7E9OcAzWsfFcadgvksWGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdWWnFg5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdWWnFg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530E4C4CEF1;
	Wed, 21 Jan 2026 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013603;
	bh=9IgrqPWxeBy8ibhvm0nRZ1r4OdMUq85UFWTGCaiFkAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdWWnFg5SZx40hORZDjNZklpWgFV40COfA895217GAJwzVSsHmDtErDO/S5in/xuj
	 cul5fbOj5OfrTfrqhedqcSZqHXjvCSZyqmrsQn3FCKOpI8HK5AUdc7yZYL+bfzImzf
	 Z5XNmW/uk6h162PxR3F/vLxNMiAN7YdYr6FiY4zp3Xo7UNbUJfbB0aBr2a5Yu2Ka7E
	 DHwVIxfIn0YOd4cNbN7P5TbIOTBcax/keROPGzAzJPjdYVZLST4VLzYChKHBfjoEHa
	 IohI0WNZVaqkPyPhbw3rrN1ffnSqhqsZfToN0hw8VpQXKG4Bk3hDySKStWMfK1mk8F
	 F8liWL6hhCn7g==
Date: Wed, 21 Jan 2026 10:40:02 -0600
From: Rob Herring <robh@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, frank.li@nxp.com,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO
 in Root Port node
Message-ID: <20260121164002.GA3427694-robh@kernel.org>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-2-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119100235.1173839-2-sherry.sun@nxp.com>

On Mon, Jan 19, 2026 at 06:02:26PM +0800, Sherry Sun wrote:
> Update the fsl,imx6q-pcie.yaml to include the reset-gpios property in
> the Root Port node.
> 
> There is already 'reset-gpios' property defined for PERST# in
> pci-bus-common.yaml, so use that property instead of 'reset-gpio' in
> this file, for backward compatibility, do not remove the existing
> property in the bridge node, but mark them as 'deprecated' instead.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 12a01f7a5744..74156b42e7a2 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -59,9 +59,12 @@ properties:
>        - const: dma
>  
>    reset-gpio:
> +    deprecated: true
>      description: Should specify the GPIO for controlling the PCI bus device
>        reset signal. It's not polarity aware and defaults to active-low reset
>        sequence (L=reset state, H=operation state) (optional required).
> +      This property is deprecated, instead of referencing this property from the
> +      host bridge node, use the reset-gpios property from the root port node.
>  
>    reset-gpio-active-high:

Probably this needs to be deprecated too?

>      description: If present then the reset sequence using the GPIO
