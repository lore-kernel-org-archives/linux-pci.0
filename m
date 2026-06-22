Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A330FC27
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140067; cv=pass; b=Zg2Ao8pZ3B7cTCZQkD1YYGwRrYRzpIA1UrBKKR/LTjuEIs/nV5APDXqg3kC+3QwVhNBCsC8WqFiFiMIAEhu4x8agBv7fQmK0JIK/wgIE0IbtnO8+qS5THQczSkprFt7iaxD6InEm1uU6UFoUGiTYi1u3+UgSQqP9oXClkqp/FOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140067; c=relaxed/simple;
	bh=U1089BIw7iIyDBnxBwST4w5ZSkTY2BwrC/I7xAP7GTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aP1f/bVq+Xe0VBvPPKt/RtD62bOpqpJlR8P/c4RYGb201Qdq+GPFtaiWkPD4RkT/5GGzwvLzGlC1LAktoTQOufHBTHLpgLlXx2OqjzEnjAvDJpegIrbcQbcFpokeHObkCiAEpahGMTiWySo9l/Df4KUYw/1opd3BfhmLWP/KkiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnnMZjUG; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnnMZjUG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4922244f7c7so39191635e9.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 07:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782140065; cv=none;
        d=google.com; s=arc-20240605;
        b=Lc79aZN88aMtKxuun0fc7GVIl7rEr5hzcGmdISfcd732v+9P44dPzP9F2NcHF7upda
         Ne95IcmKh9pDCbxFVHQjyDt7a4/nnZSssOvT/oxaXjR9O6kON4GC8etfpqMkNv7zm+uQ
         t2G66vrka240RmSzVM9+zec+0Jn9PC5ss6AF6m+eMuj1R3q8PEW573p7z6JR5bFGazgx
         rArGGEWXU4XkSr0JzP/n2mt+f9wO0wY107qtJExaejjVnlq5VFgFuHvbj2KYBMn+aN2c
         kSqpgxR8pLo5gihK80tHEikhQQECbZMgKeBWn3W982f7QcjCdJHSmgAec2ea9yqGlAGg
         J7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EverwGFGy7q/WGbEqhoYn+l8o6lObHXXPInFSiUXHk4=;
        fh=BgMyRSqv1kC74i9cubPAZ3xYRx4cIuUB0h8jYm9lTJI=;
        b=T6ZsoWIRgh/VbyW3b3GXgUroTY+2dxH2y49Cp9xu7cssrDsJYq/7B3NZ88FTiAnKBB
         +/FNzncjyfr22Rgmu9FP+gtDr1a33oeHwnoKHqytXhp18pcDB5JygO+gbk2Z2PSutXrm
         iQjuWJ7vjgd27zemYJhzxQRqoD2ZPNeKMakN/s66N5PyJANjFRX6aXI2mkYKT04tLPky
         5yzPp+ynKCEKP7RngwF0VHqT9Mbhto3gvxqd1N9t1SK6PvIw9OFPylQGtiiQooGJoShU
         hF5Z1/BwstqFRnkMxj+xR+5MZ597vDODCTLREwE/o9cg8YVY6xCZSVgLEyJCXwq+vZ8C
         eH7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782140065; x=1782744865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EverwGFGy7q/WGbEqhoYn+l8o6lObHXXPInFSiUXHk4=;
        b=OnnMZjUGLY8Vd9Jq11a3ICcakyWkDJbmxP5GXQv8OrX0LMYVTGoi1cYdFdj9gMCXav
         aHeyFiqFvIOLHtNJ8bnKLwI/iF9IlinIRw5PcZ+eJm7eTjPYajVYjpeDx2KOgK4TRnjD
         kq8FmWyAfTTYQyK4GkXR/SfqDzWq4lzu8y+1GcYMOorwvPnVsNfJIfIVWVoEEjsB9fJe
         bfxFI0SNFSNlwpwgmy4I+q1Rso+eDayHBmmE29Ds5BnVfgRjEmYP+bIdj8vbab9nr+Pp
         trmJByfEbRTo40U9t7Yr4sWWA1rmKhqr5VIx4gqRjAhDJCZor80608z1iFzwJZO8ybIh
         3PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140065; x=1782744865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EverwGFGy7q/WGbEqhoYn+l8o6lObHXXPInFSiUXHk4=;
        b=jp4tXDemyscFbSagq/D9GkXgX6hps575yi6MyNUQZdGoTCYH3NEd9skf7bPH9y/T6g
         b3eVxbyvRYk35Vdyt3IBTpr43Io9bhX3z8XnrHtiD5JeNKFh2541GfAqbglVaUOuIiqH
         QVTqrWKlONlHqIqaH1cjYbH+kGKURYzq6VgDccSQd4po04FUW3ljfpG/NLFQs4UfTCcR
         M26zF+bZddjD0LwJgxd3jajMqgFVOwwurkHUrtTCAp989GEdwAcoZ+370kSJd2rLLgCq
         nv6tiROGv6dZhVKBLBli95C4iruFjUvdO/QZro/lSRVUMErPV8GWVnhJ2ZxMpruz5VXQ
         A1+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9GqyXUt817LOvamvzVpdT1nOaWWEO7pT9sJEu9S+t56U9CcWINBMlinqnp0vVYgL5q1Lm/fIZv+9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGwasYbkMb0QFVHEPrVBF3qh8JPe+LOhgIkAqqXkJ/DIXuKL3
	YsPSpoyBaqMP3O9AdQ2Voy8g7R5JJMjImlNv90gtj3epZyE1K3ENCA5lwOMN2Gr5UAb1+J2QbrQ
	Na8CV5V8Ja+ssEc/iXGWA6Llx27PfcLQ=
