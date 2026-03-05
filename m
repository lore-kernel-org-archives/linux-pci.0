Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC483375CD
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697212; cv=none; b=IcabsN/MpdFlO7c0TR5eQmA4AG5wtEg1EJksj0fejqMPXS0qZ7g4HAepgQS18PXpd80/KGK5NLL1ziRt4KVbiZicrKzYXLVshNmBDS6soIc7lSh8EWL+AUtEfNS+SVNRU2PWqq+bdUfa+QMoFEM59hvCnGNGxaAi6ce+TWFZ/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697212; c=relaxed/simple;
	bh=1VrdyW7eBzn3eIzcJ/qwIsXSzypVzRQDxfUgekinKYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJz2yiz7rbeFmkpd8O6Bl/i4Rex8hFLKAUzx9+PWZ2KZ3SYPV4HAK+rNwnxiKOqRSMJ90M0pgOo/jM1Iu9yLi8TuU5EdeLmKlmGb+tS8V5/4PPpt4cHe6DqNdRG45RKXm1Tjnu/Fq07LUzULtogDugsRDc4xbcqlHlToNQZBdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb3fb47559so902115385a.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697210; x=1773302010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLWXJFRzKXYfvRWexgs1gCb/dTgnevi1M5AetCjur0g=;
        b=LYkUW8ymt3VVlQnAuNEUOhXk+IV7srjMsecdTtnCBidn9RrqdEd/Gi/BLilnV/r6z0
         8HrLYdXtaJzfD1pYUazh9FwmqkgZ4TOxUD05d5aZKHZwr7/PsV3iVYS9RmcZ4DShTX2P
         BI50cJmb3vtN7Xz8iKjrYErI3W5EH64V1QuwwJtQqmn0UuHIsWRMpnIEok0gqhlk7imN
         ZiPrGVNgcrQ3+MBZg6erdw1KheHzGwqNHZo8aWzq0D7AeHB9W5AA8xl0Ujpb/F4/WESf
         5m/GdqA8AW5bTiSrfLnM9WHe5tPpZtkTV8S6ke2gL1DTHd91HWTuXzYF9HG6moUSEQSc
         wrcA==
X-Forwarded-Encrypted: i=1; AJvYcCVDmpSku5wAYTLr9tQTkYR260Frsm8c8LIPoE4BGgKRIw3pVaXmZ3L13OZuhmZfyyUBKTUsjEZKceU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1Jiypk0yBY8wDEOVsuAMNpzUIu3//wERGLI3QS0tzBPe8bY9
	wLtgByth1TnTpoCQEXFjRHAd/U7SjtjgoReP2AW35Rpr8hIlcpSJtd+VP2Jbse9/
X-Gm-Gg: ATEYQzwSnf42OfmDPifeaBGjojXlSmWLWpkZthgnlW6SYDX8AXhNqLlFbANr6OWkTnG
	hrKXuokJA2RNmpaNv1jiyTxJmcXv1tivy7Sdqdfs3iDIP9aU1t5y8FmijsFrEdtsYXXM99gvYEU
	qFRDcHoB9KJyQ/CHWumN13aSttDP9k1voyM/zL6bGywJVYWPt4Od+xHH1sp+c5q3ZW3coYtY0Sk
	JoXTIDGh7sp6De5UImZQTn3RTjWIsTchq+qmHJ+fIap6qbD2dWi7HqvgonhDtpO7HmxazaYAFq/
	SAIjxkqJYENrWwUb90Ff07gPBNCTBecuYikoebT6taES8jYdefbT0Qg17VQb/bhF79WsxIv/QBO
	iDIyuYVHb8LPnh16InPTbWemYc9LDXC/2/+bv2l/6dV7Uq4M1tA5bnzqnpx8LPZIf27PPE9lID2
	RdMeEN9Y7bRbqK1z0DcZNGNDrS9sBM4e+bgni76/kwODvswFT1Q41bKSA40yBu79iZ
X-Received: by 2002:a05:620a:4612:b0:8b2:f090:b161 with SMTP id af79cd13be357-8cd5af0da55mr582899185a.32.1772697210622;
        Wed, 04 Mar 2026 23:53:30 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf7319bdsm1850397085a.43.2026.03.04.23.53.30
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:53:30 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb3825b0fbso757199385a.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:53:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrWwE7gHIlRyhm4L7nras/cLZmoRVk6VX9OfR5ouidFiOsUbCMG68H2EoGOjh6s04LplqOA+GAKoE=@vger.kernel.org
X-Received: by 2002:a05:6102:441c:b0:5f9:3a22:85a2 with SMTP id
 ada2fe7eead31-5ffaac72675mr2059267137.12.1772696734612; Wed, 04 Mar 2026
 23:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-6-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:45:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
X-Gm-Features: AaiRm52ziEM93YxO07h7pOV0rTYZnULijxTOwLRm9EW_k_lOxLulmwK4PITV2jw
Message-ID: <CAMuHMdXA67BO8Umz8-4jRg1SLvtZUSEzK0p7WxSvomnBk+WiyA@mail.gmail.com>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where missing
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
	UNGLinuxDriver@microchip.com, Peter Griffin <peter.griffin@linaro.org>, 
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  drivers/phy/renesas/phy-rcar-gen3-pcie.c       | 1 +
>  drivers/phy/renesas/r8a779f0-ether-serdes.c    | 1 +

For the Renesas parts:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
