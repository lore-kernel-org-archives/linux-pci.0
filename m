Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792661177;
	b=0VnDmPRhBabVEGk1k74f3QAlhU1J1Rn2UOavS+oyB05t67RHXxa3sCV1nTR58douB4Vb
	 7ZvT/hTzAZz6fLpvZCPj6Rrd3cmzBGmK7xTCo3dsXFjEto+o3SB3bqBmh/5hTYtS0vEsa
	 jww0jKUMtPqo6KnATIYKvHI91laWbNyFU98eeLIi8NKHrg/24tw4h5VxKjijMHPx7UoGN
	 6GBWzMd6uGWaRy83+Ru0inxle6tiEBVkzU1gcYLpmBA8vhig4rUe5RufT9nDd8C/te2jd
	 t1sm4U61YWHOVCPZespYDalCxmg6kmdl2voJbDekvx25nZ2wusKeYDYw4CaMrogikJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RDTGl8Ih6VJ8k0LP5O6/K+Q2atwePVb08UAdf/lWbCQ=;
	b=yGa7RVtrFHF9sNV6363wv2DBVqbul5rJsIxBn6CgcUibrpd5S9ysfT6cpnX3FVHfrkZi
	 33qOXcnxP0hEHSzVdBQ736vJ35YdLoFrplwVVSYQeKYrUmOj2LRIRX7zPf6Yqj1AjrCVE
	 PM03CuPWuIsRAN7NV1TH7GbRqYd7CtvUbqRQTPpM8QqD/rX/PLTh3/ei23hQD3oBWXnJr
	 xdQvoe8/TeHk+FUBmJxhT0mNSA+6oNXtPxtKzngFp48Js4W5ViiByVZRWg4uOxsfletsu
	 9DyMmUy/UqKexsrjfU6oY2+f/ViSUbmQujMZu8EnKxS/9CK7oYQG4O12PkvRyehvY0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=n8gJ18bF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC51606A335
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 09:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC51606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=n8gJ18bF
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so2131074a12.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 02:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792661174; cv=none;
        d=google.com; s=arc-20260327;
        b=TYyq3d/SfbO5XLGXCoRDZ2/DUu3G+tPhsy9l6Z3VZBoF+abWSVXwqirD2xqE8ABVGw
         6X6I3+6IlYlgqFLJJPiFmr9zKds5Ln9lSBuw2/Ye/ETKI2/Ca+Rz9GBcaJkWfQqliljS
         nxMJwViUnxzYvLWx4TaGEuZWg9Bqn4He7LP2prFqsQ7L3VsWd8e6oL1a8uLg2mNxnL7G
         lg2brTvMqnd51zWxNNH0tMrwwKuwNNI1CDe8T4TuBtpWfPCyJM6Z8/elnoeU64Y09ByF
         yVNCoPnQaO9g3IE2/R/N9TQpACC2vwzw/Wqd9vTkqF+nGs8CgBAXT3cPe9t3nASBYIYV
         mecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RDTGl8Ih6VJ8k0LP5O6/K+Q2atwePVb08UAdf/lWbCQ=;
        fh=m3/nucVAKWLnDCsHbrcr0j1MuPpo1HNoSC26A7/Nkxc=;
        b=ADMh+tHQ9Sys2p4JFf567AYFVLBSUsZyLgZR8SN2LAkpJ1rksw1elbTUmda9suBBoU
         v/u4iR+dPo1sCcnj97hValEb1EziUv6NMPaVAYKQ2+qvOQdBrTwBKbI6VbFfIUgelyvu
         TQ2T1GzvmSuo8ZR8yPP4s2rz0pk5aC3XM3EPc7CByGw9FRSTLLheFvs+FZX0hlM/P3qv
         OS+88VxcRq7V25hGt53dbW4jdnPXNducUU4FcPdiNadiRMoL/JGYIDJ5wNgp4+yPvgWw
         +X+CDLbun46FrXlgkU455DCC4a/ggYbLZvJsswixkz/TJzqg96niSz+QzpY63Qhlyarc
         UIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1792661174; x=1793265974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RDTGl8Ih6VJ8k0LP5O6/K+Q2atwePVb08UAdf/lWbCQ=;
        b=n8gJ18bFiLYWdXXIOvqJAlZPhdC/aA9JkjbTt/rfWjZFzSDyhbgHwb7oMTXS2+S1BK
         0VVHLKKQrdHNhf5ir0tYgkGOrgxqohQOyEbW1XgZldG15m5fbirWtobFMbHt8RNHtQD2
         clOjvIYDQtlIv01fjC6yT5+nwyYg/Jo2uaM2JRqnUin6d8D8KHaY8s0k+iyr+VXOBlOn
         kQHVOGAr6/S0hMvXda40+l4YfG5lXqYz6gJvF70JCkFQ06Hw04eeohc1IViVjwk0h4Mm
         iwY1TdEKUgqU3EFP0uIHTbDzLHZ5gssyFEzVykxqSWjjBjq3eXyxHW/a/2n6kMdJ4NHS
         /wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792661174; x=1793265974;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDTGl8Ih6VJ8k0LP5O6/K+Q2atwePVb08UAdf/lWbCQ=;
        b=srXOVZcpy2b1hP8qHGGgLDbjxRKcCDce3G8VFqKHD6dm0VkRx7499B0XCHM6GH78Sq
         2GY38PihrFBUdlVYFTTv1P5jRWx/HOgzOq+5LzpT91dAi+cgcK5v/5Zy1OJA7TTYROvw
         dX85YAchJPmm5VLtcMx98HkzGozx6y5AG7rZh7M2hHAZpOk5KZc4I0xZ++2VSRttl4lx
         rsyXbcRLpqEih11EZIuBMcWv3BB/riFcCFW+MdagER61A9FQMpUNjWSjpsWTxNWorgov
         1oN+bdpHZ6f7YYK/rTtIRUVr1hB6qhHd9RlixGO47FsMurK7AsnI7AQcikuAcEZeSZgl
         YsCg==
