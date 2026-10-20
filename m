Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483819;
	b=n5iTtcv/IiuY+EuoqqhAa/fOTHwqUDDYq9+mloWNMwj13f60JL/T1SrE/9gnHRnWYyOL
	 /xdiQo6p7kUpIWrupIQ6rtd++ctYuk1cETbBAAOwmyG9DM04hd9/nEstT9tnYAlMHzJkW
	 uss6uMUJdGft4Rtcoslo15gzGZ7vBzK69woNColC43UQUR5dmYfJhqmNGgVElOEokfu2s
	 Coo2KTOTsCgUIxu0G9aGAA/2qEavIgqKokqy0f05wy3RnNsYM3Co7LTS/zssor1knXPuC
	 K9Loys7Y2rGSvNvesleLA+FvLNAZ3RhkpS4VefF27hE6u8In/uRvM7AKKYoRpI4pZ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483819;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=XtoIu8lT4HxFhQlGLc/Y+wRIrAeV43o+yENerewR5Dw=;
	b=qWChQS2UygoHPTz5A9A8uEjGpPRHIXb4s79LGFXadN6AVl4lCHdAoO4MvhZrHSM8MW6a
	 Fg3VkogZVQyDug4FgBFPrSsFYaoueL3vMbKD0f3tbHPeRc6pPZN0HtzmlU8ePKaOFZY26
	 rdPzuSWQ8SnkX5YCotBoc6RhnXLNhRgsqbmdAwDWgo/2yqfUfMxSecovTX+cSgZSltUQc
	 cbW0yovAXXCqQBOtn6/xyRRzOgYPJE5aplCFetxdcBdFApdIdHm3gM9RlDvEao+yyDEV4
	 cqsjErZqz+Jwz0oRoeqih3Me7+SRaCNMFMRZxhlC4N8XrA4lhILa7VFGW9ueTIL5EgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF53606A331
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF53606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b8306b9f8so45572446d6.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483818; x=1793088618;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XtoIu8lT4HxFhQlGLc/Y+wRIrAeV43o+yENerewR5Dw=;
        b=tC8nwUb8Ja21Dze4zhH7y+JGzdnp/W1P1pNzsSPL5arUvJ2rSS50q6U44CCcC8aLn8
         kx1l05xqwwEskTZSVM1XM5t6YsrNLObSdlfi7xMoUzCg+T4O4u5FyTFZ8ow+NCyTAnhf
         NULF7TXwnATyGGhunTBi5ggT2DnQ56JIoXXXpNwZVxgwdTEs8kEZrcs4iAmBxh39dqXX
         kf2QfTEfvhRpjHp3X9+FOj7gUgv4wQiAg+t5CZ/m6nFNMr0/qTOqlS130V6b6ysDo9UO
         zwtVbu3vcHfj7J2Wpc1imSERBZLVl0ZTmGHCYX+iX2M1I/AdTa3dTNYi96AYKK/xwAbk
         fSmw==
X-Forwarded-Encrypted: i=1; AKwUvBz0c5OYts+59AUx+NsCOqnD2it+ErkPaLmFARNtOpNT2w1sd9S5rkmesVjYEp4yi7K36JjXmW0O7+0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEyoFrjkdQLWFg0e97Vy9JKQXChsC7AqgRhMsKGEpY4j7CG2fl
	C0qLz9/L4VZIZKU7Q6nAHxQBWDeGIocq1MUFdNOYxZ1wfpkphfoKUy+5dFnAqim/cU8=
X-Gm-Gg: AYBFou0NXvUbcCA4luTnvNa5UWr1UZMIbw+IYw/W1L5XuiCZ2F/e+1Mz7/T7tveQ214
	PcFVQVSCXJBDRevkX32iVMEGbBE+BWtNVV6IFa8L8exZ1Jc72VYFZ/W43tTOEoO8LI2qQFX03n1
	++ZHFtxwSkxcjyMK8LkxoURzIDWm0G/fM77e4hSE6pvvW9MdV0LmuB6qUTsuGC/XwpEcrlalGut
	fM404uLSwEbGSK0YxQ7vDBNkNMFdodjGZk20ZiTq9dfm5RSMdsAX9B53aPx01zpFnedfeIbpV3f
	WmrMvduGqHluCjpNQvbQ1Y1NTsTNz+RKZBOiz/kbWlYQmEG5mq/uuDdrI0XJTXe0LklReAnclzI
	pRUt5CgQJHWPjy2qG8mEz8MeGTjwV5KHv2F1ejajZOFkOCjxGOiRWUY4vIgHtm9U1Dgejvq15hx
	YvrP1i5PeiI4nozM7mX91TkKdGPwQW3vH0ZEfjVjdPCNOkI608CjJIxYEnLh+WmucXe38W0vO3h
	X1IluFdjfjEKlaQPUbL5czXUfpQjAOPuf0Apw==
X-Received: by 2002:a05:620a:1a13:b0:93e:b664:db34 with SMTP id af79cd13be357-93f29d9a54amr1655639585a.57.1792483817852;
        Tue, 20 Oct 2026 01:10:17 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c08b675fasm10655066d6.33.2026.10.20.01.10.17
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:10:17 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b55859245so42793966d6.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:10:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwlbUggfNDCS7HTK+feTxPVfgQ55SIm/2Dx3nnwAs7sIl9zgVTVh2gZ9K1MnIg0bBiZWyUvCBxEHEQ=@vger.kernel.org
X-Received: by 2002:a05:6102:419e:b0:7b3:4199:2dd7 with SMTP id
 ada2fe7eead31-7cc364a1700mr3331202137.0.1792483414556; Tue, 20 Oct 2026
 01:03:34 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020031049.969895-1-den@valinux.co.jp>
In-Reply-To: <20261020031049.969895-1-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 10:03:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=CEC8_Ta11oLmKWs9rkGsy20C_g9K+n9ej6qsNF6=zg@mail.gmail.com>
X-Gm-Features: AclHuK8DND9FbZy7IbKb735A7LxSnsy1udn9Z5wpI7Xg7SlqXYAKq5qlFx-pakA
Message-ID: <CAMuHMdW=CEC8_Ta11oLmKWs9rkGsy20C_g9K+n9ej6qsNF6=zg@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] PCI: rcar-gen4: Recover from link down and route
 Root Port interrupts
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Shawn Lin <Shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Den-san,

Thanks for your series!

On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> Proposed merge plan
> -------------------
>
> With v5, this series seems to have almost converged, so I'd like to ask
> how maintainers would prefer to merge it. Any advice would be greatly
> appreciated. Here's what I have in mind:
>
> To Mani:
>
>   I'd expect patches 1-14 to go through the PCI tree.
>   One option would be a two-stage approach like:
>
>   1. Take patches 1/2/5/10 through controller/dwc ("PCI: dwc:" patches).
>   2. Once those patches are available in controller/dwc-rcar-gen4,
>      take the remaining patches 3/4/6-9/11-14 there
>      (the R-Car driver and binding patches).
>
> To Geert:
>
>   Once patch 4 is available in renesas-devel, I'd like to ask you to
>   take patches 15-17 together.

I don't think I have to wait that long, as there is no hard dependency?
As soon as the DT bindings (patch 4) are accepted in pci/next, I can
queue the DTS patches in renesas-devel?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
