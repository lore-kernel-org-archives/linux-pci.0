Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32C30FF36
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055352; cv=none; b=OOp7K/sH87rxJnVRrh3ycqE74z6BY/fBJ02Mwk9St9wFG6QncRy1b0DdPkWpaXWUVHBokJjaUtiF+UkBT87iUdW2IZFDRGVF6Q6LnxhGXSAFY+vVH8e5BP4K78Rcsix7QkhUt9RKoXDCh5JBI9xYR10TZeipnt5+oJlEHsD+A0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055352; c=relaxed/simple;
	bh=9VTPY8g7oIv6TMfkb5vxRYMgbi7A/wHcnUv89A8x4/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saHrAdSaorQgpQnmaYYiNTTqCMhyJSe7KZwgSnnhRSIQXBllzDe2zwgCCQdYQUTe11yveEgzBiy+8q4PxAjOdpl5kjrZzpc2NvQvfMVWqKIUr2uu7xtqFIe3FB0JPFUfsSsq24yRpOZPZg0riMB6j4EWyFOYLgUXwBbFs3ZPjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so13205725a12.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 07:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775055349; x=1775660149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3OTPNogNajS6XpWemWBVYQAqCuRMbqVz0CHtg+iC7Y=;
        b=iOgHliix7KNibPr5y7ij3y2ojxEe9hVLGKMzfTPtC+4wYedVJafCp3Xk0/srUPpzIq
         o7IV2H+IN2l8O9eaUH4y5o0ZkxqQ9ec3RJLrPFjFpj6PnzyYnW1m0dvFQAyrMP37SDaJ
         zFTcMgyz8HBfeAr+FPo43s7nB0b90qYhSFw/Cory2mRKyCzr6grtIJwswj3vW+gWl0ol
         DsiNcYhi5MBaRTpUi4j7ly8iUUjk0brltTnmma3jmKnurXSNeFQjah4TxVLtztFhRmWY
         hskP7e2uPLd/InMC4jPZZgbtT1ncr/cS61n4+GegM3zKUtL7atFxgiWQaussuWceksLD
         tELg==
X-Forwarded-Encrypted: i=1; AJvYcCXidL7ogWHx0MssXuOAkgNC/FXu5cPfs8N/M+YDPSG+EhkPzTc8SmNruzocPm3VtLZpi0jSX6t+etI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywql6gXyYtGi4RHAoKUnNjLJQ2ekM/Kr+INyBlBQ4Tn/4x3JSzI
	BvABxWlQ5T3okrZdtwS0q9dcTzb37CFscvmK9CmcjA2GpzNt/MmeoCRctA30wrRPGNE=
X-Gm-Gg: ATEYQzwp7iV/3BfsgFs1LaMcw5HLnJbh4fe1dSAAL5GPllm6lgKKZDu5Pz/2DuytZj2
	fyv4S7+hKzF7OXrHEhLE7PWS/wppwdxE/9pGgySDIFiQtGczwEjaP+YdI97h5c1VqHpTUcG+3h0
	rtslu4tGPXspe/9ZApcPh7f3IJlA2F42aD7t71NNH3+x8nqd5KIWLA0rLEGKyf8hWrplJ8J3yTn
	/leeJVdRxZ71Lwjmdr/VCX7hWa8hpeDwhVR5RSe5qSSgXeQdeZPECOhuBM6oJQguSbIgJMjvgGY
	W4r3tktHVxe03fc8JBK/Zg0NZPeNB303VsSJCTl3fryErtF9ITFpMw94ugz+TOHvA16QfTQ8vvY
	fLuYztSwsNzteU/I2g6ahmwvp4nIPrT4XHgPh1i8SKXK5dxwaUC2YP0sKd8PhiQL5I+QbqQnq09
	aI1r2Zr/v1euWRdU+pu59TB4iA6NhXjAaXwSxazHhQNlLz1i4gU3FFaSZk3Z2LtpR0xJXf3hg=
X-Received: by 2002:aa7:c68e:0:b0:66d:ce09:5778 with SMTP id 4fb4d7f45d1cf-66dce0959a6mr1768009a12.20.1775055349186;
        Wed, 01 Apr 2026 07:55:49 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b7275ff49sm4230657a12.6.2026.04.01.07.55.47
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 07:55:48 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so11953348a12.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 07:55:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk+0rtwR2m0E1+6e0/INqAUyKjSzqXYjHm3HTmIL25zg0WD/0FW+wQgqXWqknkG7CToUBIztPAcXo=@vger.kernel.org
X-Received: by 2002:a05:6402:538b:b0:66d:f247:cbd8 with SMTP id
 4fb4d7f45d1cf-66df247ceadmr294684a12.0.1775055347067; Wed, 01 Apr 2026
 07:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401143347.8463-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260401143347.8463-1-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 16:55:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUz0wRuTw6PCWFskBQ+vn8SOzGpDRAa4YgYA2OcNbmxLQ@mail.gmail.com>
X-Gm-Features: AQROBzAbH87r2KzLGilvxvkcI_ITyAO6gxSiFE7rkB1e8Xx7I6YNsjz09w59TPw
Message-ID: <CAMuHMdUz0wRuTw6PCWFskBQ+vn8SOzGpDRAa4YgYA2OcNbmxLQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rzg3s-host: Treat link-down as -ENODEV instead of error
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, 
	john.madieu@gmail.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 16:44, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> rzg3s_pcie_host_init() failing to establish a PCIe link does not
> necessarily indicate a hardware or driver error; it may simply mean no
> card is inserted. Demote the message from dev_err_probe() to dev_info()
> and return -ENODEV so the driver defers gracefully rather than printing
> a spurious error.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