X-Forwarded-Encrypted: i=1; AKwUvBwtV8g6BVt+kPexNrGrI/eOEJEVtltuXVGxUfPbn3VCJVqGaB5nmlvHnbNpfMBjN4mcaMrBOwrQCYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPH9yREJrbLHRfVOSeToZC5ZwSnoNlTEI12trWpzu0T/H9H52a
	D7qYwknTTmNhtS8ewy13Q2Eb4bNMSGJ8nWBobWnY+uxwNTEmUPha4ahhW/dLetSg/pfnnzt3OfW
	F8lywCYcVBqveG4B6BqeojT+OXwyMxozq6Ya613K+yNRbTBoa0VnB
X-Gm-Gg: AYBFou2+NWvb3ItqXxNRz08FhQA1J3EDFj/fYKh/eS3KDAgiuHBLFYm7DqpPqwTvgJv
	l8dNi1dLKMced4JTbmQYxXacQzhbbDookv2ukbAUxhJxdjuV8/5JiPRk9KJJCXjyuGuX2wASyR4
	U2EaxTVu/ROCN1rEVqbqfGjG90kS8KaKJibeD24W9Yx/AVpiIzmb3vfPfnnmAOMJp9HpwW+y7Rl
	QdMukNd/Cm0fe7KWYlL/wyHZQGXXXhG5H0St6lHNWlJ9W1iGYjh5jAGtd3Tr4ulb89WM4tusKN8
	/A7JjQQUV77IMh4EtUMd8eZplezNRM2CpUfK7T+xNhT371w9KVGNVQdenyOnQ0Qb85cfC7IFQpg
	n/qOTsPA7rVpguzdENZQhRqTdtw+jJBfn7GdmGqYRGL0U9xpOolGX9hJ0wuDINa3PyLWdEmc=
X-Received: by 2002:a17:907:9445:b0:c3e:34fa:611d with SMTP id
 a640c23a62f3a-c46797a1c00mr390905066b.35.1792661174343; Thu, 22 Oct 2026
 02:26:14 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-1-ad37134c35a3@oss.qualcomm.com> <CAKTNdwG5XA_chr2ZM9qTnr2RaDMzOjdb85bRdCr4aJCr1EGy7Q@mail.gmail.com>
 <398a1d12-c28b-418c-bbcc-170d781223d6@oss.qualcomm.com>
