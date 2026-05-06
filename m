Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70AB4963AD
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086627; cv=pass; b=aLrrIkZadKXFULc199nJPDWFKGnnGKfS+Age63at5785SaDE8vchySLrX0b/QYW3/2tbtXjRGpJNSXSW735w6UpawAtvVlaF0Krzb5L7xNDYKTcuqVp6f6E8S0eToXtDgRB3ll7eYbKsLhYP5hNvauqJaYe8C5clrQvSh/t9JOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086627; c=relaxed/simple;
	bh=nnDPaFLuNjymt4tOlyK75CyPRpjnz6csTwevbm8ig3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEfOoKXLD6DxlB2L9gBmhwZ3+CuXMTfHhXD8LaAJ3mC/xRLQUYeYjQqHMJR2El/eFe4WzQoQQrjNNzOQhwm4i8fzQ7ZWSEEFgLeiZV2aRYUgkA9IBYSaM+G2p9/uOIyu2/K3QUC5E5EK8KfM4HGDEgD6WS50XJ3a+U+ifGCIDDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvKsfPVd; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvKsfPVd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44509921fbcso3465218f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 09:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778086623; cv=none;
        d=google.com; s=arc-20240605;
        b=ZZHZU5/yL/VgyhyyIk37Nv6MFQn3LLakVohAxiMpVgm+LiMU+LQ8Q5JLENxGwRWpPj
         v/i+kg4SFYm3DTFDCVn+ux/PP4hlWb8YROEh4g35WLbO7/uWXCPv94cysDDk4ilUYJ0J
         qPlbZaObyB9AjcNko80SF2kvuhBWgRBoAmtE2FDU2mM7fsu1Y1XjvYUvW5rGGdDiDbIQ
         HksG8y5UncWNAu2EO3wpj/QaU8BHT+Uz4VP2OW8UwGoVycXw2v2N6gXBs8DApf9xHO/+
         nJOS07y3sKLHDqvTgutRCSMjddl49k4epaRIDXk8BHDl279JI7Xm2QGTZtcLlS9xzJnK
         ye6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W3VrhHynwF48UxqEaIGN6Be/106vwYx62+QwtkeJSSQ=;
        fh=ye9CW6IlJyAXptTS69os15Z49orMcX9Qh0oAQGEHbpQ=;
        b=UGRULbFb1xSvsvszszlcsKHKlY47CsPpMripCPDXXt7d+EI1Km1y86+LHzvovATeLx
         wU9+7pFmavkjXjIBJ4nKhfxqWnCk03x7Bg71gh6E6m1shrTovnXXn5ElEjxT8ufK7RT1
         tnyPdaYWbnMOFp1kSc0TKwqYBy9XlHlStqzJIwzOcbadNBNyU6/ORx1eAYuZwjN7M6zs
         o/0eePH4bnOgTjlZbeiMPEmgzYlsEmvZS2ft16FcalEDaN6xoug/jcfrX/19/etB2+HS
         uMWy/hjCwGKUU/03kWjDxAWvC1nEcT/WQifyO1Ty5Kn2srmOMa9MozrTVMJhrYyj5GLN
         k89w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086623; x=1778691423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3VrhHynwF48UxqEaIGN6Be/106vwYx62+QwtkeJSSQ=;
        b=DvKsfPVdrYrHRnwlyd3CYOEXYiDXhfu03/bnjD86bXkyGLIjE0W3tiA5rMqTYyFxom
         dRstHX8n8g4pMknBbVzZE67RMcitm+8cFvfH8znxoFAM+ownD0ZT/en8LryF0WQbJvFI
         ncqNYvBupY6Vwk8rghUSAaKVZsvOX1ScoZTVFxT6Y84clf4Ea+CchvXnl6Y3QlUDFYkK
         K0zo9ii2IBD4B65uIBY56hUxLTlohNZvTrFj8xjSVS0I0wU9YZzn6fcnn7Y36JgXbSvv
         Z5Adq6QnW7OK+l2p86z5Mx8KBEgfVEMyKlA/ixEAZi1QrxzmnqSyf0W2tW3lSx+6zzjz
         ZZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086623; x=1778691423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3VrhHynwF48UxqEaIGN6Be/106vwYx62+QwtkeJSSQ=;
        b=OgLl0FF2DpG3pwu6Up11/sjzaeY6LJQrZF4XFUHvOKx8CyrEahKI9lHkE30A4wfCFE
         7aWaZnQK+KcYP3WIm0XLULTqsFTvd0lp+h3osqhPY1NtjcWF6puDsf9JjjZGF+7lj1sG
         Gozlx52QhZ2WCuNrXYp8vZ/eysXyuInbjw8jQ1B/Te4BdBFDAZEY08C7n03e6XG9oHFB
         YY41bEr1Az/6nr79JcNr8h6bOGVWer7iknlpiwBKEGCi4p4T6++4JE+SK6SpRbMwucWK
         y1jNsSMDoK3Vk1xIdZ43DYdQlYcs8nAmHPwLEk3cR7mlOSy1kyH3OkOcJibqZsD1kTDH
         QNJg==
