Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0D1D54FA
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122439; cv=none; b=b0Fr+g3O8qRlTS4lNlTCUDEX3BHxXsWWGGbYVIwc9IQUio2op1cdJS8VH4FC1rwokiMTgAUDDnmYZzB/LXGpb2Q11++354Mj5ByIol3kEetRJPuPQYLo4zkii3NkcuuRX39Ju6ArqiMr+AkjvIZ0PZ53LZHdNuGVAOG9u7Qc84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122439; c=relaxed/simple;
	bh=MnAXpId2QrsxBwStKm73em8Wh8kEZ3EOPZC5i6ugnWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ4Er7S96hIb3A7Pna83uRZaE1DkW4sKK3601Cw2G2lJK7BE9l1S1iAr+iI4+Iipgeyq8VRuSlxbIpFjy5k60W4Z9DCK8zd+pO1EMRZ05Jtyl17/+8SDSzYxyxLI1KbzEU9P6uLtMaJo6i7K92r5zVmiUnf819XO8j2YaYRqSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6da33a561so3470015a34.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 03:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122437; x=1782727237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTo0C41gBRbYARs5bY4lNZzY8eziG+D7rVsU/ecROJ0=;
        b=gOh165bQ5PM7YG0iQrPCJr5wM7Rc8aNkRxIkfjnqHRiKbHO6U2O9Bg1ckUrLSA3roN
         C6fnGQ6CSBHHov35Q9PAhpSAH857Qjo+agIiPhXH+tRet27DABQN3XdhdT7p2sbA+Ab9
         yugtbouzl9WTZx4BlXdqD+Y6LbG5FQeTA5S0G23ybAJV4lNxK5bzHfmrWBQry6DhD3kd
         v7wPzXbjGmpPlFDQu+5b5vCzCoaqpI4iLGR4IqNURqb607MO7UAWuHFoILVPs4X9g81e
         h3o3K5L4g4YsHP7qN51NURj5oyygLzuPQhF7mtQ/X4P4PMuWT9zk1E7BS6SSTGOo2Pep
         XzJg==
X-Gm-Message-State: AOJu0YyTBdgt8aVr1Su6jT7FzFyKvUwEMjnh3vHAzPshLdeTCxw7jXAV
	bHReKrz3DhV3Oi/aIbblBWDETAwtwbACU3J0djNHf+R2CkzoVABIQv3+HYHySwrj
X-Gm-Gg: AfdE7clkIRuqP5yhdqMVTEYtZnwbdfLRlTqyVsMc4uDcStwKVBSINjXZ2K2HzaGgIVK
	jjL2roYPhOCgLNuHfjn94dNchoZ3RDNRFEqnU1zlFu6azFxylhUvQ8Y3mT38qIm0nyKWvZwgC5W
	GMCbB9KlwxMSTL1JkHIjzw3w9UgjMoVqtHxd0q6X9wSbCj/F/GtrZMlATmZhDrKQAGnwj1F3W0r
	YOjZpA3aAY6WvIylTf0kpg3Klev23FeTnh/TgY7yAts6n1PjcSdit8Jl5pRcbSC/XRsbxViZj9R
	A9t1KLoH4xrz00QrS9SU0mzkY6l9q53tHUhodLYX7ywgHJBmeenG9hwc+9PDwZZ74ZP+Vfd+cxp
	BoG9y9UUl5EUkOqg3pKs/MW7/rRe2pJ8WHLukAsKL0V6ca8Qnv90Wgeit3BczhlHNSXnFAbUAKz
	b5+0XUOChRMmOdDUl+Nig4bhDJ1qaiN26K2UpkIek0bYcQfgKcJg==
X-Received: by 2002:a05:6830:2b0e:b0:7de:d056:19d with SMTP id 46e09a7af769-7e92d3402dbmr13559380a34.0.1782122436822;
        Mon, 22 Jun 2026 03:00:36 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944068bb7sm5924580a34.9.2026.06.22.03.00.36
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 03:00:36 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69d8f70cb0cso3148628eaf.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 03:00:36 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:729:affa:70fd with SMTP id
 ada2fe7eead31-72a1d8282d2mr7518654137.8.1782121981650; Mon, 22 Jun 2026
 02:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618220427.14325-1-marek.vasut+renesas@mailbox.org> <20260618220427.14325-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260618220427.14325-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2026 11:52:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxT87M1oQvPP_h4YX4vXFaVbbG+LCG8EdmuLTuHNtybQ@mail.gmail.com>
X-Gm-Features: AVVi8CeD0QzByTLrjVPd1X2DDUj0G8mjwUUWpPVDpYqqWicL4mNi4MB1Xhj4X1I
Message-ID: <CAMuHMdUxT87M1oQvPP_h4YX4vXFaVbbG+LCG8EdmuLTuHNtybQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] irqchip/gic-v3: Refactor GIC600 limited to 32bit
 PA erratum handling
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Fri, 19 Jun 2026 at 00:04, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The GIC600 implementation is now known to be used on multiple 64-bit
> SoCs, where it has address width for AXI or APB interface configured
> to 32 bit, and it can access only the first 4GiB of physical address
> space.
>
> Rework the handling of the quirk to work around this limitation such
> that new entries can be added purely as new compatible strings, with
> no need to add additional functions or new its_quirk array entries.
>
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4890,10 +4890,17 @@ static bool __maybe_unused its_enable_quirk_hip09_162100801(void *data)
>         return true;
>  }
>
> -static bool __maybe_unused its_enable_rk3568002(void *data)
> +static const char * const dma_32bit_impaired_platforms[] = {
> +#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002
> +       "rockchip,rk3566",
> +       "rockchip,rk3568",
> +#endif
> +       NULL,
> +};
> +
> +static bool __maybe_unused its_enable_dma32(void *data)

__maybe_unused can be dropped...

>  {
> -       if (!of_machine_is_compatible("rockchip,rk3566") &&
> -           !of_machine_is_compatible("rockchip,rk3568"))
> +       if (!of_machine_compatible_match(dma_32bit_impaired_platforms))
>                 return false;
>
>         gfp_flags_quirk |= GFP_DMA32;
> @@ -4968,14 +4975,12 @@ static const struct gic_quirk its_quirks[] = {
>                 .property = "dma-noncoherent",
>                 .init   = its_set_non_coherent,
>         },
> -#ifdef CONFIG_ROCKCHIP_ERRATUM_3568002

... as the #ifdef is removed.

>         {
> -               .desc   = "ITS: Rockchip erratum RK3568002",
> +               .desc   = "ITS: Broken GIC600 integration limited to 32bit PA",
>                 .iidr   = 0x0201743b,
>                 .mask   = 0xffffffff,
> -               .init   = its_enable_rk3568002,
> +               .init   = its_enable_dma32,
>         },
> -#endif
>         {
>         }
>  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
