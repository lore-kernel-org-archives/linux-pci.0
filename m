Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A12EB859
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974607; cv=pass; b=CmMNTd6b2ZuuIuav+nP7f3oeAxnWZzGW+URbkQXtgbpBatlm4GDlUJsA8K7YGI5abvUK5AI4y2ZytRkbBhGHpaFobsenSkQMqirM7BoNX5qyu0DcTpq2w0BNdHJuSfvspjVr6oi2Ks2I3LVN3GJhZXRgpefjMZMBt2Xqfn5icMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974607; c=relaxed/simple;
	bh=qQ0fdreUZzC/7HdkK25NxWYh+tIDDlH4eCp9sTOS4JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjrcKF1Bh25SbHcY0CSUpWkYal6nhKUOPEOLe5bmXTcW8nSqKCa0RkGRz8DnJ1ChjRrYHPObTb5N47HoNcBI5E6HlSAjLHuy1f+XbouJRmecuGRWNOUWPHVWKjHaJxfsT0wcd42rPcqI0fp7hCTeyv31dEZqiyQFZA1htTCT1dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBjs0fqi; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBjs0fqi"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a74032ff8so2664057f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2026 02:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777974603; cv=none;
        d=google.com; s=arc-20240605;
        b=Nykv6PXpDNfPhFedHw/9EJsItmFvNN+w/veV0Io8aaVhLcrTW7YZTIhU/+t9P/tWFd
         Faujt19ucNRJqtNlL82Ox4XlSIfFiPPQ5Csb2z2RrNzeLFC/8uHl4/0utVPjHjGyUcXs
         A2CU41baEmhFE4ax2HKTAa0itTHQ0V3ZpD/tA+gSurl61oqXaBioDy3vGXiekM88FVgm
         5lx+DPaYwKLEi70AELIYW328M31zj+16Uuca5GAun46DZ0vTvtcSsFZ9YfFku6WYMU7E
         BB+yDTSxtjzyuQP6j1vDo5tMEkn7fraESupmQSXVqeoau2R6pjfCuLEY+YTNZL6WpCnE
         84fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yM4KcG56R9vbDU06owym0pp3y5nB/08M1mIBueRT0Dk=;
        fh=u5DDa4TXFqBk41dmXnJxuzivjyqvi9EnrrP1aYVFYQE=;
        b=DG+Nb1VRrPtB8c/x+kUNHts8NUn8TnyaAozjNGuRqIvGKjTboctaZuTJcNoX26MRas
         z5NYLiJYT1QmECJnhujFc+fAsUy4NB0MceJSDJNM7ETrTCX+9RikvCeLUZNfT7iu0sue
         Df0nZwTygmEhaXEMmrt/ZBKQIRb254W7mSHNeKOAzL1MATWmeoYYbV41aQsGaX2+d9Fc
         8/20MWnlSBUOohAxRCof5GLYNXPvtmQuiLloi1Guv2PljOR1iVM7VYIhctob6SwhBwr4
         ErgzWQSc1ftbDNYVB6kL3bhCCEpls8s9e+MX3JREQhxG9/JtMQ1LKWVfaFcvpjoOhLXM
         AUlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777974603; x=1778579403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM4KcG56R9vbDU06owym0pp3y5nB/08M1mIBueRT0Dk=;
        b=UBjs0fqiICJTxUYdi61u826nIJwUieJ7vazwRcShSJMxW9foPK1eNRe0q8ckskaGxu
         rV6PR6bnTRgN0y0AT96FnCb5DAwCYEsiOPZqM+PPOuFo1eRV1J/Z4m5au9oxpj9whOEp
         wtyG8RaOkF6elETkRWWJoha+JfDj4I9bgsMR5ibuDP6A2cmSgjEYn3p/hhpuQcHEpgR2
         uActrKlpdRDKdqOGqPQuL4y8Dqo8Dqa1sGyhKaIXCq6pdRO5yQUyk9Ljm7t+CXXBda9o
         mfD7A9o4lADip55AeiJiXE4oZfmwKvPDQPqDMfn6gFboCGSR6WbwRk/I6u/V90MMTB6c
         mUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974603; x=1778579403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yM4KcG56R9vbDU06owym0pp3y5nB/08M1mIBueRT0Dk=;
        b=Ro7WN4Fk+NsW3wc1DVTdpN6vYp0wGT6cuwTWIYghG/9ru+mzdkJDLDjWhG67fD4QyE
         5jS7rhgZq4BqKRds5hnkuj/pP2BTzF6dfWCmYWHeEHVdrXLWSu5k4rOjyCnLGeX5Xu17
         2T3DpP09+9tDARvQvPMKxDq4oPD2fAbTt6tngtaqqAzTIl/l1o8JEds4v5VN21ScHO12
         8zU6vQZN9hMKNiMz6O8eYFPchzJmq1bvFWopRlQtQcj7VbHjwfaf8JEIvzhMZFRnfoHn
         xXAOpzoa1agb2zdKxg2+xIxcLB1Ij/VvuRjUHQO0/JUPhw03vIz8kuUf/jvy38WT26XT
         L0Cg==
