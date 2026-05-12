Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBC2EB5A6
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618347; cv=pass; b=jZmOqsTxcIxAtggwaEkPs27ZlQaL1ALZSnxlAP7O2t5ghVs6u+vcv6UD+uf+eT2Qp0xn3wxWX9vMdWDwgmwqqIWj3G497RtGVsWelVhfW/03F7QE3qMc5+ki9RbHA3dv4Gh35gWlDx72QrZDGSgcAm0MKdKLrwierKc2AUnkx2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618347; c=relaxed/simple;
	bh=zBiVLUnLg55g+8umYtETpbTrhNPTIkasp6hQef2Bu40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHt//77xJX0Fh6lNKqMcn9Urks58ePEO63tBb1efoR6QaKQdLb4d//LQJAkZRuukZkXvEIJ6R7kn69CXRvFr/ssmuL7u3SNCiIT+kIrKq/2CSwhElW279FlJjIcJcEXmZeBTfAYumUzpqbozt2M/i3A79Bg7UnewdW8RZyuWdiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5zcGatA; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5zcGatA"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd11a3729e8so352068666b.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 13:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778618344; cv=none;
        d=google.com; s=arc-20240605;
        b=DZ+DrOulw/Fr2ZfpLB2iJTS+jQZQF0Pih4wUogLddE8eNS7krbkiQ/05JWmNrKXcdL
         LMDLGVYFiTmK4AL96RgIP1MAPyUIc+heCvDfUs5MVCQAawG/7Fa5Iw3MNFbQTkHXUClJ
         YVO1ZyjHnfK/lIxxVbHR6saiMDn+NqfFS09/NMI0iQqIDaebhswoeqMpOLl1gKFk4llk
         9rAtzaiwIncQ7EPDDl0YeXRH0D0rU8RmEOEq5vobwAlVmCAc9N6ymsoX3Jt9wnZHKBAP
         bMXx/iEDiJSZVMYnBftOhvTPHX5HUzL+O9CHPPWa3JifgrnXcP4tbV0Jg9hfc05P+VCN
         ulxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=llWupUFSzskJD5hTZJkuiFFKoMSFShu4eCtfvOZTUUM=;
        fh=EuTCWd/h7j6tmaSWkQYHhqkBwLXz5T5PUhE/Z5NZo0Y=;
        b=KJ8GHEj3GDnd5HmgU8FGhUYcqorkbNC+QqSvdZzcWAxCJMtiby+gFJbcmKSToCm95/
         LTwuq2XuExRNsH7DYpZn6tO7L/5UzpccOMxc/yDzSXnesuxkCVyyHI4xgtxUPXfEBtUC
         0VW0HvfdMPFwuudEyk56KOdtyKxnT8BatqJyq0O3Q5mkZQ0Nv07ggUfQMZ/F+5YxjZyE
         bjzVCylOVhI0XLe74p+C8DZbz6m5vN2YNZk56yBqgPmi5Y61j3c33e6vrfdovKP2PhJz
         MN1DtsCRqQcC262lXYEQ9zRKHw2/dboh4YRRFmY4pZP5ICoy9//2+FfIU0LjaNhHt09f
         GGGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778618344; x=1779223144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llWupUFSzskJD5hTZJkuiFFKoMSFShu4eCtfvOZTUUM=;
        b=D5zcGatAgroGCV6AR8HGSePq6GMQ1csqfV5weBDFe8Rya1T/CPWF7dsBb4ZjE6808s
         DGLZYfEE1FjyQR1vIDD7R5c6l0eO7+P+6gYiuAb7+pFgczwF6O7bEsUprL9SwpQOPu4/
         274ALckdTR29bq9AWUePO/psC3b1Ir+yWGWCHUAAKldpSZnEXJcLetIHw8o6qN60cwUm
         wJgzgam4+sUziwwcSBKe+vODO3N4ezhVU/6FNHvZh9XKT81BqsGg4JYXA8JZ7VB3bFEp
         oEAafr9D4QLTGP+aeQXdJ1n13ErgQSNXnsxo7/FzQtQQn9vaOHIn7Q0AwQq+uMADY50R
         z7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618344; x=1779223144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=llWupUFSzskJD5hTZJkuiFFKoMSFShu4eCtfvOZTUUM=;
        b=iHp4T7AjnBmxVQmwV+0oKhS55AxkxanmJmD3hXGqXo04UOYaSQs27EaX/SLb8xOq+p
         tLb8osKwFopxgTsZrb9xYaiPPZC6MFyXEeF5fTykBYSb/AdMYN3OjzGuzL1irmvO+h8q
         /ikX2xLQhRZghVsz+5LXKn5be/LfBzAVWvpiqXJhTTsb9o40tqRsYa+Awo7T4jzSRZoT
         DMI3A/KQyBmUr2m2ZL3+1XlIMX9MUe+Ma1JqJFaIoeXTnyIcyItaWnA8Rp9cWgtQSEUB
         nx4bU7wwgIn6N5n6PekcA6kFzNXiV3qwq84UOLs150VBBthLJL9SmCh6rmL56KfvCV0+
         aLMg==
X-Gm-Message-State: AOJu0Ywr0Mv5e6/cRhHn8xo1HYYkOI7En/LUUzRDak1+226wULrT/ZdH
	2XU5NEWaMq+UIiID8QnaifA3YkkMIuDhNwBkEbDCnN5+8WJA3E99nd7+rcgpZAwvrnw/mHaBSrG
	WT+6oK3WUbs3nXHAaII+GDxffYWjqaZJ/C7ZJ
