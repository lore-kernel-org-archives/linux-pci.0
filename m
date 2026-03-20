Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603FC35F60C;
	Fri, 20 Mar 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999595; cv=none; b=nltwG/lJhj+DFPYj5eNzJGWW7hhpbLsP0NctxtREwPp2J6LinKQfWxlYCTBnAzBcGOHxK7GCYd9lBvEPprhsfuOc8e7Hi5vJYShNhQSRdYHGr6b04FPZMZx725j2tKgGZz/lzZLnI/xCypntIafcW5wP2PLscOwSOanJaQU0izs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999595; c=relaxed/simple;
	bh=i+pP4V+ABRrU7y+KipWHLhEUf1H6LxI4Ze7TYBfD/lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu5tnHkKYvFq1rwVRy8PESZXVAQIZ4g1z/KNghpTcTeY22ekSnNa+eLwyGE2+Ro82OPr4lIJQ79oInXfllcSPmS7DvlXmrNt70SX9sZ1FfbpRnhdbMJDsmyi18Y1vDlMosNpxWGgtI/5m7EJOCkIpC7iFmJIAU8xAsBuCMTxex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stetC2bp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stetC2bp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852BCC4CEF7;
	Fri, 20 Mar 2026 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773999595;
	bh=i+pP4V+ABRrU7y+KipWHLhEUf1H6LxI4Ze7TYBfD/lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=stetC2bpfEX8FvAm4oFQOc4VRxBmexeeFL8Ie45Tt4g9Vp4efZkF87YFB4x2k/5o5
	 3CdD8EjOBim1rw1aZWJsp8n7kyYeOGTNj9U5XAnoISaPaxkd3WVjdX1boKf6qMIzJj
	 GoVn9kYZOybFKPPDvEd0pF3cBu4wGm8WMp2PGwG9eEKbMhQT7TJrCB/1Hm3apSyp0b
	 W2vBTYxaFg6u7ebj3r2g1lNFlUgvK3bssbNXZLdXsUUDU5uc4Mf8OQp8IOLiE6VwoS
	 tiL+bP+14uaPKD0kRiOwhRGSscI4YamZDeq254EEmh/xp21cIKEP4PIzUUXjLJzxlR
	 vx9qewFftGPxA==
Date: Fri, 20 Mar 2026 10:39:52 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
Message-ID: <ab0U5bfZ2hwp-GST@orome>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-4-thierry.reding@kernel.org>
 <CAL_Jsq+smyMYE_oexRc9wEJgMxdUxSwg7p8Bex8q6J6PrwZZ+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xadlc4yvs4q6exe6"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+smyMYE_oexRc9wEJgMxdUxSwg7p8Bex8q6J6PrwZZ+Q@mail.gmail.com>


--xadlc4yvs4q6exe6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
MIME-Version: 1.0

On Thu, Mar 19, 2026 at 04:26:31PM -0500, Rob Herring wrote:
> On Thu, Mar 19, 2026 at 11:01=E2=80=AFAM Thierry Reding
> <thierry.reding@kernel.org> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The six PCIe controllers found on Tegra264 are of two types: one is used
> > for the internal GPU and therefore is not connected to a UPHY and the
> > remaining five controllers are typically routed to a PCI slot and have
> > additional controls for the physical link.
> >
> > While these controllers can be switched into endpoint mode, this binding
> > describes the root complex mode only.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra2=
64-pcie.yaml
> >
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
>=20
> Put this entry last since it is the optional one. Then you can move
> all of this to the top-level and get rid of the duplication.

I understand this concern and was actually on the fence about this
myself. The reason why I ultimately went with this variant is for two
reasons:

  1. XPL does not exist for controller 0, the variant above makes that
     very explicit. It explicitly documents that controller 0 is used
     for internal purposes and cannot be connected to an external port
     like the other five controllers.

  2. The ECAM region is part of a memory region specifically reserved
     for configuration space, whereas all of the other regions are
     from the controller's MMIO region. I find the DT hard to read if
     the two are interleaved.

Thierry

--xadlc4yvs4q6exe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9FegACgkQ3SOs138+
s6EIWQ//ckQncs/jfQ2lie639+yWQaYKqj+f3mfXRhxT8cmiO+3YU6I/9F1Sjxwu
w29ijDgXiM3/DdkEXbzS0mtdBMwh1V4Zl2sDsgFD+6heyw5mFCmh2wGo2E9WWxyN
4OTcuA+30wWJZvmh49BDnvcDnvDw7v4ENaaU4dyvePj/Vj8X4ekGslv1Ihv9Ao8y
NG/KGJ6nsDwhIpHwsOoL88ADKrltkSsqTgxhunnqKVu+v7bGzXRIlX2+uXteRvGx
QYU9cHLa8h589ZDZUHgylJt3Eqnew8G6tLVBvc4jMni2OdorzQQ7zyMtQRLQSvaY
NQIzfdwuK7l/+vO5DboxCvffkWP4wHI2EDFBMHK8q2zSh+Q44Gts4sG53ITXQVlS
l0OEZmguQ4RQDeytMv2EdkGmJYICW5qE/1CunjIQU3zBqxOMstY1sm1CdZkkx8sS
/dF+4JF9i9ETWl3UC5T3VpWfWAfI7ADTZEU318bREXTDtpkPwHdodlSWBZFq22gK
wmy+hjD7wG/I9fy1yJL+DhxSJBgFiDEwswvMe4pbGR34xkQjJQFcMGlSBg2YYO/N
r1nJaa0G58QMN+MGtfA62q3u0yugRfHjtTF2gy2iwJXBELawhgGPJzzEhRwNGSBI
I6RHRcxjnD9NkjSsPM0DTHJmoOaeclfetpFCgS0QUohaC6rGQQA=
=2I0I
-----END PGP SIGNATURE-----

--xadlc4yvs4q6exe6--
