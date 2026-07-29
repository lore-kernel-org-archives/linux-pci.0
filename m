Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40B453A4F
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 18:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349114; cv=pass; b=qKN03SWQZmukNjoVlrfChT80CdrGsH5efZJsB3iH9Xv8pch6W+ISjC/xaucwGDPseLFHP6cYULD/DLqDeJllhz65IVNYYwG71klmClYAodvdc0hsPFwvT6uGWrd9BPxkZP9l1CiFO46YeS5zRxrnzbRUYBHgvUsSFzTMKXRcw9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349114; c=relaxed/simple;
	bh=iF3MsUaiv9wYvTwNatTrzedOqyxinRERB8Oc68E6Mdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpmhLd/5RFeTeXXmMDN2h38FFutxKWyBZzADnTK9MllvQWNWPuiIwInjUjXycyePFqUyrfNheGuhTCBukBRjeR+e7PDtL1qypZ+chJvPrJVhZMZtgs7s5Rw1gZVQrbJPn0omX+dYDgHW4T1FQu4Z2FJdMTg/L6Yg2Jc6H2WQZ0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxbVJ03X; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxbVJ03X"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69ea0595598so1323254a12.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 11:18:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785349107; cv=none;
        d=google.com; s=arc-20260327;
        b=pUBzI0A2DMcZ/o5ON5fYqfLuuVD0jcVHBVjvOnh49Rek3Eu8Kuhcptp4450W1cK0G2
         pGNbsSAXAJtPmuykALCXVWTldHMyDMnvlQ+TVX42qUuasZqXFuHJ0M4a5esZ2ojgzzT7
         yb4hUAbsbsRutnjSTsYUsSKSLhQP1kgrrx7rDw1hOEIQ2A41Zu3t6/PzSKiH2zjCCtkl
         D4QeDUC8w0GAEZa6ajhwDmZQrysPmJOO5bAfIf31KXK8Trpaf544xWRPDE45TdyDrUFu
         oaGoJ6T6n7U8Ae86SerV/hE/Il9YdtEd0AQYdElMlhDUKTfaLc3Dtr6EYDhGizTPdIkV
         gDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcCuHqVYCKL4ZVfAAcjqS5FtBduw+dbkV1WkEbl+SbI=;
        fh=GScZpHgj1eDqBM1l3DkTQLFkQUHm4JUfi624depeMGU=;
        b=dTTvA5OJluHK+xQ5xobbP145nP38ofpt51MWtrKplcUGpSvHzcFHQ/3oqkPMBHTpJx
         5lN1DfDVbtQr7N9R+ssbkCWPr8XWvt9CaHk7R+1Kt+6b1Wk9vaoH+yW2ecrqwRuJurHY
         6BmWQmQWMZLeR2ptOLs0yMCGYh60w+BSts/0gtQE6aNQu8Ilg2JMpXfspDGIJJPLmfDj
         hEgm81K/oUqU6kwfT+8/U1En4y3JMIRS8S+lpJ2XNi3vztduZMBjhhR1FOiq7Aa+QIdL
         YHinfPk6mDw6ZCLCoYPvEO4FBVjzjwd3uiyGoXo7tenDAUjZomOtumZ14VMNpQI0187P
         6TAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785349107; x=1785953907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcCuHqVYCKL4ZVfAAcjqS5FtBduw+dbkV1WkEbl+SbI=;
        b=SxbVJ03X/oKzHJT9ND4DG+uwpn3I7yQ6jVpN653M0rTNnXGVQu+euZy2atiN+qVnTl
         UPMNduQ411zq0uVqvjWiWTiwHoRQuedDdLS6m9k9Px3HGWKb+DKzR1V0PxkhtFBcrllG
         f106hxK3SWyOVvaIwEzRFFq1duLzXsv6fX5U9XYyOMcJmDDG/wTXpMzs0JqqTgGdAOx8
         ZAfe12RiduHVHiNf6BHniCGIEpGB4czGQfWNPBA/etKgxnS/NfqERnMyGZjxVMeiayNW
         bSSg74YrwxT+o9wowotr50MIKLzSOsHeDoXKJTGYX90SgskkmkBH1Ssupi8yrxSlTK0q
         wuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785349107; x=1785953907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcCuHqVYCKL4ZVfAAcjqS5FtBduw+dbkV1WkEbl+SbI=;
        b=jcpy0n1nu2s32tA/Ee+f2lezJz1xamyaJGojQw5R9gqaEqH8mEA1zdntOb7c+eW5WQ
         tWkh6chi0N+uDHylyD24xo+k8toeVEtYArwp311JaPCzg6QoDU4gYWW3s2r2qGCEu5hv
         906Oh8YqtJclweFSzWmHjzm0VaMZTaHhWNnmEbdkLY/N3PEG2z/lwVoWg4XPOAAtzlN3
         3BcOOE/5YnRXoHehAy39J2+Zw0tntL+9OK96zvFRH8AauOcpCLV7NBX8HdrymLKeJeDX
         4D0kvRo8h9IwSCFDNFCqcSg5atwvWbTSnqIjF/m+czDBBavC/pKZkGjijlUP1GoV92Vp
         Tzzw==
X-Gm-Message-State: AOJu0Yw+FsgvXYbVyQo1we8cy0W1C+lgI8XksR2GN2iiHrMpmDaSsSYd
	4fEyi6dRl6WZdfb1xSFQG7UKZJBhO5dpbfhOYuVhQVeAciD5GoVfyRYKpTNBqzT8RohhwpB4DiE
	FwnBLcP5jGsjga/SvMnFLFZQVqOKms/0=
