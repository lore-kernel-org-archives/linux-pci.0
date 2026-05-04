Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9E357735
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885527; cv=none; b=Kko/tgsp2b1kOMz1O4HrWSmgVuQiHwY2hpHJFeH21TCSnVbsNLOFUg94Vj4qEdusNrUqbMMpDn0kV9tmgIvxV5dPUunpMgXtZgGeLepe2z2a6XXG9h1az52lmFRB4VXWzaApxxdekxzoXrpSd0qL4gHtLO3rRH/HHAdfZC9dg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885527; c=relaxed/simple;
	bh=NvZkJz2oTmRF8PSVjwwY5oHKDCA/yV3ifrPuiMpUAaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrQUDpLMBEjpzRftyMNJT4ZOQMTrhP9RL0Cqpk8Ph7tXJ8eyrRzyk3oeGRDGAdC6gioXiTs0pgxrMUyz+6qxQWDzAR/zQm21fICh8ob0KN+XSsv8TnaLTPWJPcy4A6fsSZMmsEDlTYSrw4aYLlK2gkJ2cppgL3DQpB/G0MMTG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-57513a91514so362286e0c.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 02:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885524; x=1778490324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=plo5P6qpAaOBS1LGxtH3kAqckE95GaSrW4sXgxkjnV0=;
        b=oSIJI/TTDw9dgH6i7fD8GqGuxedzSFAIYm1urDFfCJgooSlwt9YQ1+VAjoropgWVub
         WyGM+xr9Up72XJkJE6qWrp8VtaRrHmn/7d3XZauqWEAohI/jp3XrPxfNu7iEzbqhw9q1
         /xKnATo24k5xsF/sQia4L+wNwn5yjcEGs7SaxZ+C2y3xX5eObT2nS8aVjgiH1MTeDH9W
         pJxR3p1FHAQepnTxL6Fz0FAJR8zJhhCOx9HwinI/YSNCdHYtlTe+ndSRvtLGTTmtA2zX
         COJcALWTH6h3sjsgEfiJLE0NTFVSgFf5g74SjjPTCB4ri6gnoXQy+rNdLTOv8/JYyLZm
         FeFw==
X-Forwarded-Encrypted: i=1; AFNElJ8YGcCpM/GfuqFZM+zESK7Qm8PSTTEz0k2pvk6xBzV+qBKKuM3YSbdb4Ul5olCdIhzsajmaJ8JGoXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNxpThTALrbWNKcYapmLrcw4R9ovZhKDh0jG9f47UYbn2z9YG
	FiPS0i7poSkHYOeP91PY8ozF99Lbz3qOgS53D31sXZftIFvck3Ek+i5Nqmfp4UQO
X-Gm-Gg: AeBDiesdgAJFPR6VsoZDVw5C8KQTiuM1Ysk0ao7Z9nFd1gtg52TnnwC0mqgEPTLehpp
	C2GeApzS/cYgMMAOgXCJ4YuCqrsXP/xWibmAHsbMDIUbSDV7HZPbgB8dOZbY+r/uLyz4inVN7BB
	lBtLsS6IavLfN8Wwbb84gYsI8WDSCTUUampv0Du90dYkr4o0AreqcyBhC3Qp0onxEB7dV6ANs79
	opObsTHL3cW6PgyUCkXrOL7mJ/4KcrZRHUcwJp6lBPQa8LFLjnNlfr3vsutJrmX0w786xzbysgF
	xqHd0uF3Pq9mKKrDup4lUzoU41Gd127sp7m2pm4rwBEkRIVj3iK/q1jFl+B/oiAn3UUaorEeTZE
	ZdHzmeKg3y9VgX1/lg2HWwi/vz/AoSdAfyLR2QKJptGkclieHQSdlg3SaY4azkoxkdUrUsKvHW+
	lCjGobStN3ir/PMDI3WZP8YcvY26V5Ss9evuB3pkE60kl/MNl2wTxmgn/kb1GpYX06dx3etyBj8
	90TzSP9zw==
X-Received: by 2002:a05:6122:83c3:b0:56b:a673:27bb with SMTP id 71dfb90a1353d-5750c5b9a08mr2837809e0c.8.1777885524128;
        Mon, 04 May 2026 02:05:24 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5749f7e8c25sm5676862e0c.2.2026.05.04.02.05.23
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:05:23 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-62ddb07fbd2so490322137.2
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2026 02:05:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+xPPwyMoBWfhsLvQ1BbH3i0Jg6jN5v6Mm4q8pL8e67PCEltbwodVbL+gF8yvhLzX4rcf3QlCPKP0s=@vger.kernel.org
X-Received: by 2002:a05:6102:2ad5:b0:628:397c:ecea with SMTP id
 ada2fe7eead31-62d854946bemr3171395137.10.1777885522827; Mon, 04 May 2026
 02:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <605e8d4c-09e7-4d11-acdb-7829a85eacc3@tuxon.dev> <CA+V-a8srS9g2WDMARDJn98K=nL9v1LiZYxqM8evsVrzR-s5ZMA@mail.gmail.com>
 <lvix7p4e7c4dtchtdti3rwrs7jkda5iy7lthcffhqc7g6vgu2p@54qywklrspi7>
 <CA+V-a8sd=dyTZmViLbDrCPYbx5ujWzjk74HxhP0aBEqxLuEqJA@mail.gmail.com> <leky6ktelj7t3uwd4bakgefrk32m3ceyxmwbkkjpp5zqp6rjgj@jtiqktxchws3>
