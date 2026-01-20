Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697E41C2FE
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907017; cv=none; b=EleTqOTnaSgWIEtCblFdVAQ344hGksGPLqwlpgGipNAbjqQ20mLKX/OvLS5DZMJD+KhH7FdAUaOt726BJtOjO+g20iOOA72RryonSP9jZBvVhUQjr9oXTDql+pfYPztw5ocVS/nJq2GgPzY++PVe+h8UZtWKI9U0PoEIv2JWbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907017; c=relaxed/simple;
	bh=Yt74Pwf1lMdOPJDNa5I9rk37qMEnD4Vx9P4hWUTzXJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKb2OtsVpkRvS5GtNxa2TpJlkotH8ljVHcx5+c81vVk92rW0tnf9YWvf4iLLQmFODow3qu6hAiUBuxF9H09ZIjwnyvmSuIzJxkF9PYCtmmFqiaiAVTsbfXyYGtrH/K3JUvuXHgDLmrEJWAuXmqAZYcSlBL7GMteCO5K/IM7vIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-563497c549cso3260484e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 03:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907014; x=1769511814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mc4ovVXcdd2t1CG9+kKl14hd1FxE21SIum3OHqj6bo8=;
        b=miqO+Qy5G1sDH37iNNnlKv9Dt4TaUXdnRdA6MxGH/22TLAJOeV6LoM8QeSkMT3fJCk
         t5DdCMmupEelvzFe9SKYJB9TPoVMAAqoIAIKh2eXXP6QkAe2/+alyPvCSvfdZPKhdLJZ
         sKxvh2kt59W8M2qxl9xopRLUvrvuZS4tqX2g3PC+kyEF3K+1qK1heDuzdbP2WQ0OQwsB
         YNMF3gN3/nD69rVCQlytNEvp+EoIKwGL5VpozYU80Zw/IHUsBwHZMWd0XYMnFPh8qoA5
         2CToK3RKZsPU6FOeWIYqrB1NI0XtiVCsd2p2w1nfzYZdDhwpxK4+4FuAmqjcJ2M1X+J/
         urFA==
X-Forwarded-Encrypted: i=1; AJvYcCXjG2HGSeUm3/pTSHG7oFBxxPGfdKL+485eT3MVRPkNxDScBMB/7JHzLSXk3uJVTxNpEhGNB6Cbk7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaY1YPxo/VCn712ZYADp57VPwT61ETUYzL9xgmMjUwhCXiFRNA
	jSU8CsbR6C8sH2HjIMqj2qhDNM2gAMhoxCdDDAP/VDYfEt29bbzsoExPHz+GZqfA
X-Gm-Gg: AZuq6aIox8Q7SvfBuUL9FdK8lsZBzkkcskUfvUm7S1tCiOluZ/4I+oZ3/0EpSpsIlt1
	Ngh5yvY5EuLcSzO/r8spG4zkxU+P2GuWt8CzJk0P6H+AcuViyNyNrea2V4MNQ6BHm7fzreJsvSz
	XJaKbpPYMBSdt61yRmC3iPdp7vh/w0eV4Ckn3isjzRkiF7c1vxaFIZu2stPKPLmFhd0EebvSPuN
	zMu57kxiRcWTX6OCrqhOQRLFjXOAWtGUyN1aVnGe6G7Xdyg4JKVrmoegMmV2uyrTTK48a9zW/Qi
	YgsAKKzNSYPQRmnW7M6PHshJibYtXau+OJdsTLRaGIN7r7MH18z3SPwaFj/7ym5bMkg9af41F/s
	MIvzYB8k9ppJ/pzQy5yk1iXsdcym+yxE6QHdRMrT1K8629DuAdPIbxUFWszcgVJK6YSj/GczW8N
	tRnY0i8iMl180Dp4wEi1KiW0klbhFy3X3Z65hTf9v6pbu7W9E4
X-Received: by 2002:a05:6122:2a45:b0:563:7062:2a75 with SMTP id 71dfb90a1353d-565d6ff3f9amr340997e0c.8.1768907014437;
        Tue, 20 Jan 2026 03:03:34 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b71009casm3457904e0c.16.2026.01.20.03.03.33
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:03:33 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-947fe9e92c3so562070241.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 03:03:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVk7wlYVyWyJ1QBS2LBYQ6PMzCB1jJMkJO43aGrQc99oe6WvBpLVYdKtYpYHbInE6HuQCqnPBYN6x8=@vger.kernel.org
X-Received: by 2002:a05:6102:390b:b0:5ef:a59e:617a with SMTP id
 ada2fe7eead31-5f50a95f019mr413993137.21.1768907013323; Tue, 20 Jan 2026
 03:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com> <20260114153337.46765-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260114153337.46765-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2026 12:03:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKvfRr2us9YhXh5a_qtZcv8wCvz_EnVa4PEANocg_0_Q@mail.gmail.com>
X-Gm-Features: AZwV_QgrKR7tnicz6yGCyKjhkngXRza_8zoEMe8PqpfHwLCDwwFyDmgdfB6vgIY
Message-ID: <CAMuHMdXKvfRr2us9YhXh5a_qtZcv8wCvz_EnVa4PEANocg_0_Q@mail.gmail.com>
Subject: Re: [PATCH 04/16] clk: renesas: r9a09g047: Add PCIe clocks and reset
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
> Add necessary clocks and reset entries for the PCIe controller
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a09g047-cpg.c
> +++ b/drivers/clk/renesas/r9a09g047-cpg.c
> @@ -438,6 +438,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
>                                                 BUS_MSTOP(3, BIT(4))),
>         DEF_MOD("tsu_1_pclk",                   CLK_QEXTAL, 16, 10, 8, 10,
>                                                 BUS_MSTOP(2, BIT(15))),
> +       DEF_MOD_INIT_OFF("pcie_aclk",           CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,

"pcie_0_aclk", to match the documentation.

> +                                               BUS_MSTOP(1, BIT(15))),
> +       DEF_MOD_INIT_OFF("pcie_clk_pmu",        CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,

"pcie_0_clk_pmu"

> +                                               BUS_MSTOP(1, BIT(15))),

Do you need pcie_refclk_in and pcie_coreclkin?
Especially the latter seems to be document sparsely.

>  };
>
>  static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
> @@ -503,6 +507,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
>         DEF_RST(10, 15, 5, 0),          /* USB2_0_PRESETN */
>         DEF_RST(11, 0, 5, 1),           /* GBETH_0_ARESETN_I */
>         DEF_RST(11, 1, 5, 2),           /* GBETH_1_ARESETN_I */
> +       DEF_RST(11, 2, 5, 3),           /* PCIE_ARESETN */

PCIE_0_ARESETN

>         DEF_RST(12, 5, 5, 22),          /* CRU_0_PRESETN */
>         DEF_RST(12, 6, 5, 23),          /* CRU_0_ARESETN */
>         DEF_RST(12, 7, 5, 24),          /* CRU_0_S_RESETN */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