X-Forwarded-Encrypted: i=1; AFNElJ9oUgHzZAzojqHoOiGoGv/L16coT0OQUpAPw9iL4DgmZ4sDBfYlt2Q1JF1kQr+609y3aiQTC8Bxc8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1w3wM05e2Xc2CgLqSWD5cLGZPy/rlyo6U6SWpumMz0EA5OqW
	jcEpBctraK6R+vCt66IeKfEu0Ybp+hAE0deVUUcwsH55lV6On3KTtJJY2GI0MQ/23rw1uB0H8w6
	WGQovxvY/410QAozWnDfvY0hM/qE/938=
X-Gm-Gg: AeBDievVH4AIs/MImWKFAxVfo/AWXieZ/TFGKVZptjrk1SvHHwHqgvh5sDfNH67/Yzx
	YZTQ94sBZ/V0Ah9Ahzn/CSsYz1QL+pDxiOr1dJca6cSJotfJ4iwodjyG4pvJDmRMJbSrPqYtW0C
	nCvX2Xyx9atyKaNLw93Q26jPgSab6H0Il3EjR8fZ7jtKtinrQg3YB1H7zr9w9ku7PQDB1LbE3pw
	ZunXyFEOqv6eNUHV2r9ZuHYJK/Si0HturINUroSL4XU8n13N7pyapsAAkHxocl4Q/qOeApAFw+G
	LoFxtz5y85tWdJ2GyLXY8nzUGwyu5L5H72MPybnOAJq8/aaFANnzxIZt/63EDKklCbVYedwXzM0
	zBIM=
X-Received: by 2002:a05:6000:18a5:b0:43d:7c1b:b8c7 with SMTP id
 ffacd0b85a97d-44bb65e0664mr22072385f8f.21.1777974602954; Tue, 05 May 2026
 02:50:02 -0700 (PDT)
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
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 5 May 2026 10:49:35 +0100
X-Gm-Features: AVHnY4IoCllXpa4rpkEn8ddmDkn7rn864MKfmonI0Q9JZNQwspbW0qaX6F7JYzw
Message-ID: <CA+V-a8ve9+Dz1kxZDXUROAuiKMYp=+q0BqMfGo12dsy=SXjyfw@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
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

Hi Mani,

On Fri, May 1, 2026 at 3:42=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Fri, May 01, 2026 at 12:13:55PM +0100, Lad, Prabhakar wrote:
> > Hi Manivannan,
> >
> > On Thu, Apr 30, 2026 at 4:26=E2=80=AFPM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Wed, Apr 08, 2026 at 07:54:41PM +0100, Lad, Prabhakar wrote:
> > > > Hi All,
> > > >
> > > > On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
> > > > <claudiu.beznea@tuxon.dev> wrote:
> > > > >
> > > > > Hi, Prabhakar,
> > > > >
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
> > > >
> > >
> > > Can you explain what is the limitation with 'linux,pci-domain' proper=
ty?
> > >
> > As sashiko pointed out.dev, The linux,pci-domain property is generally
> > an OS-specific logical property intended to assign a stable PCI domain
> > number across reboots. Restricting it to [0, 1] would prevent system
> > integrators from using non-conflicting domain numbers like 2 or 3 if
> > the board incorporates other PCIe controllers.
> >
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
>
> > > >   Option 2: Explicit per-controller DT properties carrying the SYSC
> > > >             phandle, register offset, and mask for each functionali=
ty
> > > >             (L1 allow, mode, link-master, etc.).
> > > >
> > >
> > > Are the register offsets going to stay the same across controller ins=
tances?
> > >
> > > If they are not going to change and you can derive the offsets using =
the
> > > controller index, then there is no need to go for individual DT prope=
rties.
> > >
> > The offsets will remain the same across the controller instances. So
> > instead of using linux,pci-domain property we could use below is that
> > OK?
> >
> > pcie0 {
> >   renesas,sysc =3D <&sysc 0>;
> > };
> >
> > pcie1 {
> >   renesas,sysc =3D <&sysc 1>;
> > };
> >
> > Where 0/1 are the controller instance IDs that the driver will use to
> > derive the correct offsets.
> >
>
> What if you have other register blocks using the same pattern in the futu=
re?
> You'll end up with renesas,xxx =3D <xxx, N>. You should stick to
> "linux,pci-domain".
>
As Geert pointed out this overlaps with pciX DT aliases on PPC boards.

Cheers,
Prabhakar
