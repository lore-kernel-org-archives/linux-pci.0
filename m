Received: from mail-vk1-f194.google.com (mail-vk1-f194.google.com [209.85.221.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8770330F92D
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769785712; cv=none; b=j2FLwbj/3fZWmoxU5QHqVZxgp/1Cx6r8s0vOTtvMfMQlnuG+S/yn9OCp4REiT6QzIWEzboh0+Tttw1sNMKM45lN5G2tJX5Ba5ZrtZ6B85KaTiOkKOafaDTt94tytsJBOhwiMR7sxT1KIXcqw26ALjnCDEGTSRn5n+GtBFSGNLtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769785712; c=relaxed/simple;
	bh=ixVqgiNKWlgJlcIKmTWTDEQrvH4ksjQzpSZ+bGRd1qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XamgeeXwpM2LW9BHFMzOfoNgt21x5sZY752SNgUBcGWRj+kUqNXpr/2WySdNtXx2uhcjSAMHpe1YeBeWVWZoCYCLOQscTCZ0J2Pc0VKLcHWXgeBFbzsREMfqGa8aA6v6uBrRPJ1pEoTDKbv/1xoxj+yC4X7LCe8kNTk3lkxFaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f194.google.com with SMTP id 71dfb90a1353d-5664340e14fso599339e0c.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 07:08:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769785709; x=1770390509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGkx6eA6mbqfFwtrPFINFpkOa49uJ1Td/6euugAjzpQ=;
        b=ibc+Ec+pVaunNk/RW3GGWGAtqI563XwuSZgarL4iOaRK+6qUnhxPbboHIANdYsGmTM
         XpM3G1yqxKOObl03Eie8QvXZ919HdChgpPX/4wGk13+bwbRMwnBE/NdqdbrG2p/QrhS6
         +PGn9Q5o43nWLL649g9nPWqkzT3JRI4xFuf8UZxkhmFEM5aD0VBE6xn+ZqDiW+tv5LIz
         m3pNbJxWMKtHormbHz6w4jJMH3/6lxEDrNG2Vs2zxtQMjF23ISxV/foU61wSYECo4glO
         TzeFEy/T84mPZ/IApGslz3hqXySupLxczApRUXPV26MnD4CW4pgEW06I05zxvIzrwD9x
         00xA==
X-Forwarded-Encrypted: i=1; AJvYcCVw7uSz6MKRJct6f/CcK9R9LFDZfej+2f0VAvDmfocwNVpobT9K6nvTRmZPBTYLRN//jzdIBxqf3Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAG/HONriPsYdEvbliEggUfGrdcE+Rd5azFmWlJeyDZ+Rfs4uv
	b4i8CzYeR1naMrdoewgGTAAIyuF8xnwFuJWPOkUwqTVrwSmlOhwbpJEY/QSnqPuNW8Q=
X-Gm-Gg: AZuq6aJlrDzy4Jfz0ecbeXPJeP/L9kQOJ7h2vHeMUQ3zxx1R2MdP2YXPyhn2zztLmnM
	iIgwQFDW7MUOZzD1cwla2uqZG6YFX0++xQyQPaW7UwY+aII4YbBedBAhor9J+tn9t0Ol3q9ohCf
	hVZokDts3jDKYo4c0/M33NJkRVgkCNNry0BC2/DYOTc8UR+yue8sDelqp7yArVJH4jKQENkRRn3
	geSSZfN5TlxkjHSzc/UQjI9UiRn8YzQOFb+rKTYnpTMZHoB2J4Mwl39MtPUXLwJYNvs81mE1zVs
	R21D5gRnSJHMhJ/Uja/2ODdl6MwTxUz/PIux0Z8W4L9QQGqtdrUx4Pou77u2d9uaW4mO9meUeIn
	2yNQipSPmDn6amJTBMWYSP34g796Vu00BtqUtdcwdDRvK7X4H2+NwcXuCJQ4mBNRWXhzvXNnTrx
	hv79oSz9nbs1qjVaAviTNuqACB/2jNilO8SnPNRepvWBdNhcSD
X-Received: by 2002:a05:6122:490c:b0:55f:f2f3:699b with SMTP id 71dfb90a1353d-566a00bf8fcmr930423e0c.11.1769785709056;
        Fri, 30 Jan 2026 07:08:29 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9489e3bfa6csm85858241.1.2026.01.30.07.08.27
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 07:08:28 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5f53021703aso707654137.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 07:08:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLU5fui84015kSL5LVK8Nkzrd49oeoNHgg+9lcCdchjuyA8ON7k9VnNOsIFttuAHZTYMmCKGkP5to=@vger.kernel.org
X-Received: by 2002:a05:6102:a4b:b0:5f5:7723:28ee with SMTP id
 ada2fe7eead31-5f8e249d107mr1020998137.11.1769785707020; Fri, 30 Jan 2026
 07:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129214130.16067-1-john.madieu.xa@bp.renesas.com>
 <20260129214130.16067-11-john.madieu.xa@bp.renesas.com> <e53b50e2-72dc-47c3-be52-cefa593dd30a@tuxon.dev>
In-Reply-To: <e53b50e2-72dc-47c3-be52-cefa593dd30a@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Jan 2026 16:08:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXiQeMgJhs9QvEcBNeGRf85Fi0w-WODyaGBDrOdZeSgPg@mail.gmail.com>
X-Gm-Features: AZwV_Qjr2oO3yVh97tvIdXRZ_5OwPpjHqcx_MNr99RIUg39FgQPjshWvCCZ7iVo
Message-ID: <CAMuHMdXiQeMgJhs9QvEcBNeGRf85Fi0w-WODyaGBDrOdZeSgPg@mail.gmail.com>
Subject: Re: [PATCH v4 10/15] PCI: rzg3s-host: Explicitly set class code for
 RZ/G3E compatibility
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, claudiu.beznea.uj@bp.renesas.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	geert+renesas@glider.be, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 14:55, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 1/29/26 23:41, John Madieu wrote:
> > Program the class code register explicitly during PCIe configuration
> > initialization. RZ/G3E requires this register to be set, while RZ/G3S
> > has these values as hardware defaults.
> >
> > This configuration is harmless for RZ/G3S where these match the hardware
> > defaults, and necessary for RZ/G3E to properly identify the device as a
> > PCI bridge.
> >
> > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > @@ -1054,6 +1054,7 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
> >   static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
> >   {
> >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
> > +     u32 mask = GENMASK(31, 8);
> >       struct resource_entry *ft;
> >       struct resource *bus;
> >       u8 subordinate_bus;
> > @@ -1077,6 +1078,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
> >       writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00L);
> >       writel_relaxed(0xffffffff, host->pcie + RZG3S_PCI_CFG_BARMSK00U);
> >
> > +     /*
> > +      * Explicitly program class code. RZ/G3E requires this configuration.
> > +      * Harmless for RZ/G3S where this matches the hardware default.
> > +      */
> > +     rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
> > +                            FIELD_PREP(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
>
> According to kernel test robot report on v1 this throws a compilation warning:

Yeah, in case of a non-const mask, you must use field_prep() instead.

> https://lore.kernel.org/all/202601152104.pV9uMS76-lkp@intel.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
