Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984E361DD3
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168383; cv=pass; b=t6X8EEj1as2d95Nc0xi8/w2i+K2kc9Xv+3gwVfhqaPiWwCRASGgPIJ+CrkzKYw3B2bsyZ2ih/MSNLgpLgnapZLSSmH96O4vrlodhFh3lgAWK4QVzkdSbbUu5uteF/cad5lQWm9+m61nLnN7oZFo0t5+TP3pGJRbtTckd9pVis2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168383; c=relaxed/simple;
	bh=aisLc2ieM5f1wTihT8PCwhs96cakpU8DJktm3rN7jzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzvYzuZUIZE4lmMw1rj+50VvH+Lr1K2Mho6jtMbHjJk8CjjD6tnssx38Vhx2ziLGuXUlgiBt42QhVABF+WP1mfTossXrEb1QuisjkvRGrR2CemTZmJFwwJ7omOTH7dFJMwn2myto8oH4Fl0ra6GkDJQJXzOIrGKe9g6ZQKr/o9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awxm0fyh; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awxm0fyh"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43246af170aso1222203f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 03:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769168376; cv=none;
        d=google.com; s=arc-20240605;
        b=RNheuT7bshKqprzQnreMT31eqnpohmrZjjRrsc9xLoNjUuMHDHjGrZukRNhuMfSulj
         GsXKSgiOJ3ZJ1IugLnhcHhQbtYSW/fWf5iDXgDMHGXyAJ0uRDFg/6pGmQF6n8nnLNcX3
         52O2bSDNN15LbfuYws0Q/qkX9icUAsVxaZWu3FDNFarOldPZ+1BoJQn7DpAwozhcKqJw
         HxfU8xMvb6wVsMtFYlPpf3NaA6DltqFOCt1hfuDJ9VqQ7LxSy3t6IEzBsdZX+OqCllFV
         NyzGz0jOh7zPvno7p9LZMRV1SiTU89lpp4kyodSAbAgwH/k0yohkrnxsBXjkf9B+MsDa
         PAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aisLc2ieM5f1wTihT8PCwhs96cakpU8DJktm3rN7jzE=;
        fh=GHc5UaPNNHSnnSdc/TNAL5N+oDHX46jSFmRRSP+3UqQ=;
        b=XuQWPjz+FJuWLSBgM7Mem316a5NGEIlnElV/n73Ukqtj8BxhsHj/6xJ+P9/lGLp/1Q
         4JYX6gWMV2MbLCfw7HwtirwYj4OxZ2BqdMgmcW1xKrwEENpcNIuyHIDUvbMzprkkBHtL
         QqT1UNwfKF0JVjy7K7CJI7SmORn4Mj8ndgS3JDy4c/W2tfd2DlvtdYNZ8o/tS/yfWN/c
         OAC5a+/KzqNAfOi2/unXrcnDQhXuhcJHW3B83FedKdO/wAxyUpQj/q/T+4M8KP2wnFWT
         ZEgZH4G5O/9/4ITpa/fRHe7O7RPYJ0VgBRKdUrxKUKoGIsA5ytSfk+9w2NFC3zqbNic+
         5YDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769168376; x=1769773176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aisLc2ieM5f1wTihT8PCwhs96cakpU8DJktm3rN7jzE=;
        b=awxm0fyh/ZuqSBJYDoyOrvalD2PTMdShhFS5lFlTUkzxdPCgj4vDnskcz+OY8H2NKx
         RF6a/PkK5l8UOMmu4I6gNf8LVzTk58x1Z6ztbSpBWclkK3hu5G48x06ZF7KaKHLjw80q
         0cLEtRETx1w35OlP6pf+Fa8hZn+sbzBlGxp3wa1Z0pSNpXmcsg6Xbulh/dwXfOJ2DR5h
         sRB54auc0BeL+U91KMGU0Y/4leHeewREx9Tz0zhEIrvjfuISZEX/sXqWezZfaxGWjEQc
         YJkLfgxWjzP489vpPygx3Cjvye5KnSD8edaxL4DJpTBqfZoIZ8mxLlAgPI0mRixsB9Hd
         v6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168376; x=1769773176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aisLc2ieM5f1wTihT8PCwhs96cakpU8DJktm3rN7jzE=;
        b=QWJrSAsCv17J+iO0gGnweIS81LyLbmsbqlTCj9qGHOdmie849MzHs/tEMTX4da5CQZ
         qhXil2L5bGM6NZJ5/qYss52fRC4v98mw8l91/ruufNM5bHAV8kT32JNP9aJ5JfZm31vS
         86M+/uSF/qkXN1KabWhy276ruJn+9NClqf4G2VVErSrhEHntNGTiWtCW4xqZLhWwb4f8
         FPlIGO5BjAcKWv4cv7IBwowjD7C07blaejZfUQo7nLm3HjBLgWOJVgu5yk3SJl3zBrWP
         2dWj97qHz8QATlunhMRhcVAMs5lxX+clRkComtlOzqle0oKwSQecxX09oeVKILrMZW2D
         +/vQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+vr0IviELY5aZLEvllk1dTYmiz1lMO6nfG8F87EuWD+0S9t8SPfBPb6NlM4rROKIGqu6kqhL4dpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFxBJeGEuPgE+0iGWAXe+BH3PHq5rFl39waj0vDqQfmtd5fAP
	sJHo/5AgVz5PkufMQootZ2Vj6ULeqS+5sYyb2AXdrN7n0+HnQkz7YLOCpsolRMbQ+GrMTGvYl+A
	3g89XrP9TCNLhZS0NEV71b0OTnhrrcCA=