In-Reply-To: <398a1d12-c28b-418c-bbcc-170d781223d6@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 22 Oct 2026 13:26:05 +0400
X-Gm-Features: AclHuK8L-ayPUMBsUkPn_iJw1PmLwnZFEAovuHv3zJHxF-r9SZo38fQrGt0Y_f8
Message-ID: <CAKTNdwEzbYAqM5ABxU+tfh4juU=wgYp=QXyjvdA1haanU0e8tQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:27=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
>
>
> On 10/21/2026 9:14 PM, Alexey Charkov wrote:
> > Hi Krishna,
> Hi Alexey,
>
> Thanks for the thorough review, this is helpful.
> >
> > On Wed, Oct 21, 2026 at 5:51=E2=80=AFPM Krishna Chaitanya Chundru
> > <krishna.chundru@oss.qualcomm.com> wrote:
> >> Add the devicetree binding for PCIe M.2 Mechanical Key B connector
> >> defined in the PCI Express M.2 Specification, r4.2, sec 3.2.19.1. This
> >> connector is used to attach WWAN Adapters to the host machine over
> >> interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB 2.0, selected by th=
e
> >> Adapter's configuration pins.
> >>
> >> The connector provides a primary power supply of 3.3V/VBAT, along with
> >> optional GPIO signals for WWAN-specific power/radio control:
> >> FULL_CARD_POWER_OFF#, RESET#, W_DISABLE1#/2#, WAKE_OQN_WWAN#, and DPR.
> >>
> >> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm=
.com>
> >> ---
> >>  .../bindings/connector/pcie-m2-b-connector.yaml    | 146 ++++++++++++=
+++++++++
> >>  MAINTAINERS                                        |   1 +
> >>  2 files changed, 147 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-b-con=
nector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-b-connect=
or.yaml
> >> new file mode 100644
> >> index 000000000000..a7f4bcbc5119
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-b-connector.=
yaml
> >> @@ -0,0 +1,146 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/connector/pcie-m2-b-connector.yaml=
#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: PCIe M.2 Mechanical Key B Connector
> >> +
> >> +maintainers:
> >> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >> +
> >> +description:
> >> +  A PCIe M.2 B connector node represents a physical PCIe M.2 Mechanic=
al Key B
> >> +  connector. Mechanical Key B connectors are used to connect WWAN dev=
ices to
> >> +  the host machine over interfaces like PCIe, USB3.1 Gen1, SSIC, or U=
SB 2.0,
> >> +  selected by the Adapter's configuration pins.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: pcie-m2-b-connector
> >> +
> >> +  vpcie3v3-supply:
> >> +    description: A phandle to the regulator for the 3.3v/VBAT supply.
> >> +
> >> +  full-card-power-off-gpios:
> >> +    description: GPIO output to FULL_CARD_POWER_OFF# signal. This sig=
nal is
> >> +      used by the host system to turn off the entire Adapter. Refer, =
PCI
> >> +      Express M.2 Specification r4.0, sec 3.2.13.1 for more details.
> >> +    maxItems: 1
> >> +
> >> +  reset-gpios:
> >> +    description: GPIO output to RESET# signal. This signal is used by=
 the
