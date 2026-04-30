Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8153D9055
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550409; cv=none; b=LzELPA+usWoID99ogyjMaCNQ5BBvyuqMYtvyrLVoJtR44SwRzY0W3bzjQF4o87Wq2PQ/0a0SdmlOGmLT2oItiLk4oMzg/gpMEUkBEWwEH/qOkZDXxtC13g1MRvAf1Q/hnSjswf3RZpWMQgfDo42Qr7bmsSP2UEiXpeAMXGlRffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550409; c=relaxed/simple;
	bh=EZZ2E4Hk4P3ioWVMaervDcnw6ADW65oM1zGar71sbpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPPXfu3OyLtROPYvXC1GjGPgPXwGEfCDTTNeqKKfP3xJf/SYtHtXenpQoqoU5KbvCwvuxkq+nSj58dMN2yvfN2HRm95VTGwIAOP0rVZPQg/8W/rCBQwJL8BOAS0jF4RTbLIPQkr5PzlnCh1O5eDsS/gsUCV+EizeM6hCF5KsxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56eee0ba462so555756e0c.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 05:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550407; x=1778155207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksIL4rip+tLI1Yx6QhQXSN6krUTnsd9SRkVzjQXrZjA=;
        b=tB8yoz4WdUzVDImOUrEB39WrS2Gnz2cMkOd6gdv00K0PA/j+4HsOK60N9miLRwPcwu
         r/bzKVJRhy/Hd1uBU5+LKJ0wlvnEeJgovjVoldwZjPsvAH4vlN7dA0FeAfulfay4MQ8p
         6LXKEror79yOFOUvzSTgaxhOstD/aZfdSDP9Mmbl8vY2ssM4Uxs6disZ2yzu2SHj+8+n
         +ppBB8W/7UZ+afe5qdUE2zfHfMfo6DMQJJSazLWB7VLASXoaMrbGAF9gxCbJkEMdQv4q
         UIPEI2byCJVZZn7yv3T0lZ0UBOFgWXo9oZC2Xryz1U8mG1+dskThXjl3sRq1P2KLh/Yt
         R4CA==
X-Forwarded-Encrypted: i=1; AFNElJ/WNdlWq8K7/Kqu+u0uFaVpSMb9NCcDxENFFfxtogpTnOniD4i4a3JbSOJt0cTBqRAnh4bY6P2veEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywha0QeBF/ohL4IWF3C6vJ3Z87AzcLLsGXd8wqNijOGc4LomPRk
	kR2E+wtvIpNsK5TtNfHxKlYP8Gqu2qmxcbRBgey9Wn5BSmLlqQSDqe1QebpPTVNcCSo=
X-Gm-Gg: AeBDievtLiaXva9bP5GFSs92qPITPM7HGhd0dUivmyTj3KuD52Ykm4DtD5W98QETNyL
	rgaM9SVsUWW5n1yY5C+wE8ad4kbYzPc3I0PFuA7698ZBT76DoWhK5ZL9Zw5hAyS/FCmlFBFSQ3L
	OmKW1cMrqwF4w7Oq1fDCjB745GyqIhMggUuBTQvzmeU6CJ+qvf4NIh33SkkJrG6taasTc4Bn+oJ
	rlsBLHdZnxAw1uAmTwqiOSdojqK4pUduvnWtKZ0N4KfsdDYP66nTGRG8nD68kgvg2j2XtncFe3j
	6Oco6w70Y2I3cbagYBXnK1Yalb2uku1GrKUzWwRpELosp3ONL0bQIPa4vNP+y50gEsQgrU82Fl1
	DkxryxPrz/LN/1UpehUocY/JcQtheE+LOkD86ud3Mc3//EVyq7QlysFFY/1Y1ee5DrTuLtCkZzQ
	iHKKQk0IQjLm2LIZt9tMZKTsvWX+tv6CvOtO7KhoRJoUR8fLIexU0rqFHw86293vhFodWdRj4=
X-Received: by 2002:a05:6122:4885:b0:56d:3451:4cc0 with SMTP id 71dfb90a1353d-573c9f53d63mr611775e0c.7.1777550406731;
        Thu, 30 Apr 2026 05:00:06 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6df59edsm2830770e0c.14.2026.04.30.05.00.05
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 05:00:05 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-953a5defbbdso534724241.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 05:00:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/tlrWjfQ2MhhwWYP6JmvrK+HHTJbSeBNmHgIselJkjauQd4fHNApbpy1ATL544nbwdfAtNcfO/GYc=@vger.kernel.org
X-Received: by 2002:a67:e708:0:b0:610:347f:9f3b with SMTP id
 ada2fe7eead31-62afc506100mr613209137.3.1777550404889; Thu, 30 Apr 2026
 05:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430110652.558622-1-vladimir.oltean@nxp.com> <20260430110652.558622-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260430110652.558622-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 13:59:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
X-Gm-Features: AVHnY4K0yYb6vTu9KdtDciwvAziqboYRX_ITZ386sa6ttixZ1EP_Mzy9gi4Pi0E
Message-ID: <CAMuHMdWbeeRmLf6Ae0Fr0un=-z7z5ONc_hDdjebP=KVkXHPbhw@mail.gmail.com>
Subject: Re: [PATCH v7 phy-next 17/27] phy: introduce phy_get_max_link_rate()
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
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Markus Schneider-Pargmann <msp@baylibre.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Thu, 30 Apr 2026 at 13:07, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> In CAN drivers, the transceiver is acquired through devm_phy_optional_get()
> and NULL is given by the API as a non-error case, so the PHY API should
> also tolerate NULL coming back to it. This means we can further simplify
> the call sites that test for the NULL quality of the transceiver.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Markus Schneider-Pargmann <msp@baylibre.com> # m_can

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 3 +--

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # rcar_canfd

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -57,6 +57,7 @@ int phy_notify_disconnect(struct phy *phy, int port);
>  int phy_notify_state(struct phy *phy, union phy_notify state);
>  int phy_get_bus_width(struct phy *phy);
>  void phy_set_bus_width(struct phy *phy, int bus_width);
> +u32 phy_get_max_link_rate(struct phy *phy);

This (and all the existing getters) should take a "const struct phy *".

>  #else
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
