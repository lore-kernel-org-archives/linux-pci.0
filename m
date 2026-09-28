Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19839E190
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600549; cv=none; b=D92knrLCmUSdNpAeC+SaMh1BvZ6cBqTZZIv9NrUib+HjIvTmHDkuYJrc+YUWhCxalm5onjIAYvB1BxdKO/Pavavvid7667lXj97iZVystlzeoah2XO7rOr8wiqZPt0KMvA/wVUWZYR4JpPHXnuOKAbzwDrk/+ae6uTX1PA0kHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600549; c=relaxed/simple;
	bh=MNgEkF9rzvNLwkhHa+USMkamAutraVbddo1NEhjIddg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGS0bH9QZk5iF9D6ywa2vScmumcDP+DduonPm/27SQst0uxgFtxyKCHqokjxrmf2KcY8b5cCKwRftSXxSr7vwTogsyuXa1RyoOQcIqh1aKVmf9UcEmnzbNWDN+rqXu+Ni+jPLkzAh8F/E00yF5FVFSs7x+ix1qf52At+mVUDxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b451f1e66fso915371137.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600547; x=1791205347;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2wjW2JTwOVXb3h1ozyQBNpHWe/T9o537b+crN9rr4kg=;
        b=VVfmJmN0FXSOySiVxwMMHSc97UyjeSLE37OOgS5N2qh6fkN1h/7U4pEfPgcLZNmzpu
         Rj0X/4OZiXaJ5Jvsqbp11M5wGgOKxQhDASEu7zuAuFinezGFvJquDcNFnwEjojIB5DqU
         HdduAN6ArDMQJOugOwGAIGRhTEfXTuuJxrVcYN3CNbFjzkC0sHw7E2wabViMssxI7XJe
         ADqvPkmN6G6pwcLkXnG8Yj+vMskiz1VWpnWZp4biyH0kNBjQiCfWjyDAQjvy+lqsfGQh
         jwzAtJV9D4pbpJcrRevUmXOqkDrWxnPsrPPVjBNYroDF1lYX5cXLRG4WMOUv9GmI72eg
         W/Sg==
X-Gm-Message-State: AFq9FYJXOHildG3i46TASA8+zPhwsCjctzJF5vL94yxXGebruF51t6s+
	SW8Qbvq7tF/DiGsiZPcWqiBSQ1dj8NGz+W+dzt0OG92erBLoMaSL6h8WJ6PduVqr
X-Gm-Gg: AYBFou0vDiSnPrOjY64/xtg9NzIBKhaglZkQdPVCffpXicPmqMmVdKcNWuF4YIK9wx2
	cjP+dE/vFEFHFfvfG4gYXa2x2x+YX6S8n0ilaq579+brSo64TGoLV99xDOy22o7qwsA7sepvcxd
	H8oKZ+jt5kKnS7EGWnblS9it/dwlBNn7jJZfhByjUl7D38F+8ADtMVxnt0+yVaSmpOxmhdj8fdD
	d3Qw5B8pwuMRvu6CEcVCpumZThP02c1GIEUhHj3HtHqa8aDylb4TO9nn1Fl0vG/0+Uktw5MLsjp
	6YbDY0AF5XkZhroA7MUHWlk8N7cm1I+6AnRx8WrmP+dSAYI5TbAWpgUKfmHPNfRHAP8xL2smgd8
	g08jAQ9pJKZTqjsHCPvX/sTT0CmrW+necNXx0WkB1Nw/rr0xXYP3upY88S5F5WTzzLRKIBh0vsL
	0mOVuDdf0pIlF+6xRtNxW2AaGXNQ4ceRwlpPB1LkYpgf/UFfnw8IrOkp6JHZOv03Zxw6B2ByDtN
	6q7xAwlzXeD/6GVjBZv8TifSdHLYNh2zk4Jkg==
X-Received: by 2002:a05:6102:868f:20b0:7af:81ed:6090 with SMTP id ada2fe7eead31-7af81ed6d59mr3246374137.13.1790600546836;
        Mon, 28 Sep 2026 06:02:26 -0700 (PDT)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com. [74.125.226.235])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde5a70282sm8907395e0c.10.2026.09.28.06.02.23
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:02:24 -0700 (PDT)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9851d513a70so2330208241.0
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:02:23 -0700 (PDT)
X-Received: by 2002:a05:6102:3c8e:b0:7a7:c789:888 with SMTP id
 ada2fe7eead31-7af1c799ab1mr4246322137.5.1790600543175; Mon, 28 Sep 2026
 06:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org> <20260903205153.283553-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260903205153.283553-6-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 15:02:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUFm--o+J_dCEkQEJOYPCPhemwfujNm+j0veMPYn-g53Q@mail.gmail.com>
X-Gm-Features: AclHuK9PxP9o2Iptr30yrzx9bl3oQSb-6qLfwXQyJV5JcRh9RYQN0Hhi1zaXUYw
Message-ID: <CAMuHMdUFm--o+J_dCEkQEJOYPCPhemwfujNm+j0veMPYn-g53Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: renesas: r8a779h0: Add PCIe
 Application/Local register reset
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 22:52, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Renesas R-Car V4M documentation R19UH0217EJ0110 Rev.1.10 , Jun. 30, 2026
> attachment R-CarV4M_UM_009_SRCRn_FSRCHKRAn_FSRCHKRBn_r1p10.xlsx row 411
> describes PCIEC ch0 Application/Local register reset. Add the reset into
> both RC and EP DT nodes of PCIe controller.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
