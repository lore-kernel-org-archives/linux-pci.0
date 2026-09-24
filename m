Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC241F5ED
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232743; cv=none; b=n6k0iv99GmcQc7ytGWIP5qkd6XwoB96ZHoueVuShQylp/8B0i5KqeG+v0+9Jo+yPGXAdqyza2es/lIcgEMq8xb0b4qWkH9jx/slzLsIfTTJ/0yjkMSpr+1PbY46aCKfpTyCa+dXcdoyLqZohcBJaTXY0BELt7q4PaFQ6InKnCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232743; c=relaxed/simple;
	bh=bHdqhN6Uz/ifL7Xj9yVetsOtxe4Gixkb74+2Fem2cnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQpeqUWLC8s6QhHJuDyhaupljNKu31lTrI/Haq/SzzzZOeRoBmFKt+ZlXXEwvFcREHVCGlk/K4On/w4VliWhzD/a5HZ4JQRt9TYw40BOobyhEXHLFVDLsVQZqQwf8Va7mNVxFovS8qPLd/ya1jrNy/iRwuNglJG6dTZwNkWAygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292faso782702e0c.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 23:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790232732; x=1790837532;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8AcTxgfWu2jVaXC9s/SfRyP478Ly0vXbsE/VdtFyfI0=;
        b=0N0MDKwSr1G+jCyleB6PgUjwSgf4xjWytH131YjhyWyVlNmOaLD8f8wm0j9tlSfGG4
         qL2ruJ/1v84ghxKihyJRn0mJd41C4/S4G+JlsCpZx2IEGvOof+92UJ0vciQAIoFaqu+w
         3Lpzc4oozP3wWYxww9OqsH2c5b6O/l0ny/g1IpZcrdXt5R/Z0xKnZD1gXlcU6nqx/T70
         uO+e4OZXmdD4Y/2F1xFkJi6+5R1WrlMCsiA6wi+IrcZiCESKRl6+MqD1w0lkeZWDQ/kC
         RI8N+fcE0a4yEhUXsuJWcbqlaBTPCWRTGoTEEqcHIPyFBEoiVVGjUnJmdoYjJvswyo3P
         vHHA==
X-Forwarded-Encrypted: i=1; AKwUvBwAfcosD4g3kpdc2Sdb0EYIcYbt2g0gnMv2bhPx8BganHlCiuqy5qN8mAye6lJI5Hjnk2vDa0O6PSY=@vger.kernel.org
X-Gm-Message-State: AFuF++m8zk/F7AxUH/udY9p3XfMZFDkK/Sfhovv48eZ2qAhAjMFhbhOJ
	Y2EPL77jgnJP74joRrAqKD73K8/FmpN0l/bAqGXpvjafrYryhGlLq7/Tu2gDBzsXAa4=
X-Gm-Gg: AYBFou3kGnk6bFhPY9DYoKYr0c43UQbPoDbD/jjZxiKwCq2rVQlMi1i4O/RGfK51Rfr
	O6u+S5goF8rEUb+GarHj5BZyZFbfxfTCyYgvhx4bEjiC9Y5M0AEsjcxS4DXI/yDhKA7YlIp3f7Z
	H0NaCzMYKoDmfJzf01ybzseWpWTH4NhVFmS8TN92UX22WKcxDcwxfWjuDc3AlGdeOb0UWesSiLT
	aAmugm04jUeJGn2d6ChqCKaa9IpKsssU8GyawrJBenAPtcTD7+B/rWhMDqhPUQkTYhxb+4GHi/y
	qzGSDlWK7D5ihPIN9b3WVVy2fdiuzutfCNCfW4/alwU2NBEdzCcJPMNHOIysJdEwecsQ0cM65SD
	GziydzoToB5BCAC1XKw4CLKnEjjNk8fMgvTiRoFQstptDFG6kPaAd+6PA5V3hrUYX0BKJxqCgyb
	GyNGbqUl8VXIFndxxjddASmRp1v9P3xkLH8r+0ADlYqiSIlk4eIxrFPiISHYoYCJi3v1Ipat45a
	XBJ0lzdYDHmd1dwIaVmQMFaHQnYORYumXdk
X-Received: by 2002:a05:6102:5344:b0:7a1:f7d2:e831 with SMTP id ada2fe7eead31-7af1d4bbe21mr722967137.17.1790232731919;
        Wed, 23 Sep 2026 23:52:11 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851a07144dsm5391510241.9.2026.09.23.23.52.11
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 23:52:11 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-791a9878aa9so571424137.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 23:52:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUAtvVYzt1biOzBV4mW+zZUADnAbWlmczDYyVftTlfwur5OfKMdXh8RahSsJfwUulFQ172IUtjuO8=@vger.kernel.org
X-Received: by 2002:a05:6102:3fa1:b0:79a:21f6:20fc with SMTP id
 ada2fe7eead31-7af1bb76432mr890214137.10.1790232731325; Wed, 23 Sep 2026
 23:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924010418.726980-1-oss.patchbox@gmail.com>
In-Reply-To: <20260924010418.726980-1-oss.patchbox@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2026 08:51:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVx4Ms42zU=C154kJV3CGQ1c4PaOjmBTc=8eVQge8NHCA@mail.gmail.com>
X-Gm-Features: AclHuK9x9fUPgKfTcFQFW-zdmziFaoehsLnYyUtoHh7DDWbbSEG86VZHZP8H3cA
Message-ID: <CAMuHMdVx4Ms42zU=C154kJV3CGQ1c4PaOjmBTc=8eVQge8NHCA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar: Release temporary device tree node reference
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Sept 2026 at 03:04, Yuho Choi <oss.patchbox@gmail.com> wrote:
> of_find_matching_node() returns a referenced node even when it is used
> only as a boolean test. Drop the reference right after the match check.
>
> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Changes in v2:
> - Use an explicit of_node_put() instead of __free(device_node) (Marek Vasut)
> - Switch to my oss.patchbox address

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
