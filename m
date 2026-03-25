Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82623BE16E
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454490; cv=none; b=bjfmOZTlwh5Fdcf2qIWQCW9pDAI/tmX5/7xlTABWs67F1+UFaD3CXopvfCCFcSgtEroCPGI8AAxXd6bFPU3xyd5eU0FDKQOyjLbXIr3RuXFRMiBcpUIqtTuJUUjXJbE5E+sujVp515C9NoBvJpPqzs9ka9PliP1RbSGhE2Tlv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454490; c=relaxed/simple;
	bh=AIVPf3es6gRbVZD1OjJY+7NHbNGFfUFHbP5UCcb+Ibo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwS+yre82062AE8o2ynS1TgZxLqhDs5/vbEoTFQOEI8Hrcn3biTaCnXFJB+18hjARL4LbrxnSvVL7TolytRXS6Va78gSIrINJQ/QWnUvq7E/d4V3inVdHeMFBnqYw4hk80BFsmpZx5dCeyYuhgaOdwH0mgVbVU+77p0ts3FRSJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56b7fce3ae6so1073063e0c.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454488; x=1775059288;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsaKl4jnMb/iLg/tAunTjLfMtEyxekduMqGv5XbCBMw=;
        b=aEWXcfQgphp0h2XJ63RWqR5rxS9/eRN1ubfNq/hdLdJnpQ6EGYUj1CBiCHeXboIm3a
         KBIT6VpJ/0lcozTjrJHCO6ahj4NTN8Gt9oPL020TRWZ1ZcasyryLDiXUkRqkIhHky8QI
         4NBFTzX5RqrRNNWzjzoFuvWzEdPp5jvdNGILlsEV4LGwrNPK2mvY86S/KCjCeg5n7hwD
         7UMBIQat3Agh4jHwrLTC1SjLcwpFSc56JXivNR4hiSjOOdFscz6eLJ1o2zRTxHIxkY0f
         MmKxTGKRPseEFFllp9bsk33DvPt831Wyn9IFYwxSev8tUUlNPYwWUMVJohOEGVIj2IFz
         m0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUvrqo7rYdDelG4+PuCqFPtp4gAwYtukwigVYQudYGfD5jqlCzb3HWF3hrmXW/LhEo1rxDIRHueDNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck4duROl63V4ZyuH1h/wOuRHOgoKjWkZ9IiXF//DiLyZOyq/f
	AMIpY2rsYY8/Y8uv4kytNmr5DlxyMdjkrcymLyrvhx0if565S+B7o++Zt3dYNAqJzHs=
X-Gm-Gg: ATEYQzyumL3zmlDCyzRpOmLiMgK+8aT3Ruti0i66D3HMde4f5WVf2tY1J/JZA0nZkIH
	ibKkCWTaZ/ef60ohvbIguax5oh0vxwc7gxrlXRX2bbRQAnzyeMu1GQKLE4kHY8h8h46s2VQixOS
	4ef30ar9oDmBztQP0+deBiUXRzIpU6pB1mtOgss2CdlWReqroilutTBul+2PopUuKhTDG7/xub6
	WBQbBxfM/d7hOTHiqJCYmhD0qCbniHzuGBKXXvWeOTaVQ97MYmC2/PTO81ng+JSsC4KpQZzHBCJ
	EXH6NLlBLYXvWFf3KysyF3dZohIofTN4hY1DKrqFXqjksvFONMw0agPmqDuC0u/p+2PPeYN6kI1
	TYRfW8HJbiFssWmLSEd9BKlxaJtIcTvlqPtPivIl2cFgwlFvrZ+GQbLY3w5POq5TM/2uTh3VhWH
	9RAaIsFhYJt9Pu1MmXLg1zcLvnKtI+fh6NR2Q0o+8oi7S+0wpNtKrGJDRQ7rnYq0fD
X-Received: by 2002:a05:6122:3481:b0:56a:8f7c:49aa with SMTP id 71dfb90a1353d-56d22087cbcmr1806464e0c.4.1774454487331;
        Wed, 25 Mar 2026 09:01:27 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951be185991sm428170241.6.2026.03.25.09.01.23
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:01:24 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56cc8a021e2so790704e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:01:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5QIKr1qI4/I0IB2xRxwqo1hrnHaIaYCua4r4ugkYJta492pKHBVQsPvhrzCyX39y2wl3iD6g+yIU=@vger.kernel.org
X-Received: by 2002:a05:6122:488b:b0:567:4f98:fb82 with SMTP id
 71dfb90a1353d-56d221484dfmr1919276e0c.7.1774454483312; Wed, 25 Mar 2026
 09:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318085119.44717-1-john.madieu.xa@bp.renesas.com> <20260318085119.44717-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260318085119.44717-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 17:01:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUKCxfWPTyoV6nMGHkK32eeZFSEXnL3L2C5kGtOTUtJqA@mail.gmail.com>
X-Gm-Features: AQROBzDNP67-ZuO5q3SWFmFGIjuJmCxHdim9QMA2vOC8b_1VjWoGuY0s8rTuFQA
Message-ID: <CAMuHMdUKCxfWPTyoV6nMGHkK32eeZFSEXnL3L2C5kGtOTUtJqA@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] arm64: dts: renesas: r9a09g047e57-smarc-som: Add
 PCIe reference clock
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 18 Mar 2026 at 09:51, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E SMARC SoM has a fixed 100 MHz reference clock generator
> for PCIe. Model it as a fixed-clock and assign it to the PCIe port.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
> @@ -43,6 +43,12 @@ memory@48000000 {
>                 reg = <0x0 0x48000000 0x0 0xf8000000>;
>         };
>
> +       pcie_refclk: clock-pcie-ref {

I will change the node name to "pcie-ref-clock" while applying,
for consistency.

> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <100000000>;
> +       };
> +
>         reg_1p8v: regulator-1p8v {
>                 compatible = "regulator-fixed";
>                 regulator-name = "fixed-1.8V";

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
