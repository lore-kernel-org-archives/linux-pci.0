Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05D3DD52C
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454544; cv=none; b=gipJbkp1/y92QpolY7nM3fnuLisKTygKsQnTKxXYQtHmCbt7jTtH+2lBJwYhG4UlrYyZ5Q0a5cNdaxCqC/dkrVmlnDWpfsq2ex+9BOciYx3SqoJMUjEfJctqodjA9jt9P8xDGagJMXYSBj7NgAta1ZpjeCJEpLOKRCqzh35HEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454544; c=relaxed/simple;
	bh=V9EhkXmHhCfd6mpQBTgvR/U5ijzRrAw8mhQanHksz6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlyGZUDEXEM21qwASxM+NIxCH5gpJAzVweRBJcPfjE633V9C3bz17K+IomCL+kkicXSTTbLK0lzfUc7gwwM3ivrupHihZMWda6nMJ7ucKhIgICL1FBWSf9EYY9rLLSMDWzRcGIfAd20a3drlTz55PYzhU8fTtoW4vYvzBGUhgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5637886c92aso61418e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454542; x=1775059342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZPS9rvjiCNyKh+pIYFKpxEAkHK/vWQ91zf2PSXKLkY=;
        b=c+kdfbnicxMr/fErLKYWT7OAih1F9MkVrqzAZh/PRHuhlodnO0NHLbpT9PJWA7EX4U
         +2P1VGJJzIBfHAfG44BB1kOSMiS8M3veHCAQlE0Xg4aWIY9LptmQToSlMKVp8YuKPat/
         R0uFZp+I6jJdHZtR7NQOF+vTHjAlYLyMD9n+r3eDhY4HJ7l9hCArYpsPC9UnZaMdshBM
         NWOE1+ckBltc843gNgdXEb4WlP5TCYR0VTTTFBpVV6qYLKLHskcMyykX2zOwfFAWf2/E
         p3eJ3mccqLUw0uLYN2TpEWD9A88Hwc5tWB6zjcHfJL6fz5V1jSVHCVxdQbkJEUxJ34FI
         NZpw==
X-Forwarded-Encrypted: i=1; AJvYcCVwP4duem1IoHTqLzz82lRy9AurVRbteqT4ZyDwkawpQS59z8OUz86R+PxOoohJ5lVrd6Ruf4VzB9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXNNPOem9EunxxLRNsKmfKqQDh7X/EIQC8KyABzZdZchN4AIJ
	M76rd2ae3E6Et0bcXep6fEVFG+M0M9Rve/96rY+yZWIYtSP2JepnD2rZDBxa9wD1Rj8=
X-Gm-Gg: ATEYQzyZZIPvq8sPp1t8LsqXpNwI3jthhjJbIFLXqtD22fEeks5DKoDIg/mp9zowLiF
	EwN2U3usKiKM4ex7HtPJO6klNAK006mjtqvNgOhyoT5yzq72G+toee42iZFIpL0yYRhI9xJ3JQu
	OAHzLAkMUvdunycrMQK9twWJGepJPKlRwuKoSYawPuRYvoFpMvMMe90nOOcgt4jH1bnK7Ri/RiB
	8hsgmu9fMfs0bybIfQXYjDN+EigbKcmJ/H4SEJ//CpBxSiRNSrJDaC4flLUyKIp3VctakTsLJQU
	8ay9uXogxsTLrjGKQGeUNnE3TN98/p0SyuPieSprDhGq6Nu0hr1KS2yT43sO5kVyeypexY4r9a1
	JKrAfrP28WfXkriHfOP8PYGJfuHc/ylRDEHdAN6BIsAZf0tvCX8zhp8ddGTYlc/gDoTqnkbnylD
	jFmJd2RBNhZ4OVI9AMaDHxG3zYOAEh8dSF3DOVUNYn0kvbkSiCx8ia2zzPjAZwKNPl
X-Received: by 2002:a05:6122:8ca:b0:56c:ca38:ebfe with SMTP id 71dfb90a1353d-56d220f6255mr1811624e0c.16.1774454530905;
        Wed, 25 Mar 2026 09:02:10 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951be1063bbsm457517241.3.2026.03.25.09.02.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:02:08 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56ceded5a11so33084e0c.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:02:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPWImmFoMF9NU/iOTGKFhJWUML3OOKBoDaCmE8lAWzVoHUXReoVpZkGeGufHJm3kotZop/KljNdcA=@vger.kernel.org
X-Received: by 2002:a05:6122:4f97:b0:559:5ef5:b196 with SMTP id
 71dfb90a1353d-56d220c4f8fmr2065624e0c.13.1774454526013; Wed, 25 Mar 2026
 09:02:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318085119.44717-1-john.madieu.xa@bp.renesas.com> <20260318085119.44717-5-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260318085119.44717-5-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 17:01:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPvnoSVBVKFOgXFrOyVK_CDuiNXZ44v_FYkEBtYKEhOg@mail.gmail.com>
X-Gm-Features: AQROBzDAUOx_p6wz4xdqborLEdAuZA8hQ4cgzmgeW84NqoNOTvQEgITg1E2ITKk
Message-ID: <CAMuHMdUPvnoSVBVKFOgXFrOyVK_CDuiNXZ44v_FYkEBtYKEhOg@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 09:51, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
> Enable PCIe support.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>
> Changes:
>
> v9:
>  - Renamed gpio-hog node from 'pcie-clkreq-n' to 'pcie-clkreq-n-hog'
>    to satisfy DT schema naming constraint (reported by Biju)
>  - Updated line-name with proper signal name on the board
>  - Fixed node sort order within &pinctrl (reported by Geert)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
