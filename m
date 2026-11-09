Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228820;
	b=cR7oTYNc3th3i7Knat+gl4JCNtLN4IS6WFZKFjxgp+BswK8JwE0TdU79C5LG/7+IYz6o
	 AuQ+Ud0rLlEDUy42+CdkOIFuXh2c+15Gk2uLqmd9zik0rT4OmV6R6UvbNwdpfh9npxadY
	 ik5re3d0rokm01i64QB1Qmjjj+wBnr254d3D4fKWF1tER109/uS64uTahg98Inim9OjBM
	 clV7vuDPo4ljpl7LVAh4SuavY/AuE7IfVVSR1orHQcvuFV0PSlbfycfccCh4ZQ0HIXsL7
	 9iCXdWwLC5GtJasYVLWe74jNZijx/E8QftLVWfB3USQ63KN9jUoOhqQsPbHfwCl6egA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228820;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ux+kRKXXPI8nIz9tVs7F7c1iyRd71QPMq85RyBOC8hs=;
	b=UIn16VWFVAfNkaTF1ZZb1SfFPb3CZ1uUidlReBpZBt6f+viEspJiScJ9x9pPIDnkLblb
	 6d8mrrqg8+2p2+/Uz2sjIMelGlw9+5bni/ic79ExRBheS/jU9K/BfyVlleQbDXAd2wJ0t
	 rfbqjbVluG+tL6wpZ0RTZOSsb+LoASxYxrCcyj1uAf4/ofH+LYxFPFVaGrq2/2yhPwRAn
	 EvAq4VGRMJAEXVsZ9O2BBso0zp5G8Cy3vvgJrndTOTE/EYj1S5kRmHnY9kYvYJ2EM8u4F
	 wGicEcKAOWllqaw+xrUXN3NkUplO0p9RY2bpblvBpBk5B4SMT9eDxI3Q2f1KX0OMvnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LslcekGx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A25606A31C;
	Mon,  9 Nov 2026 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LslcekGx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E751F0089F;
	Mon,  9 Nov 2026 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228819;
	bh=Ux+kRKXXPI8nIz9tVs7F7c1iyRd71QPMq85RyBOC8hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LslcekGxXHGx640hxCX1qU4y3Ga4SG1UR8Prf0X8VgVs1GLzCg5bCzJw7B6pO32OU
	 mKE8Dk3709O1waviv0YC2ar9tj4kPP0W92IwaElOgyxliKvC/kLXaQvXl4V78Uh5Bv
	 GEkPYWqRewIIWHjIODWTtSMgOG/Yxhml0mXxm+h+3Si3ha23p3V79Nucsxd2xFYK9N
	 1AhHI+FgW+xMTowP399WLCuO9yTJv6bdpy3Dp2DmJhxT1hwwq1Rk+u3gBg8jzo2L1J
	 /9GFrZ7CPEw012u6tph2ZiGmWrODeXW8JikeNqTDzb24v2YsdhmfYTuvemRn864i06
	 k6iNs29nDkH1w==
Date: Mon, 9 Nov 2026 13:53:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Joshua Peisach <jpeisach@ubuntu.com>, Michael Reeves <michael.reeves077@gmail.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: PCI: apple,pcie: Add M3 generation
 compatibles
Message-ID: <20261109-athletic-shaggy-cougar-88b8bf@quoll>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108-apple-m3-pcie-v2-2-0e5ffec71da4@jannau.net>

On Sun, Nov 08, 2026 at 03:22:36PM +0100, Janne Grunau wrote:
> The PCIe controller on Apple M3, M3 Pro, Max and Ultra SoCs are
> compatible with the one on M2 Pro and Max. Add their per SoC compatibles
> "apple,t8122-pcie" (M3), "apple,t6030-pcie" (M3 Pro) and
> "apple,t6031-pcie" (M3 Max/Ultra) to the bindings.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> Changes in v2:
> - modified subject line
> ---
>  Documentation/devicetree/bindings/pci/apple,pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

