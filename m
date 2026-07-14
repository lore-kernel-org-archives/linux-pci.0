Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C63F39EA
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015658; cv=none; b=f7teR1huPD047U3wN0bufLvcPJrahRynVkggADJlwFmCSiqdb9qgxJOUkeoY1N2zthajidZVYPmZmEbfHbBj9h7E6r4yFRdgRQwAK+2d9xzhzZVpEJUg9UDGuHun4bKvaB1ZzfYd8sQd2QrOjXeiZHdqCRbLdYntgc26nJyaMLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015658; c=relaxed/simple;
	bh=THxugq6t+PDXlFGTMulIef3VfnF0pxoHGHT4/GfoOOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ONs9WukvZ0cHd6R/kf6F5AkWCl6vHpPWHntWqFi5j6VoxwhQp0yk4y8NY5alEIruuh2mpJJXUk/kRUxDnSO32oA2E0yxGFoZJFmttWSA7p/aHVXkvbZ0MYhsBJ6YHL9Tq5zUENhkEAuVl4M514crB6I05c5D50pK2FPOBOwjoFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bdb162ee53so324163e0c.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 00:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015655; x=1784620455;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BgRx/9A4mxiDsRVEDvyTiz/IgVDal/aTcWb8tkjr7jw=;
        b=T8fhRtXc3gSrp6/eznMUBqcg8Okm+LS5zmFmDXxt/p92s0Y93qX/FMe+qay2o4d63s
         oQt58PzHJFgUdvfd1D0BttyrhS8cFOqibPObdXUYyA+XPAs3L02yZSkv/rK5JTmzOiho
         tLmqIR6iFKDE/Jf5u/SQPZrvTsI9xZzvoJNdZwsGnRsvIUrnwe5qsLWQbAV9R94P2Lxg
         kgZbrVcwpUNeT0Hr7fJ50NJ0q27GsgjwdBnEqZfdH0txSC9fAK4+WTq/d019+Zx2ZVii
         FOwB53+SE6TtsibDGO0tijDR1UIOouD7134gP9OIg3+Hv2m6sjdChEaBKEXoMJmd8BCV
         g4RA==
X-Forwarded-Encrypted: i=1; AHgh+RpbayZRRus3ZtvcOhaO+S28VUXuMHFQbj0nKHxD4pwiFYPrgl4NgxbNcm9b3jPZPudR60i58tvfgWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lpM9XqblYkr0qHZqzY5rsGl6sLCunx/o39Lv8gPagi25HgpO
	cNkh9caQ1tVL0ZAJSGDiovir0DIc5yYqvR8KBsuipjvq7puXL2GZuJ4d5AJHBDEqTlw=
X-Gm-Gg: AfdE7ckLR0CD+8eRr7Nu4u8G56tXB6evXMTu9wiXFMYqtURlY3vSD/ZsZ7M30OTVINS
	nWVHzDkEKzyOEVFAx3nfihtTua9WAMAIC2t3OStv4kjqdFdTqvQsDAVGgUz2EFj6rytpfqB6fQ4
	C2EYqj19aTSUuM9JNfrmSeTCzLXlqfRlpsQ+NH5ps3h2uK0EPKILaYjr1G+U7xiLPx6Ugq4zH4H
	N0yPSPPRW00GSgDITC9WZhIc1LavCA+Ed4c+smaEQOiFJDGE6ju6f6VJOdNJkCIK5c3W59hcKwi
	/kvw4kcWltWnGz5a+cdHz+65yLGXyWy8yjc/JoUk9lmD/wJichRM/J3Pm+mTRCJTfrv392m48Ga
	rtWYZXiTuYyZfjGHE8U37FBBMJtSUDJ+6ORMee3kUUNQhpNw/lP6I+7LKxG7txa8jKnR7lHN7X3
	uRHyB5HAWb0bAnaJt/yoKeQbVIvmqZnZDjWmCphVIptrmyTok2X4CUmw==
X-Received: by 2002:a05:6122:62a2:b0:55b:d85:5073 with SMTP id 71dfb90a1353d-5bfbf123feamr7065790e0c.4.1784015655252;
        Tue, 14 Jul 2026 00:54:15 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f68d099sm11134897e0c.8.2026.07.14.00.54.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 00:54:14 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf959b820cso375411e0c.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 00:54:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrZZ1xRKL+hl/x9uUFSWoTOB2TpDFbyWj3UWiIJAew0+XQ0eAg5HALWuy3MW8X8Yfuv4mWZgwFxb6A=@vger.kernel.org
X-Received: by 2002:a05:6122:83f2:b0:5bd:ecad:8f9c with SMTP id
 71dfb90a1353d-5bfbf172175mr7212570e0c.6.1784015653328; Tue, 14 Jul 2026
 00:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713175400.GA1258926@bhelgaas> <2013cac8-d887-4a09-b1c5-6dc9606f16f0@mailbox.org>
In-Reply-To: <2013cac8-d887-4a09-b1c5-6dc9606f16f0@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2026 09:54:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvWE7YZgKvreSn_vJLOVD4eMmn3TCGOyqSXksqjBCwvg@mail.gmail.com>
X-Gm-Features: AUfX_mzs8lWdOW-5Jg3BgK8EeDUWxqE-PpZFEV2XQkTM46SmNqGtsnsDEZCmeKI
Message-ID: <CAMuHMdVvWE7YZgKvreSn_vJLOVD4eMmn3TCGOyqSXksqjBCwvg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen4: Inline GIC_TRANSLATER offset macro
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

On Tue, 14 Jul 2026 at 01:27, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 7/13/26 7:54 PM, Bjorn Helgaas wrote:
> > On Fri, Jul 10, 2026 at 03:35:10PM +0200, Marek Vasut wrote:
> >> On 7/10/26 10:30 AM, Marc Zyngier wrote:
> >>> On Thu, 09 Jul 2026 21:10:03 +0100,
> >>> Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> >>>>
> >>>> Instead of pulling in the whole linux/irqchip/arm-gic-v3.h ,
> >>>> copy the one GITS_TRANSLATER register offset macro directly into
> >>>> the driver.  This repairs the ability to build the driver on
> >>>> non-ARM non-GIC targets the way it was possible until now, which
> >>>> retains good build test coverage.
> >> ...
> >
> >> So in the end, it is either this patch or limit the build to
> >> arm/arm64 . At least this patch still allows building this driver
> >> with more compilers on the various build bots, so I would opt for
> >> this patch here.
> >
> > I like the build coverage, but duplicating the #define doesn't really
> > seem good to me.  It makes readability worse because cscope/tags now
> > sees two definitions without an obvious reason.
>
> I can rename the macro, or ... sigh ... I can reduce the driver to build

That would obfuscate the code?

> only on ARM/ARM64. Which one do you prefer ?

Just add the dependency for compile-testing, just like
PCIE_IPROC_PLATFORM does.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
