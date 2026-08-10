Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA613348C7D
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343523; cv=pass; b=qPYL2AL7CH/9lk1y/fvX2w17ZbYEcRnzSIysG9hQfizcl61CN53m1xlVS/yZpgKcG7BUjN2GlZHEcQhhXXGSz8ITKktIYpGg4PNjoZ918EhrT4cAiWeyQHCVKhUDGiOpDLsLKKzA0UmaUdX2vPcOct/kDuPQBiAEusJbotMo78c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343523; c=relaxed/simple;
	bh=Glv+D9dOgkTlvAE3SHxcWgORV7c52cnKk4e/SQGvejo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eedQ16bWWataaKq4/DG1PhClTBRZlS1aAD+1BgHzfFWndViiFjRYboZPeU1qC6PqUetKa62I+Vc3rtNNJPzrJOO51zAh2oh43UX7QUYFbxltLhezra0RpB2pyJqLgR0rRsSm97retblZA3KegbQaY3u+ouXf6T8tccN3WkdYjAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChJ0lHdV; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChJ0lHdV"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980dc26022so14814405e9.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Aug 2026 23:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786343519; cv=none;
        d=google.com; s=arc-20260327;
        b=PlsidxfQVmUVo3p9hq2jzUvXEfbK4daDMOHBh7ir9NZZMAAkUjPiaNj1TTYEptEA/7
         nVYUYh4Hg3VQ1n2H81iTf+5S9SdS9EqUhSD5oun6yo6vGkYqBOwDViCH390zYVLCCkWv
         9qrViuicx6+pldTu5c4RaZ9G8Sv4eBanpTYFZbdO6krWYwwz8NPARgTHv14AS8LofC4M
         D+nE7eKJ9UE2dgtfTPAIzp4Jh0N7mL7z5vlHiMbWmlt/GvPF4o3PMNNcUKnUD2H7OMZt
         hYbeSF5JsPB5cZruy2ZashYS27XZaTOS2sVmDMBdAM5twXUYLlUPU/f2V7aV2SrWtH1F
         3MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3SjLv82lPKci1T9o7jRU252gydE3KzV/t6uQyPNLwxs=;
        fh=bQZVqukVRQ6wxwnouC8DOokHUDPufBMgmioR88mlNNE=;
        b=G+PixYYh1gV4dNzb4Dy95unnEQRqXdLlmUsauDk0a1W2KjdFiswcnZvqUIJeGwAoHw
         3D8TWHsQswJUDeOqI72MYjrtDG86lXocZoCYTm1Mbg8qc9BmELNA6U/h4W3jH6mTfJMx
         s8/WctKass3cw50V3xOaytNPleUIJl22lNQgNm6vZpNZEezVnStvH4O+mHasbSNf7Ko3
         fTwWRDO6Dkmi7+HGCzHEKZ8VzWRBOhZdiX7otyH3KCCcK16iuEcQCUV59ax+voPQG0qc
         HpoMEha8eFhKVUQIDYz8GGUmKhM3QS+uMVayC4mQ2jMtaIJHZGUkmgV6+69MjdhsOo64
         7AEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786343519; x=1786948319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3SjLv82lPKci1T9o7jRU252gydE3KzV/t6uQyPNLwxs=;
        b=ChJ0lHdVZCMAgx+GeMzYotT+NmeFPeY4xMkfbo7YfSYtOGRfYr8Tr9NJD9SzPvdRXm
         tMUBV066w6UUxCp+CHSP/FpaqkGNdB3NBbo3H7rNoAvGw3x05CSymEAs9PEVUtZxtE+R
         1aNWHHg6Z7Fl2vIprhVjpN+7CzIjC+BgNhNZg8UP+xKxSg8DOmcxowzLXH9QWeX1j3mk
         f6xhQdkHrq18yTSnxyAE5jWlfMgiC49r9WLdAORAvKYm73heG/X8KbAVhc3x7OE0pVq4
         OH7EPdtrY/vb1nI3yFtM1e3hlidqyuNth1C9+2X+EtVo5uPcR8ZnX/eJbqKL7rvFOpHF
         NJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786343519; x=1786948319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3SjLv82lPKci1T9o7jRU252gydE3KzV/t6uQyPNLwxs=;
        b=Xpx04nxRJeJ6lojsQvZ+kB4N2u505UK/mFLhHTLipvgsl5try51IWEkBHeVAow0pSB
         MxERfoVkbkjz7qYuwPJ3D9wQ359qNwIF3th9M0orPg12aeJRUDHFkDA3zl4kGhq8ivf/
         nupWcPEIHOLzSFxL6xbiGeH3zR4MwSdUwaWKpTwuFwzBfnI1eHP9JTvg+Cqdcy1mb8Ow
         1mEd/9saVxLgEed6qtelX92jr1gj7Hk9Sr4KO8OmRTywni1sZR/H12qwuCkbZKargQij
         EhkzLE2Pe0sOKZJlHdSzyRH6jEEUxvkJ5ZlR2WLMy0h+fppcrM9PTD7GdwhR6oJkdRSC
         LEeg==
