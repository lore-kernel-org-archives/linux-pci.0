Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F32E7BB6;
	Fri, 20 Mar 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014517; cv=none; b=KD73lTwdnbKT0alk75AGsnfOWeSz865rqev/hVKICt1Vdw8EvaO75KHg/nvqNl0PIhfuJaqBoJIeg2g359ToK8HmnfIogg1Z80IwbRvpKt3bV9hc1AFb3gPrTP1oCaPn1V5sxOMKdMN8O9WyT31tAacOyaJsaVnEEPdLq5Mpyh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014517; c=relaxed/simple;
	bh=vJCCk5rvtYPCzme0WJmBqvyMRh/veDg3phF0oT0+lcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxPbOVzGRlsKxP/77/96u4O4mCaiIUiDO18qNdwe+MOGauLRo0OXIfMQSvI3ZYgJOaMYhbtYAS6b3ppOSWAC7sdp4svV680KoicSliqJNbFZsuuiSa4jcdkUECOuvOquuszYIb76l51t7S3ynIZ8VIKX0ClazCsq+C/EqmaDyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5rAop6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5rAop6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D229BC19425;
	Fri, 20 Mar 2026 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014517;
	bh=vJCCk5rvtYPCzme0WJmBqvyMRh/veDg3phF0oT0+lcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5rAop6QUzTNMwzWCweS2Ek0cpm8Lk1s9Vjmlku2NhT1wCJJ4SXk4to5lL5TYd7fD
	 5c19fkg+/5wru5H2aGqHpYyOig1O6XVcFkhUegqV7MTHHzTVG3deSmQsKh20xtyyxa
	 WnGRzmN3FVNRAJGlYZStD5mr0KLMeHrAnJT5x0ijKF32PuJbt699VGiV9R4U8loNa2
	 B2UTdleCuokz0z37sQwnKMM4Cz3+uK/LZ3POSQRtJ8n8R1x1b8RyxXV0K1zlTbFiMS
	 1mlLym+2mB3wG7ABwjsVlcDdtIoGb1MGrllPJPPeWxoDDF6F+ahxEjiIkBiiwG4zT3
	 nT9Hg+acraxGQ==
Date: Fri, 20 Mar 2026 14:48:34 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
Message-ID: <ab1Ik3HbOQsDsG-K@orome>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-4-thierry.reding@kernel.org>
 <CAL_Jsq+smyMYE_oexRc9wEJgMxdUxSwg7p8Bex8q6J6PrwZZ+Q@mail.gmail.com>
 <ab0U5bfZ2hwp-GST@orome>
 <CAL_JsqJuoOiBGKW=H=u9AQ=XgY+-iXS+UP7iEw5z6p57Yk_AVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rkcwga7yf7esrb2g"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJuoOiBGKW=H=u9AQ=XgY+-iXS+UP7iEw5z6p57Yk_AVw@mail.gmail.com>


--rkcwga7yf7esrb2g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe
 controller
MIME-Version: 1.0

On Fri, Mar 20, 2026 at 08:06:26AM -0500, Rob Herring wrote:
> On Fri, Mar 20, 2026 at 4:39=E2=80=AFAM Thierry Reding
> <thierry.reding@kernel.org> wrote:
> >
> > On Thu, Mar 19, 2026 at 04:26:31PM -0500, Rob Herring wrote:
> > > On Thu, Mar 19, 2026 at 11:01=E2=80=AFAM Thierry Reding
> > > <thierry.reding@kernel.org> wrote:
> > > >
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > The six PCIe controllers found on Tegra264 are of two types: one is=
 used
> > > > for the internal GPU and therefore is not connected to a UPHY and t=
he
> > > > remaining five controllers are typically routed to a PCI slot and h=
ave
> > > > additional controls for the physical link.
> > > >
> > > > While these controllers can be switched into endpoint mode, this bi=
nding
> > > > describes the root complex mode only.
> > > >
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++++=
++++
> > > >  1 file changed, 92 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,te=
gra264-pcie.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-=
pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
> > > > new file mode 100644
> > > > index 000000000000..56d69de2788b
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.ya=
ml
> > > > @@ -0,0 +1,92 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra264-pcie.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: NVIDIA Tegra264 PCIe controller
> > > > +
> > > > +maintainers:
> > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: nvidia,tegra264-pcie
> > > > +
> > > > +  reg:
> > > > +    minItems: 4
> > > > +    maxItems: 5
> > > > +
> > > > +  reg-names:
> > > > +    minItems: 4
> > > > +    maxItems: 5
> > > > +
> > > > +  interrupts:
> > > > +    minItems: 1
> > > > +    maxItems: 4
> > > > +
> > > > +  dma-coherent: true
> > > > +
> > > > +  nvidia,bpmp:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    description: |
> > > > +      Must contain a pair of phandle (to the BPMP controller node)=
 and
