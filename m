Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793187690;
	b=3BIOTfCoy7efCL2/dKeR8Ps++V9ZsBz7gQfVpmKgYnpT1YiSs18JBW2KbnozCAuuFyjQ
	 1nomLhpD0oZ9aBhRVlrKzorSYUcnIPGYkOgVGHXow0JEunmnd+6QwbZs0vIS3PW04YhGS
	 OXInTZDaoMZzVczPxPflvfgavinLVYi4/vC5gXqukwM+BZmnXx3J+/C0gaBl12j82dyv3
	 SSYMwdHaVFOgVUdKv+CuoUAvngtuZxxzNT/xHUnQ7LWvfziSAaYui85Sg2buKiQVGC64e
	 ysixqidZrg0Z9DxBd0B9A6JsL47gNNk4kmCNOjHEQHnEMvqdt01f+2dRzC2Pk+3nsxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187690;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qaNp73WDDT38C4QvIcC33K4u1Sk0ULpBkqftENWUDss=;
	b=sjPkBqBgZremlpqnqvd/9ecz6mhKIiMVQkgQdoZ77SlPaj/SRuXVCsGaew5ijvmYfcI9
	 7r0lZ4XyquVYMq3e/IdE7hLVMpyvRZ+s+lUG7xHp2h7ZC32s49bR0KwZsFYnEq9lsvuBv
	 iAxh0c3ijCS2/7bHUbEfzOPWruTogYpDC9yqcwq7vFmlf3kTHoemKxLBH0IZzzp+d8mzP
	 4fBs2vmcq0hNmxhUS8PbGeAq1yVmLsqVdIsNmmshgEwaS1oRDUx38iCZ3igASxtxpigcq
	 MFjDYdGNvJInSkbmcWxrgmg2t7CqbsU4VPrF1M8m8/579oyi3KidPuIY5kDJDFf2SSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUWdC9ii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21E606A31A;
	Wed, 28 Oct 2026 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hUWdC9ii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADB41F01825;
	Wed, 28 Oct 2026 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793187689;
	bh=qaNp73WDDT38C4QvIcC33K4u1Sk0ULpBkqftENWUDss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hUWdC9ii38YmtM4niQrcVuKM0MmLcS6Ymm/DpSbDM+uxAsUb9gym7iZ+LqjHT36YM
	 uRRpINPqxTjQD1OYZX7hZdDA2FmQ01u1OGxpwXwGh62crNj8RdX31Y+QvcF+Qe3Bqm
	 i3tx2Ar4D7q5eSfau6OEXjHP6DRwiRXMbcVo01NpfLhpqTM+HY4h4KST1dKFQrNQPo
	 bLKfNqNrf+ETVHb0gT6RzsCE+qbBEZN9TLSn/4Mdo+daIGLKGYRlWVLgVVHsLZYpYW
	 Wy9BAURW+S1OHFfq8kVrQchPE/H0KgLjNsKe9WV+MeBBjzXWWL47H58kNqZzsnWPdK
	 I0stxpRbXUVEg==
Date: Wed, 28 Oct 2026 12:41:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce
 IRQ with AER IRQ on R-Car Gen5
Message-ID: <20261028-valiant-boar-of-competence-febbdb@quoll>
References: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>

On Mon, Oct 26, 2026 at 11:44:18PM +0100, Marek Vasut wrote:
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