X-Gm-Gg: AZuq6aJLoaP/chk7+Ww3bk6qYv45JBcWlQFVfNuPOL+FLwRLJREanLNu30YrnJp4DiS
	cWfrAfZIx3XP1VLSlnuTSjKrByyYEyFlH2EqCMRB5cANXOJtEmlcl9BI2VD9hNtPVaLVkwn1Nhl
	/9q1YXJfWFMMbdSVoDj2eyY791EvjSvugRH/Z1uA+Ppwd838rUDq6q7bVKCyu/9LHOJckFX606L
	xIg8e4nXsLCT5ulQoUDG43PZTrOALoF6ZO6a1CuxY3zFeJjzsTHBif/133j43DCiExCmxnmpJLP
	/qVq3dCiEWh5eZSlD5WmPdkZcJ07UxRE/Zi2ZcyKl0II5BNBGql4MKbBEN8dvIpH2447irpNjjA
	t0OTrWslfvGxiIg==
X-Received: by 2002:a05:6000:400a:b0:431:2ff:128f with SMTP id
 ffacd0b85a97d-435b1ab836dmr4926768f8f.6.1769168375446; Fri, 23 Jan 2026
 03:39:35 -0800 (PST)
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
 <CAMuHMdXk6A2-isnLQCgrjjWRX=pYKbUvVz-nfDwy72i1qo1-rA@mail.gmail.com> <TY6PR01MB173770856BD4044A79150F6E8FF94A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
In-Reply-To: <TY6PR01MB173770856BD4044A79150F6E8FF94A@TY6PR01MB17377.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 23 Jan 2026 11:39:09 +0000
X-Gm-Features: AZwV_Qi1ncDRUlLnXwWZ1l-P3_ht124RPLuPAwvq1Re_E8LiTcuyHXUL4gel0CA
Message-ID: <CA+V-a8uNpNPCyePQrRDQxaGfN2gZE3-2VvCMs3FOqFaU3mKjLw@mail.gmail.com>
Subject: Re: [PATCH 03/16] clk: renesas: rzv2h-cpg: Add support for init_off clocks
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: geert <geert@linux-m68k.org>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
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
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, Jan 23, 2026 at 11:29=E2=80=AFAM John Madieu
<john.madieu.xa@bp.renesas.com> wrote:
>
> Hi Geert,
>
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: Thursday, January 22, 2026 5:29 PM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>
> > Subject: Re: [PATCH 03/16] clk: renesas: rzv2h-cpg: Add support for
> > init_off clocks
> >
> > Hi John,
> >
> > On Thu, 22 Jan 2026 at 17:21, John Madieu <john.madieu.xa@bp.renesas.co=
m>
> > wrote:
> > > > From: John Madieu
> > > > > From: Geert Uytterhoeven <geert@linux-m68k.org> On Wed, 14 Jan
> > > > > 2026 at 16:36, John Madieu <john.madieu.xa@bp.renesas.com>
> > > > > wrote:
> > > > > > Some peripherals may be left enabled by the bootloader but
> > > > > > should be explicitly disabled by the kernel to ensure a known
> > initial state.
> > > > > > This is particularly important for PCIe which requires proper
> > > > > > initialization sequencing.
> > > > > >
> > > > > > Add new macros DEF_MOD_INIT_OFF() to declare module clocks that
> > > > > > should be turned off during CPG probe if found in the opposite
> > state.
> > > > > >
> > > > > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > LGTM, so
> > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > >
> > > > > However, I am still wondering if there are any possible bad side
> > > > > effects of disabling the PCIe clocks, e.g. when PCIe is in use
> > > > > (network card, SATA card, ...)?
> > > >
> > > > I'll test and let you know.
> > >
> > > I finally did the test, disabling the PCIe clocks while a WiFi module
> > > connected was performing pings. System got stuck, unusable until next
> > > reboot.
> > >
> > > Was that the kind of test you were expecting or did you have a
> > > specific scenario you can share.
> >
> > Not really. I was thinking about a scenario where the bootloader would
> > configure and use the PCIe device, then transfer control to Linux.
> >
>
> I can't answer to this exact scenario right now.
>
> The idea of these init_off was from the PCIe host HW manual,
> Explicitly requiring tuning the clock off and asserting the reset
> as part of its steps, while this is not the case for other IPs.
>
Can the PCIe driver not handle it? ie in the probe explicitly turn off
the clocks + assert reset + continue further (do you see any issue
while doing this from the PCIe driver)?

Cheers,
Prabhakar