X-Forwarded-Encrypted: i=1; AHgh+RrQkU+MhhWD8Jb7THvTZdZ29Z704EUYtA8AhpRnHOnoDmsW45eeqJFBPN6E+sTZ+45glm5//oAvacM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQF6Q5SVBJEl8GfJUXLLr0IZVMB243VNzjrgNGOQGUcgt1q1p/
	LCnJ0pMQYDsmWWvCfrJS9UUcmOS3jFMu+otg7mb/Jc11vOV2C4RwPK/HeiB8d5qJtCOvxMKrc1Z
	Uv0b3PXgcuTzqDnNFJ9nXayyroOzbfvc=
X-Gm-Gg: AR+sD13EuZyu1E6KBbqjITYHGS/u9SPVe/evJVRBDU5R/COqj/Zfn5YIW0NVvvCw66N
	LFw8qg6gfMA4ZX8vYJDt5C5doFvLrwTHxMAHUvmiun71DwF0Q62Nuiv8Ceh/3ByMULHSZhn+N3a
	nYz0sSytFSKy58bPoAJyW5XMhYZi5ZwCtIryt87CYRkR5RTx0teX7947z4CV4c/KnXz5bs4kJN5
	ZxxvUO9qslhuSUf38SkpW9Gif8gL2BWWpEg8wvZdbffxnw7vZPsBpL696wnPEonM5D2Cf9erBBk
	oAqlLIMzTaG9wRcPlf3vaqYm5b0CvXLPKDX7sR0hmKCf6ShegcqUkM+zQ8QgBieORbCiZMTFM7+
	XNjPqfPXGoGRIjKO6VKT6fY2oXSnYfX/lkSWs11X6VGxbn4uBepTMXUWwBzUOjN+77v820UyR1i
	4=
X-Received: by 2002:a05:600c:a20b:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-4994e7d5b82mr387146075e9.15.1786343518782; Sun, 09 Aug 2026
 23:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260727095843.116950-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <d1a5c1c4-4a9f-4dc7-b709-4f89a25ad4c9@tuxon.dev>
