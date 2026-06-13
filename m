Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D3B33E347
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781320579; cv=none; b=VEcd6erSWTJlaql4DQ02ZPRAH0anAY1uREZfPXdeaYy4Xj7JBApH1ylAghManuj9h8pYddo9jmR9FPR0OYfI7zk7k7zwfFJhyZHF4C7JZgh82X9nDmEK3ri6FbXPw929XS+xTi0IHLv3Az7mjAOnGgJdpaShO+psnRZK0K8zvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781320579; c=relaxed/simple;
	bh=syruvy2lB53+ugOWC8rCeD7OnEXPp7AdpSqCfvRarMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qm2npjnLvRPl68/E+PHgtYudCuxpSoQTNobOXXrUqBcyAMFtMbBiisII3SASyHt0Nrjjbf/sUrVSgGv5JnTZPXsoaEMVSTxP04IMJPnlvA0pt/bfLolr0P+YIexAkjrup4Et2qQXKkxSwWlueqU/MrdZ2YvHDdq8ad5y42OGAFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEKDJLZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEKDJLZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7161F01558
	for <linux-pci@vger.kernel.org>; Sat, 13 Jun 2026 03:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781320577;
	bh=Xr+xa6dWClQ5L5h9bpGtzQpT5gTteanoBiiOx0idzX4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CEKDJLZEGHBfS9JH6iHEsuxcoyNnjiALwp9E9P7bBEBMg77xR+wQaE2QzUVC//4kJ
	 bhHpbbr/50yNdcjnYah++BsGnm55aOhgft+dB1zLkQCNBBf5p98Ul8coSo5ZVUYqbU
	 t6ZBO4lGOl3nb4UIsU41qC3rws/3Qu2TxaIfBGSL/As9IRoW+t2GsOEXPuYlLI05bY
	 u99lIyyrEZBepwsbcmvHFrn8OfAY4+TJK5Qfu7n/IlfV/4PCy6U66LXnN0JoDnm8CH
	 y9h8mzUViE3ujD9Uipzdd4S4+CrVaOI9Whz2T0VFeWE7xNDS4Yv8FX+CT4EybhuyLm
	 +3xk6eVdJfYQA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-befd83e0521so517124666b.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 20:16:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+TBavbPVwEdMGg0Y0nGPAM6jKcYP6j0Cs6SdE6gsSJSlE8c0cY+rJRR6TtF/yhxr5yOvtxcD+TyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsIXicywkqt1dP18/XJGn4DSztDBwzVk2+jpX6P8Y6CGZRYlSQ
	mq2DYThLyOcjZhhE+VO/fBkBOUbdhPT+a7Mtgwg+cwUz/EV8NLhPfP8OMt3ffMlafV5aGPnizy4
	zabYFh3KOQA8x+JaX7XuTRZh9HrwAc4g=
X-Received: by 2002:a17:907:7fa0:b0:bf9:b543:bb86 with SMTP id
 a640c23a62f3a-bfde22b16c8mr260486366b.6.1781320575875; Fri, 12 Jun 2026
 20:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609152511.753760-1-xry111@xry111.site> <CAAhV-H4QV=gYQH8+RRL3S8OTR3xq7c0iAUWgJAh0pETVikO-qw@mail.gmail.com>
 <2dbb12fcdebf6c7f375cce56cceb113746a92c4b.camel@xry111.site>
In-Reply-To: <2dbb12fcdebf6c7f375cce56cceb113746a92c4b.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 13 Jun 2026 11:16:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_JnqWoCySA+xf++1uxAuGC=xmreKROd=b2x34EQvz3A@mail.gmail.com>
X-Gm-Features: AVVi8CeMYvg7ls187hyOjTigWrts3D2Lw16AESGjQld3Ig0voaxpKT1coZl1POU
Message-ID: <CAAhV-H7_JnqWoCySA+xf++1uxAuGC=xmreKROd=b2x34EQvz3A@mail.gmail.com>
Subject: Re: [PATCH] pci: loongson: Avoid L0s on LS7A1000 PCIe x8 [0014:7a29]
 Root Ports rev2
To: Xi Ruoyao <xry111@xry111.site>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingcong Bai <jeffbai@aosc.io>, Henry Chen <chenx97@aosc.io>, Han Gao <gaohan@iscas.ac.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 7:40=E2=80=AFAM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Wed, 2026-06-10 at 16:21 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Tue, Jun 9, 2026 at 11:26=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> =
wrote:
> > >
> > > Commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states fo=
r
> > > devicetree platforms") has broke booting of a Loongson 3B4000 + 7A100=
0
> > > server with an Intel 750 Series SSD.  We also found a Loongson 3A5000
> > > board using the same 7A1000 bridge chip exhibiting the same issue wit=
h
> > > pcie_aspm=3Dforce and pcie_aspm.policy=3Dpowersave (ASPM is not enabl=
ed by
> > > default on the 3A5000 board because it's based on ACPI and the _OSC
> > > method has not been implemented in its DSDT/SSDT yet).
> > >
> > > This seems only affecting the 7A1000 chips shipping the revision 2 of
> > > the PCIe x8 Root Port: on other two boards with a (persumably older)
> > > LS7A1000 bridge chip utilizing the revision 1 of the root port, the
> > > issue does not reproduce.
> > Is that confirmed by chip designers?
>
> I don't have their contact.  This is based on our experiments on 5
> boards (two 3B4000 x 2 with rev2, one with rev1, one 3A4000 with rev1,
> one 3A5000 with rev2).
>
> > > Cc: Mingcong Bai <jeffbai@aosc.io>
> > > Cc: Henry Chen <chenx97@aosc.io>
> > > Cc: Han Gao <gaohan@iscas.ac.cn>
> > > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states fo=
r devicetree platforms")
> > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > > ---
> > >  drivers/pci/controller/pci-loongson.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/cont=
roller/pci-loongson.c
> > > index a4250d7af1bf..dc7cee10643e 100644
> > > --- a/drivers/pci/controller/pci-loongson.c
> > > +++ b/drivers/pci/controller/pci-loongson.c
> > > @@ -212,6 +212,19 @@ static void loongson_pci_bridge_speed_quirk(stru=
ct pci_dev *pdev)
> > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pc=
i_bridge_speed_quirk);
> > >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pc=
i_bridge_speed_quirk);
> > >
> > > +/*
> > > + * Some devices, for example Intel 750 Series SSD, experiences data =
loss
> > > + * (read timeout) on LS7A1000 PCIe x8 Root Port when ASPM L0s is ena=
bled.
> > > + * This seems only affecting the revision 2.
> > > + */
> > > +static void ls7a_pcie_port2_aspm_quirk(struct pci_dev *pdev)
> > It is better to follow the namings in this file, i.e.
> > loongson_pcie_port2_aspm_quirk, or loongson_pcie_aspm_quirk for short.
>
> I'd keep "7a" in the name so in case another ASPM quirk is needed for
No need from my point of view, unless there is already another known issue.

Indeed, some other existing quirks are also for LS7A only but have no
7a in their names.

Huacai

> future products we'll not get a name clash.  Maybe
> loongson_7a_port2_aspm_quirk (I don't think _pcie_ is so useful here as
> the entire source file is for PCIe anyway).
>
>
> --
> Xi Ruoyao <xry111@xry111.site>