> >> +      host system to place the WWAN Adapter into a power-on reset con=
dition.
> >> +      Refer, PCI Express M.2 Specification r4.0, sec 3.2.13.2 for mor=
e
> >> +      details.
> >> +    maxItems: 1
> >> +
> >> +  w-disable1-gpios:
> >> +    description: GPIO output to W_DISABLE1# signal. This signal is us=
ed by
> >> +      the host system to disable the WWAN radio on the Adapter. Refer=
, PCI
> >> +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> >> +    maxItems: 1
> >> +
> >> +  w-disable2-gpios:
> >> +    description: GPIO output to W_DISABLE2# signal (default function =
of
> >> +      GPIO_10). This signal is used by the host system to disable a s=
econd
> >> +      radio on the Adapter. Refer, PCI Express M.2 Specification r4.0=
,
> >> +      sec 3.1.12.3 for more details.
> >> +    maxItems: 1
> >> +
> >> +  wowwan-gpios:
> >> +    description: GPIO input to WAKE_ON_WWAN# (WoWWAN#) signal. The Ad=
apter
> >> +      asserts this signal to wake up the host system. Refer, PCI Expr=
ess M.2
> >> +      Specification r4.0, sec 3.2.13.3.6 for more details.
> >> +    maxItems: 1
> >> +
> >> +  dpr-gpios:
> >> +    description: GPIO output to the Dynamic Power Reduction (DPR) sig=
nal.
> >> +      This signal is provided by a host system proximity sensor to th=
e
> >> +      Adapter to trigger a reduction in the radio transmit output pow=
er to
> >> +      meet regulatory SAR requirements. Refer, PCI Express M.2 Specif=
ication
> >> +      r4.0, sec 3.2.13.4 for more details.
> >> +    maxItems: 1
> > This seems to be missing the four CONFIG_* pins, which are quite
> > crucial in these connectors, as they define which interfaces the
> > module asks the host to provide on the respective pins. Without those
> > module type detection is impossible.
> Agreed, thanks for catching this. I will add a config-gpios property  (4 =
GPIO
> inputs, one per CONFIG_0..3 pin) to v2. It's optional, not required - a b=
oard
> that always has a known, fixed card type in a given socket (e.g. QCOM
> glymur-crd's WWAN-only slot) can just describe that fixed wiring via the =
ports
> property and skip CONFIG decode entirely; config-gpios is only needed whe=
n the
> host wants to detect the card type/host-interface at runtime. Kept it as =
plain
> sensed GPIOs with no decode semantics imposed by the schema - the propert=
y
> description documents the full Table 3-18 state table inline (all 16 stat=
es)
> so the binding is self-contained, but turning the sensed 4-bit pattern in=
to
> "this is a WWAN-PCIe Adapter in port config 0" is left to driver code,
> consistent with how the rest of the connector's sensed straps (e.g.
> viocfg-gpios on the E-connector) are already handled.

Agreed that the logic of turning the 4-bit pattern into
enabling/disabling interfaces sounds like a driver realm, although we
probably need to consider if the connector should accept pinctrl-0
through pinctrl-15 to hint the host about which pin muxes should
follow from each of the 16 4-bit CONFIG_* pin states. This mapping is
hard to recover outside the connector's context.

> >> +  clocks:
> >> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the hos=
t system to
> >> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.=
1.12.1 for
> >> +      more details.
> >> +    maxItems: 1
> >> +
> >> +  ports:
> >> +    $ref: /schemas/graph.yaml#/properties/ports
> >> +    description: OF graph bindings modeling the interfaces exposed on=
 the
> >> +      connector. Since a single connector can have multiple interface=
s, every
> >> +      interface has an assigned OF graph port number as described bel=
ow.
> >> +
> >> +    properties:
> >> +      port@0:
> >> +        $ref: /schemas/graph.yaml#/properties/port
> >> +        description: PCIe interface for WWAN
> >> +
> >> +      port@1:
> >> +        $ref: /schemas/graph.yaml#/properties/port
> >> +        description: SSIC interface for WWAN
> >> +
> >> +      port@2:
> >> +        $ref: /schemas/graph.yaml#/properties/port
> >> +        description: USB 2.0 interface for WWAN
> >> +
> >> +      port@3:
> >> +        $ref: /schemas/graph.yaml#/properties/port
> >> +        description: USB3.1 Gen1 interface for WWAN
> >> +
> >> +    anyOf:
> >> +      - required:
> >> +          - port@0
> >> +      - required:
> >> +          - port@1
> >> +      - required:
> >> +          - port@3
> > This misses SATA which shares pins with PCIe. PCIe second lane also
> > conflicts with USB 3.1/SSIC, which isn't captured here. Should it be?
> Before adding a SATA/SSD port here, I want to double check the scope: per
> Table 2-1, every SSD-capable board using those CONFIG states is a B+M dua=
l-key
> card (Type 2230/2242/2260/2280/22110, "B+M" key column), not a pure Key-B=
-only
> card. Pure Key-B-only form factors (2242, 3042, 3052, 3060) are WWAN-only=
 per
