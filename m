Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698593;
	b=p7TacQejc5pHlGwTwHMbodWtmnWyJTbhjFMZf7Z095nFtpTptIbUQmZS8qxeCsd+rQXo
	 +YvAyOYpn1Zu3czI/ETK3Sq/m4XDcyAZKMgcyIZBkuisLaOB25L5/kgfXtCH19z/ITLht
	 a+C69yjuZHB0ZPyz33+cVM2Zj6Glh632hHV/XEEZ2Z0D/8Adg2Wu4Rx/iMhjLS1N6hbzE
	 e2JEMP/Nm15yBAPEL5wiFt98Ph1NvvC/B25QIy0klN5DV8fac06IWpw+4M6gGyGXj4Ckr
	 +nojeErB2sOnNOgRUQCn9vfZB3OrzWx74RELTAJ0VIXH0SSHHkPfdoKZTB9fDrFfQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698593;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=/8RldKvPQUEazbYpydH6ulNIbu8h2Gc8WOSWGgj6gjU=;
	b=4axkZwmOAhGUy2r4ETmYfYIk8c3UoX1/s4mxdGdYdaT+cemd4uKjuQ3rZQFJTYh/q4Sv
	 0ElS5BSvQXeHZU6Bb8ry55E7vX2dn9589Uh2mwD5uFSTMILRBA9FLntFtRqoeKp9zO+1h
	 K2HROaj5WJIE85ng00ZjwxMnohlGnHqF/iZLznoTF2G+pf+KoBZYAeWzlfht9qEj4Z+C4
	 iKWMl7B3mr7VimopOZ1J+tzO1Krb1pKhTQiSjh+SpUrjgHeiqE0CnmW5lLOS8igmLcvku
	 qVvB96pRwwpigBabHcS93bHugOjbszP5IKJZpWG8vIprMXyKwT6iwTdWYSXvw7mjL5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231EA606A31C
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 13:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eab93a9862so1791578e0c.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698592; x=1796303392;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/8RldKvPQUEazbYpydH6ulNIbu8h2Gc8WOSWGgj6gjU=;
        b=choJxxIXMZQxxQSUHtkYYNmigOqMAks1f8nfdJqVLgULQwPbFMjAdQihCdnboHi+4E
         oP933GoBOmBaOVfsYa9iPg5+RMMSelZMaa92MP33nYoElJhUgNEyM9LtIDoJc9jpYlqK
         T6OORYPGWqiTyE63smsdR7S/mKhtQHa/wHpBZq7fXsEhcmgucnOT3kB+/uoPn+31dpLU
         pLzK1hlvCJ1U66oGi8JsdOAtw3VlhmY/gpKevQMPwfl5D3X/qtVjTtLnt3EXX89RAWB7
         bj3EcqERspf5RyiwwzQWZ3Tw54U+naMhBeLczpNgs0VlmQez8O4EnlkJPxGX/rf4YpR3
         hirA==
X-Forwarded-Encrypted: i=1; AL+hErFa8nXiIc0LyV8/F7Slp5X6yMru9/AHqegcpV8R9O64fAtydfS7f8DGIDzvo5ZpT5G565kTRmWWmq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9it9/bmFL5gNHjEwA8cIcvWCQWCfgPwgYgAXLGfDVZWwkqN2QO
	zz2cSAdvIVJJzHZHVucucrARIOozgLbiYZRR9s05B35inEJB0vv7hrLD46N3iexP
X-Gm-Gg: AZFdTZdnpskQJnAbgXPaybew8LoEn6WeyR6CCnLIgAkqjSfRIpBxy3yC6nW00nvWiRs
	GgZaY2GMxH5B59KljFtSx6xf6h2hMiRirb9vY77NUFdPDHK3lYFRUW2ky87tsUfl9YjmssMPYvs
	BUPx2L2kjeYAtezniwt+r+3kxKXLbO7oviKp/Tf2GqkPnJSBm6AIHCqUG+rSnO+fZ5x8IlvutAr
	7O8vGOs693yLjuPC/V4imON5UDW1jxPqWbfzqZdJRquoh4hl/Wj8UatNuYd0rcDtdug0YzMIsyh
	Xsg4nfGrW2t7O3pe9pAh8YIDbY6JC9D3/Mu6sTqkznr1542IFb3Sof8lta+DzLHKeis2uvROdwp
	+AJAurryEElLbRI2lGnEqtx6LNoL8QzoWeo51qHwryME8+sywSSaTm1amwTbc7VBIDLV4zf7XHM
	1vIyoQerKG9SCLkboDrbwyXUWiz/SB9oOh0e5yKQUmmKtBxFVgtRcQeGQQHiQOhJiE+7T8ZRAAy
	FXqo3zJz4taEEe1je31f66QqK/gUI6cbG/kKX6EBl8goD0Dgsxlopq5Bj3mtA43wT9cHybU3jnT
	kKNYWgxTyNm4phrdU7DTk+uyX3WC6R8cX54qCJSZokxRoGwyDH+fRRKPBZ4P/xFGmxAMcok=
X-Received: by 2002:a05:6122:2493:b0:5c9:a60b:e5bd with SMTP id 71dfb90a1353d-5ee8aeff63fmr10722876e0c.13.1795698591898;
        Thu, 26 Nov 2026 05:09:51 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm20189809e0c.4.2026.11.26.05.09.51
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:09:51 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ebf39def3aso2530499e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:09:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEunbBj+nlIqcetUJ/u+GLRW2x3M7JXGTrBNQCeCEgmmeJhfTGFOza16UdxywZofcQR46JLSqlOqec=@vger.kernel.org
X-Received: by 2002:a05:6122:8b87:b0:5ee:27c9:ebec with SMTP id
 71dfb90a1353d-5ee8ae89d30mr10164180e0c.6.1795698590878; Thu, 26 Nov 2026
 05:09:50 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020031049.969895-1-den@valinux.co.jp> <20261020031049.969895-16-den@valinux.co.jp>
In-Reply-To: <20261020031049.969895-16-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Nov 2026 14:09:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUodx0aRPvj9YZVS5SV_42vq0bvnk8VgPFmeOoZDXh4NQ@mail.gmail.com>
X-Gm-Features: Aa3M54oGF1y6BfpWLxe4xGuZFgd7nGmTk63s0g99O3cHf_svXMj9Q2unpIc8mY8
Message-ID: <CAMuHMdUodx0aRPvj9YZVS5SV_42vq0bvnk8VgPFmeOoZDXh4NQ@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] arm64: dts: renesas: r8a779f0: Describe the PCIe
 AER interrupts
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

On Tue, 20 Oct 2026 at 05:11, Koichiro Den <den@valinux.co.jp> wrote:
> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
>
> Append the new interrupts to preserve the existing interrupt indices.
>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
