Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692FE30EF7E
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372932; cv=pass; b=C6AXqyUuvPqGAdxxYghBSHB5yFTbwYrRO+pNhuHYcKAI3dWYJXY0OiAq29lpww4ulEQa9KRC/c7nBWUOlJ7/EcmeFKs1uZrCkuLrMMNDW/rLpthwCg+yuLEg4v/6k+yYcqu9bSOO/krutNgHmw/4iGgxatYmEhTtvWSA5OcSnWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372932; c=relaxed/simple;
	bh=veShxjLg1b+Fw9op99xAw5lNPSgk5/UlV+fWfx807zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXrARDCr4b/jD/FGHf34veLxwoDXeyYokVH+SOgPIAdbanDfN4jL2LrtwISXoJAT/Ygr+jgdvqq5IcsNqNK/vMmMrriLqodZrC+HK2bhRW3V4SXH6Q9rtYIiFbkPhCMU4pWraK1iXkurDjIkkrKKl5PxWhw10uKovoSOcA1V3ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0V7rPqw; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0V7rPqw"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69fc9f25118so1658361a12.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 17:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785372930; cv=none;
        d=google.com; s=arc-20260327;
        b=kQIhNpEPKUpllv4Gje04mm+JkHG+RL/GhJb86BhKjHdOKx0GRDimAfhs0zEdMAJ1LS
         MZCwTRIk5PwE8eYSiXfiD6iOs1uZmr2UWvviOeeO6haXFh/U6/bL0FwIPPk6Yq4ueljq
         ti7TDtwEaf+lx+vBdxKkOwyX0hN6aJFrRjjKxTq0rweCDE6yTrKJlHZzTHnXxXnltXmq
         nAnhmHuXeM1FTkZSFlorqZa91c1BSpScN644QGjTBO1wS2SW/1CTwhfrS+a1YdTuZSmB
         t5rpIQwVyHtGw4ttCsbnd8lq+8jynbii2iNjuwJY4onZXilJX1/G+b3ca8WJ6XcHHOHZ
         8gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gobfjnthWgTQXNW9RE05SfOdwzRlTBDEl0y0GpPD5ZU=;
        fh=CSD7408ja+aXV8xmtttjJl9W5sR28F8jctujoQCPhYs=;
        b=foXCpquhFv/R3c/m+HjpOAQyflmiwyXnMpkzjC+BhbJNc3Jw3de0RhMZAvs1JkX+z4
         pNWBtneIWzY+CJoc7IY2jLBQdWXaGksGMTvdZQf89z3f2YNINawZKMlceeK9apadrteX
         0I7roffpIYt+iAN2N3xjgBl0tLnkcrmsJA1wbsA5R8583tSOCxb5LeFWYeF+pnb6rlzL
         AIBv6VEjF7pIvZnowylJ8wHWbCYrGpnRMXUPUXX/eXMi7Uwp6N1BeCTDCOh1rLtNoxS3
         RB5UDePvzeTyiatkGceo+4GvlMT6fqPGGnz7j9BcxXJUcej9mVnneEUExz04sZ3B4Jzd
         a7aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785372930; x=1785977730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gobfjnthWgTQXNW9RE05SfOdwzRlTBDEl0y0GpPD5ZU=;
        b=k0V7rPqwKnZjHLyW8EW7jAfGpL7hoaihfnYQZt4H/tFsNr71QfcrkHGa3xEk6Im5s9
         pDNA0eoSu3JVSfeuXlhs7db3/BN7+4cx6qTxBhSSwv5qwacYFJY8xfweDekQW+UFKCLY
         cEwb3A6BtpJ0FdOiha5NSqXAoBDFYfaPzcdnFJv64lg3hAwLJXNwQDrI4DGNAQaodOF4
         j4wTQbxW1BQw0zl9PxjIuoxxVtiaaRZKcLGRS4JHRKR/yKscIDa+yQCHF4iH+ARuv8O4
         iCosdGWVEaMjSHsZlv63GwOar+leT+KxPiObXkcpmmRLRflOUdy7NSLKII8V8jjdO96e
         r+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785372930; x=1785977730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gobfjnthWgTQXNW9RE05SfOdwzRlTBDEl0y0GpPD5ZU=;
        b=fWDpt3q3fSN5WntIoWcRl3LAs1u5Q8D5J/MmmREN7759z/JccmuYv9eMRt4vKvf6CY
         g3FjUWM5aaOTk1/OX8bXMbPIXEg+Eq43fEz35F6my/NzCBI9vcszi5bO/pogrI8/KH7k
         gbUkZ3T4H7mGwsE2Q0HqGbdi4rofQBf7ZMW9oLaXmzdL14ZeFQaYmNMSbvqb5UUHx8kM
         blBYlcE+h1XSmYIG5utdUgv+8+Y8STlF5XcY8LmH/o64dZdhPIrkvnGG3XTSAg0I42Rm
         D+mqlYXDPpBUNfpuGRnMJtTiFVC7t+hww8rcsApK65PURi4XwyXYm5Kwc4BCBqk1odaf
         GTcg==
