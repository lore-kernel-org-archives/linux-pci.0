Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C2231A3B
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245561; cv=none; b=LahLeyr4uxR5uxN38X9xeKDOdC4BX5xDu9EMefziiEHHpQgrxVm3aeLbtmPBRfjwsqNjfmBPxFO9ejmCzRoP29MoxXJY/Jd1TAv9O6q9SO5ban6Qg3NQZ1g+9apaLFJ/OmaMvIWUHK9hDfd3ybcS5Ul4OdFYG8VUxXW6gWoeP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245561; c=relaxed/simple;
	bh=kriQ31pznimK4X2P3ovzVVed34liQBkD34H6iVN9D1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lk22C3l4jILLBnkZRKoPNdpxsXXyGfhpI8oAxdb3JroRiAh37j90yB3CImiX6o1c5NjriulViLNGfloy2hhOCU8uWNw/hB0HmLCCKGc9ssYZW6VACRyFGIuaDccigjV+H8qxK8x994Dva6R7vIXXui1OSmczPV3YpdntG6IoKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56afafef7aeso94098e0c.3
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 09:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245556; x=1773850356;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TZQnjO7g8xVtwDHS6cEDEA1/Z/EJi3b/CK0eN89lxs=;
        b=Xe8Jl/3TENzAijddmO6Dc/bkehVs55To+98jZhitdDubuGrwwS1v1B+ERrCBzihbWA
         2tYRTD3ICdFGvhUgYKwy1Fr369tdjuWul50DRxiAxs3bkL1Cuvk9wSsBHGbmsrVPMjA5
         PoIEnMhyzeqS8YrQ0Kh7D+JQYTzsEctqmootlYtQB6x6GakqbDHETGytXpLlwKhooOVE
         uXl+PH1jVYj0XTHbhPBfmKW9jdxpjjSFJ5aTd28SGTvkGfMblWZGGzXgRzevWXP34tK8
         wDaiIcbPmuk9BzoXJwVPDOrUauh6l+25dnonjmD4T7lzzjK49g6ggQVkvtSRaSMyDxW+
         KIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6HD6Je4GmsxmfoPpuGya+hzp6XKfOGWjcksRbLDTJSojBnkJwkJyMB6K2+2Mdc5qJvBzrBzk5zz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeelg9lvB6OtR6TXLgZbjnz6+Lngcy4Xi+g9HdZC8Rr8cbHoA
	HC9MafvXSQJUVo+A1rxK85DKM+BoHZ5J8Ph+iOZaQWZy0+oddsYAaqb3A/WCtbG73gE=
X-Gm-Gg: ATEYQzzvMKTIax7hp2Q5LiBHpipWvWca/+vPKwvyShmTP4LdhqrwCqYx4jKXyTM1pHd
	7L+FWzbCCY94UbDNVrRHjXOd7DLx8IbxVOcq9jYVpeVCJRe/w1IsQoPtj79lZbrAT0RLSRxLOmK
	cjMOQTDnQ5HbInwG6mYFWSF698TdcTq2UN0F5Ir4blUc2ZeB0rewx//l5RQWZmG/W2ZjBi1SShw
	fnSqDhfdALU0XBRdlfwU5K+CA1s5Dn61zVvCrmgeocnZpJhONbXxn7BhAgu+h/pxBmv4HOdFprP
	pEUKnMS6lOEx+5wki+SDc6zLpkCnHYNK0x171tCCSvUhWvR55lz1LS4gdTOBDdoy5JtKsmtQPLP
	wJcM7q31T2ErmaHZGsXy6yjJca2wYgx9HPkB2k3pYL4DMoKFu50WTVAmtcJdg+mKdml5G5XlaQy
	fAJVAjSZlVDd6MfLuMRlf2CZbGUeHCWmwa3xwAyLSnFGJRZSAW6wNgDFBMoHqV
X-Received: by 2002:a05:6102:510e:b0:5ff:dcb9:9222 with SMTP id ada2fe7eead31-601deb2b6a8mr1340258137.7.1773245556526;
        Wed, 11 Mar 2026 09:12:36 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601dea9fa96sm876719137.9.2026.03.11.09.12.34
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 09:12:35 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-600404dbea3so21479137.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 09:12:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAn87JYYaX0Gkt8EUWFn7qg7/KCHcvH3p43MwyRR7326kDft8pM1Sy5Z3Wiv6XyxyIPuAGOhm+jZQ=@vger.kernel.org
X-Received: by 2002:a05:6102:290c:b0:5ff:d192:ff22 with SMTP id
 ada2fe7eead31-601deec1db1mr1359334137.19.1773245554633; Wed, 11 Mar 2026
 09:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com> <20260306143423.19562-16-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260306143423.19562-16-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 17:12:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWMCqPZC2o8GMaRkJVTE3-FAtbPB3h_aDjpND6s=FWbZA@mail.gmail.com>
X-Gm-Features: AaiRm50HgMmG-2Hd3S3CzPU1H5WBB19C2AdyrH6AqIP1ufq9nQI1hgHf7Jj5-NE
Message-ID: <CAMuHMdWMCqPZC2o8GMaRkJVTE3-FAtbPB3h_aDjpND6s=FWbZA@mail.gmail.com>
Subject: Re: [PATCH v8 15/15] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be, 
	krzk+dt@kernel.org, robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org, 
	magnus.damm@gmail.com, biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Fri, 6 Mar 2026 at 15:36, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
> Enable PCIe support.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> +++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
> @@ -122,6 +122,11 @@ key-sleep {
>  #endif
>  };
>
> +&pcie {
> +       pinctrl-0 = <&pcie_pins>;
> +       pinctrl-names = "default";
> +};
> +
>  &pinctrl {
>         canfd_pins: canfd {
>                 can1_pins: can1 {
> @@ -167,6 +172,17 @@ rsci9_pins: rsci9 {
>                 bias-pull-up;
>         };
>
> +       pcie-clkreq-n {

Please preserve sort order (alphabetical, by node name).
No need to resend this series just for this change.

> +               gpio-hog;
> +               gpios = <RZG3E_GPIO(4, 5) GPIO_ACTIVE_HIGH>;
> +               output-low;
> +               line-name = "pcie_clkreq_n";
> +       };
> +
> +       pcie_pins: pcie {
> +               pinmux = <RZG3E_PORT_PINMUX(G, 7, 1)>; /* PCIE_RST_OUT# */
> +       };
> +
>         scif_pins: scif {
>                 pins = "SCIF_TXD", "SCIF_RXD";
>                 renesas,output-impedance = <1>;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
