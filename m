Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3D3BCD23;
	Mon, 29 Jun 2026 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716854; cv=none; b=Wboz2PSyJ5fT+yrGyK2bDy4KmL37+DmMeT/035unyjTxO4IifBBdFOx23m17CdD3p1NTxP6LQts4FLePNDCzeXOPtqIjDyAFcLU0SuqRMAp9d70bVmtvIGK9UCOLSdrpFIe038nIvJWg+5X41jJE91DGbYcG8+SRbOEaD17jOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716854; c=relaxed/simple;
	bh=Jw6vNOtoZ6w5SsAHnbHy9znudhYHX9kAAkfnsf4a0Vo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p6HJRTJefpdJl82WJ76gdLk7FQR8NLsDCQZWMlAawJsQLNuWpdZ1Y3Hc+nFoy0PUVnp7iIfN3PTuQs651dBsJmhwA7Zkp7Fm4/jXLwM09AijPSoikagd//KFAniv3Oz0Xkl4xRo0HTpHVH78f7j2C3DLIAl2uwsYfvrDNWxnmfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7740B20027F;
	Mon, 29 Jun 2026 09:07:22 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1we65S-005CZR-1I;
	Mon, 29 Jun 2026 09:07:22 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1we65S-000000003Wg-1Jlm;
	Mon, 29 Jun 2026 09:07:22 +0200
Message-ID: <68b43224e0a124c055fc228b3a254fc7908dbcdd.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] clk: en7523: add support for dedicated PCIe
 PERSTOUT reset
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Christian Marangi <ansuelsmth@gmail.com>, Bjorn Helgaas	
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Ryder
 Lee <ryder.lee@mediatek.com>, Michael Turquette	 <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney	 <bmasney@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, 	linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, 	linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Mon, 29 Jun 2026 09:07:22 +0200
In-Reply-To: <20260627121450.3529133-3-ansuelsmth@gmail.com>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
	 <20260627121450.3529133-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sa, 2026-06-27 at 14:14 +0200, Christian Marangi wrote:
> Add support for resetting the PCIe lines with the PERSTOUT reset. These
> special reset are controlled by the PCIC register and are specific to eac=
h
> of the 3 PCIe lines.
>=20
> Notice that reset logic is inverted for these bit where 0 is assert and 1
> deassert. This is intenrally handled in the reset function.
                        ^^
typo: internally

> PCI enable/disable are updated to drop PERSTOUT bits in favor dedicated
> reset handling.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/clk/clk-en7523.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index 1ab0e2eca5d3..c9b21d9bf2f3 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
[...]
> @@ -754,14 +756,21 @@ static int en7523_reset_update(struct reset_control=
ler_dev *rcdev,
>  			       unsigned long id, bool assert)
>  {
>  	struct en_rst_data *rst_data =3D container_of(rcdev, struct en_rst_data=
, rcdev);
> -	void __iomem *addr =3D rst_data->base + rst_data->bank_ofs[id / RST_NR_=
PER_BANK];
> +	u32 offset =3D rst_data->bank_ofs[id / RST_NR_PER_BANK];
> +	void __iomem *addr =3D rst_data->base + offset;
> +	bool inverted =3D false;
>  	u32 val;
> =20
> +	/* For PCIC reset logic is inverted, 0:assert 1:deassert*/
> +	if (offset =3D=3D REG_NP_SCU_PCIC)
> +		inverted =3D true;
> +
>  	val =3D readl(addr);
> +	val &=3D ~BIT(id % RST_NR_PER_BANK);
>  	if (assert)
> -		val |=3D BIT(id % RST_NR_PER_BANK);
> +		val |=3D inverted ? 0 : BIT(id % RST_NR_PER_BANK);
>  	else
> -		val &=3D ~BIT(id % RST_NR_PER_BANK);
> +		val |=3D inverted ? BIT(id % RST_NR_PER_BANK) : 0;

You can simplify this into a single (assert ^ inverted) condition.

regards
Philipp
