Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793053603;
	b=S6slzIxhZBfqMjbGG6L0QfdHL5Kah0pFwdxuz4Ty/ZWE8oLKXE9lniBJEBSQP+DlyTdM
	 98XJINtZgfJ2glYrmT+Fu6Hy59JbggN9PUx0bY6tLyCUt+JEuanFpdWVc7fs2dDSlOwZx
	 kaqtj1txai8JyTjcaNlV+HqoKcgyoXpjyeM7NDNQDblJKoRfYIJ/fIxW6FJ0aQHqQvfAf
	 KG9xZVoElicGAo+u2FemSKd6wg7yh1BQYPqaSNeKjzqd94i2vyZ6vgsbhsH550sKcecYf
	 n4p1k6aPCaEfGmSsbOBbKa9ROJEtDzzQPLa2+MiuA59bk6bZ7mKKyJLGzJmGgiITeZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793053603;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ULBxQsLKeig0T/FlmtJ8WLo+AdcFG7aZxo3nudNz58s=;
	b=nuZL4YlyiIRsHlSrnj4Pu9Z/jOy+CEJqyNnzgw65zYqm64H31BwA0BxIUy4sQqr9+/2L
	 LuxhZMHTv8iGkOprUCdYl6+ObNqAbv1eahyyYLe8pqk8v/BGqDHGhPlaLLeUhtAzUh5j3
	 JHwR9YJFai4kiU4P+uyneTcZolKT9BASUi8s8QKdHypb8FHbTRsUD2fBtqvskJlQ7a85P
	 zZzdh3LCyVy9Qg023FuCPaxoVFepX2UYkJWgQ6IXFqM7BNy2vC6OSOMEJyNtM3DIev1sL
	 pCEM5TIP9V0rCEsy4nkoqjVll6RHi7vESvIChxo1S1l/V9YTepDmnrJjLsRa7cxz2Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XngLByOZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78BA606A31A;
	Mon, 26 Oct 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XngLByOZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC7E1F01825;
	Mon, 26 Oct 2026 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793053602;
	bh=ULBxQsLKeig0T/FlmtJ8WLo+AdcFG7aZxo3nudNz58s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XngLByOZdbAcb8MjWL9wMjwsQQoczgpB+TuokEsPFJTSPxZuuhDxZ/ichLbZMEl/z
	 KQTcu0Oz1/RHyDsgF+By3u5+a16GiJoW9o/cU4Yaxo6elhSTMddAU8brYzS7TH+YBV
	 P7Qu3Uh52yBhmLplMsPtbz8ioh1pSSlqyXWqQHuCEYeqBGEURV2AB5Evvkw+17ne8E
	 AdvAGmF8MuWsJLpm35wuQ0EsbYmXJw2l/S1ax4mh3UMv1qRbU+kJGOL9Xh6hzShXh0
	 vHPQpbqBuNu27TCmc3mgAvXr6ZUO6vatukd27w5oMhJ+kdNLXCESF3pHYj7s6Qn0X5
	 ipIs5+D9nTnRw==
Date: Mon, 26 Oct 2026 17:26:39 -0500
From: Rob Herring <robh@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ
 with AER IRQ on R-Car Gen5
Message-ID: <20261026222639.GA4182867-robh@kernel.org>
References: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>

On Sat, Oct 03, 2026 at 11:57:04PM +0200, Marek Vasut wrote:
> The R-Car Gen5 SoC PCIe4 controller does not have dedicated sft_ce IRQ.
> Make that interrupt conditionally available only on R-Car Gen4 SoC PCIe
> controller.
> 
> The R-Car Gen5 SoC PCIe4 controller does have dedicated AER interrupt,
> include it from the beginning. R-Car Gen4 SoC PCIe controller also has
> an AER interrupt, but to retain binding backward compatibility, this
> interrupt is kept optional and added in a separate patchset.
> 
> Fixes: 5b555a496160 ("dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> NOTE: Gen4 AER is added in https://lore.kernel.org/all/20260928165230.3397664-1-den@valinux.co.jp/
> ---
>  .../bindings/pci/rcar-gen4-pci-host.yaml      | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> index 362c43a1a15d0..083b77d4de8f7 100644
> --- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> @@ -28,13 +28,6 @@ properties:
>    interrupts:
>      maxItems: 4
>  
> -  interrupt-names:

Keep with just 'maxItems: 4'.

> -    items:
> -      - const: msi
> -      - const: dma
> -      - const: sft_ce
> -      - const: app
> -
