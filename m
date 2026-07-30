Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6433438F
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374589; cv=none; b=HiGvNISbMhSsjSN2E1qBPnTF/f+mFZ/2dNo7qLHsr6vNIQOh8qpj0BEkcOE3bPLJS9K3ftmw/Ox8fHurBJwK9P7X4CoGqTvmZ2aMw1U8fwXVUoGQYKkD0NjLfW9eEQcJxTI+xvEk3jYdfpjjrtEb5G8boOTmBbGH9bkk7OpQfk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374589; c=relaxed/simple;
	bh=5oCvMgbRGxkQFMB+0lF8Til6T4ZdlIG3wJDn5asRq6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L43cjkT551lcnExgBmQzLrVCpREETHEiIWYjTCO4PFqzKmUTOmy8O3crYpFiQQaRR3avvlXUewKX/MMsia7CzL9ti+WC0sA0RAgida+wMXToSULssFByt/GKV2SGup7lGTWduqkDxwzFrJ0QjdrL723oWnSYsvWYQK5OedMf7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC6qvX+w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC6qvX+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AE61F00AC4
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374587;
	bh=ffGAcapN3R5fgPUa3yUZnlAkGuMraG/kj2eR0YNfPCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iC6qvX+wwbqeV6fYwEOvIHaVrQyjHltI2QjakrA73tYEQ2dmDl3MGThB2YKBmPPu5
	 RXXEmWRhTFw1i0Sl+3T2W0I0E6j9HuEVPEifBfddzx+Kw8TAwrhiwipQtqjGbqlhno
	 OBn5+tUVYT9tItiSMXxaO3ovB8GtU/EGUHORlcyc92LlUcWtsw43yGjKOVdQA+p5KF
	 1dpumgyvnaXf7IFypCBi6bOEVV6mIxiiycE74Ob8MRXxZrRUD8/ou+5nf1ufxen2Yn
	 3itHZM3scB8+AsKhH1SUBlctsxJRnBWrrZ5UpNWq1f56WzKBgaZY5i1HVnC8KCWMBf
	 oiA9RYNxYy4vw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c160420289bso221033766b.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 18:23:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YznmVvFNjOBo2quy+BnCU/AW8vkbh//fAiLdXvXDb2Oo49LBcvV
	pfpdSXNC7l6eLK7pJTGP9wA+8d7iYnBT7BYHOQTdpAA5LJeGcfY0vt/Q0rnNclVqt/RAJGnWKLX
	Atx4zeATc64kpr6BUKBePEumLZa6Irw==
X-Received: by 2002:a17:907:3c83:b0:c12:5e26:da50 with SMTP id
 a640c23a62f3a-c1fa57ca16cmr23754566b.65.1785374586439; Wed, 29 Jul 2026
 18:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727234408.296186-1-rosenp@gmail.com> <CAL_JsqLLME5rN_HW4hEPfGcLBZX-r-10XJ_=cvU1nq1x4cJEEg@mail.gmail.com>
 <CAKxU2N9Q0tWCtVk2jn8bWu4H5YGGiKnxJksxZ-MjuKtoupzVmA@mail.gmail.com>
In-Reply-To: <CAKxU2N9Q0tWCtVk2jn8bWu4H5YGGiKnxJksxZ-MjuKtoupzVmA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 29 Jul 2026 20:22:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKufnuTbHpiJhvFcWQxvLWocnkZbr+HoHGVpvtJ2JDW8Q@mail.gmail.com>
X-Gm-Features: AUfX_mw4oUlyqEPrkpHCD7R6Ci5jgme3jesHsmEr7sxa_gh8ShIwR-wWrDGCpmY
Message-ID: <CAL_JsqKufnuTbHpiJhvFcWQxvLWocnkZbr+HoHGVpvtJ2JDW8Q@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: iproc: platform: use device functions instead of OF.
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 7:55=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Wed, Jul 29, 2026 at 5:32=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Mon, Jul 27, 2026 at 6:44=E2=80=AFPM Rosen Penev <rosenp@gmail.com> =
wrote:
> > >
> > > Since this is supposed to be the higher layer file, use higher layer
> > > than OF to handle this. Remove OF headers as a result.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  v2: fix platform_get_resource() parameters.
> > >  drivers/pci/controller/pcie-iproc-platform.c | 31 ++++++++----------=
--
> > >  1 file changed, 12 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/p=
ci/controller/pcie-iproc-platform.c
> > > index 4c9a0c4bb923..488ff737ec52 100644
> > > --- a/drivers/pci/controller/pcie-iproc-platform.c
> > > +++ b/drivers/pci/controller/pcie-iproc-platform.c
> > > @@ -10,12 +10,8 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/platform_device.h>
> > > -#include <linux/of_address.h>
> > > -#include <linux/of_pci.h>
> > > -#include <linux/of_platform.h>
> > >  #include <linux/phy/phy.h>
> > >
> > > -#include "../pci.h"
> > >  #include "pcie-iproc.h"
> > >
> > >  static const struct of_device_id iproc_pcie_of_match_table[] =3D {
> > > @@ -40,11 +36,14 @@ static int iproc_pltfm_pcie_probe(struct platform=
_device *pdev)
> > >  {
> > >         struct device *dev =3D &pdev->dev;
> > >         struct iproc_pcie *pcie;
> > > -       struct device_node *np =3D dev->of_node;
> > > -       struct resource reg;
> > > +       struct resource *reg;
> > >         struct pci_host_bridge *bridge;
> > >         int ret;
> > >
> > > +       reg =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       if (!reg)
> > > +               return -ENODEV;
> > > +
> > >         bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> > >         if (!bridge)
> > >                 return -ENOMEM;
> > > @@ -52,26 +51,20 @@ static int iproc_pltfm_pcie_probe(struct platform=
_device *pdev)
> > >         pcie =3D pci_host_bridge_priv(bridge);
> > >
> > >         pcie->dev =3D dev;
> > > -       pcie->type =3D (uintptr_t)of_device_get_match_data(dev);
> > > -
> > > -       ret =3D of_address_to_resource(np, 0, &reg);
> > > -       if (ret < 0) {
> > > -               dev_err(dev, "unable to obtain controller resources\n=
");
> > > -               return ret;
> > > -       }
> > > +       pcie->type =3D (uintptr_t)device_get_match_data(dev);
> > >
> > > -       pcie->base =3D devm_pci_remap_cfgspace(dev, reg.start,
> > > -                                            resource_size(&reg));
> > > +       pcie->base =3D devm_pci_remap_cfgspace(dev, reg->start,
> > > +                                            resource_size(reg));
> > >         if (!pcie->base) {
> > >                 dev_err(dev, "unable to map controller registers\n");
> > >                 return -ENOMEM;
> > >         }
> > > -       pcie->base_addr =3D reg.start;
> > > +       pcie->base_addr =3D reg->start;
> > >
> > > -       if (of_property_read_bool(np, "brcm,pcie-ob")) {
> > > +       if (device_property_present(dev, "brcm,pcie-ob")) {
> >
> > If the property is boolean, it should use read_bool and vice-versa.
> I don't see it as a boolean in dtsi.

Looks like boolean to me:

arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi:156:           brcm,pcie-o=
b;
arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi:185:           brcm,pcie-o=
b;

Rob