X-Gm-Message-State: AOJu0YxhAAaD5jwqNfOTKkAZ3adJTNgCkFEMQ0cvjw0ohiXoSaKQzAVq
	xczM/g6rJ5xWFtNrgdvsxztVQ1LaaHk6pcnbLi5xTsTYqRxG3FkhiNuPB/9DalU2zp+NXnmhOIR
	dVmY07XyWsXyfqqU7UGGKOe2X0sIRg4Q=
X-Gm-Gg: AR+sD13YKhw/sYtGz06dUFybH4bI0p9WxzU5DGr7hxUUMok98iFM4RQtyhd30jjPFuk
	JCHEqrKHjJwLbfEjsEkCmvG9zgdZMGXj1UcXEY/FUyMX9Qh9g2V2ZUoyDlCim2NgqcJ0g5EXBKS
	ZiCJgBkpKnitfojGxTB4NwO5IFgOQ7y6opUAHLhhrv+0Li1TNQzDon/QMMG6uGJxiRQg1iD0ase
	B8soL48JkEpIwRNZz4qOZfGvbPgyXkDUL13JJ9L2pzP8BjIQG4kpr7lX9EDdvuPaXNjzdfsbQY/
	p5l1VXSbPsiNSC3by5chF57czAtI7uwADUgUY+viWO5AkHEkCPb/bq4B3MNSzNMZ6I6jQi4AY9X
	PGxe89FfKfPz+0CYni0SY2IsqzHKqtxF7W72BLD/4/qGr0llV36+S1SEeH3TrW/PPVEVYWXoUyK
	Sg9TsNPw07aHyVEy/qLDasSsYmePgVoh61w1KndUPu79RJsMYVJmfPUBc=
X-Received: by 2002:a05:6402:ea2:b0:69f:4a9e:a872 with SMTP id
 4fb4d7f45d1cf-6a07b886b7bmr217764a12.37.1785372929473; Wed, 29 Jul 2026
 17:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727234408.296186-1-rosenp@gmail.com> <CAL_JsqLLME5rN_HW4hEPfGcLBZX-r-10XJ_=cvU1nq1x4cJEEg@mail.gmail.com>
