Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607F9323416;
	Wed,  9 Sep 2026 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788938930; cv=none; b=gYzsryWueLHK/85yG8xj2B/baH4290Rh14igU8buBUVu5bRaWYpKaJrHxbPmoSUj8s+17N94CqVFKDR1t8OcWG1Vwof45+hSXhcwRatVlwGQv+qcZ/DSmsp6aesqd9x6p1MbSSsRUPT7BDSh9r3xmcPV19loStnfwykgZn3pE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788938930; c=relaxed/simple;
	bh=8yVzF90AoaAUb8R+7eeWxFRhtRbFA35v3+7WbXbVEDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQQ4VRNPiqb1PLv1xuJfyS471kch/0EQ19D0Xve8UKztW+kMD3iHxLYv64w6w/uC5r8Dh6SM/3HPlZoiWgD03JqnMa7XtwhJB9cFFfwEMwBy82K8NwAVT/PpPlpIafmdNMc4MrEI2cHA8BAgAqYp/m4vJ/tW6BPTG0zTfMGFvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsOz/14p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsOz/14p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008D31F00A3A;
	Wed,  9 Sep 2026 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788938929;
	bh=t+tV0/lAuT7CI4Ui5m8EmZlQe7dn2V6hXPejm7rkrWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KsOz/14poZfHaEGIYearElwNKpYepOycHddfz19fcbPukp3QY0jFiThoKoo6dH8ox
	 ruNgL2F2sgLxRWLbCzTid0KtgtOALFDWS1/vZn+0RHolpOCqWjj51MW+dFmHSs328p
	 6V68IYu/RTvevUQrL5vSfTOWwYf+AEnrwBYR4E8Zp5nIdgB9OJUrc8UpWc+0oJ4ZjG
	 UStIj/s7p9/UgYcAQypYG0aTynHwQQD+92scbsmHbu0AgO9XuUeCxDFmBbZJEq5KBD
	 rGZ3f+YTeCovtgRktywNP4E+0jPaFWh/uVIrE++8FWGiZnvOwp8jm7Bwx0IyuHCRpR
	 FmRE+ukf41yVQ==
Date: Wed, 9 Sep 2026 09:28:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>, 
	Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Message-ID: <20260909-fascinating-vermilion-tarantula-0c9dff@quoll>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904-pci-tc9563-aux-v3-1-5b1449d62ba2@oss.qualcomm.com>

On Fri, Sep 04, 2026 at 07:15:18PM +0200, Lorenzo Bianconi wrote:
> The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is registered as an auxiliary device by the TC9563

"auxiliary device" is Linux term, so not really relevant here.

> power controller and accessed through the same register map.
> 
> Describe the switch node itself as the embedded GPIO controller and
> document the per-port reset-gpios property.

Isn't the switch node already described?

> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml       | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index f084830c6d0c..c4cd162cb084 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -31,6 +31,11 @@ properties:
>      description:
>        GPIO controlling the RESX# pin.
>  
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
>    vdd18-supply: true
>  
>    vdd09-supply: true
> @@ -84,6 +89,11 @@ $defs:
>      type: object
>  
>      properties:
> +      reset-gpios:
> +        maxItems: 1
> +        description:
> +          GPIO controlling the reset line connected to the downstream port.

Why do you exactly need this? Isn't this PERST, thus already there?

Best regards,
Krzysztof

