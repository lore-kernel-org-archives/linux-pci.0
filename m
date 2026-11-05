Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793878760;
	b=koRe8asLZp42kiUXa8hHxFD+1K8fVTqggY3DmqvZyOBs4wDDECppwFMzQ1+CsU0pXCjD
	 uOhkyEHSLxWQB5K5hguKGuuqPEcpKtdlDPG09IWiQg/N0GbJUg6k07wDTiFC0RqWaae8R
	 dn4D4Ec8DEv1XCMABGgv/tNSnxhwhdk6qUKCPIgbL58EgqAtW4ypORfrEN/FWtp+oJhWZ
	 NYm5PhIrNnIb75ECIOfHmfDKz+fr3qPV07ISc3JWGSlTyt3LV9Yd4skMKhWSTceqKwjGp
	 Nsws+4NwS64nul/6LdiOjafkfDluQNfkWsDEpiq0w4f5gyHqFC8lU1lwqBA/zGBZs3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878760;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=dusSPG9xdMmVsVmNbkzIpKIHdRS2NNRTzKzvSiReq7M=;
	b=abcLTWpVSDC1G8UKyoGSkOVgnxvn67C2HdLSGhneuJsgq98ICr35V5G//Pwpr2xv1NOR
	 azP8qvsu655+twYjaPGmRdOg2Zip5sxP3X+Ggp0qoA2t6xrKlD8ZTAj/mtH6fxZvATpOE
	 OnApExwr4B3+JP8I/42tvodbeTPPlWQlvqgyN+oi1DL2+VTHUrejPMzSaZQHn6CuRVfu4
	 Ka7t48AKSUFOXoa+I+L2tQ0KghsiZspIaQ6ieeXoOLrHNppcbLwEDYrfJdhELZxYNyqFu
	 FUMCTKwFZUpyKRHLqq9//oUWxwQwumKVpWPfZRvJrHLA5EDyTd/bqPI9J/5vuUZ0mWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="Ygj8Imd/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06C606A31B;
	Thu,  5 Nov 2026 11:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F06C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Ygj8Imd/
ARC-Seal: i=1; a=rsa-sha256; t=1793878715; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ck6FNJp0Yxgxqt2iULMM3JNKRistkUhgh/gv6A2N87GaYoyWqdg4+jUoCPr1bsLBlYq6cIcTai28I+tLZWLoCWeKuDVv1iczbtGPtKO5KnS8kOkb2ml4iBvMgyViJlvZ42qbPBXGu1yp49sd2dMNty4Pp2uG+u+FxyLYrl9UumI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793878715; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dusSPG9xdMmVsVmNbkzIpKIHdRS2NNRTzKzvSiReq7M=; 
	b=lNIsr5k3EvhNllfZJkYwMfn5uAystXsC0cmmbJYIwhuXjJLSYJoddmAPLz/L7kfexdeKnmtsszaPd5/2AKelrcis9JKmI66YOXoIC8pkhoAfezcBW5vrcLa08T22sldBx7LazI2Jqwuse6LKcJ09ssXWrCDORzrMT9Hb1gzLgz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Ygj8Imd/JfamIY3R12XIvTLsdH2222RBVyS/4e2SHQPz1jUK37NgbnWhB2CFoSVMrbpgUNnO/8xMJuqZuFdUdbtJu0rgQ0HFu05P/c7pl1ET+VwvaWzrYM1G2/04EtnYkKLZ645YjjegQ+Whhca8kOk02PNjWqczgvvKTaAUQkg=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=dusSPG9xdMmVsVmNbkzIpKIHdRS2NNRTzKzvSiReq7M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793878713458719.9402546907897;
	Thu, 5 Nov 2026 03:38:33 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 07AF8180350; Thu, 05 Nov 2026 12:38:28 +0100 (CET)
Date: Thu, 5 Nov 2026 12:38:28 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v8 7/9] PCI: dw-rockchip: Add pme_turn_off support
Message-ID: <auxpGArMuCJmdn-S@venus>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-7-0434b4f373bc@collabora.com>
 <f047dcbe-efa2-4c60-8436-6d001c936467@rock-chips.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kdkht52zgzkidek7"