X-Gm-Gg: AfdE7clEvtHrzsU64rrUOHirrMKsR1/zP0jex+4i9givfIM+T+QLEKDJ3LRc1ddS1EG
	v8c7nJF30Lgi4krB4XJ05HDtoT0E3sJtVuAjISv45grqTCp+KQHJ40VyOy+dhJMTFj+ztl+wibn
	410OptseY7/lV6qf9lsL2XbqLaiH6psMtRdMaB/S8V1wlizY9Oi8Puxjs60wbEzAfK7BhSlVbE9
	muC0WRmBXKLR/PjuzB2yOLppG7hVez13WjGS1znn+NrchjNSA/KqYt2vcajCxPykzSMLR4Uld2W
	lkyDzJNWlQ062Er5BGA3iQRbnsalghbSXlfCjRxOrqY/e01srx7aqPnXkQ==
X-Received: by 2002:a05:600c:5489:b0:492:4668:27b5 with SMTP id
 5b1f17b1804b1-4924668299emr206639315e9.6.1782140064335; Mon, 22 Jun 2026
 07:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260602195019.1798126-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <50a908557bb3ce5f14b67396d1e73e70289a583a.camel@pengutronix.de>
 <CA+V-a8uGho2RMhreDgieOOZTggUALoF0bGyjdEEDvyL_75sAyw@mail.gmail.com> <fuefvecgjdqbnbvpvam4gmewmpmhofllyq2ootwi6cjqhnyoys@edjzqlh6fjw4>
In-Reply-To: <fuefvecgjdqbnbvpvam4gmewmpmhofllyq2ootwi6cjqhnyoys@edjzqlh6fjw4>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 22 Jun 2026 15:53:57 +0100
X-Gm-Features: AVVi8CfxL1LYbXI4i0sLlo6UNgqoA-R9n854OJS7t3HTOGk64xjVruCWhx7GIqc
Message-ID: <CA+V-a8sRxoR96TRM2V3cFXS5NPiQUVrUJCWwkh7o10cGYPU9_w@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manivannan,

On Mon, Jun 22, 2026 at 3:30=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jun 05, 2026 at 12:54:46PM +0100, Lad, Prabhakar wrote:
> > Hi Philipp,
> >
> > Thank you for the review.
> >
> > On Wed, Jun 3, 2026 at 9:16=E2=80=AFAM Philipp Zabel <p.zabel@pengutron=
ix.de> wrote:
> > >
> > > On Di, 2026-06-02 at 20:50 +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Switch to shared reset controls for PCIe power resets to prepare fo=
r
> > > > RZ/V2H(P) support. On this platform, multiple PCIe controllers shar=
e
> > > > the same reset line, requiring shared ownership of the reset contro=
l.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > ---
> > > > v3->v4:
> > > > - Added RB/TB tags.
> > > >
> > > > v2->v3:
> > > > - No change.
> > > >
> > > > v1->v2:
> > > > - Updated commit message.
> > > > ---
> > > >  drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci=
/controller/pcie-rzg3s-host.c
> > > > index d86e7516dcc2..a5192e4b58df 100644
> > > > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > > > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > > > @@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_get(=
struct rzg3s_pcie_host *host)
> > > >       for (i =3D 0; i < data->num_cfg_resets; i++)
> > > >               host->cfg_resets[i].id =3D data->cfg_resets[i];
> > > >
> > > > -     ret =3D devm_reset_control_bulk_get_exclusive(host->dev,
> > > > -                                                 data->num_power_r=
esets,
> > > > -                                                 host->power_reset=
s);
> > > > +     ret =3D devm_reset_control_bulk_get_shared(host->dev,
> > > > +                                              data->num_power_rese=
ts,
> > > > +                                              host->power_resets);
> > > >       if (ret)
> > > >               return ret;
> > > >
> > >
> > > I have a few questions about this.
> > >
> > > Can you move rzg3s_pcie_resets_prepare_and_get() and
> > > rzg3s_pcie_power_resets_deassert() up before setting
> > > RZG3S_SYSC_FUNC_ID_MODE and RZG3S_SYSC_FUNC_ID_RST_RSM_B in
> > > rzg3s_pcie_probe() without ill effect?
> > >
> > > Can you move rzg3s_pcie_power_resets_deassert() up before setting
> > > RZG3S_SYSC_FUNC_ID_MODE and RZG3S_SYSC_FUNC_ID_RST_RSM_B
> > > rzg3s_pcie_resume_noirq()?
> > >
> > > Those would have the same effect as the reset already being deasserte=
d
> > > by the other controller.
> > >
> > Yes to both. I have reordered the sequences as suggested, and it works
> > perfectly without any ill effects.
> >
>
> Are you going to respin the patches incorporating the review comments?
>
If I have not mistaken, no code changes were requested; it was just
that Philipp wanted to ensure the shared reset worked correctly after
shuffling the code around.

I can respin the series if it fails to apply on top of pci/next.

Cheers,
Prabhakar
