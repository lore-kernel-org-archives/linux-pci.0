Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94913CCFBF
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022327; cv=none; b=VYKS3X/7tllbfvmV8NKhlcvIWjLv8MLZGkr7KMwkmca6sv5AFM8JMhmXfheESCHiQUgv7iwHRJHRAXXnHmya8SQrPacn6llzdKqulyfAXSaNHpqad8NyxsYjixsusMorCjCoYcOPe//5hMkNOLcRe7WZMDnaR67xmrXr0b24mLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022327; c=relaxed/simple;
	bh=aiSd5OVBVjs+5Lqgol+Wge7MnZFB8HU1UxEFicnTJsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsc75D3WOCEdLM9yjwq01lN/ZFnBxAuLVUnm3R5f+Ov8SOfYkZxLx7YiNgodS/XI1wGzlHBsdCSPL5MCFQVoMKG0E6agEA2BcvBEXa2kXJ1a/6UuEhS1rN5YMGkaxRevLEqIqnmhGMzdhrowKz4VNkRyBes4lMvbAGG1FcqzhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJiwwkWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJiwwkWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690E9C19425
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774022327;
	bh=aiSd5OVBVjs+5Lqgol+Wge7MnZFB8HU1UxEFicnTJsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sJiwwkWqsGD9uI3P7tI08I1OFNcFBuZrkZq/6h0a5aQZ/JJotn4uYeEC9maFNwo6H
	 LpoacLh7JeCIuplmpZJg09lODgjvLhPSg/GovK3jOPsRVOdMjKL4tEzwU6+mE2HRba
	 ion9X+xu3H/tf/M+hO9cVrPRwyHJtlaGRGKVYbYhMgw8NK/6Ny15jIDEo8/Xt5O/LH
	 hBX9uh1Ol5v4g3yMrxu+aHxh6OsZwGvYGzPc6N6PXWoQ4HRz7UVwPFjY/73d+2KDEU
	 8/E2W3YQoAIviNyd1QA+8kqePAJUekZGB6t3OvMNLAUzJYa7IgdnuajH6Tidmmk1wf
	 X67JWILRtMz0g==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6687be9791cso3004608a12.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 08:58:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+fM9v0bXtRN5OsQN5tdZSSwazdRsMNpCGUzprXcBGaGEOpWkbxOewEFkiM3Lz/j0RHQt7baoRk10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZ1i1LGT+Gvk49/DHhi1lgXZuGSpsaJWlFOkCykh7qrHkWRsN
	ucS18sXFTpXCyF05vfkssq2Icxv0W+pxL3nfqWMcph0clgQhjDKuZmw/9wpCFop+jp2lb+D+w1k
	fCkBRYQtdoFYuHFMOh3k9UoFQfrcBuw==
X-Received: by 2002:a05:6402:50cf:b0:668:6e22:3e10 with SMTP id
 4fb4d7f45d1cf-668c84f299fmr3104507a12.0.1774022325958; Fri, 20 Mar 2026
 08:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-4-thierry.reding@kernel.org> <CAL_Jsq+smyMYE_oexRc9wEJgMxdUxSwg7p8Bex8q6J6PrwZZ+Q@mail.gmail.com>
 <ab0U5bfZ2hwp-GST@orome> <CAL_JsqJuoOiBGKW=H=u9AQ=XgY+-iXS+UP7iEw5z6p57Yk_AVw@mail.gmail.com>
 <ab1Ik3HbOQsDsG-K@orome>
In-Reply-To: <ab1Ik3HbOQsDsG-K@orome>
From: Rob Herring <robh@kernel.org>
Date: Fri, 20 Mar 2026 10:58:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWLCyV0j5pe_EtH-393zL2Bqrz-xFBydm7pECi_8iN0A@mail.gmail.com>
X-Gm-Features: AaiRm538DnCHUjf50GK5tgq6RwltBjLP6uKu6msBMEA6dCdN5XqSvWmjN2Y_lR8
Message-ID: <CAL_JsqLWLCyV0j5pe_EtH-393zL2Bqrz-xFBydm7pECi_8iN0A@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe controller
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 8:48=E2=80=AFAM Thierry Reding
<thierry.reding@kernel.org> wrote:
>
> On Fri, Mar 20, 2026 at 08:06:26AM -0500, Rob Herring wrote:
> > On Fri, Mar 20, 2026 at 4:39=E2=80=AFAM Thierry Reding
> > <thierry.reding@kernel.org> wrote:
> > >
> > > On Thu, Mar 19, 2026 at 04:26:31PM -0500, Rob Herring wrote:
> > > > On Thu, Mar 19, 2026 at 11:01=E2=80=AFAM Thierry Reding
> > > > <thierry.reding@kernel.org> wrote:
> > > > >
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > The six PCIe controllers found on Tegra264 are of two types: one =
is used
> > > > > for the internal GPU and therefore is not connected to a UPHY and=
 the