> > > > +      controller ID. The following are the controller IDs for each=
 controller:
> > > > +
> > > > +      0: C0
> > > > +      1: C1
> > > > +      2: C2
> > > > +      3: C3
> > > > +      4: C4
> > > > +      5: C5
> > > > +    items:
> > > > +      - items:
> > > > +          - description: phandle to the BPMP controller node
> > > > +          - description: PCIe controller ID
> > > > +            maximum: 5
> > > > +
> > > > +unevaluatedProperties: false
> > > > +
> > > > +required:
> > > > +  - interrupt-map
> > > > +  - interrupt-map-mask
> > > > +  - iommu-map
> > > > +  - msi-map
> > > > +  - nvidia,bpmp
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > +  - oneOf:
> > > > +    - description: C0 controller (no UPHY)
> > > > +      properties:
> > > > +        reg:
> > > > +          items:
> > > > +            - description: application layer registers
> > > > +            - description: transaction layer registers
> > > > +            - description: privileged transaction layer registers
> > > > +            - description: ECAM-compatible configuration space
> > > > +
> > > > +        reg-names:
> > > > +          items:
> > > > +            - const: xal
> > > > +            - const: xtl
> > > > +            - const: xtl-pri
> > > > +            - const: ecam
> > > > +
> > > > +    - description: C1-C5 controllers (with UPHY)
> > > > +      properties:
> > > > +        reg:
> > > > +          items:
> > > > +            - description: application layer registers
> > > > +            - description: transaction layer registers
> > > > +            - description: privileged transaction layer registers
> > > > +            - description: data link/physical layer registers
> > > > +            - description: ECAM-compatible configuration space
> > > > +
> > > > +      items:
> > > > +        - const: xal
> > > > +        - const: xtl
> > > > +        - const: xtl-pri
> > > > +        - const: xpl
> > >
> > > Put this entry last since it is the optional one. Then you can move
> > > all of this to the top-level and get rid of the duplication.
> >
> > I understand this concern and was actually on the fence about this
> > myself. The reason why I ultimately went with this variant is for two
> > reasons:
> >
> >   1. XPL does not exist for controller 0, the variant above makes that
> >      very explicit. It explicitly documents that controller 0 is used
> >      for internal purposes and cannot be connected to an external port
> >      like the other five controllers.
>=20
> That doesn't really matter to the schema because it can never check
> that unless you have 2 different compatibles (and you shouldn't).

I know that, the documentation would be more for developers/users rather
than the validation tools.

> >   2. The ECAM region is part of a memory region specifically reserved
> >      for configuration space, whereas all of the other regions are
> >      from the controller's MMIO region. I find the DT hard to read if
> >      the two are interleaved.
>=20
> I was also going to suggest putting ECAM first just to align with the
> generic host binding. That would make it slightly easier to rewrite
> the node if you decided to make it a firmware initialized controller.

Huh... I hadn't considered that. I think that would be a compromise that
I can very well live with.

Thierry

--rkcwga7yf7esrb2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9UC8ACgkQ3SOs138+
s6GJPxAAkHONgPwkJWGNWziEcj9AyPHuT2Kjtt8y9cwHu5QI6GE5Mva2B63x79Pg
qb3l7NqD+B8BeowgJZVuFVPkziIOoyOqZpoy40H6Rg0Qpq9/jVyyg1f3AQiWd3CI
RUSETXA/cUt6LQVG8aBteFl5yEopAygfAkkwlQ5Ans8mgtcOtTgUQODGIyfz+yZB
EP6+dSu0HtUiaBQTifPN58FLLBVqELqhoNQP26iyGdIBZEJ/BB9jwyyCvos3W1vK
0I9x0rAjp1SLNZLTTfS3CUfAgvqYubGE7DBR0yjzcl/3I2PFKC7H9ShbOudwMMeG
3w+svuDt2ARQ5INPRHJ4hO3rAqYfleDbD+uYJuStoyPoBJTZoVR+OYDZE8p1L6R9
YysUtfXJNIfrPKYe7FMVTKbUaI24pFE3enqnbRi0Ge9kJGJMNclj2weYqbpQyW1j
tavzlIvVEXqSnVCsCyq7kUFiwvYs1AeM97N7E6Pmzu3kZ8kqSs9U1z2bS+13KiOh
0E0RSQkt26sv7Qvu/6qHMeMJmoLmTxrzHr10piAksFVK69Zw51xO67IotDUq1nmQ
AHY5KICJm1T2iMMktqL7Gqj9TSH8iIxLH4mM6vHS64bpnRqxmGHwOSei4fLaVpnS
q00zD5BudtYiFjTN/0PAumW2fIk7vbIKDcJ0QkMFMmhLTLpLPbY=
=V8Ii
-----END PGP SIGNATURE-----

--rkcwga7yf7esrb2g--
