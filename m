Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4B3603FA
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886060; cv=none; b=kkBAWbW+zRBUxVmOtUSwCtnY1M2J8JBLXCawnzzFk5G1M80GmaKpimVovJTHCw/pPlEgADLZPpKBxA/P0JL2Ppzq1JE4fu3RC784ofi4plldU52GNfXsbGtKuQZMY0jagyxflhN1qSydA7YzM7YMNRK8LPoDlMeMRhtBKBSNgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886060; c=relaxed/simple;
	bh=Y30a/Oc/ZpLcfEvZRO6RE54BICXHkQ3pkt1I8Ae9uRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiM9A1+kFzlwA6IMeC1nIjVHBQer2EJFQCWBYe6RqvYUZujRdnc+IAnGHckcDt44paKxtE0JVbsXlb78kvMazTpdur3F83haTTkeHKo+Im5nkweuCUsD/Huw36Apkdz+0k3HLymE4KMOD3Mj6NTMgOQEPu8YvUjH0+ZDJwkc8ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-62f33bad185so504884137.3
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 02:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886053; x=1778490853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n5hHHo+yfxt7H7E3OF8Dc5zPcnFuji78/mo4OM09ccQ=;
        b=LyjRB/dDYrx0SJ9FIX269jVHp2FNmOdjRvZ3uvdCrklR/JPupkZMenB3oyzLcKK+PC
         HRdaZYcaGa6B8CU+bJfHlWmnz/ufXkv8zgncoZV5rtZaJ8s9LvaiktZQNiDMksM6DErG
         yYj6nHlgeyY05WxGcXnur8Hn35E0FXsSFKAe6gTWYY4kSw37OAhNFmbiurkhZg1kmFKD
         3BAl8cBP6/BW0t2YBsmy1NC5wTWVJ0ZSc2HFTJ7sPvjDY2eGe0RdzwA9iWODuE0VTCXM
         TK1OqnxEbWJmIFc2dEGL8FgHj/kynUUlJUTMxdtw314IEKOAHCNdPmh9KJjTZpUjrSDi
         SJpg==
X-Forwarded-Encrypted: i=1; AFNElJ8tEHRWSZe5TfNyF/fED5+jUJUxiTVmD0w8so7HGYbherj6jfxMcWRMCnyvKeJfdzlNEYxsLrHANuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauPDoJaqJkQjAsbAA5CaNxEx34L+MNacOqeYSywW9jOA7JClP
	P4+wUplX0gr+SrM0L9R2cfoGPhy9pmvekzv/KinXLG8u+UVzB1vLZxt8alPByCXZ
X-Gm-Gg: AeBDievW0bo48RFQlNsIfzoOFiKzc00iah4H+jhwKTW4vWVE6zUl2UaMWvTdC3tXQl5
	ZUvlvw5hUV/HQG40cr6X01DAXMWh7fHrVvbrsGBYlv7TR0FEE8ceCmf55UY4SySliyWMviNNLs6
	YQX03pWR8q9SoeurajFeJTBWSkYDrNTTFxeEpETTe95L3MpUs7XcLkIl+CgmEjVYmrkRv6qPOJU
	CR5hUYOy2WE9HSzTG9FL9pWORYVdZCPnXbrs9FDpFV0F6e1YG0wJxgNPn1vxZ71u67bxTdGO32D
	y/mPtkYK1Fm+QqnaBT46YfG7knI4xf95tgaBKUB/PQt1BDXPE2+kEvAmohmQCFuqobEpE45n7ig
	l1QpgCF1o3obB4yo+vWfGHhLaDkFeK1nX7kDFHgTMCDJGhVHoikxt3XDiTA22t5C4FRNfmVEXZQ
	ysPuZFfw87qZnBE1gRHQPea4zwk+0Usb+IninI5teDUrrwLIjghj8sC+yMLj/cOhcy6ynjRBoRB
	W8=
X-Received: by 2002:a05:6102:2926:b0:605:2ab5:5c1d with SMTP id ada2fe7eead31-62d8734f885mr3100336137.22.1777886052785;
        Mon, 04 May 2026 02:14:12 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62bfddbc09csm4925369137.11.2026.05.04.02.14.11
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:14:11 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-573a81abef0so2502827e0c.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 02:14:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9g5Pt9FuKjZ3dJodNRysjb4G0IaVu5Kmyoc2agEMXv2/zFRnZg7Z+6t0qyiN+XT2rmfj6/1i73tM8=@vger.kernel.org
X-Received: by 2002:a05:6122:8889:b0:575:19a7:ae16 with SMTP id
 71dfb90a1353d-57519a7c4edmr1523286e0c.11.1777886051499; Mon, 04 May 2026
 02:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev> <CA+V-a8srS9g2WDMARDJn98K=nL9v1LiZYxqM8evsVrzR-s5ZMA@mail.gmail.com>