In-Reply-To: <leky6ktelj7t3uwd4bakgefrk32m3ceyxmwbkkjpp5zqp6rjgj@jtiqktxchws3>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2026 11:05:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpzABKKRBwK3mMmTS1+S21R+0k94bOX-+4ZBoa+bRWSA@mail.gmail.com>
X-Gm-Features: AVHnY4LeZA0N6FCy7UX3qdh0-rhPGX17H6io1xUI_gkSOdYz_S3cRhnSj4PBBRg
Message-ID: <CAMuHMdUpzABKKRBwK3mMmTS1+S21R+0k94bOX-+4ZBoa+bRWSA@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Fri, 1 May 2026 at 16:42, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Fri, May 01, 2026 at 12:13:55PM +0100, Lad, Prabhakar wrote:
> > On Thu, Apr 30, 2026 at 4:26=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > > On Wed, Apr 08, 2026 at 07:54:41PM +0100, Lad, Prabhakar wrote:
> > > > On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
> > > > <claudiu.beznea@tuxon.dev> wrote:
> > > > > On 3/18/26 14:44, Prabhakar wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Add support for the RZ/V2H(P) SoC PCIe controller to the rzg3s-=
host
> > > > > > driver.
> > > > > >
> > > > > > The RZ/V2H(P) SoC features two independent PCIe channels that s=
hare
> > > > > > physical lanes. The hardware supports two configuration modes: =
single
> > > > > > x4 mode where one controller uses all four lanes, or dual x2 mo=
de
> > > > > > where both controllers use two lanes each.
> > > > > >
> > > > > > Introduce configure_lanes() function pointer to configure the P=
CIe
> > > > > > lanes based on the number of channels enabled. Implement
> > > > > > rzv2h_pcie_configure_lanes() to detect the active PCIe channels=
 at
> > > > > > boot time and program the lane mode via the system controller u=
sing
> > > > > > the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renes=
as.com>
> > > > > > ---
> > > > > >   drivers/pci/controller/pcie-rzg3s-host.c | 142 ++++++++++++++=
+++++++++
> > > > > >   1 file changed, 142 insertions(+)
> > > > > >
> > <snip>
> > > > >
> > > > > This introduces some limits in the systems with RZ/V2H(P) SoCs wi=
th regards to
> > > > > the usage of linux,pci-domain. I would like the PCIe maintainers =
take on this.
> > > > >
> > > > > As this is necessary to index in the system controller driver spe=
cific data (as
> > > > > there are different SYSC offsets for different PCIe controllers) =
I see the
> > > > > following alternatives, if any:
> > > > >
> > > > > 1/ add a dedicated DT property for this, e.g. renesas,pcie-contro=
ller-id
> > > > > 2/ Add dedicated DT bindings for RZ/V2H(P) SoC that would be used=
 to specify the
> > > > >     system controller register offset and mask for different func=
tionalities.
> > > > >
> > > > >     E.g.:
> > > > >     renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> > > > >     renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> > > > >     renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > > > >
> > > > >     And use them in each controller DT node. E.g.:
> > > > >
> > > > >     pcie0: pcie@add1 {
> > > > >         // ...
> > > > >
> > > > >         renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> > > > >         renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> > > > >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > > > >
> > > > >         // ...
> > > > >     };
> > > > >
> > > > >     pcie0: pcie@add1 {
> > > > >         // ...
> > > > >
> > > > >         renesas,sysc-l1-allow =3D <&sysc 0x1050 0x1>;
> > > > >         renesas,sysc-mode =3D <&sysc 0x1054 0x1>;
> > > > >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > > > >
> > > > >         // ...
> > > > >     };
> > > > >
> > > > I'd like to get a clearer steer from the PCIe and DT maintainers
> > > > before investing further in either direction.
> > > >
> > > > To recap the two approaches on the table:
> > > >
> > > >   Option 1: A single renesas,pcie-controller-id property used to lo=
ok up
> > > >             SYSC offsets in the driver.
> > >
> > > Can you explain what is the limitation with 'linux,pci-domain' proper=
ty?
> > >
> > As sashiko pointed out.dev, The linux,pci-domain property is generally
> > an OS-specific logical property intended to assign a stable PCI domain
> > number across reboots. Restricting it to [0, 1] would prevent system
> > integrators from using non-conflicting domain numbers like 2 or 3 if
> > the board incorporates other PCIe controllers.
>
> "linux,pci-domain" is supposed to be used in SoC.dtsi, not in board.dts. =
AFAIK,
> the board designers have no reason to change it.
>
> Yes, the property name implies that it is a Linux specific property and i=
f you
> want, you can propose a generic one (not vendor specific one). Other than=
 that,
> I don't see a blocker in using this property. Many SoCs already do this a=
nd
> other DT projects like u-boot do not end up parsing this property.

Sounds like this overlaps with pciN DT aliases, which are in use on
some (PPC) boards?

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
