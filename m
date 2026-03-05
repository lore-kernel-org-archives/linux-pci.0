Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7702F319851
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696881; cv=none; b=dghhPJvXb/hjz3kbCQG+o+FNfnBZKhD4IpWJQWzz9d2Jp+ncDSJtgj6YMdmy0GDXPsUFPtUGxBPPi8uPMLI94okisWqKaxDo5mfW0iH6hMqoD2G+tqtDx9tuGYtOecC6MNKGLstF05hgQbQe5DdFVpmewK4bI7JtR4CONRVhjBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696881; c=relaxed/simple;
	bh=urVD1xPdaF3hV5GqXqVqTidMinFWi7P2lc2J0G3o7gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggY8+DOmy6kiDwy5UcgYTCCg/Beb2b87HmrzMDIfVF1yRealmKpwgSnXiufWZGZozQTaIK3CLa4Pf2zHRq4ITr1Mf+R2mztPSARwIYF8SoICPwxtV8J0+HMB63IBUSPjDdle5B5sKPoHY1u0PrHtDNdr255VSimrq77BN8TTNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ff1703cb9eso2132725137.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696879; x=1773301679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xyHjzGnphi32H4Bte19x6wQV76UaiJqzbc3zMkJKs8=;
        b=v2eAPYtbt/pzci0xhPDzUT45cBlEx4Rx8kB/zFr1M8sxXWlc9TQ9qRcK54kg1n6HmU
         6pnHkt4H5v5fch+BdW5vlz9UpD4LvgVp18cOPJgaSo9CDQbDQk03fXC84XUKtRkdSs3W
         3vyZOqVILGCfPduAAcOwZOhvdBC2CJ06qd9KNphoU4zn+ICOanIvpqs6JuqqtV5lT9zq
         LClhYVafcMogOhjsXr8UjOg67edw7k2LxRMY5XT5lR0K/1Y05gDpmjRIg55Uz9nMpHLf
         7BfxuLnHIWiiHXw+hNInv8xmo9EpDIb4f47adePx2OkqxkfAQ1uTgY1hzj4uFCPpKUW5
         rTvA==
X-Forwarded-Encrypted: i=1; AJvYcCXl2yfYNz2e1wbu6FvnO3V1Aqu/uh85J/if10Z+ynJAL53dhziMRD4CkfDoRBU3Vi5wjWdervUSWmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqThb++eANeEe01HawXlp2C+aosBHE06U6c6Zq20xRMylk5j76
	0VwEvT/33YHTbvKMeU+bnSprMFMkiWDX7PltBvlPVxziR7nXcaDZVPcJHc33BBRM
X-Gm-Gg: ATEYQzzchxG8ls01sA16XK1kHWhCsAgwfvelJESkq/7IghITL/6WP4snET1MKetFdFc
	DfWDBXPl3p0Y4xlC2dMfEPJwaBLFE4cXtLGFoLget6w9EcLmio+UtqFx1KP9H6MCm4Vbk4dI7To
	BtuQuoKXdGCLVki6iksk/QRUJkQlOhXGHO6/aQXaBl7MB9r1THN8GN7O7FsHutLyHztbQrHdf0o
	dboa2GOtNQ8NJN6WfUQlRPg2Ej3yFAplRXEatKD6/5jZbGmjf3nbo4No6RLQyMD3OA4Ibv4rfuU
	mIQV8uWnvWaVhcG0rV5ekKWJG89ccJYrDFh/g8H0izyTPyzHmuNPug4v3IVZkwmDcteHkJeQWu4
	EZjy6mEgCBknwg7NAUVUtNGbVeM9tFnr8spX53TVnZoh3Un0B9uT75e6+V/1oo1IxIGNr2f9MjM
	A23wJRbal0Pwx9izGFSwqCBRLXAc+CM92O3jRhPYrwtFNyMMvb/AqQALSjm8dI
X-Received: by 2002:a05:6102:dc8:b0:5ff:8b8:9f89 with SMTP id ada2fe7eead31-5ffaaf66716mr2083551137.35.1772696879404;
        Wed, 04 Mar 2026 23:47:59 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffc3bad550sm2190478137.4.2026.03.04.23.47.58
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:47:58 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffa0b23a60so857996137.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2xR+fuyeLVDWrkhvTp59uWuULPgncaHPciVPSNMoyzGQMZ/yP/WeIkwRDtIU11Jnwb0k07diX7ho=@vger.kernel.org
X-Received: by 2002:a05:6102:32c1:b0:5ff:a16b:93f9 with SMTP id
 ada2fe7eead31-5ffaae2d5b0mr1883200137.21.1772696877960; Wed, 04 Mar 2026
 23:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-14-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-14-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:47:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
X-Gm-Features: AaiRm514iMGAdfTBAVsgfVfK-GGHy9jHY4ezK-Lp3w09-JWpnENLQ0I4lkIFgvE
Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
Subject: Re: [PATCH phy-next 13/22] phy: introduce phy_get_max_link_rate()
 helper for consumers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 2 +-

For the Renesas part:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -640,6 +640,12 @@ void phy_set_bus_width(struct phy *phy, int bus_width)
>  }
>  EXPORT_SYMBOL_GPL(phy_set_bus_width);
>
> +u32 phy_get_max_link_rate(struct phy *phy)
> +{
> +       return phy->attrs.max_link_rate;
> +}
> +EXPORT_SYMBOL_GPL(phy_get_max_link_rate);

Any specific reason you are not making this a simple static inline
function, like phy_get_bus_width()?

> +
>  /**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
