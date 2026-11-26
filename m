Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698989;
	b=d52GZOJsjpTr+58BmNEhGb6vw+xHBa1lkbexyVBUhVmUiy+mWpi5iXsvCJWJKW5OaBJc
	 QyH8jNmQytQLIug/WUgQ/mhAnxggy5nmG1M8apjt7BrrqKWAeq/apWTbHPyEpemVsSiQZ
	 8/0uQ60tyIqRgmDJlutRK1pmi+gp5tClV/0f4ICb2w98WTjZZEUnI+byV5WCi3RSEyz0t
	 ocLDd6nGQY688Q0IgmAH48iuEP73MLvAuDJ1O2zqGRbc0F+gfma6giD4rXnjEGVMqvgBu
	 RF9LY7gqyagfh95Jb3/C9noqQAmOUABfNjBx7qJTaYXU5mtN6O9UDnz3Qc9ibkHbGOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698989;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=z5gsJ+BDz+8hzJBQw/xAOysO2V3ppLgl3lpNGd2ZXi4=;
	b=z5brofDXK6lCLGDXTMVyoLQyeBzGtHBABUQ/DhvnKY50tKQsYlALKf8YWJf+lgd0FwDH
	 xl7SKtowjQOlBXPGhWyq3xVr9Iu1y5JHwBSqTFWDsViEKNRjDWtPVyIAXa+M1+FRCZY77
	 mMhKceu/jtEnk9AdyHZ4JQoQcux2ahVOaHjUlrRsPJLhRSYlwahsDyEoRHdbUp/qeMhx7
	 WWz2LveGTGuWctEjxg0DZdHIMnUiLKzQle4l+6ZQLVit7x2h/BcwstbraoySfeftSnvuH
	 7gkNQjx9lV5vQWcUDXcj1R7jtKr9jMf5giWApSUItXFxnlfsdPNbjxoSrQWjFAeBfzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3714E606A68E
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 13:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3714E606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f20b304c0so629438785a.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698988; x=1796303788;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z5gsJ+BDz+8hzJBQw/xAOysO2V3ppLgl3lpNGd2ZXi4=;
        b=yur+ZTVVts0FSbsLNwl/k50CfqOvYYCIDBdpEdQolSAIv0pHcF3EL0jv2+1WXVFuwL
         geDz0sk18OW9Yk/yk1H7Zq8wp4p04tfnMlPS/aruJWkWkVJhwkHs1YQTLujv3y1eOzB1
         E7KMKwd+PkZkc87KMeESbkJa1J5q/67JZ6Wf14wUmavEq3sQwltqjrPXpuntMUXHNk2O
         asA+gBABMD7b9at8D7/BHzd8znaBySwuSIgLIDCjaKY3FI8N6qyHKWaSO20u4oOwtwEj
         5XvDFTiOmbZ0FqJlOjnFthL/HFOZWopQskDI0CEu2H2zf1P5IwQc70ZkkYjRSauC7oh7
         cvVg==
X-Forwarded-Encrypted: i=1; AL+hErHmUSAtOPGr7lBGzVci+9UEfSoipdqbTwZ8Lk/SFmmvaqQvjkjkMVGz0t6EEq7FET6lqyC36GUv6iU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+W4MBozFl30Nl+Sm9opp5C515MzetIBwshFAhnmWeFdM5/OXe
	NWxflt7YjDt6pJWmwSJ5Tl64wOe4gP9qITD9mQ/OX9xI/XoNv2FcQLMZQLQ5dOwq
X-Gm-Gg: AZFdTZdAOdfYGXYzyIBclmHXMeYAzkS4QzxZ1NShqgI8kB5QzNKZKGIAmdQfUeVAxKr
	6lZ8hoerccM7SloOIErd2TwXzu6SrSO272SYTmibagfo6z/X0rumQc6V7HFLOZwhw8X1RZcOMsE
	40GJhzUsHJ+ciGM6ArjfmJNIazJLYzVn0TjZwidrB16MULOWb0rna0oFNOA0xwuSKQyOidyNkqq
	KvMeo2Tv2+djTNt+fWjE2EgiyncS/sh3Jp1QLPeHSQ1qKigobiSQK58TTjnh5vkq9+50fHPWZE6
	QA+tEx/8VOF+XKAfN+INP+wNDgsw60r25TQ52Tx0dRSvw9DnY3+MD4aV5Azi1ulDVk4Bq3z/fCZ
	Sd/BxBLDV6K5ebJOR70ehl5VZxdHS7CCX2RDC0eI8Dz9YXWQ4GI4AnDbOELjPxQ770vG9vZL8kO
	ertqqv5g3N1SviRCsEW57z1KSuO+5y+NrUBQ0Wk2QucLS0ljchi+UO12h3+pCO3535cAI0pRMMZ
	7Ajux16abExPBjo00HZGI0BmsV7AAvB2WwEXGIpaVBNddWniRvrpi0neT94HEMtDyJmeMFBQSl7
	H9avxzugKZ/FeCo8WV6SQm4gKvEufMz5aeL2PALJxsTOyk16q8CGptHANfRjRVn9dlBh7FQcSzF
	Osg+abIZNGzIJ2utR
X-Received: by 2002:a05:620a:17a2:b0:949:6e15:e1ca with SMTP id af79cd13be357-949ba965b33mr3753111585a.19.1795698986665;
        Thu, 26 Nov 2026 05:16:26 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb4004e8sm1570063685a.33.2026.11.26.05.16.26
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:16:26 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-94965745d92so691120285a.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:16:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG3WZH4NseQTJGzCR+W4JubAS0QV7Kg4eayMorGTwgKA2VLWY8nmh6OFUROYgB6LvwyYShduwCFP/4=@vger.kernel.org
X-Received: by 2002:a05:6122:e16c:b0:5ea:bfe3:6035 with SMTP id
 71dfb90a1353d-5ee8aecb450mr12500493e0c.8.1795698622003; Thu, 26 Nov 2026
 05:10:22 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020031049.969895-1-den@valinux.co.jp> <20261020031049.969895-17-den@valinux.co.jp>
In-Reply-To: <20261020031049.969895-17-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Nov 2026 14:10:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpV=FLZG6iiNMj8Mq39RQ3u8JxKyTVws7J0O9Y__2EqA@mail.gmail.com>
X-Gm-Features: Aa3M54rTYSp7n6mDEivRvXB3zz9tm8FUTty6In8Jlz7Pqa2lf3sYsYsJuOUeaRc
Message-ID: <CAMuHMdVpV=FLZG6iiNMj8Mq39RQ3u8JxKyTVws7J0O9Y__2EqA@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] arm64: dts: renesas: r8a779g0: Describe the PCIe
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
> The PCIe controllers report Root Port AER notifications through SPI 454
> and SPI 461, respectively, separately from the integrated MSI receiver
> interrupts. Describe these interrupts with the "aer" name so the
> controller driver can use them for Root Port error reporting.
>
> Append the new interrupts to preserve the existing interrupt indices.
>
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
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
