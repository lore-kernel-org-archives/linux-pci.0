Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C73B9D96
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680189; cv=none; b=K1kXaa3qyRCJgtMAD9I3MYiKY4RSi1X5bsEE2TdtncuL9Ryn6mnwCiGj6059pKvjLXsSMqx5hyFjNqIcV5UyyDnPmvC+E2xiiT0jJsIP26PzcAi0PHqPda0NdXyS3gofHQhry9lXIgdsj8WSgzdrTMyuVSq3Ft9QwURwErxb12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680189; c=relaxed/simple;
	bh=iVrtPWbggK31kf+NMVcxt/bIB/zBj/D8Klfi+iYlymo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTTp0cRP1KxZXcMBTpkFu4CogwtQvwJjFjqT0YQtYZA/eOXOsvGkNZMg6c030AvpVRjFcjaOkpIQXIkQLcrN8U5S7AYX5A5IcksfD7EeZYYw1BK+P6ThVyarKBrm/0UuavKrOx5u7aDBsESnl5kUxqxAZxYcpSTplpkNMb8DDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-59d7db12342so1493521e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 00:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781680188; x=1782284988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdX/1r/VC5gVdSWCvpldxzdbyoom7W8WRGEDFlCTq6c=;
        b=tCegrbbJGsi4cNri3mnAWRb/2BEhTbFfY0J5VodMmbuCzZ8ugd2b2ES321B8h7qIZg
         0p7705VPCLXYRDyiOclH7HURlMvBWWCTMat8sKd2ZVgI3NTlhkmjs/1pVo+62rLof0zh
         4zCoxkonKxRXh3GYHof/Lj5wM+5bEMnmBnX9C3frKDh45QhqCGVO0o2jE9g4qbSSxm6m
         ajWd1bJOy8PR2fhB23r27Mcp+7cNDfRQ60wjKhuG1Txvf1j3S40Ph1nLKD2PhrXjRdv1
         VYyi1BL1c9Y8xp44enBTM29ncKbySunZmEB6+trAdEZuRS6n6KjjM0AI9ObkBi12XdL0
         zeXg==
X-Gm-Message-State: AOJu0YyMkE9oUbTbGTZUE762R2uSyCDcXjywrObALMP4oW021A6OJexi
	BjiQanCFmvC+0iIEakaGz8MlS0WF86rpb04+OAuwH/VNPMOyv768lTA3qwQrdEe8
X-Gm-Gg: Acq92OHOPPXVStd3rAWDa/8LGm8Jv4eeVkoGf4aAwcFviWG7nH3qPU8KsZKh6659V0R
	KqKaDwIpoaKiUs18ZJRU/hX0j+iybrSKFQ/PU9WBZy/Pu4qFuMY8XOFLT3t/UK1ZVRxZf9k8K2C
	oB5fnngdtepjt1KhqbWbUZCJOrqY73t/CZAFLBCg4NeEgGieLqXaCH1FjvA60MJ2njGn3d4QUzL
	CNXH+xMuFIM53ForYuzNJxxcKqagWgM0xag+7Yo3dFPgyDaMk2U/2UbzlOta0hWv7ILpo1cbM6g
	KoWFITzjS9LvUZabachxFDmX4sXeRUzBiV49Dzwr70O2+2Eao/0J9V4HTrfADe8kLfVgkuIUL7n
	wIC8EMnrhJBim435cwlqf4/LxVNidIguYMDUhbDy8jM5NHJkrROHwBRWZ0krhUDCNu9xSrz2TQe
	qD+OlbsQ+Sg8+l+CQ/lsq4kQxVohnHNwMbw4yq9ctaQOC2L6peKQ==
X-Received: by 2002:a05:6123:14d:b0:577:51e4:ef1e with SMTP id 71dfb90a1353d-5bbbe6b350emr1364356e0c.9.1781680187626;
        Wed, 17 Jun 2026 00:09:47 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb9017f04dsm8868230e0c.9.2026.06.17.00.09.46
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 00:09:47 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-966df39a092so26968241.1
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 00:09:46 -0700 (PDT)
X-Received: by 2002:a05:6102:8386:20b0:631:e729:4575 with SMTP id
 ada2fe7eead31-7245cec45e5mr949237137.5.1781680186567; Wed, 17 Jun 2026
 00:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617030008.154449-1-marek.vasut+renesas@mailbox.org> <20260617030008.154449-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260617030008.154449-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Jun 2026 09:09:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX7XuHQDSsX4P7NZ46_OnCX2o25szuALwSs2z+PHq+JNg@mail.gmail.com>
X-Gm-Features: AVVi8Cf4irFbaHbMK6oTTjowYmtlzx-ojJFWgXAHjFGSCYVJj8Ydp7M37Z78yvQ
Message-ID: <CAMuHMdX7XuHQDSsX4P7NZ46_OnCX2o25szuALwSs2z+PHq+JNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] irqchip/gic-v3: Add Renesas R-Car Gen4 erratum workaround
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Wed, 17 Jun 2026 at 05:00, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Renesas R-Car S4/V4H/V4M GIC600 integration has address width for AXI
> or APB interface configured to 32 bit, it can therefore access only
> the first 4 GiB of physical address space. This information comes from
> R-Car V4H Interface Specification sheet, there is currently no technical
> update number assigned to this limitation. Further input from hardware
> engineer indicates that this limitation also applies to R-Car S4 and V4M.
> Name the limitation GEN4GICITS1, and add a driver quirk to mitigate this
> limitation.
>
> Note that the 0x0201743b GIC600 ID is not Renesas-specific, it is
> common for many ARM GICv3 implementations. Therefore, add an extra
> of_machine_is_compatible() check.
>
> The GIC600 implementation in R-Car S4/V4H/V4M is r1p6.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4901,6 +4901,18 @@ static bool __maybe_unused its_enable_rk3568002(void *data)
>         return true;
>  }
>
> +static bool __maybe_unused its_enable_renesas_gen4(void *data)
> +{
> +       if (!of_machine_is_compatible("renesas,r8a779f0") &&
> +           !of_machine_is_compatible("renesas,r8a779g0") &&
> +           !of_machine_is_compatible("renesas,r8a779h0"))

of_machine_compatible_match() with an array of strings might generate
smaller code (I didn't check if 3 entries is enough to trip the balance).

> +               return false;
> +
> +       gfp_flags_quirk |= GFP_DMA32;
> +
> +       return true;
> +}
> +
>  static const struct gic_quirk its_quirks[] = {
>  #ifdef CONFIG_CAVIUM_ERRATUM_22375
>         {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
