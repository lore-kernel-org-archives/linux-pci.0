Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175604A483A
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857563; cv=none; b=UQiPwANqNyJ7KtbjLJXcZcrbFPCz3oxxxeVMd4D+DXSPaiTME4VabB67GrJCB8UhY6nnx9SHpmt6+2m5jvJThmnfjgznxNfGENua/dJco3ff3nj+UQZyyFzTWogviVXjjWwI1P8B3E4+ZVJllFf2Xlpxrn9oFiNMp210Ww/LazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857563; c=relaxed/simple;
	bh=DaAQfNMDqfA4SiBqN/u9osdm8oWxv6NACh882Mgt+no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7OqSJ6uXVwnTeE5kRp+n4/2fcnhhJ6+K3o/Y8TUYCOo86FCPNwafTNQNJmJiNuZajmjORmj0ebGhgxItsNd5we3dJinBMPe7sIaHuHg7A/cxqfnt3v8mY8ZapfiVQylEtVeh5bW2lo+JSH8eq2B6a3oeHgKwZcfgGdU1a4tRNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7f4ea388ba6so4105455a34.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 01:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788857545; x=1789462345;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jpscs7JaPB6a7DSYaibBo7ovev0XT0EFpj0jxoPpShE=;
        b=SZEFZ+7Ulb7XL+GA9yuYpivA5GoMw7CxqWGHc8P0++2LN73XB3x7o35lUOP1L5I1iZ
         jOIul6wDm4CvIexe+Ba+VRwGH5KfhhKeW3r2hP/I9mMAOhqgAblMA+PvKdhwgO5m9/ff
         3mV06T4re+hUG1OfPDoxs4s+PVe5ZIs/4falvH1RI84AAs/WNrHZQBluEXdrVvmsn9HR
         DauJfamyJb8+U5KaVIDa32gylUy/fgr78uWLqiQi5+qIMSIC2gFW9EVhD50GxMQs45A2
         OeL7zFs/krr3Gt/qryoesxXKEXHiApgNAQC3GE+wgIbiSiJOq504n0PzUTlX27IKWisg
         UQXg==
X-Forwarded-Encrypted: i=1; AKwUvBwNy+QJjpkNDm+R+f7EnBpJyYIKH4uRczA1utOxsjBxGCj6OSVjxcUPnG12XO0QTtU2wV+Cw0fWWnk=@vger.kernel.org
X-Gm-Message-State: AFuF++lEHOMQvckZ3aF7KwFUyY3H6S6o9jp9c2n/TN9eOferEgvnHeWX
	cR0M8Ugz/B5m+Ua/3QCJHXdh3j37x2AMUzYRML5SnqWni4AdcenMgvZf8X0W1vP2
X-Gm-Gg: AYBFou3c7Tkwzvt9S6mbOK5ITmHW4L30ajAhGEjmg2FmHFV+XNzE2hyan2zw6QKcRld
	XZM55smEx78S1/q/iOcEJJtlkYU2LTdNkD7bM4CXMNYNqHxOcSKDjuVJh5R0l5jDsMN1rr4vkFh
	50s1HBaJ/SLjrLlRwqrTaYhChrSY2n8UfPEz/lKaWDgbxaELJZZx1hB98B0XWCb2RsDn3x1BfgC
	mqXkgC2vmv7gs2HhPJDOGKwHbTMjWo1Avm5solTDy4IuaSYMlvyl1iHVax2ZK+ld5h5w0Ijs9wD
	6ffqi76aN/XCNpOHTgI+7vd9ba76h93EtMXcfIRd5Y1WOS0erzbkx6S0dahuNJ4SH/1rjT9reLz
	bVLsY45PZxrTlrK0hQ4TdpLa5za9DVUmSwnpGqf4GAUDkvV5g/yNGJm/frL1XnEQkE8dvV8gNnx
	TTKBCA3guTi8CAI1R2Vud1DCiiAROCBkaY+BP7X3juQyTj2O8TqBqrSlr5YO7biNlGU5QYKc2Uw
	etkj34D7XYadzzqmp+v1EBImw==
X-Received: by 2002:a05:6830:3495:b0:7ee:3bdc:9205 with SMTP id 46e09a7af769-7fa1ff6686emr17956054a34.13.1788857545403;
        Tue, 08 Sep 2026 01:52:25 -0700 (PDT)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fc68d5ae2bsm7881531a34.3.2026.09.08.01.52.24
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 01:52:25 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b1497f0453so3125745eaf.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 01:52:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxm92d5Lwllr9zUzv9TDu7ruLzeyxUB0ND+RHZ/oiU+SJblxP5Olq1N9TsAu8sCLzznuSvSpvFkua8=@vger.kernel.org
X-Received: by 2002:a05:6102:3054:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-78a4aa3506cmr8542865137.11.1788857192323; Tue, 08 Sep 2026
 01:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809200429.843212-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260809200429.843212-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Sep 2026 10:46:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpq170gW12KEzmf5cUkUfRQ-6Vj_hMyeGeUny_WUCohA@mail.gmail.com>
X-Gm-Features: AcwNN1U6U5lTYgv4OCUonWRRw758LHZnUmo8hmQI7dJ9Temn454yHA3PWD6OCBM
Message-ID: <CAMuHMdXpq170gW12KEzmf5cUkUfRQ-6Vj_hMyeGeUny_WUCohA@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: renesas: r8a779g0: Add GICv3 ITS and
 update PCIe nodes
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Sun, 9 Aug 2026 at 22:04, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
> SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
> and add msi-map into PCIe controller node.

I missed before that "msi-map" is not actually added?

>
> The GIC ITS does have master interface to issue transactions to RAM.
> The interface does support cacheable transactions, however, it does
> not support shareable attribute, because the AXI port signals are tied
> to inactive in this implementation. Therefore, add "dma-noncoherent"
> DT property into the GIC ITS subnode.
>
> The GIC redistributor does not have cacheable/shareable, therefore
> add "dma-noncoherent" DT property into the GIC node.
>
> Co-developed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -809,6 +809,7 @@ pciec0: pcie@e65d0000 {
>                         resets = <&cpg 624>;
>                         reset-names = "pwr";
>                         max-link-speed = <4>;
> +                       msi-parent = <&its>;
>                         num-lanes = <2>;
>                         #address-cells = <3>;
>                         #size-cells = <2>;

> @@ -2148,11 +2150,22 @@ ipmmu_mm: iommu@eefc0000 {
>                 gic: interrupt-controller@f1000000 {
>                         compatible = "arm,gic-v3";
>                         #interrupt-cells = <3>;
> -                       #address-cells = <0>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
>                         interrupt-controller;
>                         reg = <0x0 0xf1000000 0 0x20000>,
>                               <0x0 0xf1060000 0 0x110000>;
>                         interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +                       dma-noncoherent;
> +
> +                       ranges = <0x0 0x0 0x0 0xf1000000 0x0 0x200000>;
> +
> +                       its: msi-controller@40000 {
> +                               compatible = "arm,gic-v3-its";
> +                               reg = <0x0 0x40000 0x0 0x20000>;
> +                               dma-noncoherent;
> +                               msi-controller;

Likewise, make dtbs_check: "'#msi-cells' is a required property"
And it must be <1>, so msi-parent above is wrong, too?

> +                       };
>                 };
>
>                 gpu: gpu@fd000000 {

I have already queued this in renesas-devel as commit 7fe73a3a3f2c3718
("arm64: dts: renesas: r8a779g0: Add GICv3 ITS and update PCIe nodes"),
but I can still amend it.

Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