X-Forwarded-Encrypted: i=1; AFNElJ8D5OeVkNYh2D+TWHQO4UhBkrjfEq4cKOTpUmV3l14joIOV2NQps+F31ToL76GzlFS381A/ISGUI1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC1uNLFBYdqjdFnqdhVE32192hTBj7Y9wn8U1GVEUrjD+8KhCi
	/gdfbAIXikzEslk9oker7NEN2IYD3cJbQz42tp1pFj7eNzmhQNAJgzbh7fL3OZfPqLdJexB0O1Y
	7EDTNFeGhXG2DlPyGg0arDr6z7oXW5io=
X-Gm-Gg: AeBDiesikKps+gcSj3ArSNqG6yWKto0GEA1zH7lq0TeGdp37I21KfrEx0w4QIRjWi3O
	HaUKrLVtCgW2Q3HLV4u71hTSabCPdFRajGx+OExtpibSDpa0k9IfhfZtNLksVcouQg3x0jTgqOV
	swW2w+ZNo2rpeYJLb2a68hbzwq3bBD3np/K396TCwyyfO0KmdMjhy1pIAUi8ZTOQW65vTOk15gL
	do3eQ1haBfa81rgaU7Fd55muJcrZoCt76rPP0WiQNrAmtIItM3+nAetEN04Nt8wYqd9OPQcwNn4
	9QIC7spcTgTNNE2CqQAODkca1PHpLfWT1mFx5DJn49dhaFEFlFTWBspWEPaq0mjrxx4RhpsjTMx
	RhC3q/n5THG1QL79Nmike9onB5yyNhVA0iY90
X-Received: by 2002:a05:6000:1ac6:b0:43e:a9ba:b194 with SMTP id
 ffacd0b85a97d-4515d5c6b69mr7472966f8f.34.1778086623205; Wed, 06 May 2026
 09:57:03 -0700 (PDT)
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
 <CA+V-a8sd=dyTZmViLbDrCPYbx5ujWzjk74HxhP0aBEqxLuEqJA@mail.gmail.com>
 <leky6ktelj7t3uwd4bakgefrk32m3ceyxmwbkkjpp5zqp6rjgj@jtiqktxchws3>
 <CAMuHMdUpzABKKRBwK3mMmTS1+S21R+0k94bOX-+4ZBoa+bRWSA@mail.gmail.com>
 <phuerp2kp6ngruqjkpyjczpn5ya7iywrsiaqiiydvqxwlkntks@gyfcws3intsw>
 <CAMuHMdW_f5676cmimQYNyO3FZyi=DY_3sdVdUSUqXyZXpqCN0Q@mail.gmail.com> <ed3g6ff6rprbmho6aegkl3p3rzr2lroskf3h2rk774jhxpbqkt@pkuovjn3hrlw>