> > > > > remaining five controllers are typically routed to a PCI slot and=
 have
> > > > > additional controls for the physical link.
> > > > >
> > > > > While these controllers can be switched into endpoint mode, this =
binding
> > > > > describes the root complex mode only.
> > > > >
> > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > ---
> > > > >  .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++=
++++++
> > > > >  1 file changed, 92 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,=
tegra264-pcie.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra26=
4-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.ya=
ml
> > > > > new file mode 100644
> > > > > index 000000000000..56d69de2788b
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.=
yaml
> > > > > @@ -0,0 +1,92 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra264-pcie.yaml=
#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: NVIDIA Tegra264 PCIe controller
> > > > > +
> > > > > +maintainers:
> > > > > +  - Thierry Reding <thierry.reding@gmail.com>
> > > > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: nvidia,tegra264-pcie
> > > > > +
> > > > > +  reg:
> > > > > +    minItems: 4
> > > > > +    maxItems: 5
> > > > > +
> > > > > +  reg-names:
> > > > > +    minItems: 4
> > > > > +    maxItems: 5
> > > > > +
> > > > > +  interrupts:
> > > > > +    minItems: 1
> > > > > +    maxItems: 4
> > > > > +
> > > > > +  dma-coherent: true
> > > > > +
> > > > > +  nvidia,bpmp:
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > +    description: |
> > > > > +      Must contain a pair of phandle (to the BPMP controller nod=
e) and
> > > > > +      controller ID. The following are the controller IDs for ea=
ch controller:
> > > > > +
> > > > > +      0: C0
> > > > > +      1: C1
> > > > > +      2: C2
> > > > > +      3: C3
> > > > > +      4: C4
> > > > > +      5: C5
> > > > > +    items:
> > > > > +      - items:
> > > > > +          - description: phandle to the BPMP controller node
> > > > > +          - description: PCIe controller ID
> > > > > +            maximum: 5
> > > > > +
> > > > > +unevaluatedProperties: false
> > > > > +
> > > > > +required:
> > > > > +  - interrupt-map
> > > > > +  - interrupt-map-mask
> > > > > +  - iommu-map
> > > > > +  - msi-map
> > > > > +  - nvidia,bpmp
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > > > > +  - oneOf:
> > > > > +    - description: C0 controller (no UPHY)
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          items:
> > > > > +            - description: application layer registers
> > > > > +            - description: transaction layer registers
> > > > > +            - description: privileged transaction layer register=
s
> > > > > +            - description: ECAM-compatible configuration space
> > > > > +
> > > > > +        reg-names:
> > > > > +          items:
> > > > > +            - const: xal
> > > > > +            - const: xtl
> > > > > +            - const: xtl-pri
> > > > > +            - const: ecam
> > > > > +
> > > > > +    - description: C1-C5 controllers (with UPHY)
> > > > > +      properties:
> > > > > +        reg:
> > > > > +          items:
> > > > > +            - description: application layer registers
> > > > > +            - description: transaction layer registers
> > > > > +            - description: privileged transaction layer register=
s
> > > > > +            - description: data link/physical layer registers
> > > > > +            - description: ECAM-compatible configuration space
> > > > > +
> > > > > +      items:
> > > > > +        - const: xal
> > > > > +        - const: xtl
> > > > > +        - const: xtl-pri
> > > > > +        - const: xpl
> > > >
> > > > Put this entry last since it is the optional one. Then you can move
> > > > all of this to the top-level and get rid of the duplication.
> > >
> > > I understand this concern and was actually on the fence about this
> > > myself. The reason why I ultimately went with this variant is for two
> > > reasons:
> > >
> > >   1. XPL does not exist for controller 0, the variant above makes tha=
t
> > >      very explicit. It explicitly documents that controller 0 is used
> > >      for internal purposes and cannot be connected to an external por=
t
> > >      like the other five controllers.
> >
> > That doesn't really matter to the schema because it can never check
> > that unless you have 2 different compatibles (and you shouldn't).
>
> I know that, the documentation would be more for developers/users rather
> than the validation tools.

You can add whatever documentation you want to express that without
needlessly complicating the schema for no validation purpose. Arguably
if the schema is shorter, that documentation will be easier to see.

Rob
