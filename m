Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9BC2FF
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782019821; cv=pass; b=vBiyQRVHyjz/PHavjpcyX+XSbVDnOyJjJXGuzz3jH1RbgKmoJa07pL76bpK2t2Ntr0MMLjzn422qgs0gyC/rNFl+p+VzkrHUHZrnQUcDQcgD1EeOHjkUlflU0dWizr6pw9wW+Zffxw68CwJ5OREvsnanig9/1sk2TdkSXGMf4pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782019821; c=relaxed/simple;
	bh=YAtxztktHol+NWkRQ3GQNrVaqDgxEl5tO/OrMZmUCcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki6dnsH4ruqYUj+qXI0MP86E/fi8/K+fHjjbWsMRANr3vGpIbVORhC/VOyN6BLi9U2er1yFs+WG8uy2K6IRQAA3yaLqOZi9dZSLdh7n6tweNV7mtwKAFi2DSG7FJQoAIQI5Yeg8DeUG6Ba9qd0232VnOAsz5SdWDii7g09BbX1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVpLluPP; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVpLluPP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6977dc206afso1517182a12.1
        for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 22:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782019819; cv=none;
        d=google.com; s=arc-20240605;
        b=T2fWTjlvYbKhiMc12hv94zWkDERB/R6uXGyumuYo0U+oOzMNmGiz+gMovXwbNU8hrr
         0cl9l8uAGzJvVFzsZnytt2elC9ebmPbUicGtXaP87jyrgmdU63P22sa8PN4UdlLBVnDg
         otg3RUiouxD5TgREORVnRA9M4lc+5Qq0Yl8C9FrEK+OaoNWvigIVXQdWfbqDEW88xZW3
         zEkAHbigo6zn8CGPfBNdv6G1iKNa14GzLo6H0kkE9Xix8vV/i7QVXR8Cu7oIMvYbz2oe
         ccpaPtf05DOXr8U6N4gSbMjhou5tscPaejEDjIyqtCqKU6s52FpHTxixDy/isvKyX1F0
         djBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmPSXJguXWQ/tlLldwXhVLCtaD8MB9GAT4fB3JYPsUA=;
        fh=EuTCWd/h7j6tmaSWkQYHhqkBwLXz5T5PUhE/Z5NZo0Y=;
        b=iMzhfRiQFhHR2Sns+deNdORrQnVGFteCFLoKtgvAH1f5QwxI2uI7rX8C0jMPGrFfeL
         xmPwGOfCKgzzYdBomBfGQvcNRmFXIFZ2PWcW1eH/IMzB+pDZPJmbMOKzAbvO+HISZF7w
         sR/BNp2y0VOzfPDEaJozopE9+X+5PHW8aEgzvn1m3VGSfxoqvmpGq2coySKkY9j/CaXJ
         l1DuaDagzgitgUJ4KPQa6r1vt5fx52qYyt4L8FEoAnYFqtVCR1MbFJ/FbX+Lobpv4f3a
         v0/NOkAnHyUdgfwUX2slnrEQ/SpBRwntZaFVCxYklJccUg26R3v3QWkzWKlROaIWkMld
         qH+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782019819; x=1782624619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmPSXJguXWQ/tlLldwXhVLCtaD8MB9GAT4fB3JYPsUA=;
        b=rVpLluPPd+8ELoKP3BJJAQx2CL3HxhjsDASl61j6k5qe28D24tMNS+W3QEM66+hnGa
         JOLhANYjO7UmQwYu5AjMsEDC7+kZI52fZBV80b30b3IbhEXAEP5WAtXdek9+RtdpjrY0
         sPFC2089Q7CCflgQROkO2z0fKK5TUs73SM2e2/+705YCLzGNqyqZ4KGGx5ZJYTlBZMOS
         UkLcrETCwLkVtGKfuUKznZKsQgIzULH96lmjiWpzhiw6JJnToBe1ZlVXGEfP6HsOPFVi
         DvJsuXWj0di4ksagmRHfuHpEuOJ3CQUy5dI6TqBLQRi3WiHWJ6j5t+KvscsuiivhiWvm
         iboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782019819; x=1782624619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmPSXJguXWQ/tlLldwXhVLCtaD8MB9GAT4fB3JYPsUA=;
        b=C/U07NSACgH41q3TO0pDiff6f9dVMP4HOTX2JsSv2BshoKJvxH9Ipq8y4wTLczQqLv
         /E6vIKdnASa07tP4P47Pgdw1JYnqq8IlDe0hLDGI0pMvM6/yWpZkUNXZgI2svzuOfqH2
         cpI9ijGktMDrb7tPxFbtpD4gb2iokTy/rs1e5B9QhW+S9cI1V/+bVci/U400tvAhzj2J
         nHV50XKd8hL5JkB01ham8PTElRRrJyWLuSYpDJ6IU15WxrXPmPR+X3/8JeEfWaggu9TJ
         nnHKBo1KkWc9+K++rNnXV94+GlTtYU8wQP+4vwK3gFbBgd1ODvMlyO82oI02NENbLfpL
         NF4w==
