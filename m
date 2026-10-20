Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497167;
	b=BZXS3eVuMC2+OGynZutFj6fWhD4lN9pZMk2V4PiBdCwKMClhdKMxeW/45+N3J2jbXmDI
	 0e0RJg2RkO6riJS3PYtjfz8TuHsoqndArOrH2EaxqlTq94KHP1+fLyt20Bzbu2EspY+1y
	 7GyjUoEo0CJU17xCIz6ey032AoRCWxDoIg5/klGilghUtS5lLZ5+bbUeOaXiJDCh/jeQg
	 oS4nXbTWIyJc0SEUnpe3/twKSYdnJBZLHKdM2sdPpYn0HsuK8LWScgQDsUM9tcpqT4F9z
	 ciyjhmQC5t+eY/g7Nx2+rqeWHL/Mgf2dFUvLDUH05O9j8o0HhBRTD7Rr64z4Dt8MHRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497167;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=7AH5KLYkXXpwtDoOq342gqQ4JtDTxtQFyRIk7TQMJ3k=;
	b=j94VgCmShuPRkg8k4pfR3+OYDmHBMeMbE7gRpaKChO6GbqCDO2VeeAKmUOFkpv8x4Lmt
	 A1lt337BCP4zpFg856yXDxNxAFlj0PokJ3yLW6xAE0rdjqLMSYZ0mZM6EgpmHPNapd5Gq
	 N+OyQDTLViCaNJdryNEkmXDSdTHeEenGmOxXSgnOS8m1T3g/JvgtdJSfP/pOPq6hCyn5t
	 rDxyAofKeJziJG5G+gyNEV8Gt+qUHOsepGiG3A2Zyt0X2uEQl6ARKvo7QwVHed8Ebcs3o
	 B4tCAUUetGa1thDXT2LgCdsphwNKUcfdISLENovarf+mLxAZOMuHMu8HKM8KRfrCpxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FA606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 11:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 806FA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ccc6b11a19aso1237624a12.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 04:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792497166; x=1793101966;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7AH5KLYkXXpwtDoOq342gqQ4JtDTxtQFyRIk7TQMJ3k=;
        b=c1OvX2GlCaFJSCbfNf6eHVfHnHlf0sTcQCY37nmQqrx4HIJHBjXFsv/Q20SZwhAcGQ
         QZzmfRTEomjJLQSpAG44NwXBM5kHRzX2oNKu00tVrkh0dcexnJLHvzCmm9nm8gYjyBUx
         dlCjcyvI/jduutBmS6nTVGjApGO78dgdX/q9E2My8lAYQr+2Xbv73WiRbPs+/yi/7nfP
         TnY4SEbXndPNOPZySSwmwhQ40NRI9lpBRSBqA0jaVrkx2Ygxtbc2inr7X5OAazpEf8uy
         d+lH9YZPcYyUOn/R0cicRQw+ZbzPSKZuIAa0ioo0ccswCDQLGDOBlkRhLT6rrOQ2ZuAE
         VH7g==
X-Forwarded-Encrypted: i=1; AKwUvBzHKmXGVQWdLbMDEIND1BCqr9EixYF5KnSM1PvG8eEwlBVllCOzlvrof01KJVal3YXOeU5md5hQemM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK56zIk74lKZ4o/2+I3quhrdiDQF6+eYJlUIEV6gQArYzHys2nF
	OEisfWbfin5DQfc8eY+s0GAxHs6LHpuYxxG9iqaRIhl5lZqvaadgF7PcJN7Q2EjSdAo=
X-Gm-Gg: AYBFou3dlNsu9iGoec3HjgusYNMDntobBTngGsGOkrcemibcGuaMCvulnXsWosx/8Mh
	Uz7ZeNFgbxpP9q1fMmrY6lqs2ntoC2p9znheMz4annnYbDxQV7j6kimSrvZyzqbeq9oUA29Ezjq
	79/xLf+mNl2qjDLCVZQk0E8TOYb3Vn1DIy2yhCc06RAOGNit9Wl4Gl/SReqNLo0YxdBk8lbAwKH
	p+0Q9LPeomTOkedT+zMAfxE/6djbTz56+52H+LAz/cyP7jYhiD7s8TGCBCss73vup7F2+ym8N4O
	Ii2YZXXINx+k2RcQXcat6z71JRdOLa3b9ZmLpGDNiOkMfvptS1bnS82O1Cg/bjBo9x1gsEPxVHO
	2yBYZY4nokpW6ShrlbM7YH6ImwQwnDDdm03fjfFbBhw5sPBP2B200dBKNlIHlozikjJkBd3EYCX
	gPasPREu74k0q3vmhnCT6rDFePoPJSMSOHMeKFh3BdhRc9RjqyCCr/mVhqYaCtqLG7ZNjqVrzZA
	tYsHhsDy471JICfr/SZnMA2QTZ98bwpDgKeRaeA/G/XKLoackweY7nngvukmjdwHt3ZxBVuaiAf
	6+nM01xRBiRdIaKEgFhp
X-Received: by 2002:a17:90b:5630:b0:3ab:1af3:a0d with SMTP id 98e67ed59e1d1-3aceeea8ed2mr8728728a91.33.1792497165762;
        Tue, 20 Oct 2026 04:52:45 -0700 (PDT)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d564327sm3426234a91.8.2026.10.20.04.52.45
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 04:52:45 -0700 (PDT)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36681e85e87so483776eec.1
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 04:52:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzidPgSkVa9VmHOtMUeTMHbPxK3RcKRf51LisvHGRT2w98Z3H0huzvVEmYGJIXqYx2Svy6LWmbWZYg=@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:2c29:54ef with SMTP id
 ada2fe7eead31-7cc36a1fdd5mr2439750137.19.1792496853877; Tue, 20 Oct 2026
 04:47:33 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020031049.969895-1-den@valinux.co.jp> <20261020031049.969895-11-den@valinux.co.jp>
In-Reply-To: <20261020031049.969895-11-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 13:47:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2wTNjaT3HacNiAAwSNU9MtvXqdFg6uSk-pZUBh+9tXQ@mail.gmail.com>
X-Gm-Features: AclHuK-oSwXELoK3ftCuQEMht83trZrqGJxwnNQHzvwYJozTnmt64-x3G5ZnW4o
Message-ID: <CAMuHMdV2wTNjaT3HacNiAAwSNU9MtvXqdFg6uSk-pZUBh+9tXQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
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

On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> .deinit() callback. For a core-owned parent interrupt,
> dw_pcie_free_msi() removes the chained handler right before the domain.
> A glue driver that owns the parent interrupt and demultiplexes the MSIs
> itself through dw_handle_msi_irq() can only stop its handler in
> .deinit(), after the domain is gone, so a late interrupt can still
> dispatch into the freed domain.
>
> Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
> dw_pcie_host_init() unwind. Keep removing the chained handlers of
> core-owned interrupts before .deinit(), which powers the controller
> down. Clear pp->irq_domain when the domain is removed so the unwind can

FTR, this is now pp->msi_irq_domain since commit 8f0b8cc3a655f56b
("PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain") in pci/next.

> tell whether it exists.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
