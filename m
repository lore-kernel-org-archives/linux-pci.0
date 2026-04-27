Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33634B1B0;
	Mon, 27 Apr 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305856; cv=none; b=mOevJRLv4nH0jdsEQoGqqMXP9Ez8DQ3votvQy9NyWpNTSlPdN9Rr63VKNWNcVezkbdaHUqUDhajXrEYzz2OeulH3Nrc39RUmY2z+1cfcjYTFyu7qKsenkqsBWSaQJ5Ha1hFdYRUzNWEmWZG5a8eXsbLsaMqCCtxeolnzU3VAvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305856; c=relaxed/simple;
	bh=UW2ziu0vYi5bpD6WFhH5Pn3wPP3OyNm/8gp9tgp+Csk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktp1eYa52g3tN7xq8RicNvdPqbpMfipRSSYQEkafVp6xDOQge6vpi5KAr1JK/5uFHow8A9gizAA06QKm8BJaPEcOHvWXn0UcfCUzd8VpbTF1ywmZUIn0G2wNxnGhKrvp9DsVqjMAJJ+PhQRtieDMvCFghx6tQaZ4axTGi+stCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANS0RD56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANS0RD56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE58C19425;
	Mon, 27 Apr 2026 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777305855;
	bh=UW2ziu0vYi5bpD6WFhH5Pn3wPP3OyNm/8gp9tgp+Csk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANS0RD56V9xO7muEwlXC19L7PVGslrxc8Unt6bLywkbL/6ktX+fA3CVNmVSw5ME0w
	 hHaHUAuppJxESPCR9N3xldV3rFpIXius4tc96mHRm/yntMRnQu5mJfWzgnV53K2BaI
	 +JOymfjjgNoe9tj+vIfhRtRNqFVIFVuJ+TxabdFGuo6B2Hy7FWpA0uGqayPQA0Bxdx
	 7QUbI8JBvOF4fH+Onr5mXyFMn4LdrR7t8BngJOACF9ngxr3VSQjiLEzCeyUvQeDh1Q
	 uxjTIeUmecSjAFN4dOIjMrrcdncXgOTLjqjeoq9qToILdDbSiEq40Cc2k33kx6y42i
	 ydNNto3wWQTJg==
Date: Mon, 27 Apr 2026 17:04:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Message-ID: <20260427-mandate-crucial-47bd161ecd73@spud>
References: <20260424025735.1490772-1-hongxing.zhu@nxp.com>
 <20260424025735.1490772-2-hongxing.zhu@nxp.com>
 <20260424-sinless-unfiled-d1087a894da5@spud>
 <AM0PR04MB522051DF5CA446158839C2BD8C362@AM0PR04MB5220.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qkvg/+lyFeMVn9Cn"
Content-Disposition: inline
In-Reply-To: <AM0PR04MB522051DF5CA446158839C2BD8C362@AM0PR04MB5220.eurprd04.prod.outlook.com>


--qkvg/+lyFeMVn9Cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 03:17:12AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Saturday, April 25, 2026 1:06 AM
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > bhelgaas@google.com; Frank Li <frank.li@nxp.com>; l.stach@pengutronix.d=
e;
> > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linu=
x-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; imx@lists.linux.dev; linux-kernel@vger.kern=
el.org
> > Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer=
 and pme
> > interrupts
> >=20
> > On Fri, Apr 24, 2026 at 10:57:33AM +0800, Richard Zhu wrote:
> > > Add optional 'intr', 'aer', and 'pme' interrupt entries to the i.MX6Q
> > > PCIe binding to support PCIe event-based interrupts for general
> > > controller events, Advanced Error Reporting, and Power Management
> > > Events respectively.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> >=20
> > This binding supports lots of devices. Do they all have these additiona=
l interrupts?
> Currently, only i.MX95 PCIe has these dedicated SPI interrupts. The earli=
er
> SoCs in this binding (i.MX6Q/6SX/7D/8MQ/8MM/8MP, etc.) do not expose thes=
e as
> separate interrupt lines.
>=20
> I can constrain these three interrupt entries to be valid only for the i.=
MX95
> variant using conditional schemas. Would that be acceptable?

Please

--qkvg/+lyFeMVn9Cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCae+I+QAKCRB4tDGHoIJi
0qZkAP0VeBYH09JW4VBXLCbVfTkp6AJcYotAdzH9DNBySmjUwgEArxXLiGeMs/b7
yRxmf+g2s6n2tJ8PXHvaTMjIJac0FwM=
=ppW6
-----END PGP SIGNATURE-----

--qkvg/+lyFeMVn9Cn--