X-Gm-Message-State: AOJu0Yz0RjC74ZMaJnE3MnqwvRWLx/Y5If43lJm7Hw1WpOlrRRRo8xTP
	+pp1zAwALIrJtzQM6/WyLAjPkMcsr5z1org8/K0lzEOqu1P9lN+KoMa38oW8xmLxS30kAsXfSsl
	xWiYGsWNWUnvCA17kP8NU+IyztsPajXv/XEIc
X-Gm-Gg: AfdE7cnHZMm2my3Wgj8YFCT+P55wAzVjzjUyNb5AQsWKqDz0opNc31/0hdfBuvpy4hv
	BIrFrAlLKXv6yQ/+JTwzISb7fJyzB7H+/uCh7BWObVXtLOudmHZj4H4bcQ+VTAectnh1rIF1FKC
	BZg3+0wEnDgS0FgZTc98UtSlXanTXJ9Uv8fEtXbrT29B9XEn211DOm4RzS37aVzYbu+o/eVPFpS
	CnKs+qCCguUgdGdOC4RQ2S4hOlmwvm8M9A3aBY27TUTxNIw5SWLwRZgpRQpgaft2Bk5wE+JaydQ
	WRGAP+AjlHiV5SFPOU/evOOpStDtEFsWYimaAmnXDQwBijsZDEaIGEGjvDC+bPFa4BbMnH4JKB1
	pVnQYub1fsIYkLO4rOZcJj9DeI2yROkohTiqInMFVl4Yj3qPmUJrtE+SDNQ==
X-Received: by 2002:a05:6402:3883:b0:695:bea9:7e31 with SMTP id
 4fb4d7f45d1cf-696d788231dmr4588794a12.0.1782019818544; Sat, 20 Jun 2026
 22:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411043051.174309-1-rosenp@gmail.com> <7sibn6mlvuozzjuggu773w2eqjyb7dz34gkdrx7tzxyjbygfpx@hiqzen36nknm>
 <CAKxU2N_WpHOLPyN6AfnK0CyoU1dkBsGivRvVZt1fnKMSpc3aVA@mail.gmail.com> <qb6nxxkowjgrsscddbmorh2z27uwwtceohokjtathytzdvqe75@apahvpqwrht2>
