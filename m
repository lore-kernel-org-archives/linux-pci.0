Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFBE2405EB
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699836; cv=none; b=boiZSVDHqk+xQMO4t1xLOpfRdUCUFXbifvqAGpSfoMPhTjfu/ffamT0JLjcy1Q/uoRLDgT755J7W1qXcKBXttBkCCUIbhrFRCi+bRWqT7CTATIFEiys7lEMXgYzDoS7l9lOTD67BpKwZRaZz50rE++vX58fA+RhmJoQwzalybqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699836; c=relaxed/simple;
	bh=CSh/OPgCewZMrxAGotXGAjNREHTmD2ri4RotS2E+6yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eovb1BFgsQ1F4INpyKEp+bOMkWRQ1d/DNCZRTSRKT0uf0lrhP/1oXT8Khan7//qOi6yPi2ioI4smOjRr+e80Ya603Wo8QaZ1yN6nBObW2VNb4dHnZSZt1NciSdfGlH6xQVI+S9cXN4veRqVpMREH6NUYSbLIK9WiUGS51tfjCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4138136f02eso2271558fac.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 00:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772699834; x=1773304634;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ymdw+XC/6Jy9fN+NX35+E/o8bLZmtxZBZ4e3pQeTxE=;
        b=SW/yzxEy2LlTyIt1rM8eOuC/nBEHTuMeaGFv8piiZ/zydhw52sW9RjQCSBKnzKZxmg
         parISF5tS61L9y5amMeeQBuX/FFB/6AymRXyShc2r5evOxPOt5+9a5XuGXyghAGrkngu
         p+Te25FNjL1NNIUJ9uV2lOrJuUlh7hHop6W7Z7rdWXPtQiPOQ4pnvK7KbxYIm58IY93i
         vuVjPg0GXou4cb3Rln1maHgDNd6edw3e90QP89KINQyaOeg8AKWArKLX11/wbg3DVlzf
         EwYvDCw+xGa4wVHfjbomGDM5TfqKO6eaKkOLzolLMXqeMQoV4nthr+qbM8d5zZ5ogiRU
         OXgg==
X-Forwarded-Encrypted: i=1; AJvYcCUJmgfTIFTl81ahCH+CA2Op0f3PKEFV89ccZFUNPjrzGm167j9qfiNV8N7ZvZ3KTJUZpCyHJ2KI2h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLFhdkE+yDK34OQtWJ2Wl7qN6byivA8aDRcnzzoBL0kOrrthW
	KzS6NRh9v/DpLx8hBp5+BsSvCiIjhR7GkdFR9NQ+211EuuRqsRYCuahxCYV9Z6JW
X-Gm-Gg: ATEYQzyesPzR+sK8KHJ++UqMxKMO8zSYWnCam5+k1ZVE/1D7ksq9heq74IclqpxQGYF
	R3gY0g3fAR0ntOod2T2cxXW9y1GrmYPPNSMkjPQRwNCJvP+CanJ3HRkDqkZhbXUCHhbeI7mEJFn
	JYvS4pOraS4uUz2jnurlboNwJ8OMV9yxtGQzsnR8o7kU2fggop2RcYTnDVAFMPOPJ4Tf1MJWFYo
	BuTtedNjOLEsRu3L2M4FvSUCw3pPPJYdAvyheCw/+1L0LpKkRSKseYxZqsk03IqUq2wg4suZ/Of
	DKLqBbY3Wh/YsNQUiXbWvMEGrlgECD1V+O7SQC04OiS3clgEFTWBeVsQYOuvo0A+BvXeJ5qa2wr
	OXwMj58h+UGVi+raT3BBwKFyYjogxFUsOYGweBB5IyoO/KRQx55a1BSnkz7h8QdQhepBBeA5iT+
	1VUbvNP/eZaVUsb6KshgDzGuXSsehGaKBSC1XuFQaikeO9pu9SHDSqoXVbmnFw
X-Received: by 2002:a05:6870:7313:b0:3fa:ef4:3e3f with SMTP id 586e51a60fabf-416aba5cab6mr3375242fac.33.1772699834267;
        Thu, 05 Mar 2026 00:37:14 -0800 (PST)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160cf2572bsm18651581fac.2.2026.03.05.00.37.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 00:37:13 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d55b97f358so6130987a34.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 00:37:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3LPIg79/6SIfsG9+TDfIC7WMGJNhrnzxjE76SBcZGE0c44qEftrI0KozMIW7+6jbaluu/ZZ0ymwI=@vger.kernel.org
X-Received: by 2002:a05:6102:2ac9:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ffaaa86250mr1899404137.7.1772699399463; Thu, 05 Mar 2026
 00:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-18-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-18-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 09:29:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXUBhpnFEnnTfyPdECWqNmKLweupX=FY2SedYA3bapG2g@mail.gmail.com>
X-Gm-Features: AaiRm53mHozL13yvxji6rv0MKzaGvWxuhr7SWHD2SjBJ0VWNhqppZZeXezGpDhg
Message-ID: <CAMuHMdXUBhpnFEnnTfyPdECWqNmKLweupX=FY2SedYA3bapG2g@mail.gmail.com>
Subject: Re: [PATCH phy-next 17/22] net: renesas: rswitch: include PHY
 provider header
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
	UNGLinuxDriver@microchip.com, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Michael Dege <michael.dege@renesas.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> As a PHY consumer driver, the Renesas rswitch dereferences internal
> fields of struct phy, something which shouldn't be done, as that is
> going to be made an opaque pointer.
>
> It is quite clearly visible that the driver is tightly coupled with the
> drivers/phy/renesas/r8a779f0-ether-serdes.c, which puts heavy pressure
> on the Generic PHY subsystem.
>
> This was discussed before here:
> https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skbuf/
>
> but to summarize, it is generally expected that when a Generic PHY
> function is called, it takes effect immediately. When this doesn't
> happen, the PHY provider driver must change its implementation rather
> than the consumer be made to work around it. PHY providers which rely on
> a hardcoded call sequence in the consumer are just lazy and wrong.
>
> The most obvious example is commit 5cb630925b49 ("net: renesas: rswitch:
> Add phy_power_{on,off}() calling"). Problem description:
> - Ethernet PHYs may change phydev->interface. When this happens, the
>   SerDes must learn of the new phydev->interface using phy_set_mode_ext().
> - drivers/phy/renesas/r8a779f0-ether-serdes.c implements phy_set_mode_ext(),
>   but this only caches the mode and submode into channel->phy_interface
>   and applies this to hardware during phy_power_on().
>
> The commit author decided to work around this at the consumer site, by
> power cycling the PHY for the configuration to take effect.
>
> This had a worse implication from an API perspective in subsequent
> commit 053f13f67be6 ("rswitch: Fix imbalance phy_power_off() calling").
> It was observed that phy_power_on() and phy_power_off() calls need to be
> balanced, and so, the consumer decided to start looking at the struct
> phy :: power_count (the technical reason why I'm making this change).
>
> This is also wrong from an API perspective because
> - a consumer should only care about its own vote on the PHY power state.
>   If this is a multi-port submode like QSGMII, a single phy_power_off()
>   call will not actually turn the PHY off (nor should it).
> - the power_count is written under the &phy->mutex, but read unlocked
>   here.
>
> The rswitch and r8a779f0-ether-serdes drivers both need to be completely
> rethought in terms of Generic PHY API call sequence. There is no quick
> fix to apply. Just include the PHY provider API along with the consumer
> one, to keep working as before when struct phy will be made an opaque
> pointer to normal PHY consumers. But this is a bad offender (and it's
> not even a provider) so add a FIXME.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
