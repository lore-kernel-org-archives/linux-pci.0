Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7CA3D3312;
	Tue, 10 Mar 2026 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130914; cv=none; b=BZgEZuOChxdzafr8Y+Okq4nAuSusmDIDJ02taqZccpKBAObhDOpabUnJO1Kz/A3n+K04g+prY14vfMO3I3mASPZf26P3qsQ+EbMr/qcK/6sHu2RrjcKtRyBGxENz1le4JmTsH1irmRJ2RsuBaQ1a0b5Nye+Ku4RA97eUgcZ7hig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130914; c=relaxed/simple;
	bh=OSpFEb+8JxBVY9j4OB3Pja7xXgXwec+4oG380zPRh7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CL0ivQwv5KhDrVbledMVDh1d/qNVIAG+j6VBrW1GCqe9pYv7d4BAXNd6jEGiMV6ICHVaffblWUTBstIkLgevR0rtFou9jU92Xwnk9t4nDF7r8t/zqos0yg5l0MFjjTqT11yZ+37WEhX4J+Z0IVuUL7uX92oKacwR5WU5VIQYYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RedxTO/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RedxTO/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B86C4AF0B;
	Tue, 10 Mar 2026 08:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773130914;
	bh=OSpFEb+8JxBVY9j4OB3Pja7xXgXwec+4oG380zPRh7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RedxTO/B6FUWuNCirVgKnpdAkbhRW+yZrydrsSbKiH6rJ4fCepqVobZeyfBXjEm4k
	 cgwzz9pjSmf1nygIOEcZ2LnEWWUGPTLjluc9h2zs+sGJ+zj2M1JQlrnrefpT2kwYyM
	 KKQ/UdAkupvoypw42FfyRRQrgbMvRWOqLr1aXh38U3LXOLVIISIsf8gxi4H3npH7wg
	 dsx/uArC2p8Pp1s7JQdCRKhMACtLjAmLq/2cak2yJdLXB+D40s1dc/bys/MPcC0d9U
	 7U25KwQ6iejRCng1l9Hw/7v/8RmAKlRhENNbOvcgLhYV4Kfo5Kd1oABy12k2Rzkxy5
	 QeYJdP/Kb5GZQ==
Date: Tue, 10 Mar 2026 09:21:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
	p.zabel@pengutronix.de, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	nbd@nbd.name, ansuelsmth@gmail.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] dt-bindings: clock, reset: Add econet EN751221
Message-ID: <20260310-rousing-tacky-catfish-fcba60@quoll>
References: <20260309131818.74467-1-cjd@cjdns.fr>
 <20260309131818.74467-2-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309131818.74467-2-cjd@cjdns.fr>

On Mon, Mar 09, 2026 at 01:18:11PM +0000, Caleb James DeLisle wrote:
> Add clock and reset bindings for EN751221 as well as a "chip-scu" which is
> an additional regmap that is used by the clock driver as well as others.
> This split of the SCU across two register areas is the same as the Airoha
> AN758x family.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  .../bindings/clock/airoha,en7523-scu.yaml     |  7 ++-
>  .../devicetree/bindings/mfd/syscon.yaml       |  2 +
>  MAINTAINERS                                   |  2 +
>  .../dt-bindings/clock/econet,en751221-scu.h   | 13 +++++
>  .../dt-bindings/reset/econet,en751221-scu.h   | 49 +++++++++++++++++++
>  5 files changed, 72 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/econet,en751221-scu.h
>  create mode 100644 include/dt-bindings/reset/econet,en751221-scu.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> index a8471367175b..91abe7716fce 100644
> --- a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> @@ -32,6 +32,7 @@ properties:
>        - enum:
>            - airoha,en7523-scu
>            - airoha,en7581-scu
> +          - econet,en751221-scu

751 < 752, keep alphanumeric order

>  
>    reg:
>      items:
> @@ -67,7 +68,10 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          const: airoha,en7581-scu
> +          items:

<form letter>
This is a friendly reminder during the review process.

It seems my or other reviewer's previous comments were not fully
addressed. Maybe the feedback got lost between the quotes, maybe you
just forgot to apply it. Please go back to the previous discussion and
either implement all requested changes or keep discussing them.

Thank you.
</form letter>

Best regards,
Krzysztof

