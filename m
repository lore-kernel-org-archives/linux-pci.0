Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112E2D6407;
	Sun, 31 May 2026 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780228040; cv=none; b=T5uaipeCRTkqZrlcX4F0Sel9cPOFB3ewzgtDCUX7HJRrcJlYLYpjJfTDnx6IDaTzRCbrOI2RTvZpheYJFqvihJtaS9DXjT3AA9j2fP+KtlJQvDGX32zI5KyQgVVKrkdYxJjJ71q9GSh+tClFlp+aMqouEgEtKwBJtG9AG4y2ySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780228040; c=relaxed/simple;
	bh=gN86oofKCEFJpKNMYabO1UCbKCN84jTmlVIlPXcZULk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewD31rng1vaVmcN2ZjUVAi+Vu3eFGmwjSrqz3kX9OvqgQHMywdnuTq+hLZqF/u9GA2hhOUr1Fd/hwHTP6j1+eyJ/wt2bIJq5rR98z/Z3mKGSyHCg2rrG+WRsiCeFaAPIfPJ3myLWt0obPCFD23snQxEmxo5z43OuXktpRhjALxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnsFonrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnsFonrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363291F00893;
	Sun, 31 May 2026 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780228039;
	bh=ct8HY92i6QZ17YyTCxgrZWO6N6bGL7NsPGPY6sbzL1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TnsFonrrBOVdJXLe1AySwEBB+ooQtPGNMReKfpeM7ET3Nt5+omF8h4GU5185mDWSy
	 ppHIKAR4DsR8dRb+22Ry+cjAyLnA4lJIB+tWwyVCXa9XhH2svVYpkoJ8Cv48RMOsNA
	 I9wBKL8IeybkWVI/RjH6b5NGPSSpbfKwIJzAvpx9K01WXdO3BiHvxtz8rzYHZKDnFt
	 OVSItln/t3ZwzEQUTptgDu7tLRUArTc29bIEDRZNcEgl3GbVo+Ep/6RUi57gZ9Omq0
	 gM1hscwckle8DxzmU3rI2d58VYmUa/yRNMNBII3P67kPLsayflvuweivChd6dzdXBB
	 k8mSNLi6q8e2A==
Date: Sun, 31 May 2026 13:47:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: imx6q-pcie: Add optional interrupt
 entries for intr, aer and pme
Message-ID: <20260531-benevolent-malkoha-from-wonderland-cdfafc@quoll>
References: <20260521093255.61585-1-hongxing.zhu@nxp.com>
 <20260521093255.61585-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521093255.61585-2-hongxing.zhu@nxp.com>

On Thu, May 21, 2026 at 05:32:53PM +0800, Richard Zhu wrote:
> The i.MX95 PCIe controller introduces three dedicated hardware interrupt
> lines:
> - intr: general controller events
> - aer: Advanced Error Reporting
> - pme: Power Management Events
> 
> Earlier i.MX PCIe variants (imx6q, imx6sx, imx6qp, imx7d, imx8mm, imx8mp,
> imx8mq, imx8q) do not have these dedicated interrupt lines.
> 
> PCIe basic functionality (enumeration, configuration, and data transfer)
> works correctly regardless of whether these interrupts are present. Mark
> these interrupts as optional to maintain backward compatibility with SoCs
> that lack these hardware interrupt lines.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 9d1349855b42..cf709132ff1e 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -58,12 +58,18 @@ properties:
>      items:
>        - description: builtin MSI controller.
>        - description: builtin DMA controller.
> +      - description: PCIe event interrupt.
> +      - description: builtin AER SPI standalone interrupt line.
> +      - description: builtin PME SPI standalone interrupt line.

Same feedback as before, nothing improved. Schema says imx6q has these
interrupts, commit msg says otherwise.

Please read entire binding - you would easily guess what is there to do.
And you already received such comments.

NAK

