Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AA3AB285;
	Tue,  7 Jul 2026 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406899; cv=none; b=XQvzvr8fLMQHohrWvU102uZ9U75pLWYmiqy2pYh7+zaIGr0Ay4oC5KVpsw4zz4YbBzYKx5u+S26nLyyObFgU+XjUrcfh/pR4ZbaGF8kFGD77Pq9LD2EVUZJxlAmcbsTsSoS6IMAfh7qwwGP14a65nrEiFRnOWOAQcSefrdZVeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406899; c=relaxed/simple;
	bh=UwUjbwSrwUSMFsUgMlKlenkSVxB9MMMg7w0wXZ/EZEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPpFKvl2F2+9aYFqH1uaL75SM+IU6Sz9AMJf5CkGG/NJZ5aKw6Im+wrVYv+A031jGwX9toHXNjOeDrNAE88ECp+tzJF6wW5ze5PkckphrpAJBjIxVfooftj+cdvKDBJO+r4CZ/iBCIrC3KVIQzBKq/n2BNttexXWgHLPsz3gsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH9OBtFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH9OBtFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F51F000E9;
	Tue,  7 Jul 2026 06:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783406898;
	bh=Hac1D+DwkuFoG+G5po4P0T2lLHD81goBLdqm6cccAAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TH9OBtFkWh6yDb+swE9L0AP0Cfza5ifewJC9fCyNVxzdtFX654XOAQxmTCIdwkF5c
	 roEsiK2qWY5xCEu2XhpkJE+Cmfle4Wo8HAabFOyCG6VIwXhDzZrQJws5B9GPtecC8J
	 KFEUfU9X4jbwcoD6inu5drqF13ClAh/qGkKr+/3xXumgYeQAqhEO9wYsd3+zID3DMk
	 FRwjkVSOr75iihiK3gkw4Z6Gq50N5pBmoIEIgix0/J2VfcTR3+XZFDmuJ+m2uUoLVj
	 nD/DNGbw5E6kErE0yg63oi2Lr4mtbZgJlPmreVJwo/M4mq9pZ6CdNRByUJ6CPt2/F6
	 QQxnhtlwEhecQ==
Date: Tue, 7 Jul 2026 08:48:08 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: PCI: Add bindings for endpoint gpios
Message-ID: <34ao6p6f3alyqynyscpdmc7k4svmbcrlmamzhwjq2qdn47lnm5@u5bpordfbams>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701-shikra-upstream-v1-3-e1a721eb8943@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 12:32:45AM +0530, Sushrut Shree Trivedi wrote:

Use proper prefix for the subject.

> Add devicetree bindings for TC9563 GPIO's which are
> used to control endpoint power and reset.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index b3ad05d90201..f9f71f28aa92 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -26,6 +26,11 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +        const: 2

Fix indent.

> +
>    resx-gpios:
>      maxItems: 1
>      description:
> @@ -69,6 +74,17 @@ $defs:
>      type: object
>  
>      properties:
> +      reset-gpios:
> +        description:
> +          Specify the TC9563 GPIO used to reset the endpoint
> +          connected to the particular TC9563 downstream port.
> +

This the PERST# signal, isn't it? If so, mention it as-is.

> +      ep-pwr-en-gpios:
> +        description:
> +          Specify the TC9563 GPIO used for enabling power to
> +          the endpoint connected to the particular TC9563
> +          downstream port.
> +

So this GPIO controls 3.3v supply to the endpoint? If so, it should be described
as a GPIO controlled regulator:

	vreg_pcie_3v3: regulator-pcie-3v3 {
		compatible = "regulator-fixed";		
		...
		gpio = <&tc9563 2 GPIO_ACTIVE_HIGH>;
		...
	};

And then you should let the pwrctrl driver control the upstream port. The upside
here is that the pwrctrl driver already controls both 3.3v and reset-gpios
(PERST#). So you do not need to have any change in the TC9563 driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