X-Gm-Gg: AR+sD11BgCFSbVrfVcgHYDO6s5ne8Iw+Ur17oTyDmA3jeLhVyqJdj8RUJ8L7TteXN0a
	YfuLf2vGEyXJTrSg/23cnLvbgqgB6fl5oPpK2LsgM85hjlfU4eTrT+WimnW3ShXa2rNMsNdAM++
	eyRhlAKfllDEDj9rvYz3N7KQRQqN82ryXq/eXPy6GT5ioNIG5h8qpf3NVCvVam7xdmqcK6FdJJb
	ShWm/7CPFqsm7ongCDuP5mIKoblFOH1+96TadaAX1AUlrv/WJnkvamLAimj7DqUgzL6srswrLgr
	VdsEOR7RoHc/RbA+BGrNYyJauX1pQPnn8qcKwtRZEk+0iiCZSu0rBILNCVAQMArhkv7ejspGavb
	19wBxU8Sp4vl0xn1FG1jZFSx0CeXB0Ose6Dl/Qpd5b+s3JHRGo35vCSS90lGCOUVxqtA3A19kcW
	eXmrOKh9Xt9vm1C4T9ZkJLVBaBuVboDhNhl4wi4A9/AKrf3tJB9tnwO+VvLLUE/sruDg==
X-Received: by 2002:a05:6402:e0c:b0:698:be4d:ca2a with SMTP id
 4fb4d7f45d1cf-6a034a398cfmr4241255a12.15.1785349107364; Wed, 29 Jul 2026
 11:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716205811.800920-1-rosenp@gmail.com> <g3gtckpqgacw44jqqb5hb3oejpelxvbba47tdwsvksxbbskygp@mcwtsbypoyar>
In-Reply-To: <g3gtckpqgacw44jqqb5hb3oejpelxvbba47tdwsvksxbbskygp@mcwtsbypoyar>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 29 Jul 2026 11:18:15 -0700
X-Gm-Features: AUfX_mxrjUfVZ84R9XbJRtIPW_yLO3WV_Dd3HDwSinvRF3cFNjojFlllhS1HjGw
Message-ID: <CAKxU2N_f1nN4Oo94V9MY6Q-wp66j=3kodfMs0BeXVGB9XivvNA@mail.gmail.com>
Subject: Re: [PATCHv2] PCI: xilinx: use fwnode_irq_get() for INTx IRQ lookup
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Michal Simek <michal.simek@amd.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:00=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Thu, Jul 16, 2026 at 01:58:11PM -0700, Rosen Penev wrote:
> > Replace irq_of_parse_and_map() with fwnode_irq_get(dev_fwnode(dev), 0)
> > in xilinx_pcie_parse_dt(). For an OF-backed device this is equivalent t=
o
> > the previous call, but uses the generic firmware-node API.
> >
>
> What is the benefit of using fwnode API for OF only driver?
I get conflicting information. Apparently of_irq_get needs a call to
irq_dispose_mapping but fwnode_irq_get does not. irq_of_parse_and_map
definitely does.
>
> - Mani
>
> > Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ =
or
> > a negative errno and never 0 (it rewrites 0 to -EINVAL). Store the resu=
lt
> > in an int and check for irq < 0, returning the error (including
> > -EPROBE_DEFER). This also adds the error handling the previous code
> > lacked, where irq_of_parse_and_map() failures were passed straight into
> > devm_request_irq().
> >
> > Built for ARM (multi_v7_defconfig + CONFIG_PCIE_XILINX) with LLVM=3D1;
> > drivers/pci/controller/pcie-xilinx.o compiles cleanly.
> >
> > Assisted-by: opencode:hy3-free
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: use dev_err_probe to handle EPROBE_DEFER.
> >  drivers/pci/controller/pcie-xilinx.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/control=
ler/pcie-xilinx.c
> > index 4aa139abac16..58532296182f 100644
> > --- a/drivers/pci/controller/pcie-xilinx.c
> > +++ b/drivers/pci/controller/pcie-xilinx.c
> > @@ -20,10 +20,10 @@
> >  #include <linux/of_address.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_platform.h>
> > -#include <linux/of_irq.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-ecam.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >
> >  #include "../pci.h"
> >
> > @@ -535,7 +535,7 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie =
*pcie)
> >       struct device *dev =3D pcie->dev;
> >       struct device_node *node =3D dev->of_node;
> >       struct resource regs;
> > -     unsigned int irq;
> > +     int irq;
> >       int err;
> >
> >       err =3D of_address_to_resource(node, 0, &regs);
> > @@ -548,7 +548,10 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie=
 *pcie)
> >       if (IS_ERR(pcie->reg_base))
> >               return PTR_ERR(pcie->reg_base);
> >
> > -     irq =3D irq_of_parse_and_map(node, 0);
> > +     irq =3D fwnode_irq_get(dev_fwnode(dev), 0);
> > +     if (irq < 0)
> > +             return irq;
> > +
> >       err =3D devm_request_irq(dev, irq, xilinx_pcie_intr_handler,
> >                              IRQF_SHARED | IRQF_NO_THREAD,
> >                              "xilinx-pcie", pcie);
> > @@ -585,10 +588,8 @@ static int xilinx_pcie_probe(struct platform_devic=
e *pdev)
> >       pcie->dev =3D dev;
> >
> >       err =3D xilinx_pcie_parse_dt(pcie);
> > -     if (err) {
> > -             dev_err(dev, "Parsing DT failed\n");
> > -             return err;
> > -     }
> > +     if (err)
> > +             return dev_err_probe(dev, err, "Parsing DT failed\n");
> >
> >       xilinx_pcie_init_port(pcie);
> >
> > --
> > 2.55.0
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
