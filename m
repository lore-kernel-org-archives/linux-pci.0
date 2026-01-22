Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDE3A3CDA
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099385; cv=none; b=mZGPq9O9MqdWIfTgVk/yMDtDbPhKNvOfL9FcwKDTYMzgRL6A7RUNpxtOC4EeJfAq9g1LBumXzQ5eL2tCQ3fNJ+FkvC9OTWCvTQDrWXS2joyFTsuFikBIwdqYaTNqbuGijAf/UGnrfR+y8zRNcq0dyNfS3hqcLZD/ZWw070nV2Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099385; c=relaxed/simple;
	bh=KsGWBtdWAcOuouRcNgHYXyDSxWrjlkEILO0o03DoYzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaaT08XlS7pOqmH1a2vNK6MlB8FiUCKC6EGh3gS5rtzpIdk0HPogO0z3j2e7eoFv7HK8k2FhblzsSkoS39Fhn4J/QKaBCwFGe+yrRC4vuvly9wPgYWaqwcmkX3coFM8ktxx4NbBT+5v6/8xD0ukCdBE4H17aF1XDGEl936w1IsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5f535ff78abso794570137.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:29:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099375; x=1769704175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1WfrbwhdDFpnMP8QjUxFisYdCm9ShlmwjTsosQ6yyM=;
        b=L68lzmMtlY2Ga4nFUhzLJoODnNGpapuQfh6gE6Km9/AIGgYHgvXk6hJ0V0H1wUREhY
         GT+1rFSsBMwOD2spBtFUJHfO6Gu3JLgtll7u8lO0EUAV2e2yS9lGrQXpgvgYhLySkJpe
         01TLzYsTBP8cK8F5HXinNPDZfJhln9BKE5zT8W+yLAT8gHqUlbjJvAtksE2zTx4XGzxG
         wEfopAZFNVDj8YdcxwbX+jjH/vpdI9ORh6LKaAMBbTY/8qSexlL32GhATwH1vmys5vc7
         KLT1xtlyHNTTtXtU81QRnVivXBwZ6x8SLEtqmSzxPt0NkSxOmmUJ5FELpHhNWAHa56i2
         PajA==
X-Forwarded-Encrypted: i=1; AJvYcCUjdp1P/7Mpr11d5utuXin0WnPFedZfy1iCdpZnHxxpRKeiMVKcPwfRSJxLL+q8HbvshjaCsk8A720=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTkTJlDM3rUK7dHE7we+4jNk4khw+yjYHl/OIj1DYl6kp1QMd
	QASfnf/zE81HUnqQOHLHFHug8IjT4vnToINYn/66cJOVdXwdB+HfU1Pb78B9Lgf0
X-Gm-Gg: AZuq6aKfjywWnqXlVYFyRNimzejgaoQK/qEYaPl/hs4gPM9dF7VQ7xkRYtDSc4vIdW6
	zWUDFH6xWkLv25CLNH7TAc44Shq/QLr19qZYeOeWn0jUfVsdEg/zEoxBByp60k2w4Q3Krb1z8Td
	Eg+uOpL7ds1p19i7vgIZjXzc4SniJNiLFw4zgi5ocmgVbSiFlrfYkO4+BKwtmPm+3jLA02rTsW0
	KVkeQ5O3byuBFbY/FqzadPh7i7/bmZc/V7hJRpD1ruw6+z2GuAtNgDNlefgwVao7tmylbXXOzIC
	mOyuonoVq/Bf7YPxcoHIgGwetu9gPRwEZjHVnWEHWbt5E5Cd4U93AGpgwirKAuZu3gerSOP44vY
	N9NyzydnSFLvnonKTIhfbgjDOkgN3D9VHS9C4QUdiCJ+YneB0GcXpE+KMWlsJRw78WBKV3ElfLs
	IwzXrYjedGURO1vFNPewxekkxeUL372hRFBoCKIMz6+LgkFMm5
X-Received: by 2002:a05:6102:dcf:b0:5f5:3d46:e5f5 with SMTP id ada2fe7eead31-5f54b9da31dmr93449137.3.1769099374539;
        Thu, 22 Jan 2026 08:29:34 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-947d044fa0dsm5320703241.14.2026.01.22.08.29.33
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 08:29:33 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-941063da73eso537478241.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 08:29:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxa0jqtRnCASuMTwyOT5w3iY6093IPQs3F8PceUNhmkI0PjFWwO1k79Q5MZJ3o6o/PbYteB7HyHRM=@vger.kernel.org
X-Received: by 2002:a05:6102:c88:b0:5db:25b5:9b5e with SMTP id
 ada2fe7eead31-5f54bc6f96bmr75281137.22.1769099373234; Thu, 22 Jan 2026
 08:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-4-john.madieu.xa@bp.renesas.com> <CAMuHMdXAAUe_0kboQ9C0AMPn5re-1kCagecp1fMCGramDpXGRA@mail.gmail.com>
 <TY6PR01MB17377AE5807504FFB6594471AFF89A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
 <TY6PR01MB1737738E302D0BA716AAA2650FF97A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
In-Reply-To: <TY6PR01MB1737738E302D0BA716AAA2650FF97A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2026 17:29:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXk6A2-isnLQCgrjjWRX=pYKbUvVz-nfDwy72i1qo1-rA@mail.gmail.com>
X-Gm-Features: AZwV_QhbFTwa7jTSNEghn2CR26nFA8B0X7gABEL6FIix2T_XBXqsyJgYshZo110
Message-ID: <CAMuHMdXk6A2-isnLQCgrjjWRX=pYKbUvVz-nfDwy72i1qo1-rA@mail.gmail.com>
Subject: Re: [PATCH 03/16] clk: renesas: rzv2h-cpg: Add support for init_off clocks
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "magnus.damm" <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "john.madieu@gmail.com" <john.madieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Thu, 22 Jan 2026 at 17:21, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> > From: John Madieu
> > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > On Wed, 14 Jan 2026 at 16:36, John Madieu
> > > <john.madieu.xa@bp.renesas.com>
> > > wrote:
> > > > Some peripherals may be left enabled by the bootloader but should be
> > > > explicitly disabled by the kernel to ensure a known initial state.
> > > > This is particularly important for PCIe which requires proper
> > > > initialization sequencing.
> > > >
> > > > Add new macros DEF_MOD_INIT_OFF() to declare module clocks that
> > > > should be turned off during CPG probe if found in the opposite state.
> > > >
> > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > LGTM, so
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > However, I am still wondering if there are any possible bad side
> > > effects of disabling the PCIe clocks, e.g. when PCIe is in use
> > > (network card, SATA card, ...)?
> >
> > I'll test and let you know.
>
> I finally did the test, disabling the PCIe clocks while a WiFi module
> connected was performing pings. System got stuck, unusable until next
> reboot.
>
> Was that the kind of test you were expecting or did you have a specific
> scenario you can share.

Not really. I was thinking about a scenario where the bootloader would
configure and use the PCIe device, then transfer control to Linux.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