In-Reply-To: <ed3g6ff6rprbmho6aegkl3p3rzr2lroskf3h2rk774jhxpbqkt@pkuovjn3hrlw>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 6 May 2026 17:56:36 +0100
X-Gm-Features: AVHnY4IxAQNfa7ZXVBZBUZ_-kUL61L7PlHFWw3kP1JJ8Ny6Y6D4wlmNswfFeMso
Message-ID: <CA+V-a8t01Rf-i--7RL3A+O4xVGOtDLEJWSnztH0S-OGWDLQ94Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
To: Manivannan Sadhasivam <mani@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
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

Hi Manivannan and Geert,

On Wed, May 6, 2026 at 2:12=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Wed, May 06, 2026 at 02:07:21PM +0200, Geert Uytterhoeven wrote:
> > Hi Manivannan,
> >
> > On Wed, 6 May 2026 at 14:02, Manivannan Sadhasivam <mani@kernel.org> wr=
ote:
> > > On Mon, May 04, 2026 at 11:05:11AM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, 1 May 2026 at 16:42, Manivannan Sadhasivam <mani@kernel.org=
> wrote:
> > > > > On Fri, May 01, 2026 at 12:13:55PM +0100, Lad, Prabhakar wrote:
> > > > > > On Thu, Apr 30, 2026 at 4:26=E2=80=AFPM Manivannan Sadhasivam <=
mani@kernel.org> wrote:
> > > > > > > On Wed, Apr 08, 2026 at 07:54:41PM +0100, Lad, Prabhakar wrot=
e:
> > > > > > > > On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Claudiu Beznea
> > > > > > > > <claudiu.beznea@tuxon.dev> wrote:
> > > > > > > > > On 3/18/26 14:44, Prabhakar wrote:
> > > > > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesa=
s.com>
> > > > > > > > > >
> > > > > > > > > > Add support for the RZ/V2H(P) SoC PCIe controller to th=
e rzg3s-host
> > > > > > > > > > driver.
> > > > > > > > > >
> > > > > > > > > > The RZ/V2H(P) SoC features two independent PCIe channel=
s that share
> > > > > > > > > > physical lanes. The hardware supports two configuration=
 modes: single
> > > > > > > > > > x4 mode where one controller uses all four lanes, or du=
al x2 mode
> > > > > > > > > > where both controllers use two lanes each.
> > > > > > > > > >
> > > > > > > > > > Introduce configure_lanes() function pointer to configu=
re the PCIe
> > > > > > > > > > lanes based on the number of channels enabled. Implemen=
t
> > > > > > > > > > rzv2h_pcie_configure_lanes() to detect the active PCIe =
channels at
> > > > > > > > > > boot time and program the lane mode via the system cont=
roller using
> > > > > > > > > > the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@=
bp.renesas.com>
> > > > > > > > > > ---
> > > > > > > > > >   drivers/pci/controller/pcie-rzg3s-host.c | 142 ++++++=
+++++++++++++++++
> > > > > > > > > >   1 file changed, 142 insertions(+)
> > > > > > > > > >
> > > > > > <snip>
> > > > > > > > >
> > > > > > > > > This introduces some limits in the systems with RZ/V2H(P)=
 SoCs with regards to
> > > > > > > > > the usage of linux,pci-domain. I would like the PCIe main=
tainers take on this.
> > > > > > > > >
> > > > > > > > > As this is necessary to index in the system controller dr=
iver specific data (as
> > > > > > > > > there are different SYSC offsets for different PCIe contr=
ollers) I see the
> > > > > > > > > following alternatives, if any:
> > > > > > > > >
> > > > > > > > > 1/ add a dedicated DT property for this, e.g. renesas,pci=
e-controller-id
> > > > > > > > > 2/ Add dedicated DT bindings for RZ/V2H(P) SoC that would=
 be used to specify the