> that table, with no SSD row.

Your binding is about the host-side M.2 key B slot, which by design
accepts both M.2 key B cards and M.2 key B+M cards, and the slot
interfaces are explicitly designed to support both. So the binding
should reflect the slot's hardware, not the card's hardware.

> If that holds, is modeling SATA/PCIe-SSD states in pcie-m2-b-connector ev=
en in
> scope, versus always describing a B+M socket via pcie-m2-m-connector (whi=
ch
> already covers PCIe/SATA SSDs) and reserving pcie-m2-b-connector strictly=
 for
> the WWAN-only Key-B form factors? Or do you know of a real case where a p=
ure
> Key-B socket legitimately decodes to an SSD CONFIG state that I'm missing=
?
> Happy to add the SATA port either way, just want to scope it correctly be=
fore v2.

I don't think B+M _sockets_ even exist. The socket is keyed either B,
or M, not both, and a B+M keyed card is compatible with either. It
also reflects real-world use: people can and do use SATA SSDs in key-B
slots. Same with NVMe SSDs, although those are rarer in B+M form
factor (but I own one, and it works fine in a full-function
spec-compliant key-B slot).

> > Should the graph also envisage connections for the I2C bus (GNSS),
> > audio (2 or 4 wire), re-muxing of W_DISABLE2# and WAKE_ON_WWAN# into
> > HSIC functions in Port Config_3, GNSS interrupt line and the such?
> > Should the connector node also define pinctrl configurations for each
> > of the 15 interface configurations?
> These are all real signals in the spec (GPIO_0-11's BTO-defined functions=
 per
> Table 3-15, plus the HSIC remux under Port Config_3), but I'd left them o=
ut
> deliberately for now: every one of GPIO_0 through GPIO_9 is explicitly "V=
ENDOR
> DEFINED or GPIO_x" in the spec text, i.e. there's no fixed function to bi=
nd to
> without a BTO agreement between card vendor and platform. The sibling
> pcie-m2-e-connector binding takes the same approach and doesn't model its=
 own
> analogous BTO pins either.

I thought only configuration b1011 explicitly says that the other
interfaces besides PCIe and USB 3.1 Gen 1 are vendor defined. The rest
have an explicitly assigned function for GPIO_0..GPIO_11, as set out
in the Port Config_0 through Port Config_3 mapping table. Port
Config_3 is the weird one, with its vendor-defined IPC on most of the
pins, but the others are more clear-cut.

> I'd rather land CONFIG_0-3 decode plus the SATA/PCIe-SSD scoping question=
 in
> v2, and handle I2C/GNSS/audio/HSIC-remux/per-config pinctrl as follow-up
> patches once there's a concrete board that needs one of them with a real
> driver consumer - adding properties nothing reads yet felt like the wrong
> order of operations. But let me know if you think v1 shouldn't go in at a=
ll
> until that full state machine is captured in the binding.

The general guidance is that bindings should be complete, even if the
software does not fully implement them yet. I'm not sure how strict
that guidance is.

In this particular case I'm wary of the risk in merging a version of
the binding which will make sane modeling of those extra interfaces
impossible later on. Assigning port nodes to all possible interfaces
envisaged by the spec is probably easy enough, although subtleties
remain, such as: do pinctrl groups for each interface configuration
belong to the respective interface providers or to the connector? Does
the binding allow additional vendor-specific interfaces on the
GPIO_0..GPIO_11 pins at all (e.g. various IPC configurations which the
spec leaves to the host and module vendor to decide), and if yes -
how?

These decisions (and probably others I haven't thought of yet) will
likely shape the correct binding structure. It would be great to
discuss and prototype them before committing to the binding, which
must remain backward-compatible once merged.

Best regards,
Alexey
