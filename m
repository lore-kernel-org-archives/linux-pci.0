Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627F733BBC5;
	Tue, 31 Mar 2026 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942582; cv=none; b=oLkn041ElWcIG48V004tjjA+oMoOXkUAt+cN+OXLoLtvNhupHefwvb6X4T65TwHyHlkJoXHQdjSneIx1qEJhYk5npZipBUT6daouhlIUeXdoJ3RfZ43VC8zXyoYgp7Z1+8K6PSfrsqnoenIJAHWYDW9CTb6nV9pFeZ9MbHTsG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942582; c=relaxed/simple;
	bh=j8DZITM2E5A+n+wmV61zvcPDChBz2rEzBMfon80KEfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uqnfz5t24TpS9VmixMlgDDIy1T49ToR87UORU6HsJ9PYSN1d7T7Sdl6q+oXCUamyFLBxkHhEL+MHT//yW57xVlzWr+CpODn8zzGnozxxlTrOZITb52Pew0yQjFlfROKAP15vWMT+G0zX+74WjBwOTezu3QbW9LP/VmJf2EuBWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0RDe9vQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0RDe9vQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8621C19423;
	Tue, 31 Mar 2026 07:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774942582;
	bh=j8DZITM2E5A+n+wmV61zvcPDChBz2rEzBMfon80KEfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0RDe9vQxbjgkkRhz3NQu4nzYfKa2bR5A1V5UPobEiWXGxLsl6DNTweKa53JaUP7e
	 4Jl/JpAeExn7g00VZ/Thvnd84M2eV64dRRL2yDVSdr6qVkNS4W176wgdiw+Z3QVR/d
	 blTYf+NUdYpkg5KQiNaNACz74XBXmBis8uCjwaEWFgcTiGXUxbB5669JRQlHu+Q45U
	 EX1zMXivzB43AOmB4A2grJbLzvebx2kQZP+cdKpLmFP33L3VPE9ZIcOTnmM24zqzop
	 f33sbhVt2D1NBvuWITkqYoKF5S7FyF0ObqknfgFPhGs4nz7nUY+RskXDrdOX4iq6iB
	 8GL9I+PH5G7bg==
Date: Tue, 31 Mar 2026 09:36:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rahul Tanwar <rtanwar@maxlinear.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Eckert.Florian@googlemail.com, 
	ms@dev.tdt.de
Subject: Re: [PATCH v2 6/7] dt-bindings: PCI: intel,lgm-pcie: Make atu
 resource mandatory
Message-ID: <20260331-expert-hummingbird-from-arcadia-3cd1c4@quoll>
References: <20260330-pcie-intel-gw-v2-0-8bd07367a298@dev.tdt.de>
 <20260330-pcie-intel-gw-v2-6-8bd07367a298@dev.tdt.de>
 <b8c60db1-7b72-410e-95a1-f13052af7256@kernel.org>
 <34a5e88249cf895cfa1132a29343ab90@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <34a5e88249cf895cfa1132a29343ab90@dev.tdt.de>

On Mon, Mar 30, 2026 at 12:52:16PM +0200, Florian Eckert wrote:
>=20
>=20
> On 2026-03-30 11:50, Krzysztof Kozlowski wrote:
> > On 30/03/2026 11:07, Florian Eckert wrote:
> > > The ATU information is already set in the dwc core if it is
> > > specified in
> > > the DTS. The driver uses its own value here [1]. This information is
> > > hardware specific and should therefore be maintained in the DTS rather
> > > than in the source.
> > >=20
> > > Backwards compatibility is not an issue here [5], as the driver is
> > > exclusively used by Maxlinear.
> >=20
> > What does that mean exactly? It is not used outside of Maxlinear
> > company, so it is purely internal device and no one outside of Maxlinear
> > has it?
>=20
> Background information:
>=20
> The PCIe IP core is only available for Maxlinear=E2=80=99s URX851 and
> URX850 SoCs. However, the chip was originally developed by Intel when
> they acquired Lantiq=E2=80=99s home networking division in 2015 [1] for t=
his
> SoCs. In 2020 the home network division was sold to Maxlinear [2].
>=20
> Since then, Maxlinear has been responsible for the driver. However,
> their SDK is outdated and based on kernel 5.15. Other than that, not

v5.15 DTS user of this binding is still valid user. Why would you break
it?

> much is happening! Even the developers listed as maintainers can no
> longer be reached. When it came to the patch set, the email couldn't
> be delivered  to the responsible developer
> 'Chuanhua Lei <lchuanhua@maxlinear.com>' either. The email bounced
> back.

Not really relevant to my question. I understand that this is not
maintained, but I asked about backwards compatibility.

Backwards compatibility of the ABI means that existing in-tree and ALL
out-of-tree users of given ABI must keep working fine. Properties with
lists have strictly defined order, so changing that order is considered
ABI break, unless you prove otherwise.

Calling code unmantained is not proving that ABI is not broken.

>=20
> The company I work for is using the chip and is currently in the
> process  of extracting the key components from the SDK so that the
> SoC URX851/URX850 can work again with a mainline kernel again.
>=20
> [1] https://www.intc.com/news-events/press-releases/detail/364/intel-to-a=
cquire-lantiq-advancing-the-connected-home
> [2] https://investors.maxlinear.com/press-releases/detail/395/maxlinear-t=
o-acquire-intels-home-gateway-platform
>=20
> > Then we can as well remove it and I don't quite get why you are working
> > on this (since no one can use it outside of Maxlinear...).
>=20
> Maxlinear continues to sell that SoC. They are *not' EOL.
> It=E2=80=99s just that their Board Support Package (SDK) is no longer
> up to date.
>=20
> > >=20
> > > Old DTS entry for PCIe:
> > >=20
> > > reg =3D <0xd1000000 0x1000>,
> > >       <0xd3000000 0x20000>,
> > >       <0xd0c41000.0x1000>;
> > > reg-names =3D "dbi", "config", "app";
> > >=20
> > > New DTS entry for PCIe:
> > >=20
> > > reg =3D <0xd1000000 0x1000>,
> > >       <0xd10c0000 0x1000>,
> > >       <0xd3000000 0x20000>,
> > >      <0xd0c41000.0x1000>;
> > > reg-names =3D "dbi", "atu", "config", "app";
> >=20
> > Drop, irrelevant. You still break all users of this binding.
>=20
> As noted in link [3], a Maxlinear developer has stated that
> backwards compatibility is not necessary here, as the IP core
> is used exclusively by Maxlinear`s URX851 and URX850 SoC`s.
>=20
> We use these SoCs in our Produkt for internet home gateway
> routers.
>=20
> [3] https://lore.kernel.org/all/BY3PR19MB507667CE7531D863E1E5F8AEBDD82@BY=
3PR19MB5076.namprd19.prod.outlook.com/

OK, yet I do not understand "driver is only used for internally". How
Maxlinear engineer can know all projects around the world and all 7
billion people if they use that ABI? And if they are right and no one
uses it outside of Maxlinear, then let's drop this code. It's dead code,
no?

Best regards,
Krzysztof