In-Reply-To: <qb6nxxkowjgrsscddbmorh2z27uwwtceohokjtathytzdvqe75@apahvpqwrht2>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 20 Jun 2026 22:30:06 -0700
X-Gm-Features: AVVi8CcVh1hO0ymp98FfmFfRv1xuTMEmwfaoq_klD0UHstTeyN1NoA3D-OCSbkM
Message-ID: <CAKxU2N8ZNhCSsCuDDuef=XSUq5qShpa4WqAEE82Ugj5FFt6ung@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: allocate ports with pcie struct
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:27=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> On Tue, May 12, 2026 at 01:38:52PM -0700, Rosen Penev wrote:
> > On Tue, May 12, 2026 at 4:29=E2=80=AFAM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Fri, Apr 10, 2026 at 09:30:51PM -0700, Rosen Penev wrote:
> > > > Use a flexible array member to combine allocations and simplify
> > > > slightly.
> > > >
> > > > Add __counted_by for extra runtime analysis.
> > > >
> > > > Needed to move mvebu_pcie struct below others as flexible array mem=
bers
> > > > require full definitions.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/pci/controller/pci-mvebu.c | 33 ++++++++++++--------------=
----
> > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/contr=
oller/pci-mvebu.c
> > > > index a72aa57591c0..dea50f6e88be 100644
> > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > @@ -78,18 +78,6 @@
> > > >  #define PCIE_DEBUG_CTRL         0x1a60
> > > >  #define  PCIE_DEBUG_SOFT_RESET               BIT(20)
> > > >
> > > > -struct mvebu_pcie_port;
> > > > -
> > > > -/* Structure representing all PCIe interfaces */
> > > > -struct mvebu_pcie {
> > > > -     struct platform_device *pdev;
> > > > -     struct mvebu_pcie_port *ports;
> > > > -     struct resource io;
> > > > -     struct resource realio;
> > > > -     struct resource mem;
> > > > -     int nports;
> > > > -};
> > > > -
> > > >  struct mvebu_pcie_window {
> > > >       phys_addr_t base;
> > > >       phys_addr_t remap;
> > > > @@ -125,6 +113,16 @@ struct mvebu_pcie_port {
> > > >       int intx_irq;
> > > >  };
> > > >
> > > > +/* Structure representing all PCIe interfaces */
> > > > +struct mvebu_pcie {
> > > > +     struct platform_device *pdev;
> > > > +     struct resource io;
> > > > +     struct resource realio;
> > > > +     struct resource mem;
> > > > +     int nports;
> > > > +     struct mvebu_pcie_port ports[] __counted_by(nports);
> > > > +};
> > > > +
> > > >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 =
val, u32 reg)
> > > >  {
> > > >       writel(val, port->base + reg);
> > > > @@ -1455,11 +1453,13 @@ static int mvebu_pcie_probe(struct platform=
_device *pdev)
> > > >       struct device_node *child;
> > > >       int num, i, ret;
> > > >
> > > > -     bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(struct mveb=
u_pcie));
> > > > +     num =3D of_get_available_child_count(np);
> > > > +     bridge =3D devm_pci_alloc_host_bridge(dev, struct_size(pcie, =
ports, num));
> > > >       if (!bridge)
> > > >               return -ENOMEM;
> > > >
> > > >       pcie =3D pci_host_bridge_priv(bridge);
> > > > +     pcie->nports =3D num;
> > > >       pcie->pdev =3D pdev;
> > > >       platform_set_drvdata(pdev, pcie);
> > > >
> > > > @@ -1467,12 +1467,6 @@ static int mvebu_pcie_probe(struct platform_=
device *pdev)
> > > >       if (ret)
> > > >               return ret;
> > > >
> > > > -     num =3D of_get_available_child_count(np);
> > > > -
> > > > -     pcie->ports =3D devm_kcalloc(dev, num, sizeof(*pcie->ports), =
GFP_KERNEL);
> > > > -     if (!pcie->ports)
> > > > -             return -ENOMEM;
> > > > -
> > > >       i =3D 0;
> > > >       for_each_available_child_of_node(np, child) {
> > > >               struct mvebu_pcie_port *port =3D &pcie->ports[i];
> > > > @@ -1488,7 +1482,6 @@ static int mvebu_pcie_probe(struct platform_d=
evice *pdev)
> > > >               port->dn =3D child;
> > > >               i++;
> > > >       }
> > > > -     pcie->nports =3D i;
> > >
> > > So now, nports stays with of_get_available_child_count()?
> > yes.
>
> But do you really want to configure disabled ports as well? I wouldn't wa=
nt to
> do that.
Wait this calls of_get_available_child_count and
for_each_available_child_of_node. disabled nodes are not handled.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
