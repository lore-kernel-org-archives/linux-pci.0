Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A18372EE8
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699344; cv=none; b=RgYbeMHK37yuuOtvedxMZQCFyBaziN1jeqXx8gI60NzD+/YnuIkitrHx2jrZn9AHqPi5gJ6QdkjrpSreWMSK0ay7Qun4lx7fAPl1NDjU25Ma4IQnE0hdXb0g/4ZCLDgplFrDLgXsytJ64LcfNvwYcSVCTwqnqcy/qPCVKSEFRi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699344; c=relaxed/simple;
	bh=hefLtFvtSppGuVWRD/xSsfWMjnGgnQggEUG9Y7OFLDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGzOMc0xW+QboeFQOxhuGqYIKTo5r/ijiRAwr3hgwWJesDSbbLp8PtRovHhSlIisk6NRTJSBoHFHINi0FguSZc6LoDwnp/GuibjVizyBQkS6P1MJrvLOVnyFrkZ3vLSjXq0X6raCNYHy3fNiVyvNALoGUwhYxUg+iNnPXXgE6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94ace5d0e39so2297216241.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 00:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699342; x=1773304142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlLnToI6SbxsSn7ypnmaqq1RX+miw2VMTyDHKi+gwbk=;
        b=NOv0hoHkTYnrI1f7oEyFARq/9e9QufDgAn1tW/oG//TUZRhZET5oz5RBgk23JCA5DB
         fLq6w7GVlHZlsw6SBX5ZtsqqdCJbcYm4LqqPJZeNCUIJ/bTtH3tQnjI+mVV/81GnBNsZ
         posgATwxHsvAXvosLcyHv8i4UrX7oNgqAas6NCbAA4DFlt7g6i18kygbvYpX1Ng0YOdb
         CL4/sQfdG6y+CKt7naFZ4LpP5kbEeQ4ZnkQ8BaO5YZo0hxSpwGN4CETJO8UJpnY2sxdK
         E99N7RuRodg/HQ8J3KN7pfPnL616TqmLJppFRcZ0NIukWywXxAoxFHE1708vVFc6NOv3
         /tQA==
X-Forwarded-Encrypted: i=1; AJvYcCWwUAD4TeiJkHue+8Hk3YVfOtIU3KwjL2Oni2AZzl80HMcZ5X1q16BTpcC0mXK0mvj1frKLZY8ZFbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziByVY1FGxB0qr9jgKP0zXwLLbivFxPJoNDtcu42N+83GF57Ne
	4IIapJQFDeMtxZkpjmm1AV7zvtFR5T+7PzfsLmNdE/JDtQOK+mG7rZqWRree2c/C
X-Gm-Gg: ATEYQzwrsZUCxfOOC0S7Ta4mjTNZ1RORzIw8/Mt2e27eID4S2Qo2AQVn5PIHOY+OQdt
	lu1Qjz7HqmkUOxsGgIW8vPSw7+qnup7CAzLWMf8tZwG4kI957e3aOnHLIqt52DhHNFbl/fSFFQS
	QAq7hJV4/L6JuqAw43l0juh1krjOTtk4mYPyLvo5it7CaSxU3a6X9FaptgAA8Ge6lZPnVY4G1j1
	DffgmWlaE89QM8nqI4MuquGuiJCqbi00hiuXyFX/pe2pic2Sy18IHqSnMvGFVysOiYzxlRbwb/g
	QRI9T8CwDsRcLUbIy36CviVcEYPfAMdopxG6YJS0tI/1yWVqV+2BjSqCfvGUbvGt0Bh/tSj7lyG
	nik0Gcl024zqdJIgMmXk5/XwNCVwwlkRW7NZUmUMz/lLTg7Xwv1ZtB7GZo4FLSseFDWMuyBM9Dm
	OtW5Q7LJkXFUO62TNV1tp5iCb8vm1TI6NHRyua9ERXlnUn840/5w+bya5JP4oN
X-Received: by 2002:a05:6102:3709:b0:5ff:2dce:82b1 with SMTP id ada2fe7eead31-5ffaaf5d425mr2010475137.31.1772699342267;
        Thu, 05 Mar 2026 00:29:02 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65b281asm20198580241.13.2026.03.05.00.29.01
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:29:01 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ffd57b6fc6so8172137.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 00:29:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVinSOy0zXd124wOBDaqeI9rSkPHDlXLXWR9uL7Z3ahQxkffwoGfjbdN9A1ATCoeLwND1da71Se/Hk=@vger.kernel.org
X-Received: by 2002:a05:6102:1607:b0:5ff:c64d:228c with SMTP id
 ada2fe7eead31-5ffc64d2600mr724913137.22.1772699340961; Thu, 05 Mar 2026
 00:29:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-13-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-13-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 09:28:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
X-Gm-Features: AaiRm50Kgxrt1IEt_9GEmeNyCIrylErpUd7qkh7D4FIoK_FYituUB8DTITetq4c
Message-ID: <CAMuHMdV+7n==crPmitH-JCwtJiH+7LaPKZQYU4ZqX_duo3_7Eg@mail.gmail.com>
Subject: Re: [PATCH phy-next 12/22] phy: move provider API out of public <linux/phy/phy.h>
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
	UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:03, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> The major goal is to hide the contents of struct phy from consumer
> drivers.
>
> The idea with "phy-props.h" is that both consumers and providers make
> use of some data types. So both headers include "phy-props.h".
>
> Two slight points of contention.
>
> 1. phy_set_bus_width(): Vinod explains that despite the current caller
>    situation (9 providers, 1 consumer), it is a consumer API function.
>
>    The use case is that the controller (for example UFS) may have
>    limitations and should set the expected lanes to be used and width on
>    those lanes. A number of Generic PHYs can support multiple lanes and
>    multiple width so this is way for controller telling I am using this
>    configuration.
>
> 2. phy-provider.h should go to include/linux/phy/ or to drivers/phy/?
>    We do have 3 PHY providers outside of drivers/phy/:
>
>    drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_dphy.c
>    drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>    drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
>
>    but the practice is not encouraged, and with time, these should be
>    moved to the subsystem. This is not something that I can do now.
>
> For temporary compatibility, keep including the provider header. This
> will be removed when abuses are all gotten rid of.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/phy/phy-provider.h

> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -1,246 +1,38 @@
>  /* SPDX-License-Identifier: GPL-2.0-or-later */
>  /*
> - * phy.h -- generic phy header file
> + * phy.h -- Generic PHY consumer API
>   *
>   * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
>   *
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>
> -#ifndef __DRIVERS_PHY_H
> -#define __DRIVERS_PHY_H
> +#ifndef __PHY_CONSUMER_H
> +#define __PHY_CONSUMER_H
>
> -#include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/device.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/phy/phy-props.h>
>
> -#include <linux/phy/phy-dp.h>
> -#include <linux/phy/phy-hdmi.h>
> -#include <linux/phy/phy-lvds.h>
> -#include <linux/phy/phy-mipi-dphy.h>
> +#include "../../drivers/phy/phy-provider.h"

Shouldn't there be one more "../"?
Interestingly, it compiles with/without.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