X-Gm-Gg: Acq92OHapPC6wJfK/SPsxDDlFflCrssRQm+yt9Nukdj317l7/aPnbvFyi7HoXOOD2eb
	KZuUOTGY4VAfvWn8mugm4Tj2vAhWpJOGsbb4IXmEGqG1nHM405pJ5FmZIxdzT02ph4c4nPdgNRD
	mt+bu95ubEgh5+E8gpPQhamai8GBoZT06+psCrOSbH1zRz4YigLDyMmu3hMfBu7d6kS3BzeUt/f
	lNJT/APypVMYyvkaMEKAysNCGsYkR3SqJUR0jp+T7Yp81tjZMaUzqPsp8UFpUHBcFjmptz1tqgE
	7J65szedtqZ4GQqDpdr5KV7WYqWUfCeH4ohTKQYaVnZ8VTqDi1usTVpjOPweyzoHoPIqYu/Ec6r
	DG3pGzH0freHE+YY1ZI8xmjdDNMO2FoI8OLcdBA0KxJ5SgPUbUKO5xeCmfw==
X-Received: by 2002:a17:907:d20b:b0:bcb:9366:4cfb with SMTP id
 a640c23a62f3a-bd3bf77975dmr24035166b.15.1778618343661; Tue, 12 May 2026
 13:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411043051.174309-1-rosenp@gmail.com> <7sibn6mlvuozzjuggu773w2eqjyb7dz34gkdrx7tzxyjbygfpx@hiqzen36nknm>
In-Reply-To: <7sibn6mlvuozzjuggu773w2eqjyb7dz34gkdrx7tzxyjbygfpx@hiqzen36nknm>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 12 May 2026 13:38:52 -0700
X-Gm-Features: AVHnY4KsWYZ6_zXcVofKJP8g2qSPNYlnXAWpzEkGByljG0jrlubk0bgxqgbSAPo
Message-ID: <CAKxU2N_WpHOLPyN6AfnK0CyoU1dkBsGivRvVZt1fnKMSpc3aVA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: allocate ports with pcie struct
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:29=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Apr 10, 2026 at 09:30:51PM -0700, Rosen Penev wrote:
> > Use a flexible array member to combine allocations and simplify
> > slightly.
> >
> > Add __counted_by for extra runtime analysis.
> >
> > Needed to move mvebu_pcie struct below others as flexible array members
> > require full definitions.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 33 ++++++++++++------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controlle=
r/pci-mvebu.c
> > index a72aa57591c0..dea50f6e88be 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -78,18 +78,6 @@
> >  #define PCIE_DEBUG_CTRL         0x1a60
> >  #define  PCIE_DEBUG_SOFT_RESET               BIT(20)
> >
> > -struct mvebu_pcie_port;
> > -
> > -/* Structure representing all PCIe interfaces */
> > -struct mvebu_pcie {
> > -     struct platform_device *pdev;
> > -     struct mvebu_pcie_port *ports;
> > -     struct resource io;
> > -     struct resource realio;
> > -     struct resource mem;
> > -     int nports;
> > -};
> > -
> >  struct mvebu_pcie_window {
> >       phys_addr_t base;
> >       phys_addr_t remap;
> > @@ -125,6 +113,16 @@ struct mvebu_pcie_port {
> >       int intx_irq;
> >  };
> >
> > +/* Structure representing all PCIe interfaces */
> > +struct mvebu_pcie {
> > +     struct platform_device *pdev;
> > +     struct resource io;
> > +     struct resource realio;
> > +     struct resource mem;
> > +     int nports;
> > +     struct mvebu_pcie_port ports[] __counted_by(nports);
> > +};
> > +
> >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val,=
 u32 reg)
> >  {
> >       writel(val, port->base + reg);
> > @@ -1455,11 +1453,13 @@ static int mvebu_pcie_probe(struct platform_dev=
ice *pdev)
> >       struct device_node *child;
> >       int num, i, ret;
> >
> > -     bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pc=
ie));
> > +     num =3D of_get_available_child_count(np);
> > +     bridge =3D devm_pci_alloc_host_bridge(dev, struct_size(pcie, port=
s, num));
> >       if (!bridge)
> >               return -ENOMEM;
> >
> >       pcie =3D pci_host_bridge_priv(bridge);
> > +     pcie->nports =3D num;
> >       pcie->pdev =3D pdev;
> >       platform_set_drvdata(pdev, pcie);
> >
> > @@ -1467,12 +1467,6 @@ static int mvebu_pcie_probe(struct platform_devi=
ce *pdev)
> >       if (ret)
> >               return ret;
> >
> > -     num =3D of_get_available_child_count(np);
> > -
> > -     pcie->ports =3D devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_=
KERNEL);
> > -     if (!pcie->ports)
> > -             return -ENOMEM;
> > -
> >       i =3D 0;
> >       for_each_available_child_of_node(np, child) {
> >               struct mvebu_pcie_port *port =3D &pcie->ports[i];
> > @@ -1488,7 +1482,6 @@ static int mvebu_pcie_probe(struct platform_devic=
e *pdev)
> >               port->dn =3D child;
> >               i++;
> >       }
> > -     pcie->nports =3D i;
>
> So now, nports stays with of_get_available_child_count()?
yes.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
