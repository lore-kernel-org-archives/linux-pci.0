Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75B38F24F;
	Fri, 20 Mar 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004205; cv=none; b=bCfL9Lboaq+VaXTCRVhZzoq9yiYZqaa/JVNuvM8VH+Dh7RfLXB4xjTSV4ipYj0spIrHfsVZw1DtPkdCtPiYx0/6/PwabWeGM/PtKKxFI6kctA4PaHmNlzroO2eqiUbwC0SgqyrAsveBYBM/ALaiZyyn6cRtCOK4C70tRLTpKiGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004205; c=relaxed/simple;
	bh=n3uZ/gyaXh7/K/y6oC2rz3ZYkHHXphOchlC3Gq0VCzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ded0YlKw8mAvQwBEztGQRFfjpMko+OIBl6GHAlXmckPqfGCKv1ChKwU9+MD09Hb6se2raNHLV9fSTdynDBGKGPU+V5JAsIGCSFze9Uc1/FiX67H1rl2vLOJihIw+zDsK+oWIo6Eo5232kqeWqqkwKlLxPmhpKvMsO0jVz9BgoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrclYYlB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrclYYlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5C7C4CEF7;
	Fri, 20 Mar 2026 10:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774004204;
	bh=n3uZ/gyaXh7/K/y6oC2rz3ZYkHHXphOchlC3Gq0VCzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrclYYlBb2Y95KfsX3mZL/oMhqpZQ8RfUJKgl6hV80JdELeDtUisBh1EAdvZVGbVX
	 8P0ajrRd12x86BiiVteglSqW5NGNxktMORquLiEBX/XvzOnDEW2qhp5FaPeBiBkYhu
	 WQui+k/kSMLTsfs9UWKZ3/XvErda7rF0jS9x4uR94G4ZqU6CzZjMNI+Ncfd7dulxGZ
	 CnXpoJCd1tMuIrOC3OQg4+0KQtqDID47Lh06+7vsshBvGj156wLE++03jMFR8FCKVH
	 sD+fow8WeIC08N3qm3OBfBoU1X0w2HG192INsWfbI0ORY4BNKQ2PXekYMfgKDss0GC
	 ZSS2kLNPhXXmw==
Date: Fri, 20 Mar 2026 11:56:42 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
Message-ID: <ab0m9vhaXJUMM4Dr@orome>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-4-thierry.reding@kernel.org>
 <353939e0-ef52-4c8f-bf71-ff27fa2c7d7a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46nql75yhiesreer"
Content-Disposition: inline
In-Reply-To: <353939e0-ef52-4c8f-bf71-ff27fa2c7d7a@kernel.org>


--46nql75yhiesreer
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 05:11:17PM +0100, Krzysztof Kozlowski wrote:
> On 19/03/2026 17:01, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The six PCIe controllers found on Tegra264 are of two types: one is used
> > for the internal GPU and therefore is not connected to a UPHY and the
> > remaining five controllers are typically routed to a PCI slot and have
> > additional controls for the physical link.
> >=20
> > While these controllers can be switched into endpoint mode, this binding
> > describes the root complex mode only.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra2=
64-pcie.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie=
=2Eyaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> > new file mode 100644
> > index 000000000000..56d69de2788b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nvidia,tegra264-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra264 PCIe controller
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +  - Jon Hunter <jonathanh@nvidia.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: nvidia,tegra264-pcie
> > +
> > +  reg:
> > +    minItems: 4
> > +    maxItems: 5
> > +
> > +  reg-names:
> > +    minItems: 4
> > +    maxItems: 5
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  dma-coherent: true
> > +
> > +  nvidia,bpmp:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: |
> > +      Must contain a pair of phandle (to the BPMP controller node) and
> > +      controller ID. The following are the controller IDs for each con=
troller:
> > +
> > +      0: C0
> > +      1: C1
> > +      2: C2
> > +      3: C3
> > +      4: C4
> > +      5: C5
> > +    items:
> > +      - items:
> > +          - description: phandle to the BPMP controller node
> > +          - description: PCIe controller ID
> > +            maximum: 5
> > +
> > +unevaluatedProperties: false
>=20
> This goes before example
>=20
> > +
> > +required:
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +  - iommu-map
> > +  - msi-map
> > +  - nvidia,bpmp
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - oneOf:
> > +    - description: C0 controller (no UPHY)
>=20
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint. Don't rely on
> distro packages for dtschema and be sure you are using the latest
> released dtschema.

I certainly validated the DTBs resulting from this series and didn't see
any issues. I thought that previously also ran the linter and bindings
checks, but it looks like it doesn't, so I'll need to update my script
to do so explicitly.

dtschema should be up-to-date as well.

>=20
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: application layer registers
> > +            - description: transaction layer registers
> > +            - description: privileged transaction layer registers
> > +            - description: ECAM-compatible configuration space
> > +
> > +        reg-names:
> > +          items:
> > +            - const: xal
> > +            - const: xtl
> > +            - const: xtl-pri
> > +            - const: ecam
> > +
> > +    - description: C1-C5 controllers (with UPHY)
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: application layer registers
> > +            - description: transaction layer registers
> > +            - description: privileged transaction layer registers
> > +            - description: data link/physical layer registers
> > +            - description: ECAM-compatible configuration space
> > +
> > +      items:
> > +        - const: xal
> > +        - const: xtl
> > +        - const: xtl-pri
> > +        - const: xpl
> > +        - const: ecam
>=20
> All of above are part of top level.
>=20
> And speaking about example - where is it? How can you then test (verify)
> this?

I'm using the DTB resulting from the last patch in this series to
validate an actual example. I suppose I can extract an example into the
bindings, but I thought this was no longer a strict requirement.

Thierry

--46nql75yhiesreer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9J+kACgkQ3SOs138+
s6FGgRAAqeqRCdwX6d7aWgRrVxGx1tGvzmRJ7e3cEZebM/frhH34MWXdjARsp+uC
OxBB+zxQ4UsOdaDvGn7CXd3s/ITHVMJGH5DGG5PaVozFgNY1+jpz75+gdBiszQMC
2H7hJOlMuhdko6gAIOWhrHQn4NBOZEDnOjqv3SP6iAKnMjmioUPHsGNg7lQMYpNO
EM5bcs0Wu9ZvhKUB7/g0gQptelyUYZ3UPh4rdR381BFsouv7YVVwSoDYpfbouWr6
2jNvAbMXolAg6VhLKj1sy7pbiZ+lxcG7MQakr5PwsMNF4CQAn5wR1Tnv9C86rGDw
T9h3UK84xQ4mANTWtvj19v5sPLFFZpB77IWk8zsCXNuFaNWa0iz9Y33Vt6X1mP18
mb6Q/2Bi3cnnC4FmrxyzOFr6hY1OJP+7E6TbFpldWOn0UOObHodELzf789U2q0qo
GyCnbBaaipoWsfpVnoMGixCeu8fh0PAOqNL9Os1DktjutLYGGshDAIE7+IBFCVVg
mSE1TJgTx9ogmKdHQXSn8gCQGWb3cTmZ5T370WVydBfvALHEuvrCbz9uW5zbqm4H
LN0ZoJQ6edN6jxoAtkgRqiuWL5nR2k++I3fgaYMrsU/cvjiRJ10FOxsk6lRnuLgr
x+1SvwxveRijcKBVXSeAo9BhzYqkdlwJxFjitKLM4na8fGG8wTA=
=aKvz
-----END PGP SIGNATURE-----

--46nql75yhiesreer--
