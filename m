Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D52823DD
	for <linux-pci@vger.kernel.org>; Wed, 15 Apr 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257204; cv=none; b=jBnkwLXxgZJ/cTdQqnNKto6U8ZtlrCqLWEa9XO+dlOgb6Es4tzP0342zWesXNwcZD9qKPnyZqpwj/b/qVmKQNzd0cMT4ASmO5EeQCdPkvGIz/KRDocLRoxA5z46+eqCog/u0BdAOb/dbzzNDE7s0kZDCwo4N6hatVsjunA6nANA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257204; c=relaxed/simple;
	bh=y6aTsiofXPOnvztdKrV8k2Ec2I+P5cQybhcJwQvOeog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vERFIgMJkSpd1hUyV4MnH1dBd9R5uisP77Oj+j20G1epUEBSXzG/Na4PeRTPLF66En3tiugpqMpOh3Ic9uUYbPFlzzSX68D2WUE1vEYtOgzm101ljaQIE9CM6bUcvYaPETvO5f81+XX3mPSEUwm7XJ0rvTJAldBYpcQJJ590Anc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAML3OpY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAML3OpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43714C2BCB9
	for <linux-pci@vger.kernel.org>; Wed, 15 Apr 2026 12:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776257204;
	bh=y6aTsiofXPOnvztdKrV8k2Ec2I+P5cQybhcJwQvOeog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NAML3OpY1TjcqVX13hlsUO4T7/EL7/87EQccArfc3DzyT8jArSkr39Y6zqOQnkLjv
	 UJCc+lARrNpX3YXcSYl3Fyrue153+6GLKrz6zxXYGBja8FTdA3Wj9Ed/fce9yLyGzr
	 QMCgQBVKjcXwnr172m2TvTdUrjIKYBLpoOLbBoAjiHp75BBXenY8pVpLBYmk+mczne
	 Yyr5HMyJwrzyYzyyry6ygT59/QKLVob0ju5sJfahkezQ3VlxXaJwYM4/UDkH9YXZhC
	 xmlLQl11NLPvG9Dgpt934BQgS+vjfm8EO/vka/2Vti6nQ4Zh27AiMOuBC5rmne0BXA
	 TNmEAsePtwl3g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-671dad7cac8so3164161a12.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Apr 2026 05:46:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9+T4cx7P8G1kHBpgoB2KGiA2QFiHlpNTGaKTRQw6bZ0gyBXFvzAJl9t7tyJOo8YAslj6M8i0Qj5Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdyTjpc2bm4S9Pwy34/2XBLfBhHoQLYzNxdbqNnZxdK7+HAX2
	m/gcbPjOlH/vX7zJGP5ze7DhnXq9xEkOJMpD5JBtWIgZyvvKyPMxxh+YXuJzqkbiael8TnaUOa2
	AV0m/QLOilKiSUyKms7RM3AuUMKyjeQ==
X-Received: by 2002:a05:6402:280b:b0:66e:37b0:f802 with SMTP id
 4fb4d7f45d1cf-6707aa4840fmr10497971a12.21.1776257202551; Wed, 15 Apr 2026
 05:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-pcie-intel-gw-v4-0-ad45d2418c8e@dev.tdt.de>
 <20260415-pcie-intel-gw-v4-7-ad45d2418c8e@dev.tdt.de> <CAL_JsqJp_s1gH438sCTdOr_kTA3A9E8ch48ann-w-8D3ZH6MmQ@mail.gmail.com>
 <a7f3fb115256a180741aa817b14fee35@dev.tdt.de>
In-Reply-To: <a7f3fb115256a180741aa817b14fee35@dev.tdt.de>
From: Rob Herring <robh@kernel.org>
Date: Wed, 15 Apr 2026 07:46:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4KTq+HSS+4g_0GbOZ=Kw-wnJi2J_L_s_zaP+Gzy9kqQ@mail.gmail.com>
X-Gm-Features: AQROBzAxKS5TTJOZJvS_S6XVlD4QyCz8G2jrW7sy2RQ1KlCNgne8zOM4PFaLeqU
Message-ID: <CAL_JsqJ4KTq+HSS+4g_0GbOZ=Kw-wnJi2J_L_s_zaP+Gzy9kqQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] dt-bindings: PCI: intel,lgm-pcie: Add atu resource
To: Florian Eckert <fe@dev.tdt.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 7:26=E2=80=AFAM Florian Eckert <fe@dev.tdt.de> wrot=
e:
>
>
>
> On 2026-04-15 14:09, Rob Herring wrote:
> > On Wed, Apr 15, 2026 at 3:02=E2=80=AFAM Florian Eckert <fe@dev.tdt.de> =
wrote:
> >>
> >> The 'atu' information is already set in the dwc core, if it is
> >> specified
> >> in the devicetree. The driver uses its own default, if not set in the
> >> devicetree. This information is hardware specific and should therefore
> >> be
> >> maintained in the devicetree rather than in the source.
> >>
> >> To be backward compatible, this field is not mandatory. If 'atu'
> >> resource is not specified in the devicetree, the driver=E2=80=99s defa=
ult
> >> value
> >> is used.
> >>
> >> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> >> ---
> >>  Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> >> b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> >> index
> >> 54e2890ae6314ac6847fc23f49440d05d66d87d4..9b7a8ef77585677841c7064c5001=
110bc2b65db1
> >> 100644
> >> --- a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> >> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> >> @@ -27,16 +27,19 @@ properties:
> >>        - const: snps,dw-pcie
> >>
> >>    reg:
> >> +    minItems: 3
> >>      items:
> >>        - description: Controller control and status registers.
> >>        - description: PCIe configuration registers.
> >>        - description: Controller application registers.
> >> +      - description: Internal Address Translation Unit (iATU)
> >> registers.
> >>
> >>    reg-names:
> >
> > Don't you need minItems here?
>
> You're absolutely right, of course!
> My fault. Thanks for pointing that out.
> I will wait 24 hours to send a v5 with this change.
>
> Just to clarify. How does the creator of DTS know which items are
> required.
> Does that mean, in this case, that the last item is always optional and
> the
> others are absolutely essential?

Correct. There is no way in json-schema to express some entry in the
middle of an 'items' list is optional.

Rob
