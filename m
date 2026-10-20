Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510778;
	b=MJ6TV46ylN/jzlcqmYvlLK5u+Tc/7bRp84lI8sFTlD9ygev6TYH2qfEJhDYEVBtruhmd
	 9G6wUvjfHM0xR4jtXOGUCl/a9MW0iQK1HXWOPFFvfPggUrNc/myjNdQvlifQ8pHGIgWzb
	 HYsl23aXo/dYyEAK3r+8F1NnGd+6+yWlgisxv09XLHbtqkM59PJop3I0VjYiftdaD3OKh
	 Y21S33Ggxzd1IuqZUlBLj71LbKN2TY11obxIoB25KUpy+GHDvJfoYWyjvt4UVRNWkNkjH
	 6eSaBGdhkK7cIk1PynOFIjZ87i/tRX7DlaJE5vigMMasXzZjlO0vh1mebUmclvbluxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510778;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=uOdggBIS0MQjP7rBXZTasAv93vWRuNQG4pH4+meS/uA=;
	b=FZ9xzFKJSUmYA3013gUE4CVhOZoFRCRmkBIbHlM1G7lkHdYCkVSVEltqmztQdBhzLml2
	 HvYyr9KsOFUVSfgk25lkKxGm4dzehVKO8nFBjzlFmqnnCi1zaQv84PReDT1o8+KDjtZY+
	 pMjn1ouKHkOtvXfY9dCF1BhIZt9h56a+SQkWir6rGE5Fa1L12SvCUqasjm5B35cVNUwNy
	 6GGyy1vjO9rFl+CUmEnOG28ia0m7tg0lNUSm48zn9NiTuBBBGoWYE3GVD/yldvXiDggRp
	 nuPCMcAf7QCcHRmeH3V//vRbwpro17ajPq+PJN0dQ3HQRaiAU9iWazq1Im8UQUeihrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0B606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 15:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CA0B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c450ab1483cso253328666b.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510776; x=1793115576;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uOdggBIS0MQjP7rBXZTasAv93vWRuNQG4pH4+meS/uA=;
        b=g3Fqzi0FcJJROphUtgljMyeEdilI/C9kVjonY8snNEBmkiQL8J9Ttf+IkNZcTj3OaX
         edXbJw6NPDb5rzvyGxm2gIVwbVTb3l4EA9UwRgmffzl7sB/QNRTpfNBcpNGua5YO7n6I
         ZRhHQKMlCQ+iIpA1Tomc67WILmsPvDdmVPPz4kWgGKVpRK+aeN32Eum3dY4OR1buqh7f
         h+Uv7tWc95nhSeGqtYt5EPKLfo26x8ADbUVOtebkVbYzDhPM6So+BlIOIDTcgdYZYHJf
         4/KCQ2E7N2P6yDNOWJ9FItZkJHFylbR7c4i235IUqi0Ex8OrfOKyz9K5Y7NvW4BfyaNS
         VzfQ==
X-Gm-Message-State: AFq9FYJOYrIbNash08KUX7zoBcJAu3ayCAByaXwhkTV84xTrWaWDiyQD
	aElgSS7b9DZMEx7J+lTUiQHiOM/PkIxgG8VSuh+6ppOi0AFdx/R/7C8AXxNl1WEeKTM=
X-Gm-Gg: AYBFou19H8ofw9FhvYCMHxq2Y4CloVY0r7Fk5si6IwJbszoMeKxstk4FydM86x/CQdN
	FrwYxxhNvCsNcBnP54TLpRzWd0psjP47nvE+Xzdpm7DTR53N3h0OxlDhxW93jp5UWU/nBrqsopP
	foqZgd0AiVh+gv+GqJ6oPD2Cw2qRz6S0/nkWoCSDYExu1ynthFzJKknDUv6F/nsfqpAjcTkJXuP
	uxi7qbkEL/1P2vR6whzSwFBRXFRFiXtv/eqBUYkIjSqtMWNQ+/px4oJicf4JwerF2s91560S5m2
	M9bUvmj7kAERDGTadRluJc9cNJEfmibpME5kipXwGEEwmNfE71411AbCqlT+YqRF8sJC2sURY6M
	RPsttOhuZExARoL1kMvL3EWNhJCc+1GJP612nV2wISFgI6+byZula6U/vhgjlq3ToGtyYKiZYA+
	uNm/OHmo8yP39EtDeNUlmsoyTjoL9AlocBEi4S0+c6v/IS8tNkhQyr0ts6AKraNMaf2DyIz4eQi
	ItDeSODywh9O55lJElk1rn9Ip62/UgRkOn2