In-Reply-To: <CA+V-a8srS9g2WDMARDJn98K=nL9v1LiZYxqM8evsVrzR-s5ZMA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2026 11:13:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRtAOZrQbebng5pLXNENUeZenA1Hng1kER+1vbSwaj0Q@mail.gmail.com>
X-Gm-Features: AVHnY4IwZDZQbmmfAhrkW3faVQFI1p5tavPs1Lp33uXjss7HBIDZ1-3ZwYbIoeM
Message-ID: <CAMuHMdXRtAOZrQbebng5pLXNENUeZenA1Hng1kER+1vbSwaj0Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, 8 Apr 2026 at 20:55, Lad, Prabhakar <prabhakar.csengg@gmail.com> wr=
ote:
> On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
> <claudiu.beznea@tuxon.dev> wrote:
> > On 3/18/26 14:44, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add support for the RZ/V2H(P) SoC PCIe controller to the rzg3s-host
> > > driver.
> > >
> > > The RZ/V2H(P) SoC features two independent PCIe channels that share
> > > physical lanes. The hardware supports two configuration modes: single
> > > x4 mode where one controller uses all four lanes, or dual x2 mode
> > > where both controllers use two lanes each.
> > >
> > > Introduce configure_lanes() function pointer to configure the PCIe
> > > lanes based on the number of channels enabled. Implement
> > > rzv2h_pcie_configure_lanes() to detect the active PCIe channels at
> > > boot time and program the lane mode via the system controller using
> > > the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>

> > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > > @@ -1687,6 +1712,63 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *=
host,
> > >       return ret;
> > >   }
> > >
> > > +static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host=
)
> > > +{
> > > +     struct device_node *np =3D host->dev->of_node;
> > > +     u32 domain;
> > > +     int ret;
> > > +
> > > +     if (host->data->num_channels =3D=3D 1)
> > > +             return 0;
> > > +
> > > +     ret =3D of_property_read_u32(np, "linux,pci-domain", &domain);
> >
> > This introduces some limits in the systems with RZ/V2H(P) SoCs with reg=
ards to
> > the usage of linux,pci-domain. I would like the PCIe maintainers take o=
n this.
> >
> > As this is necessary to index in the system controller driver specific =
data (as
> > there are different SYSC offsets for different PCIe controllers) I see =
the
> > following alternatives, if any:
> >
> > 1/ add a dedicated DT property for this, e.g. renesas,pcie-controller-i=
d
> > 2/ Add dedicated DT bindings for RZ/V2H(P) SoC that would be used to sp=
ecify the
> >     system controller register offset and mask for different functional=
ities.
> >
> >     E.g.:
> >     renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> >     renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> >     renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> >
> >     And use them in each controller DT node. E.g.:
> >
> >     pcie0: pcie@add1 {
> >         // ...
> >
> >         renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> >         renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> >
> >         // ...
> >     };
> >
> >     pcie0: pcie@add1 {
> >         // ...
> >
> >         renesas,sysc-l1-allow =3D <&sysc 0x1050 0x1>;
> >         renesas,sysc-mode =3D <&sysc 0x1054 0x1>;
> >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> >
> >         // ...
> >     };
> >
> I'd like to get a clearer steer from the PCIe and DT maintainers
> before investing further in either direction.
>
> To recap the two approaches on the table:
>
>   Option 1: A single renesas,pcie-controller-id property used to look up
>             SYSC offsets in the driver.
>
>   Option 2: Explicit per-controller DT properties carrying the SYSC
>             phandle, register offset, and mask for each functionality
>             (L1 allow, mode, link-master, etc.).
>
> Both have trade-offs. Option 1 is simpler in the DT but moves hardware
> knowledge into the driver, tightening the coupling. Option 2 is more
> verbose but fully describes the hardware topology in the DT and avoids
> a driver-internal lookup table.

As this is SoC integration description, I think it belongs in DT.
But adding many properties is indeed cumbersome.
Fortunately the two register blocks inside SYSC seem to have the same
layout for both channels, so you can just use a single property to
refer to the base offsets (0x1000 and 0x1030).  Even if a difference
would pop up later, you could check for e.g. =3D=3D 0x1000 in the driver.

> Are there other approaches the maintainers would prefer that we
> haven't considered?

Option 3: Look at the unit address.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
