Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89CC38947F
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036733; cv=none; b=m42uuziJN4K6a7Bx3ZDbbFcnKEv/FsON4gP3hZEXulCYkIFrmm9W9C7sK1wXVXvcLftO+F5UWBatNSGsEiS764rwpQd9gTbc5jWek7SAxAZzypv288qWegxH8ediNMVFdOGaybriPv6ccgC4dAoIX0nNKuHGjM0936HizH5g538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036733; c=relaxed/simple;
	bh=b4NZfzsXInAfqDzBfnXs78PKv4Oy3tSAAU8GhHt2f3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4wccdYE5RO1xB0QX97WAdCTe4WjQEUlGeTK2+2i3heUDl4mH2tFnKI/eKXSViUTZYiHotVWeQeUcgpWq/YLIK8meI2GIhX77ECdTohB7F3chc3Ocz57L7mAMhYW3r6mj4HDlyD8xrBgRZLrPphRBIA61DujbJjyFI5KksamyD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8201447e8cdso75188537b3.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 00:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036726; x=1787641526;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ELu0AhEyCl7g57UsYbLgfglrPLTlAwPkVEKgX34T5NE=;
        b=lrCvWRKJBspD6W62FqB0HvuX6ubMjVxNKRUeS0zLPF6HZrT6tfVkWTO7+dTqn3YV6e
         Zpt9SSRKZrG7Fg8yD1daEzSOvhdhTLKzOeMyekV0FOQXnys74U6DW5AASWrx7FDU10ru
         w0XyWkWX/Vp0sqvwTLfzjmzC0nqDa5VevD8fpGqwGM3Zn0+naTIazNTuBRZnW8I5lsZW
         Sipa1KZCGX6pSXD5UR6OqjpeaNWjddGICgC3zpRduzhEhT/TV2aEP+c3kOhj7UI5RxIb
         eOuRDsMKpj+mShPjJJwU0xQZCkZJhaDRQQcdK4dQjQMMOxbFReTMl4PfyHNA10Syw9u+
         LQGA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3HNzPQrnX+4vTj6AAbkPw29YSjY5UakLfV79qQgxhTizvtW02+3xKkKQrRkf5lxg+NNAKJ8Y5ufc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIfKOF9p9Tt0QLxSyAdmZ5Qdi0pB+vSiOuemoIGDVK/W/hgDh
	kf4vL93re0jWPKPX/BMmRV7SaWwTjI3JX8rGA3o/+a/n359ZJGqlbLCMxQWK7rI0
X-Gm-Gg: AR+sD11LiNq7n7JCeURW5jYEFgJb2opqqfI66iVXukJZiqkqr+N0dX8orfymCT6nBCU
	cr9zuvhT7DAbEbrlVfO3Y6S/BDTH9CJqghVHXoBmh+XKb/kcCnRN4j1t9jw7g2aN3Kcn88eVCHD
	gZJ9d2PcTRlHVuEbdUvYe7Q8B0Kw5nFpMzUdUZk38P+i3oQj4SJtHY9AphusJ8Ff7rUXK5h6rD8
	/j4r89qYplxMxneyKqJ9YruXvbi/keL7COOQYEvpFKiWzBgHGKQF4F0m/QAubGqKZe4Q64yQiUe
	59TxbMdS2be14GdNRfQ1VfdKEgI9vlrYpFl/gxp7bnEtarzbrDet3t9BAeowO34rmHwyPoZbagU
	ZTBamMouv03/MUpGUHTpdUYnFeGhtvQSTwYmXmApg+9v6YAaIRRxUEKeaQplx+q7WKLPH7hgY+4
	EE9dZtqyPV6RpmDveSJa5pbr0XFtNv4bjVmOVVAsTnGPQRc/n3D/wpHHssBh7CJIrmkRwEPXcHt
	FQhYjH6C2jsdSld3zBzmXog8oznLbhQ09Yz8fFw
X-Received: by 2002:a05:690c:998f:b0:821:1288:f820 with SMTP id 00721157ae682-8370dfb3afbmr114646997b3.4.1787036725899;
        Tue, 18 Aug 2026 00:05:25 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84068c24d45sm16809077b3.16.2026.08.18.00.05.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 00:05:25 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8201447e8cdso75188397b3.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 00:05:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro/QNJ84DnTtWYwXrOdUTyXWa5yZyQPNnvxAd9tl4cC19RnyZKkf+lk0ie0FaaEsU4D3xPSIt1NG50=@vger.kernel.org
X-Received: by 2002:a05:6102:1496:b0:738:9c30:2b7c with SMTP id
 ada2fe7eead31-76f2c541b8bmr7363952137.6.1787036286929; Mon, 17 Aug 2026
 23:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813091925.71363-1-marek.vasut+renesas@mailbox.org> <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
In-Reply-To: <h43onk4priskfkvdrheml4ttx2b7udavnulxvftj45midvcs3c@lec5rx7mrgys>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Aug 2026 08:57:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
X-Gm-Features: AcwNN1V_vBBvui0ICUc760n-rTYHtfhaEcvZ01hKtas0lQM66m-P4QIf_6RReAo
Message-ID: <CAMuHMdUAph2fbR94k8RDaAeVH=OTKWAWe1dJne9D-YbQQrYHsA@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Fix potential unclocked access in rcar_gen4_pcie_ep_deinit()
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Den-san,

On Tue, 18 Aug 2026 at 07:55, Koichiro Den <den@valinux.co.jp> wrote:
> On Thu, Aug 13, 2026 at 11:18:22AM +0200, Marek Vasut wrote:
> > Initialize PCIEDMAINTSTSEN in rcar_gen4_pcie_ep_pre_init() to 0,
> > and in case rcar_gen4_pcie_common_init() fails and the result
> > propagates to dw_pcie_ep_init(), the invoke common deinit instead
> > of endpoint deinit, because we are certain the PCIEDMAINTSTSEN
> > register is already 0 and the common deinit does not do any register
> > accesses.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> > --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> > @@ -487,6 +487,8 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> >       struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> >       int ret;
> >
> > +     writel(0, rcar->base + PCIEDMAINTSTSEN);
> > +
>
> 1. The new writel(0, PCIEDMAINTSTSEN) runs before clk_bulk_prepare_enable().
>    Is MSTP024 expected to be already released at this point? I added the quick
>    check like below on Spider, and confirmed that the clock was already enabled.
>
>    --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>    +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
>    @@ -9,6 +9,7 @@
>      */
>
>     #include <linux/delay.h>
>    +#include <linux/clk-provider.h>
>     #include <linux/firmware.h>
>     #include <linux/interrupt.h>
>     #include <linux/io.h>
>    @@ -487,6 +488,10 @@ static int rcar_gen4_pcie_ep_pre_init(struct dw_pcie_ep *ep)
>            struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
>            int ret;
>
>    +       if (__clk_is_enabled(dw->core_clks[DW_PCIE_CORE_CLK].clk))
>    +               dev_info(dw->dev,
>    +                        "PCIEC module clock was already enabled\n");
>    +
>            writel(0, rcar->base + PCIEDMAINTSTSEN);
>
>            ret = rcar_gen4_pcie_common_init(rcar);
>
>    If that is not guaranteed, wouldn't this write rely on firmware or some
>    earlier user leaving the module clock enabled?

The module clock is enabled through Runtime PM:

    rcar_gen4_pcie_probe
    -> rcar_gen4_pcie_prepare
            -> pm_runtime_resume_and_get

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
