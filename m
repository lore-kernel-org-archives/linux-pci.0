Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D72184
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179033; cv=none; b=UKT9hK/QQHBIdWCI6DmlkCE5eJmfEhIAHudT7mTywfoRPERGy3GNvM8O0j+vkia23azquMz/NMqtH25FrRSxgs5CkUicT1dsUuiUECPLxAZfVuXYB36YXe9hE3kPyF/oR9Fmm6eoteiua8h31fQAFWMLLfn8a/nf6T87wBKPYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179033; c=relaxed/simple;
	bh=nCsWChx6yxZSKjZAa2GMQpNOMLhhdbKSzY6rM8oSSlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6x3tNckweEJLTYph3pjvPG+vb6iRsPiKaeNciHyvhZrqmGCXOH0+wdDa2qTKoepQK34LeWxrC+9HaMJ1tfS67KGu8WNCqznSJNatJwAVxToLVwQIiw9X1PyoFQedE9hNd70aJaZSbFEjgdBfd+Ff6sqmyaPLoVSkYVL4KoBwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso1507931241.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 06:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179031; x=1769783831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeOBI8yfyx4Jru6wCPGb60ftZsgppeSY8TcHOVeV6Js=;
        b=r+KqGZLSQpnm36ow/5qY7a6bHmrAf6ELjFzTavy14rWXMmREbpt5hdN3QRtlG0rI6T
         s7WKF9mLm7dYt7dc8DHVsrv4MI83KE97JCtPMXXktziDk8SqaOheHEGQdenlNahTH1uQ
         RDx3A59ll6OkFR0J0dNAFQVO3qMIuhFbnZvUf9Oqk2LROkoBrOJvTStYplXZ0/IyvZRz
         LSWKTJ+tk7hZkJYQGN2b7zzj1PK/8DMISxbb9zjlitfwDb9szJAMfFBoJ7kyvXWefaSu
         ZsIwTViunqpso5xw/E1RaDgJnR1thWcMCVoEDhVmqMEqT5lXaJMVCBfXtV7s5YNs7qFr
         mXTw==
X-Forwarded-Encrypted: i=1; AJvYcCUng6PMEvmhQblZNqlh/1pWQnAjhIbVB/86p9AKOGQjJ3yrO3JrFSMBQVtolDGBMBPL6AJAZSDN28g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9ffQheB9cXMZmoA2/C9yelXOkeNUr92t4yk0jY4IksafJS18
	wajeAIBQ7MPwuLYqgLTt0yz0U8fy9pFZSr8EvUwnHvluOpmIl4nsNcQE+ECc3Y2E
X-Gm-Gg: AZuq6aKde+YEHujWjEmVhJFgOsjFEARS7gVuG3Ger3OHFaPsKDfRq+ges40BvPIYJ6F
	Eu/4kKcLzOqFWSg3wVygH2v1bI9fakgI1GfIIWkuPPKfEzUCkORUNB9C3rg63KGxQNWROBiYqRw
	5SiBJRaqLTpZynEMJutLsxBUZxYmJlcUq7jTxjK91WGVf2eTGKQp/x6It8+IFxcDmmJEpXYEcq8
	pJDOEVpW7TkvTB3MU73DXjmlW4sjJZ0ugqRNxjeHP0CglFUmEoIlBM010B3Tdd4hBUQjK8X7yD1
	6Qh1YcGi+heKqJFBSA+0uR8WQHOtwF38iM0RN3XhDs0gbAb4P1jJXLmJwtdfQPm7iEB+DRLPx6L
	AFP9y032VgJSQhjCQxKaDCt5GT9lUb4pxYHEpLbh7YgQHOnoOCfOxaCtb6kUfYU9YqXHYWEbZF0
	sFlfCd78eBMDcb0Kpf4ys/bJwzv4jMGBfYzh0woyDA5MlwBYifb07co2rX6RI=
X-Received: by 2002:a05:6102:2ac7:b0:5f5:328e:73a8 with SMTP id ada2fe7eead31-5f54cba4eb2mr915109137.15.1769179030577;
        Fri, 23 Jan 2026 06:37:10 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5f54d66fc9fsm534084137.14.2026.01.23.06.37.07
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 06:37:07 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5f524301a76so2056541137.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 06:37:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2tca/ixaQYQ8oTnBIt+HSOOBcm+xF1upuQOM7aevpUYWHaEYEqllvvbEmNjJO5/KStSRCy1gWsqc=@vger.kernel.org
X-Received: by 2002:a05:6102:f13:b0:5f5:259b:66e1 with SMTP id
 ada2fe7eead31-5f532daa612mr2326635137.3.1769179027220; Fri, 23 Jan 2026
 06:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com> <20260123140031.94752-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260123140031.94752-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Jan 2026 15:36:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyFMWth7x0+ZVysLeZkxNNFPQibdSJMVfqymtAE=PwbQ@mail.gmail.com>
X-Gm-Features: AZwV_QipW_DLhbWh9heQ9wnTY0UPaLJrYO-wTDJgNVv9-6b_lsLVLgBLRKHfS18
Message-ID: <CAMuHMdWyFMWth7x0+ZVysLeZkxNNFPQibdSJMVfqymtAE=PwbQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] clk: renesas: r9a09g047: Add PCIe clocks and reset
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Fri, 23 Jan 2026 at 15:01, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add necessary clocks and reset entries for the PCIe controller
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>
> Changes:
> v2:
>  - Fixed clock names
>  - Used assert-variant for reset

Thanks for the update!

> --- a/drivers/clk/renesas/r9a09g047-cpg.c
> +++ b/drivers/clk/renesas/r9a09g047-cpg.c
> @@ -438,6 +438,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
>                                                 BUS_MSTOP(3, BIT(4))),
>         DEF_MOD("tsu_1_pclk",                   CLK_QEXTAL, 16, 10, 8, 10,
>                                                 BUS_MSTOP(2, BIT(15))),
> +       DEF_MOD_INIT_OFF("pcie_0_aclk",         CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,

Please preserve sort order (by _onindex, _onbit);

> +                                               BUS_MSTOP(1, BIT(15))),
> +       DEF_MOD_INIT_OFF("pcie_0_clk_pmu",      CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
> +                                               BUS_MSTOP(1, BIT(15))),
>  };
>
>  static const struct rzv2h_reset r9a09g047_resets[] __initconst = {

The rest LGTM, so with the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
