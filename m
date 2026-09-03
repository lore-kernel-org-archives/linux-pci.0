Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774244A8A0B;
	Thu,  3 Sep 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439868; cv=none; b=tGoyT3C5a9mkdhJEX5IKKweGjthywpE2juFi1X4Z9UbKLHJgZcxsqj+iapnczmKo21yRMQ2kxC9DxMbsydXhGeYbyxcU51hRuQ0hP3Em+sePdXHaiyKLtYASJz5lS7FReBwx54dFdgghAgJgAHHni+FidcgDgxrG/NXa5HjUnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439868; c=relaxed/simple;
	bh=LjmIPmw7ySstw2MxWPXvqRywplG1G3B8XVWx3/VMvMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFGNB/ABy8HqErCzYUiEM0YnDoliJm86tG30STCw1gqCDMXAmg65iJ8JdxlkOoUjP6/Oj48V0orVFlIEms/ciyiQldZaYkxu3184ehD8ul20I60NNGoPMeHHsy+ZzBvhZccCX6WxqkcjW7cwh96zvp0+Bqzu1asV5g4QeEAzZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O24KCjmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O24KCjmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B941F00A3A;
	Thu,  3 Sep 2026 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439867;
	bh=H/rdkPlLjorMEohQUu1+1d+wMkk6zb1tM90EqfTca1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O24KCjmKrZ0eOMZd04iNAg1XzK1hi8LicjfTcpjiEVGH/agfHTAM5IHFaFgF53AHH
	 ncDFJ/TH/sDpxmJQ8I0e/tb4lGinHRPhYLJRyUfP5aPzxZsPEZlaj7rCxbm5cvlKN0
	 jU+EsjC4CHVu7pEJ+kDnLUO0BW1fwr1/7nrKxMLBJTCCjo//Pg47J6tYp5xUNz9d7z
	 ofs1LE+vabuQqfzvYSWugcJqLLUmDnTuXUAOHoMqsRza9X/TZAdhhk2TSKSJjxd07W
	 KgxmBjACYzWg2ZYriP9pBQqsbyGVMHdQ1RrLKsjB2ogM76FsFzopQbdPe1IanfECeX
	 nRYileX98WbTQ==
Date: Thu, 3 Sep 2026 14:51:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: PCI: toshiba,tc9563: document embedded
 GPIO controller
Message-ID: <20260903-organic-duck-of-swiftness-f0426e@quoll>
References: <20260901-pci-tc9563-aux-v1-0-dd9b80738e70@oss.qualcomm.com>
 <20260901-pci-tc9563-aux-v1-1-dd9b80738e70@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901-pci-tc9563-aux-v1-1-dd9b80738e70@oss.qualcomm.com>

On Tue, Sep 01, 2026 at 12:27:53PM +0200, Lorenzo Bianconi wrote:
> The TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is not bound by a device tree compatible string
> but is registered as an auxiliary device by the TC9563 power controller
> and accessed through the same register map, so the GPIO node has no
> compatible of its own.
> 
> Describe the embedded GPIO controller as a "gpio" child node of the
> switch, document the per-port reset-gpios property, and update the
> example to reference the controller from the downstream port reset
> lines.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index f084830c6d0c..47cd58c14e4a 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -54,6 +54,23 @@ properties:
>            - description: I2C slave address
>  
>  patternProperties:
> +  "^gpio(@[0-9a-f]+)?$":

Why the unit address is optional? And what does it even represent?


> +    description:
> +      child node describing the embedded GPIO controller available in TC9563

No, this is a PCIe switch so the children are PCI bridges. This does not
fit at all. I do not understand why this node was created in the first
place - what device does it represent?

> +      PCIe switch. The controller is registered as an auxiliary device by the
> +      TC9563 power controller and accessed through the i2c device.
> +    type: object
> +    additionalProperties: false
> +    properties:

And why there is no reg here?

> +      gpio-controller: true
> +
> +      "#gpio-cells":
> +        const: 2

Are you sure you are not re-implementing
https://lore.kernel.org/all/20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com/
?

> +
> +    required:
> +      - gpio-controller
> +      - "#gpio-cells"
> +
>    "^pcie@[1-2],0$":
>      description:
>        child nodes describing the internal downstream ports of
> @@ -62,6 +79,11 @@ patternProperties:
>      allOf:
>        - $ref: "#/$defs/tc9563-node"
>        - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +    properties:
> +      reset-gpios:
> +        maxItems: 1
> +        description:
> +          GPIO controlling the PERST# reset of the downstream port.
>      unevaluatedProperties: false
>  
>    "^pcie@[3],0$":
> @@ -149,6 +171,11 @@ examples:
>  
>                  resx-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>  
> +                tc9563_gpio: gpio {
> +                    gpio-controller;
> +                    #gpio-cells = <2>;

Where are any resources?

Best regards,
Krzysztof