In-Reply-To: <CAL_JsqLLME5rN_HW4hEPfGcLBZX-r-10XJ_=cvU1nq1x4cJEEg@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 29 Jul 2026 17:55:18 -0700
X-Gm-Features: AUfX_mzhB7IANok2yPa703dtvh2qN2QOSacOzLqKPShSKaU7fBbZLxBxN9gcXIg
Message-ID: <CAKxU2N9Q0tWCtVk2jn8bWu4H5YGGiKnxJksxZ-MjuKtoupzVmA@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: iproc: platform: use device functions instead of OF.
To: Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	"moderated list:BROADCOM IPROC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 5:32=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Jul 27, 2026 at 6:44=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Since this is supposed to be the higher layer file, use higher layer
> > than OF to handle this. Remove OF headers as a result.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: fix platform_get_resource() parameters.
> >  drivers/pci/controller/pcie-iproc-platform.c | 31 ++++++++------------
> >  1 file changed, 12 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci=
/controller/pcie-iproc-platform.c
> > index 4c9a0c4bb923..488ff737ec52 100644
> > --- a/drivers/pci/controller/pcie-iproc-platform.c
> > +++ b/drivers/pci/controller/pcie-iproc-platform.c
> > @@ -10,12 +10,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/of_address.h>
> > -#include <linux/of_pci.h>
> > -#include <linux/of_platform.h>
> >  #include <linux/phy/phy.h>
> >
> > -#include "../pci.h"
> >  #include "pcie-iproc.h"
> >
> >  static const struct of_device_id iproc_pcie_of_match_table[] =3D {
> > @@ -40,11 +36,14 @@ static int iproc_pltfm_pcie_probe(struct platform_d=
evice *pdev)
> >  {
> >         struct device *dev =3D &pdev->dev;
> >         struct iproc_pcie *pcie;
> > -       struct device_node *np =3D dev->of_node;
> > -       struct resource reg;
> > +       struct resource *reg;
> >         struct pci_host_bridge *bridge;
> >         int ret;
> >
> > +       reg =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +       if (!reg)
> > +               return -ENODEV;
> > +
> >         bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> >         if (!bridge)
> >                 return -ENOMEM;
> > @@ -52,26 +51,20 @@ static int iproc_pltfm_pcie_probe(struct platform_d=
evice *pdev)
> >         pcie =3D pci_host_bridge_priv(bridge);
> >
> >         pcie->dev =3D dev;
> > -       pcie->type =3D (uintptr_t)of_device_get_match_data(dev);
> > -
> > -       ret =3D of_address_to_resource(np, 0, &reg);
> > -       if (ret < 0) {
> > -               dev_err(dev, "unable to obtain controller resources\n")=
;
> > -               return ret;
> > -       }
> > +       pcie->type =3D (uintptr_t)device_get_match_data(dev);
> >
> > -       pcie->base =3D devm_pci_remap_cfgspace(dev, reg.start,
> > -                                            resource_size(&reg));
> > +       pcie->base =3D devm_pci_remap_cfgspace(dev, reg->start,
> > +                                            resource_size(reg));
> >         if (!pcie->base) {
> >                 dev_err(dev, "unable to map controller registers\n");
> >                 return -ENOMEM;
> >         }
> > -       pcie->base_addr =3D reg.start;
> > +       pcie->base_addr =3D reg->start;
> >
> > -       if (of_property_read_bool(np, "brcm,pcie-ob")) {
> > +       if (device_property_present(dev, "brcm,pcie-ob")) {
>
> If the property is boolean, it should use read_bool and vice-versa.
I don't see it as a boolean in dtsi.
>
> >                 u32 val;
> >
> > -               ret =3D of_property_read_u32(np, "brcm,pcie-ob-axi-offs=
et",
> > +               ret =3D device_property_read_u32(dev, "brcm,pcie-ob-axi=
-offset",
> >                                            &val);
> >                 if (ret) {
> >                         dev_err(dev,
> > @@ -87,7 +80,7 @@ static int iproc_pltfm_pcie_probe(struct platform_dev=
ice *pdev)
> >          * core driver. For platforms that require explicit inbound map=
ping
> >          * configuration, "dma-ranges" would have been present in DT
> >          */
> > -       pcie->need_ib_cfg =3D of_property_read_bool(np, "dma-ranges");
> > +       pcie->need_ib_cfg =3D device_property_present(dev, "dma-ranges"=
);
>
> This is correct as dma-ranges may not be bool.
>
> Rob