> > > > > > > > >     system controller register offset and mask for differ=
ent functionalities.
> > > > > > > > >
> > > > > > > > >     E.g.:
> > > > > > > > >     renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> > > > > > > > >     renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> > > > > > > > >     renesas,sysc-link-master =3D <&sysc 0x1060 0x300>;
> > > > > > > > >
> > > > > > > > >     And use them in each controller DT node. E.g.:
> > > > > > > > >
> > > > > > > > >     pcie0: pcie@add1 {
> > > > > > > > >         // ...
> > > > > > > > >
> > > > > > > > >         renesas,sysc-l1-allow =3D <&sysc 0x1020 0x1>;
> > > > > > > > >         renesas,sysc-mode =3D <&sysc 0x1024 0x1>;
> > > > > > > > >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>=
;
> > > > > > > > >
> > > > > > > > >         // ...
> > > > > > > > >     };
> > > > > > > > >
> > > > > > > > >     pcie0: pcie@add1 {
> > > > > > > > >         // ...
> > > > > > > > >
> > > > > > > > >         renesas,sysc-l1-allow =3D <&sysc 0x1050 0x1>;
> > > > > > > > >         renesas,sysc-mode =3D <&sysc 0x1054 0x1>;
> > > > > > > > >         renesas,sysc-link-master =3D <&sysc 0x1060 0x300>=
;
> > > > > > > > >
> > > > > > > > >         // ...
> > > > > > > > >     };
> > > > > > > > >
> > > > > > > > I'd like to get a clearer steer from the PCIe and DT mainta=
iners
> > > > > > > > before investing further in either direction.
> > > > > > > >
> > > > > > > > To recap the two approaches on the table:
> > > > > > > >
> > > > > > > >   Option 1: A single renesas,pcie-controller-id property us=
ed to look up
> > > > > > > >             SYSC offsets in the driver.
> > > > > > >
> > > > > > > Can you explain what is the limitation with 'linux,pci-domain=
' property?
> > > > > > >
> > > > > > As sashiko pointed out.dev, The linux,pci-domain property is ge=
nerally
> > > > > > an OS-specific logical property intended to assign a stable PCI=
 domain
> > > > > > number across reboots. Restricting it to [0, 1] would prevent s=
ystem
> > > > > > integrators from using non-conflicting domain numbers like 2 or=
 3 if
> > > > > > the board incorporates other PCIe controllers.
> > > > >
> > > > > "linux,pci-domain" is supposed to be used in SoC.dtsi, not in boa=
rd.dts. AFAIK,
> > > > > the board designers have no reason to change it.
> > > > >
> > > > > Yes, the property name implies that it is a Linux specific proper=
ty and if you
> > > > > want, you can propose a generic one (not vendor specific one). Ot=
her than that,
> > > > > I don't see a blocker in using this property. Many SoCs already d=
o this and
> > > > > other DT projects like u-boot do not end up parsing this property=
.
> > > >
> > > > Sounds like this overlaps with pciN DT aliases, which are in use on
> > > > some (PPC) boards?
> > > >
> > >
> > > Hmm. DT aliases are discouraged these days, AFAIK. Are those boards a=
lso need
> > > these register configuration? I thought only RZ/V2H(P) SoCs need them=
. If not,
> > > then RZ/V2H(P) DTS can use 'linux,pci-domain' property.
> > >
> > > If yes, then it would be better to hardcode these offsets in the driv=
er based
> > > on the compatible. DT's job is to describe the hardware topology and =
resources,
> > > not register offsets.
> >
> > The offsets cannot be hardcoded based just on the compatible value as t=
here
> > are two instances.  The offsets do describe the topology.
> >
>
> Oops. I mixed it with the PHY compatibles... Anyhow, I'd suggest to go wi=
th
> 'linux,pci-domain' to get the domain ID and use it to calculate the offse=
t.
>
Thank you for the feedback, I will go with the 'linux,pci-domain' property.

Cheers,
Prabhakar
