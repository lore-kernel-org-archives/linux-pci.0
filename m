Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4023BB669
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600427; cv=none; b=Xt2+lSsF8ox6aZmOngeeOMtvh49spmacnDCRXlyOlhpMCGn5AzFRxLZb6/WPxhbbTUZPRMmj1UiANOIkzGjXS1x99m6ipZpY5gpLS8Aa34oaC9mNyNNDQjYjq6Jm6dTdlJeitxhSZV2jOhLmcWTLL3SNVloz2ZsivEGcUoOxmbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600427; c=relaxed/simple;
	bh=J1UCxf74Usvo8/m/zisLMoMzaDelPgwuv0YSMGlmZ0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLexzZE8pZj9Wb84iheAMYZIzjUuMS5xnEDWGlk9a448/ZP1T/nLwmmbdbeFU/ppKkmYBXbnqZ4IvvaVoBELtV5XZeI4eBHMAbQqExeWhtw1euQc1URwbJuCAB7VCiVy7Oj+cndisWkdNHUx3bZewv2zDt8DtQ5l5JaotQUNPH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5ce4d8751cbso606514e0c.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600424; x=1791205224;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=swC+rKb42cR1zlVWS2oz+HcUhOn9Ph47VvSZUMBtH00=;
        b=hXSrSAHOm0MrH285l74UY9ZhJ+Gat+HkvHQK8SXiVAfKqNoIB0iI66YBVwAv5VRqX0
         RERWPeTIid4U+9o3z7heG4bqqiaDcW9r6kK354Esz/YNQSNX1qts9TARFhRzUf5gngHm
         k48p34SEzEmW/8fx93lm1+hPKvoYOMpUPqq6qx1NV+onQDOdmSKRbBvdUtbQ3QRQRD67
         7vtD3Nppaa6dCg73x1+3YozNOb4uw8gk7x86rKk/X3+v9ji5kQM7vDvKbHj0iFdbO+gq
         IBYB4hC0drtR2QwzB/FL5HaOtP7Cg/rC+cI5JZpgbAzYyfrMV9PWBAmMtn/hyEXO6qQ2
         vBsg==
X-Gm-Message-State: AFq9FYKuGqvziIhdiCIPtK0beVlGP/p+7y17/Sg5yzlj1SiK5iDYPI38
	4Jp43e9eAvKe2ParWFWG0XJ7gUENbebdoY9PUlmbJZIZiIBR0DPk7Dhq+xic5Ob9
X-Gm-Gg: AYBFou3WyUPHvGmNf6q9TqhuRyV8CFhr3WXBoCaS+N4w86ob9R5GvGIU0JBFXrxyKp0
	cHwfOU/HtSYdLwZjYXXaeZNXrZA7o66QUb5rFuntJ/xWwHm+X+iAN+Vkcw9kNRgLpLvtAKBc2kH
	bg6akdyqGu+JJBqo3thXgmCdXjjqzNE3YFjh2lcZRjc6Enlx3IzuXRe+iiCcBFeZ52+21bn9oDJ
	ccidq+hDTAr3/FEHMsCDHwbXaSJbNEs9//Vy39KRCVm4LuQFxr+rwM5ScWUVyx5vkprDEki2e4a
	Fjw7iBZUMieiIXZTUjxRVM6mb0QjBXHaoPNLfLN0OjbdzRPXmBS06oJINWnEJW67PnUIapW55aV
	ty3FiY2BGmUuu4B6PhJiCh8qoABUfF3CF0xZCvyTJIEuiocNNcFAyqYMBxwYK4hm7WzFYkvJcQX
	HDJonp/4/L9ydpEmwwftWDsEN+NAAhO/rz9FS7s13OxCbuRwChc/4RQD8wVhvLZMAa6fjMHIQGd
	NFh2ZBWEffDIi07xKOMVD8z4phnuVphrSwF
X-Received: by 2002:a05:6122:3d44:b0:5cf:5ba7:b3fe with SMTP id 71dfb90a1353d-5cf5ba7b808mr1221068e0c.14.1790600424358;
        Mon, 28 Sep 2026 06:00:24 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde664c06esm8782760e0c.16.2026.09.28.06.00.19
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:00:20 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-79028ca9371so1016371137.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:00:19 -0700 (PDT)
X-Received: by 2002:a05:6102:5346:b0:7a7:19aa:f0d2 with SMTP id
 ada2fe7eead31-7af1f40a6ebmr3883955137.31.1790600418873; Mon, 28 Sep 2026
 06:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org> <20260903205153.283553-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260903205153.283553-4-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 15:00:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVHAFoa+RvhzXDS=hijNXqBk=Fnt++LVm5rTiRQzzvm2g@mail.gmail.com>
X-Gm-Features: AclHuK_dpCNqN6yq7ND9MT0G1Ai1EvNq4GQtb8fvGHVDUDen2mnNfX37jzbkzIA
Message-ID: <CAMuHMdVHAFoa+RvhzXDS=hijNXqBk=Fnt++LVm5rTiRQzzvm2g@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: renesas: r8a779f0: Add PCIe
 Application/Local register reset
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 22:52, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Renesas R-Car S4 documentation R19UH0161EJ0140 Rev.1.40 , Jul. 31, 2026
> chapter 9A.1.1.12 Software Reset Control Register 11 (SRCR11) bits 22
> and 21 describe PCIEC ch1/ch0 Application/Local register reset. Add the
> matching reset into both RC and EP DT nodes of both PCIe controllers.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
