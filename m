Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F23D7D75
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 10:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906187; cv=none; b=ctepKUwIahPU2s9nOUHgsh/pWpZvYGU1F4uhnD+RYaSfi9MQrSFo33ogFO12U2hXXPoDnv8pD5PB+n9eibtch/sFBuO+W/8wU4XEcqQriI5VEszC9ztPfEfXiIEwWo2j2sNyLROXSVCzryl9Ob4u2oo0k3uE3QHGwyvtoqI+sX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906187; c=relaxed/simple;
	bh=Jo14SNVvgAvpmCa6sHx3d7iO2VYD3GagcaTjUOnITWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJ3vNGQoHdsEEuUN0vBv+Iyam3dXdN6MUGXTgk8IHX+5go35HPW//LCUjl8/ooXpSrF0IoP2Ak6DWa3Z3xahlnuwFUPtlPqd3BYztBsItbo4IqqUxWLrUp00HvAtrbEVyuE26JWRF4dACSKlq+/RaBHA7dtvgq+NYe/AsQIfsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-559f4801609so1993785e0c.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 02:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906185; x=1769510985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZ0wVYmrXY0w9NWoQKTsT/lFDBKGzH8gk5CbiyOvxNo=;
        b=d+b6M/3TKdjjyu0I8Fx3Z3uY1i1uzlaEFiS9QrXvJzh2kZg4em6GAlfaMQzx+7z+ot
         i+vEV9FrsM34lcg6HPpLosHVtM2xLfjMPjHz2+dX/MjeUtnhI3BcDyi+97symKJh5zQO
         g1VMt6RuXRn25gcc/cvIMj7FA6Wt1WCwhdlto8OxFVgxI3arwNMG2LA/OzJah9WDXl9P
         8E0gsfiZkEs0fN8hCttAyLhTwTvu5I46I/uRi/jc0sEnMHCKOERCGJAXHe0Nm3R3yDaR
         MVAPEF9yIgzHDZiRX5HYIB3XLqeT7/gk3QrpzWgH7W5NRUj/o+0t43Mn0TdVPO/8Jlz6
         wfEw==
X-Forwarded-Encrypted: i=1; AJvYcCWj5SL6vSGB+LHfspV4x3ljZVycFBczcTu/XeE0Q94GuyZ5sqhZc/l0L8tiiI0Lz9hl61X0lVwIVVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlqwqpolom7GsbM61owOz5BqmpwMJQUcCYxAmgG/2d3w9PAVJb
	cuo+aBNshioNzJCJUjcBWujVJPoIOkTEruaVnt1RmU6JZTVcfLQdwdXiOEtNO1CP
X-Gm-Gg: AZuq6aIlGxIIaQUjM9XafxQ5/1/FsWANxcqwBI8502bQ/KPTR04umWLeswIAh8zoisH
	q2NdxugvKfLJWYhH8vhhNX3mwtb0KuP5W4gsQZC0jwB+QSkgW7TCNbTEBNzxVqjcIfcrDkR/YzM
	ljXj48gwzkKMnUrC9kxdmlzO72tiF3wa9cfmTK8iY2z3P7kN06iZSjDWF+JCPeBZdTl6OvORLzd
	ppkoJNfSwi0j58do1UPPqqcD5fcHZ2KCMULrBhoJPv0W98XsBzKnnM0L5070UtrO6ZOrokl4Oz+
	nGPM1nQ4y+Kg+gtewOnbTEgnFKrnuO+RyuZx8PWLJpT4PTz1QTntxnM1tAYu8uGEevIHNVClVDd
	L4k6hsFnS87fTKmfxo9LHsi7b+mJrx+hq25j653Q2aNnHxTYg1kaMAjgFbp1a9rVdfCKaGYKsZF
	+5DT9ffxGsrJAybRSb+ycznkUstVAG4Sqjv27IF6xJtRCz0CbW
X-Received: by 2002:a05:6122:e26f:b0:563:5a97:ad78 with SMTP id 71dfb90a1353d-565d90a1646mr432043e0c.6.1768906184744;
        Tue, 20 Jan 2026 02:49:44 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b7123621sm3444062e0c.22.2026.01.20.02.49.44
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 02:49:44 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ed0a9cbb3fso3308999137.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 02:49:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPbWFT9de6duNUAFYbmI/2pGrsTPMxG5M1aphQ6Bic2XynhV9qHbBVoV3Cn2AxmBO5juoOlMuqSEM=@vger.kernel.org
X-Received: by 2002:a05:6102:3f56:b0:5f1:4fb8:6b92 with SMTP id
 ada2fe7eead31-5f50a9d3b46mr342934137.22.1768906183803; Tue, 20 Jan 2026
 02:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com> <20260114153337.46765-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260114153337.46765-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 11:49:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXAAUe_0kboQ9C0AMPn5re-1kCagecp1fMCGramDpXGRA@mail.gmail.com>
X-Gm-Features: AZwV_QiaybW_I-1gR5s_n3JOLx29V6BZF-xoPK94FskYw67mu-RW2omq6aWspo4
Message-ID: <CAMuHMdXAAUe_0kboQ9C0AMPn5re-1kCagecp1fMCGramDpXGRA@mail.gmail.com>
Subject: Re: [PATCH 03/16] clk: renesas: rzv2h-cpg: Add support for init_off clocks
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 14 Jan 2026 at 16:36, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Some peripherals may be left enabled by the bootloader but should be
> explicitly disabled by the kernel to ensure a known initial state.
> This is particularly important for PCIe which requires proper
> initialization sequencing.
>
> Add new macros DEF_MOD_INIT_OFF() to declare module clocks that should be
> turned off during CPG probe if found in the opposite state.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, I am still wondering if there are any possible bad side effects
of disabling the PCIe clocks, e.g. when PCIe is in use (network card,
SATA card, ...)?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