X-Received: by 2002:a17:907:728d:b0:c41:4d5:e97c with SMTP id a640c23a62f3a-c419f7083e0mr807929966b.37.1792510775657;
        Tue, 20 Oct 2026 08:39:35 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb1835sm498137366b.79.2026.10.20.08.39.34
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:39:34 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2acc1e170cso499875866b.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:39:34 -0700 (PDT)
X-Received: by 2002:a17:907:c819:b0:c40:bbd2:62f6 with SMTP id
 a640c23a62f3a-c419dd3942bmr740265666b.19.1792510774520; Tue, 20 Oct 2026
 08:39:34 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <889ae6695b19ce57ca4b17526c69b48c9414f5ae.1792508601.git.geert+renesas@glider.be>
 <sashiko-outbox-179228@kernel.org>
In-Reply-To: <sashiko-outbox-179228@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 17:39:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW6hm1aGOKMLZfvS2oU7SBa7p5Eup3+iYqw3LaD_pv9uw@mail.gmail.com>
X-Gm-Features: AclHuK-Vu3hkTIFpilSQsdE4giSc01tkJXVlYbgJEZ6QBjeQmSjSTzB8n2GcoFo
Message-ID: <CAMuHMdW6hm1aGOKMLZfvS2oU7SBa7p5Eup3+iYqw3LaD_pv9uw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl/gpio: Correct GPIO_TC9563 /
 PCI_PWRCTRL_TC9563 dependency
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sashiko,

Thanks for your report!

On Tue, 20 Oct 2026 at 17:11, <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] PCI/pwrctrl: missing select AUXILIARY_BUS in PCI_PWRCTRL_TC9563
> --
>
> commit a7730129e4c039c8e8c890c4f31a553b4c62308d
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
>
> PCI/pwrctrl/gpio: Correct GPIO_TC9563 / PCI_PWRCTRL_TC9563 dependency
>
> This commit reverses the Kconfig dependency between GPIO_TC9563 and
> PCI_PWRCTRL_TC9563 so that GPIO_TC9563 depends on PCI_PWRCTRL_TC9563 ||
> COMPILE_TEST instead of PCI_PWRCTRL_TC9563 depending on GPIO_TC9563.
>
> > diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> > index 38aab596aa04b..1952ab4f29b69 100644
> > --- a/drivers/pci/pwrctrl/Kconfig
> > +++ b/drivers/pci/pwrctrl/Kconfig
> > @@ -29,7 +29,6 @@ config PCI_PWRCTRL_TC9563
> >       select PCI_PWRCTRL
> >       default m if ARCH_QCOM
> >       depends on I2C
> > -     depends on GPIO_TC9563
> >       select REGMAP_I2C
> >       help
> >         Say Y here to enable the PCI Power Control driver of TC9563 PCIe
>
> [Severity: Low]
> Does PCI_PWRCTRL_TC9563 also need to select AUXILIARY_BUS when dropping the
> dependency on GPIO_TC9563?
>
> Previously, depending on GPIO_TC9563 transitively selected AUXILIARY_BUS.
> Without that dependency, if PCI_PWRCTRL_TC9563 is enabled with GPIO_TC9563=n
> and nothing else selects AUXILIARY_BUS, drivers/base/auxiliary.o is not
> built:
>
> drivers/base/Makefile:
>     obj-$(CONFIG_AUXILIARY_BUS) += auxiliary.o
>
> Meanwhile, tc9563_pwrctrl_adev_add() in
> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c unconditionally calls
> auxiliary_device_init() and auxiliary_device_add():
>
> drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:tc9563_pwrctrl_adev_add() {
>     ...
>         ret = auxiliary_device_init(adev);
>         if (ret) {
>                 ida_free(&tc9563_pwrctrl_ida, id);
>                 of_node_put(adev->dev.of_node);
>                 kfree(adev);
>                 return ret;
>         }
>
>         ret = auxiliary_device_add(adev);
>     ...
> }
>
> Can this cause undefined reference link errors for auxiliary_device_init and
> __auxiliary_device_add when CONFIG_AUXILIARY_BUS is not enabled?

Indeed, both GPIO_TC9563 and PCI_PWRCTRL_TC9563 need to select
AUXILIARY_BUS.  I will fix this in v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
