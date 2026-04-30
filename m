Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792338E5DE;
	Thu, 30 Apr 2026 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777536301; cv=none; b=DO/PG9//BPw60xwwGHpvcpa6R1ySrdL4uYF9PkMeoLpttxT1uhxbqtut0GY2u/b2alBTzTqrBsnfIWswAFfI6ABBmZYs1xhITssA6qQ4JfgZxBYodRNM9Wt2wF+3711wIE3RTCH6RL6xXSxlCDf8a5REF2epul8XiqTs40AI/lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777536301; c=relaxed/simple;
	bh=7nNKR94jeY1+8VKy4ZEGDpWJaACzWqalOpA7Fj7cfVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHBhoYEX7buVcbO3uKcdiveUAiObKq1l4qRfStosrMqkfRyTgAsXkx1UtNqBYorK1sQmvpoXl8OAvxild5fXbOiPhFkl+liNDlD0oduBbkIAudZUoQ9z/sMcrHaAs+yl+C1Vhjpk8rEXVCDIJOCkv6l9u9zvg3y//PzeICrrEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrFXUzp9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrFXUzp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C95C2BCB3;
	Thu, 30 Apr 2026 08:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777536301;
	bh=7nNKR94jeY1+8VKy4ZEGDpWJaACzWqalOpA7Fj7cfVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrFXUzp9bDp0CSbhaP2uFQGbo//AE5QuvYcezv+XHTmTjXwuj2u9/OjHFdoWNEj6X
	 NVzQZfFaHCwyyNBVvqnakuGlj11iO2AYhwYXX0zPCcUeTZ46lcwy0mtTUPdq7S0cAX
	 XEjMP0DdIbIDIR+e34ArJJ9EkAYnAZ7LA+JsuXBKimcbImp1lycOqKLtMB4s6Ttg3t
	 9OsdxEoICc1ivrQLtftCFYDlys4UZgVOesx4Hz/9kX+MMQNptOKGFmS/WzLQgSU/Lq
	 K9CQo2lFVGpTyYd1mZpDeXiJzAf/5XEwymN1lquWyKkEvWWPGXIa/FoaESmFU80SGb
	 86T1x7IKvEViQ==
Date: Thu, 30 Apr 2026 10:04:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
 interrupters for pcie{0,1}
Message-ID: <20260430-adaptable-wonderful-hoatzin-e1056f@quoll>
References: <20260430050954.3467984-1-hongxing.zhu@nxp.com>
 <20260430050954.3467984-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430050954.3467984-3-hongxing.zhu@nxp.com>

On Thu, Apr 30, 2026 at 01:09:53PM +0800, Richard Zhu wrote:
> Add dma, intr, aer and pme interrupters for pcie{0,1}.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 71394871d8dd0..6896d9c15bf53 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1861,8 +1861,12 @@ pcie0: pcie@4c300000 {
>  			bus-range = <0x00 0xff>;
>  			num-lanes = <1>;
>  			num-viewport = <8>;
> -			interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";

Why there is no fixes tag if this is here for two years and you claim
that IT CANNOT work without these interrupts?

Best regards,
Krzysztof

