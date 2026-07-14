Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712FB44CAF8
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041674; cv=none; b=mD05cD9kmP8OAg8uxN/m+meCOHBsHNmx6PeF4KCqxOlWYUGdV/UfAEPDHe8mYMSbHUA1+s8Qh3KVy3F7+9gDHYghEo47ooiJLTJe3amKet+qV4lOoOBSY0AABr0uJoYMFonBC2iG5Z1kq3ynd26sRjod9t+cBiQUAD+N6YqcvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041674; c=relaxed/simple;
	bh=EydTAVFmfsnxHYlpbg8UU22Qc+XHEBpnj2CpvQQHEJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Spr1bF+3jalF+1Yj2YKrwswhD34BPUtX9VsjVM93JkCqAhfTBWEihTW62OVaN+/myG9rORnbFjsF5dAhTHP2a1meLkJTfqs2wzWqq5nPwhlawMVFKm2lI47vajnomxgaQKiX+IVrIKE3KOa9xCR0YDJXNSApLzeeacylCeYnyhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e592da74so540074966b.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 08:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784041671; x=1784646471;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jo5VGLZCIAx58XGGknenbn6fKSICDfYV+/5FruvF+xY=;
        b=RYpE27in7NlKYx5ntuNJ2hiGn4/yBz1XDU/l6NXTP6ua1kmV0DS7bzVK1WZmOP3mL4
         AyIwJhC/aeF4uvyUC6JC/nhY4CRTNMLw2hC4E4TP0HVtgVaBSxzKkLmaqMr/IB6cdBYf
         O1MbXtg4mUXcHf+iXxRKgt1e3VIFfNUinTOe4iiyJUZqbPvPL9zYMVpZ5fSEAvfawIgN
         BcLmCMUtB8MVw8XNQAtE0kSIWj56g0V+SHFs1r3bpPtuDSvMxsaFkNla+Is/uBYoD37q
         30llMMJv8ETX6kKeJYV74S18Vzu7XtWPWgYUGJz3HNK5XK6I6+u/Zq3+sNGhWhJbCh2D
         FazQ==
X-Gm-Message-State: AOJu0YxhwqTVy/Df4KxKJegekpsfEeuFr9F1uqj31hRgmF5KcObLVkVN
	DpEHaxsotD0s03G8aZadea+YXe6+/5cNkwjeiwqCvMKh62hM97+2Fa/D7A7iMym6xgM=
X-Gm-Gg: AfdE7cm/tVX4AkpEsSI8JiOUWiQ75GHyc0AjW87Qpcr6gj/yNCnNjS+6PzAbOJDJE7H
	I328pAiXBUhcXMypWhiEM9GaH5FZ8nfmUaZAltOCAItHii8pyEbSg65LB5Zoaiu8HBhjrOuhUkF
	zvkwzhDbD/PEHMApx4GydkTDxqEqfeAeLNiclh4AJqwU3onZlmuYFNiZpH5fpffd7/luPLNk4D/
	iHeHacyge2AO0P9x3TGtNNl9VWjdhlfc4+M9wgh+cY3rYr2tUIzZ7pYVlRRmhcIKDqRZl0QXlCY
	GpTJGh+owtMppl0pdbo7LTTl8aE0I8ZNHb2OdMKv4/eajWcl9cgmFSBdpVlfrJD0naBLEgcFVvw
	1t6lk/T7A+w4Rslv4XouzzDR57YfxLRRrB61IooaYg4fw4ke1e8ahPPCNWlZb/EtNt01xtJTIhk
	dDjus19LJMWK7w5fm/Cho5r5ZAsY96Fnq9Hv8ACEjiAtHAbEcDZQ==
X-Received: by 2002:a17:907:a644:b0:c15:b96f:c3d1 with SMTP id a640c23a62f3a-c161ea1f5bcmr683555666b.41.1784041671291;
        Tue, 14 Jul 2026 08:07:51 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c166c0fab3csm89718766b.5.2026.07.14.08.07.48
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:07:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso6611714a12.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 08:07:48 -0700 (PDT)
X-Received: by 2002:a05:6402:5518:b0:698:1504:e3db with SMTP id
 4fb4d7f45d1cf-69c5f12584bmr5921618a12.29.1784041668249; Tue, 14 Jul 2026
 08:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704202748.355708-1-marek.vasut+renesas@mailbox.org> <20260704202748.355708-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260704202748.355708-5-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 17:07:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVqw-gqydVg5N7WiMj04rVAPuLjJjzgrk+eEgJpbzS2g@mail.gmail.com>
X-Gm-Features: AUfX_mzNY37K7gCxxfwbxm0n7Y10BRypx8qySLz8CYFaayTElsV73S_ymVmDRtU
Message-ID: <CAMuHMdUVqw-gqydVg5N7WiMj04rVAPuLjJjzgrk+eEgJpbzS2g@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: dwc: rcar-gen4: Handle PERST via reset subsystem
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sat, 4 Jul 2026 at 22:28, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Handle PERST via both GPIO and reset subsystem. On R-Car Gen4, the
> PERST signal is operated as a GPIO, on R-Car Gen5 it might only be
> accessible via SCMI reset via reset subsystem. Support both options.
> This is a preparatory patch for R-Car Gen5 support.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

> @@ -299,10 +300,27 @@ static void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
>
>  static int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
>  {
> +       struct device *dev = rcar->dw.dev;
> +       struct reset_control *perst;
> +
>         rcar->phy_base = devm_platform_ioremap_resource_byname(rcar->pdev, "phy");
>         if (IS_ERR(rcar->phy_base))
>                 return PTR_ERR(rcar->phy_base);
>
> +       rcar->perst = NULL;
> +       for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +               perst = of_reset_control_get(of_port, "perst");
> +               if (IS_ERR(perst)) {
> +                       if (PTR_ERR(perst) != -EPROBE_DEFER)
> +                               dev_err(dev, "Failed to get PERST#\n");
> +                       return PTR_ERR(perst);

return dev_err_probe(...)?

This error condition is triggered on Sparrow Hawk and White Hawk,
as their DTS does not have perst:

    pcie-rcar-gen4 e65d0000.pcie: Failed to get PERST#
    pcie-rcar-gen4 e65d0000.pcie: probe with driver pcie-rcar-gen4
failed with error -2

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