In-Reply-To: <d1a5c1c4-4a9f-4dc7-b709-4f89a25ad4c9@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 10 Aug 2026 07:31:32 +0100
X-Gm-Features: AUfX_mynmOOcMxUkeHfpvOzO_beN0LAWdFmV1ZYmmpijFA_DJ37tQAh5BAIv5NA
Message-ID: <CA+V-a8ujEokYydnADu3uxLxb0StKpB3sjsKPZqv=m4YF6Za6pA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: rzg3s: Fix IRQ domain initialization error handling
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Fri, Jul 31, 2026 at 5:02=E2=80=AFPM Claudiu Beznea <claudiu.beznea@tuxo=
n.dev> wrote:
>
> Hi, Prabhakar,
>
> On 7/27/26 12:58, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > rzg3s_pcie_init_irqdomain() installs chained handlers for the INTx
> > parent interrupts before creating the INTx irqdomain and initializing
> > MSI support.
> >
> > If any subsequent step fails, such as obtaining an INTx IRQ,
> > creating the irqdomain, or initializing MSI, the error path returns
> > without removing any chained handlers that were already installed.
> > This leaves stale handler and data pointers attached to the parent
> > interrupts.
> >
> > Fix the error path by unwinding the chained handler registration before
> > returning. Also clear the chained handlers during
> > rzg3s_pcie_teardown_irqdomain() so that teardown fully mirrors the
> > initialization sequence.
> >
> > Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Restricted the code to max 80 columns.
> > - Moved calling irq_domain_remove() under err_cleanup_intx label.
> > ---
> >   drivers/pci/controller/pcie-rzg3s-host.c | 49 +++++++++++++++++------=
-
> >   1 file changed, 36 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/con=
troller/pcie-rzg3s-host.c
> > index f51b5d7c1998..70f1faf7e422 100644
> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > @@ -1006,22 +1006,35 @@ static const struct irq_domain_ops rzg3s_pcie_i=
ntx_domain_ops =3D {
> >       .xlate =3D irq_domain_xlate_onetwocell,
> >   };
> >
> > +static void rzg3s_pcie_clear_intx_handlers(struct rzg3s_pcie_host *hos=
t,
> > +                                        int count)
> > +{
> > +     while (--count >=3D 0) {
> > +             irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
> > +                                              NULL);
> > +     }
> > +}
> > +
> >   static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
> >   {
> >       struct device *dev =3D host->dev;
> >       struct platform_device *pdev =3D to_platform_device(dev);
> > +     int i, ret;
> >
> > -     for (int i =3D 0; i < PCI_NUM_INTX; i++) {
> > +     for (i =3D 0; i < PCI_NUM_INTX; i++) {
> >               char irq_name[5] =3D {0};
> >               int irq;
> >
> >               scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + =
i);
> >
> >               irq =3D platform_get_irq_byname(pdev, irq_name);
> > -             if (irq < 0)
> > -                     return dev_err_probe(dev, irq,
> > -                                          "Failed to parse and map INT=
%c IRQ\n",
> > -                                          'A' + i);
> > +             if (irq < 0) {
> > +                     ret =3D irq;
> > +                     dev_err_probe(dev, ret,
> > +                                   "Failed to parse and map INT%c IRQ\=
n",
> > +                                   'A' + i);
> > +                     goto err_cleanup_intx;
> > +             }
> >
> >               host->intx_irqs[i] =3D irq;
> >               irq_set_chained_handler_and_data(irq,
> > @@ -1033,21 +1046,29 @@ static int rzg3s_pcie_init_irqdomain(struct rzg=
3s_pcie_host *host)
> >                                                    PCI_NUM_INTX,
> >                                                    &rzg3s_pcie_intx_dom=
ain_ops,
> >                                                    host);
> > -     if (!host->intx_domain)
> > -             return dev_err_probe(dev, -EINVAL,
> > -                                  "Failed to add irq domain for INTx I=
RQs\n");
> > +     if (!host->intx_domain) {
> > +             ret =3D -EINVAL;
> > +             dev_err_probe(dev, ret,
> > +                           "Failed to add irq domain for INTx IRQs\n")=
;
> > +             goto err_cleanup_intx;
> > +     }
> >       irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> >
> >       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > -             int ret =3D rzg3s_pcie_init_msi(host);
> > +             ret =3D rzg3s_pcie_init_msi(host);
> >
> > -             if (ret) {
> > -                     irq_domain_remove(host->intx_domain);
> > -                     return ret;
> > -             }
> > +             if (ret)
> > +                     goto err_cleanup_intx;
> >       }
> >
> >       return 0;
> > +
> > +err_cleanup_intx:
> > +     if (host->intx_domain)
> > +             irq_domain_remove(host->intx_domain);
> > +     rzg3s_pcie_clear_intx_handlers(host, i);
>
> If you have it like this it worth squashing these lines in the same funct=
ion, e.g.:
>
>         rzg3s_pcie_teardown_intx(host, i);
>
> defined something like:
Ok.

>
> void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
> {
>         if (host->intx_domain)
>                 irq_domain_remove(host->intx_domain);
>
This needs to be done after the handler has been set to NULL as the
handler does use intx_domain (pointed by Sashiko).

>
>         while (--count >=3D 0) {
>                 irq_set_chained_handler_and_data(host->intx_irqs[count], =
NULL,
>                                                  NULL);
>         }
> }
>
> > +
> > +     return ret;
> >   }
> >
> >   static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *hos=
t)
> > @@ -1055,6 +1076,8 @@ static void rzg3s_pcie_teardown_irqdomain(struct =
rzg3s_pcie_host *host)
> >       if (IS_ENABLED(CONFIG_PCI_MSI))
> >               rzg3s_pcie_teardown_msi(host);
> >
> > +     rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
> > +
> >       irq_domain_remove(host->intx_domain);
>
> And use the same function here, replacing:
>
> -       rzg3s_pcie_clear_intx_handlers(host, PCI_NUM_INTX);
> -
> -       irq_domain_remove(host->intx_domain);
> +       rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
>
> Btw, the order b/w rzg3s_pcie_clear_intx_heandlers() and irq_domain_remov=
e() was
> revered here compared with the order from rzg3s_pcie_init_irqdomain().
I will do the below:

static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host,
                     int count)
{
    while (--count >=3D 0) {
        irq_set_chained_handler_and_data(host->intx_irqs[count], NULL,
                         NULL);
    }

    if (host->intx_domain)
        irq_domain_remove(host->intx_domain);
}

Cheers,
Prabhakar
