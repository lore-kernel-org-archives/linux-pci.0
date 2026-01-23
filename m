Received: from mail-ua1-f67.google.com (mail-ua1-f67.google.com [209.85.222.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF91314B79
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 14:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179342; cv=none; b=Ih2K5VyqkErhQD3lBd0E+aMDHTZaKkKyJ/XufK3q2jNE4Tz+w18nIWaFmoypAQlL1+6TflPM3Zew82COlkchu9CJ5cmhYuYOHGUPA3AXXOxzmhkmc46Y6eq35MinyyQ4Ao6f8kBv/gDUBp5lz9ank+Geu0tO5fenQP4CbPSTm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179342; c=relaxed/simple;
	bh=Wnzral5cDoYZxbt4300gIY+fWD5kwAwcN6sy8j1a/Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCZ7t8II5cIsAFBEz1UxMhOy+BnDvdbT6qnLWPMv77T1Tl+BgwzCKkd3MlRZSRdU6T3SbK8yX2ZqxR+ylAzFWYaqIjywj8De1INsifxhhsjEMeEsWHZDXXIp4Nv8NbqYrlhPwEbvfCzWFk3KY1CdClIS3g8T4FbYInLzntLPbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f67.google.com with SMTP id a1e0cc1a2514c-93f56a97064so493718241.1
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 06:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769179340; x=1769784140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrLyFLOgIReHJ7nKkJOEOCPW8EUbvL8/pGt99hnxu78=;
        b=eKkZhbOJXivptSZC54/ijsqyvWfUTcm6XzHi0Bo/u69in3zH0b7iI2SwgAXIXNOW6t
         4eTz7470AD3z+d/T5jKkjw/Ihej0hkwxrozEdD/eSTTnjiMC2x0QD2hzGHfTvI9/qDhY
         qR5N2Rw8ucBXE/XITBc/A51ouyirLTWot8jIEsWRK//G0boTPHuQL+L+C/GP0jC4IuX4
         QEI1Sa6wGkiua2zXlLfzop95wtARW6YKGUVynKP7oRVDnAmaarAonpQOnxnvoHUUen1u
         zVSAF0cH9RS11tEbTMtNPA1RxwpnUrAnNPKfHJzmjaHrd962f1t10RzTWIVFdF5N4+VK
         woMw==
X-Forwarded-Encrypted: i=1; AJvYcCVkhKSujhkR0M+l31ZJlP/qarJ4L8ahTKB3nBcyAVP4xXzQhOU2+pbhCW6K8wfyIaYblIT2zzYSWgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwBzXd0I2zG6h6g0oOr7qoEVSk0TbCVzHWO9ARAfs+Bhf9ZKEn
	BK4dt91n0qhSpoWRozYpt4tbhoTBi69L3UFACCLGdC3p3B+cPB7QpHS2qywpciOEheQ=
X-Gm-Gg: AZuq6aLr+H5HOgW5SSPIu7AV1KoxFNytb11B+Wumb+e5aQj0DUt5Xh2CaX2v9SXSDSg
	0FrKy+kc+zNbSK3X8olTmiEdqB7zSIJS53OOdSbY+EXdjhJOn4TIC9S6kIBkWXvVrhU7V7K9b4K
	TfnalzyI3PPHS8KoDaoYqyPoumSn8SDzCaX70fye8Ai2jscQzuPpxUSVw+vz1eTLsUzoiGThW6T
	bZ0f9ZXZlO2OFETD8/iiTSctFm8uZF5+LcwqDBwTpNLg8xsSK0hmRbi+zlgU+y/RRScU5ymcT6O
	vheE8BIIFtfU9XTMstyzLg16zv0v6LgE/gQmb68jIDxIi5UAS90h2Q7evy/PPhlJ8QgVZD2xiMW
	fux6DDkCOdn/sgHvQ0NcIgdmypVwR4kHPngj1aAyWjER+MKStDCtoHS5/rUN7KyEZJSPVXVDgSG
	0J+b51hU/oPueEofcUOdCZF4t0CBrvRxsCNfOwLDqI3jUM3S8q
X-Received: by 2002:a05:6102:510a:b0:5dd:a616:69fc with SMTP id ada2fe7eead31-5f54b9e82a7mr881073137.9.1769179339645;
        Fri, 23 Jan 2026 06:42:19 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9482e37e7acsm473952241.13.2026.01.23.06.42.18
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 06:42:18 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5eae7bb8018so703013137.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 06:42:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbzdsR+4DmWI7N29JxU87irDbLw1L1VdK6tXuttZEOz9f/jJG00ozPxyUKkJzH+eiDDXXz2sEAYdw=@vger.kernel.org
X-Received: by 2002:a05:6102:3ec1:b0:5df:c228:288d with SMTP id
 ada2fe7eead31-5f54badca71mr922168137.8.1769179338018; Fri, 23 Jan 2026
 06:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com> <20260123140031.94752-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260123140031.94752-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Jan 2026 15:42:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWV1zUaHTfToV-KcK+7Gtr6pG1f547-wwuFxm8rqicSeQ@mail.gmail.com>
X-Gm-Features: AZwV_QhVxxcKWK1L1APmdxo8PbYPyqK8ra6u83gDCmRGJACGU8TN-Ywh_mSZ5zc
Message-ID: <CAMuHMdWV1zUaHTfToV-KcK+7Gtr6pG1f547-wwuFxm8rqicSeQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] clk: renesas: rzv2h-cpg: Add support for
 init_{off|asserted} clocks/resets
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
> Some peripherals may be left enabled by the bootloader but should be
> explicitly disabled by the kernel to ensure a known initial state.
> This is particularly important for PCIe which requires proper
> initialization sequencing.
>
> Add new macros DEF_MOD_INIT_OFF() and DEF_RST_INIT_ASSERTED() to declare
> module clocks that should be turned off and resets that should be
> asserted during CPG probe if found in the opposite state.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>
> Changes:
>
> v2:
>  - Added reset-specific assert on probe
>  - Removed Rb tag from Geert due to previous point

Thanks for the update!

> --- a/drivers/clk/renesas/rzv2h-cpg.c
> +++ b/drivers/clk/renesas/rzv2h-cpg.c
> @@ -1337,6 +1337,15 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
>                 spin_unlock_irqrestore(&priv->rmw_lock, flags);
>         }
>
> +       /*
> +        * Turn off clocks marked with init_off flag if they were left
> +        * enabled by the bootloader. This ensures a known initial state.
> +        */
> +       if (mod->init_off && rzv2h_mod_clock_is_enabled(&clock->hw)) {
> +               dev_dbg(dev, "Disabling clock %s (init_off)\n", mod->name);

rzv2h_mod_clock_endisable() already prints a debug message.

> +               rzv2h_mod_clock_endisable(&clock->hw, false);
> +       }
> +
>         return;
>
>  fail:
> @@ -1585,7 +1594,7 @@ static int __init rzv2h_cpg_probe(struct platform_device *pdev)
>         struct rzv2h_cpg_priv *priv;
>         unsigned int nclks, i;
>         struct clk **clks;
> -       int error;
> +       int error, ret;
>
>         info = of_device_get_match_data(dev);
>
> @@ -1635,6 +1644,22 @@ static int __init rzv2h_cpg_probe(struct platform_device *pdev)
>         for (i = 0; i < info->num_mod_clks; i++)
>                 rzv2h_cpg_register_mod_clk(&info->mod_clks[i], priv);
>
> +       /*
> +        * Assert resets marked with init_asserted flag if they were left
> +        * deasserted by the bootloader. This ensures a known initial state.
> +        */
> +       for (i = 0; i < info->num_resets; i++) {
> +               if (!info->resets[i].init_asserted)
> +                       continue;
> +
> +               /* Check if reset is currently deasserted (status == 0) */
> +               ret = rzv2h_cpg_status(&priv->rcdev, i);
> +               if (ret == 0) {
> +                       dev_dbg(dev, "Asserting reset %u (init_asserted)\n", i);

rzv2h_cpg_assert() (actually __rzv2h_cpg_assert()) already prints
a debug message.  However, it uses dev_dbg(rcdev->dev, ...), which
I believe will crash in set_dev_info() as the rcdev is not initialized
yet at this point?  I think using priv->dev instead should work.

> +                       rzv2h_cpg_assert(&priv->rcdev, i);
> +               }
> +       }
> +
>         error = of_clk_add_provider(np, rzv2h_cpg_clk_src_twocell_get, priv);
>         if (error)
>                 return error;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