Content-Disposition: inline
In-Reply-To: <f047dcbe-efa2-4c60-8436-6d001c936467@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.861.93
X-ZohoMailClient: External


--kdkht52zgzkidek7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 7/9] PCI: dw-rockchip: Add pme_turn_off support
MIME-Version: 1.0

Hi,

On Thu, Nov 05, 2026 at 08:51:14AM +0800, Shawn Lin wrote:
> [...]
> > +static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +	struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> > +	struct device *dev =3D rockchip->pci.dev;
> > +	u32 status;
> > +	int ret;
> > +
> > +	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
> > +	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
> > +	ret =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
> > +				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_warn(dev, "Failed to send PME_Turn_Off\n");
> > +		return;
> > +	}
> > +
> > +	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
> > +	ret =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STAT=
US_MSG_RX,
> > +				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
> > +		return;
> > +	}
> > +
> > +	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
> > +	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATU=
S_MSG_RX);
> > +	ret =3D readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER_CON,
> > +				 status, status & PME_READY_ENTER_L23,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
> > +				 PCIE_PME_TO_L2_TIMEOUT_US);
> > +	if (ret)
> > +		dev_err(dev, "Failed to get ready to enter L23 message\n");
> > +}
>=20
> This is a question for the DWC core: should we change
> dw_pcie_host_ops::pme_turn_off() to return a value instead of silently
> ignoring a failure?
>=20
> Looking at pcie-designware-host.c, we have:
>=20
> if (pci->pp.ops->pme_turn_off) {
>     pci->pp.ops->pme_turn_off(&pci->pp);
> } else {
>     ret =3D dw_pcie_pme_turn_off(pci);
>     if (ret)
>         return ret;
> }
>=20
> The handling feels asymmetric. If ->pme_turn_off fails, shouldn't we abort
> dw_pcie_suspend_noirq as well?

That sounds sensible to me. I had a look and apart from Rockchip,
Layescape can run into an error. Most platforms cannot produce any
errors in that function, which explains why this was void to begin
with.

> Other than that, this patch looks good to me in current shape,
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, taken over for v9.

> We can further discuss the callback's return value issue on top.

Agreed. This will touch all the glue drivers to add a return 0. I
think its better to do that in a separate series.

Greetings,

-- Sebastian

--kdkht52zgzkidek7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrsaqkACgkQ2O7X88g7
+ppOQQ//WoZHIiRbMmXqisCxBjqzqieSnrTn+4gdKBb5ipuBqtBM3YnhR5D9z8vj
qxkO9v5mR2ykXKTUTN0b/IgpGwxVnC5ccoYNQWNzpIttV4i/e1Tj7V+4KyGnxfo9
ZI+qDp3y2jGlsh7j89VTZmHoH78j8CLDDGZqUAIhW+sFNvqyJ69abnG8c6ozO6Yu
R4yjEHkEdan4+RJJufB+9hCzbLAJs3OgZkJMbUf1DkVgLxtJGmRp91M+ZcNqlmo1
H9ri2ur38nBzAhcgQqAIl3FbqdS42WI8EIbB0nUT+u6P9UGw3Run7NyNmSl9SZO9
cimqFBsGEJP19fcWYsaY52FpYHapPlkTvL961G74cIZaXeHhgOU+np3vlKu6L9Nj
CYVktU59FVlyL2AjLNxPPz7Nj0ApJwWqeHduV5iv6mPXwZKsgfBlljKKmt9ENEV4
3aXWLthxSTXn8EbUJaDhbCEuSAckZ6Q0jBLLm1jxI6Xl91BXLugGeHrxHLg7Ot/W
eItpBHYxgVmFYdqWIOEnwEvNosQ5AAGuiaxxpbtiijQ1Ry2cgD2WwQ3eIxPRhI8X
mSmeonaUh1lDbY6pJlb+R8O1lADwOTreUVYahV3BleF6YiVCqe18qJPXu+Vw/Oul
lElhNe92o+6baSESkxZHh9syJgR8/81Pz8CGQ+SjICYIzN+M+iA=
=4x0q
-----END PGP SIGNATURE-----

--kdkht52zgzkidek7--
