Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71754611ED
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991157; cv=none; b=EL2LVEpcvIg4WA7IfbmP1P1vvMgTWyBbmANfhZMUjU61us36Be8TphZ+3ZlskuiY06h92miWDXNMJf2fTHuJth9FoUB5ChiVo85uRMRBaEcR8fKZkboy0+5XaZZxdtBwM6bDRfr0sSdmryQDcxPJEpF8eBLN+ICoXMPOnK9Vp1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991157; c=relaxed/simple;
	bh=Nvus+CBCqOlTSbWo49/3x1+8dGKD+L2I7BSM+bCrpkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRm/As0sds42YWlHBZ0OAVa/YUiyr2tgIQGWNRajZ6x1CtxisU0YFpRomBZh5tzV9GpNfCR7j++ZgNge3qqSZoZhGMP0Cktiay1OIAIarwaA5a2H69aChU1tLfVdN0jS4MENtw5ycih8sU09QUfeRySJDEBOGb6aOCSwXijb664=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5f524301a76so243185137.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 02:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991141; x=1769595941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO+jELtAqR5E9j/qLczmHfGIJgU+mWLnq5p5v66Y2yE=;
        b=tldLuM3GdT1N0szV4VAkbZmkGZrRWSNzRkUNw+Dc5Fk0cov81/94RAk2N2eVle5lty
         sOQGKFu/MqDpJtyJsyDeVgBZiW24bglWdAzx35exCjlRSCGXcj+aoehAKdaCBqansQHu
         jm1JS1yBwUQGJzFWM++N2AobeUrz+zczZia4GhDQGyslZ3tkE4FxzX7RkEnSGgBoN543
         yHnlv0CGDqBoafcJCBpuCreAH/YZSHZVPbu51Kchzx3HmM1aTzxSqBTXiz4/Ii8qKhd2
         Sg1PPJzuN5OQ7x4suZRe6Vzqc2+Gt5EsJtU+/sqAhZFlnRISiJty+XGza/i1GkrGPt3y
         QRdw==
X-Forwarded-Encrypted: i=1; AJvYcCVbXnhlodFf4zIhYgpwzN+ZzbzalhMOMh6DlCVrUhPLZEAxl27fZeuSGblWEDKkqTkNwOAYuhl5qTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4weq5dnEMIk0DzPb6S1dap+cCsk5v/SF7e03ukJYEzUw6hUx
	+s1y2tsLZtkR7w2lykrEa9K0otA3JsUUvTqjSVOasbV0Mim5inPpStM1/7Al95AC
X-Gm-Gg: AZuq6aIMPhWjcmLgddooIH882So5FdrlpYpwVEBboCm4ioTdcmEh5A8PamDaUsIAeDC
	K8iMkkD7KyuEWDaCUqB/J/nQC6uD+gC3BXjAsu+gqBcrL7/ObEcxbGWTfjFXl7e5+3aT7aWKxO7
	WfwxV08A5nX19N4BLow/s97g9xRy4zK4Ft5L8TVRLNiSv7MwSV5m6Hj6eh0dG43aPvis9TsMzZ1
	a5ujTWVGmuRvgMCngdpRSuLufokEVAxHXlkxr8KWulVrzyqqPGWFuGhsDRnoFmP3O/0IC5DjIDH
	6aYZZrL4HKt3ADe3xcJKrmuFwCNuRY/+R+qNGFX2e0luj1PAlfUabkEM+N6AXahRIJ1+jZfIjg7
	zMLtVR9t0P1wfnIrQSB2uzHZQHOxuhpRYKy4CqFvnN6ezuGRz8fjUq0HGPvwcvxQ1ycuEmwTK2x
	nKSaVHZOh31hCrcAvax3XzdnfnG2Vll13ZxzRXDDcHuS1t7mgPv4KWv1PD3DAqRaQ=
X-Received: by 2002:a05:6102:3f13:b0:5ee:a6f8:f93b with SMTP id ada2fe7eead31-5f1923fb3b6mr7819477137.2.1768991141483;
        Wed, 21 Jan 2026 02:25:41 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d03eaf17sm4620264241.8.2026.01.21.02.25.40
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 02:25:40 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b219b2242so475015e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 02:25:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJI0y2TOf0asOhUPJBwjbHj/n2B80xr6CBhrdyMB4RxvxLF8nuwJgmwYrW0Ki4DkllTsQjaFAGNuM=@vger.kernel.org
X-Received: by 2002:a05:6122:8008:b0:563:50ff:69b4 with SMTP id
 71dfb90a1353d-563aa9c7454mr6150186e0c.7.1768991140325; Wed, 21 Jan 2026
 02:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-17-john.madieu.xa@bp.renesas.com> <TY3PR01MB11346AE1205D35A8D8BC90B9B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY6PR01MB1737773DEF65ABEBEF11D2E96FF8FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346C084AC2534C52822BC8B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346C084AC2534C52822BC8B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2026 11:25:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWXrYCULkavZGBE2foOh4A7kesda8Be1PfW-rE0WEsjKQ@mail.gmail.com>
X-Gm-Features: AZwV_Qh0oraDBmK-XBjWZ-KYpOXfBLlpVps5djRVJqCRGWxVzazW7dn9SuHVFa4
Message-ID: <CAMuHMdWXrYCULkavZGBE2foOh4A7kesda8Be1PfW-rE0WEsjKQ@mail.gmail.com>
Subject: Re: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "john.madieu@gmail.com" <john.madieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Jan 2026 at 17:50, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > > >
> > > > The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
> > > > Enable PCIe support.
> > > >
> > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

> > > > --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > > +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > > @@ -96,6 +96,13 @@ &i2c0 {
> > > >   clock-frequency = <400000>;
> > > >  };
> > > >
> > > > +&pcie {
> > > > + dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
> > >
> > > This entry to be only in SoC dtsi like RZ/G3S.
> > >
> > > > + pinctrl-0 = <&pcie_pins>;
> > > > + pinctrl-names = "default";
> > >
> > > The pinctrl entries to be moved to board specific file as it will be
> > > used by RZ/G3S, RZ/G3E and Upcoming SoC in future.
> >
> > To summarize, you suggest me to keep only the dma-ranges update in this file and move pinctrl
> > assignment into r9a09g047e57-smarc.dts right ?
>
> Just "status" should be sufficient. Drop dma-ranges and move the pinctrl entries to board dts.

Agreed. After that, the future RZ/G3L DTB build issues related to PCIe are gone.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
