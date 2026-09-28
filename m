Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FD331ECE
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600521; cv=none; b=HcilU3G25U9QI6b6uHS5FdEjlDIRSpWqqCzTQptv3irvOPI5dZ0yZ9Rngs/QeI+1Qwf6kSEAvP5aDDleN9SA3LlFA1BDrMLkdwh+XU9CuRgd0NL1neMrtj7ehLmhu3/gqHgXcNDrzUppluxBIjaqiOdyjBDNNmHWFJlLwJ0xYcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600521; c=relaxed/simple;
	bh=xuYApr2qWZXqJ7pnlIxx/vPxMRV2f9KFjGcz6WImdvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaJ725V0+OQmzZmLYaVZV3LC3dp4r/W4bwp2nL/W9TixIM8Ac22h8p5Ka3RUkXO/lxKNk7tZ5M4VtKxCsJkOmDUYh5rDJsQGmqWbka5VkbRwqzIvT5MW+d6b+/tIRFMxbETGpNdS6pK+Ndh+4PEqiPJ4B8ajb6jCUkwThB7/rUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cdb9cb7feeso771768e0c.2
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790600519; x=1791205319;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BaSNmHda6KzqKPwX7Da3e/YKu7hL/7ztMKV1umyjMjo=;
        b=ORzgNTPkwcYmxiLgSiEQMKzdvAYaqPWeWJjbUpNuPNZ3d37V+uJen0HfJ1w3baZURS
         3mDlYxA9/WEUQeWXyO5v3uH4hLDOIwtjX6o6Dfee4Xp/hPr//npAVlfGEFiyIntZv+gz
         M1/qupFJ3+VHBB1hJXLHQtct3o/gXdJMotv98wnHcEaRsePT+q0Oqnjcu85XSMNj52E3
         g9i1GQiston0QVTi/LwrB4pHjmZFrfWneaM6I8DJEw7IMRljsCaUvhmgjeXijG0F/hyt
         7Z/O/ylMEVDBWGHrMKrW34k/eTWEnZRrLnX/nzeuyk8R0OJ4yN5ybNNmCHx1UtgOpxRu
         s0Aw==
X-Gm-Message-State: AFq9FYILzM73FW+K4DgOXiBTLy60kLR6cwsxKZn9cb0PDwsVtX2fsZYK
	mtivDNE6z8k4I9qZC5fqvU+d2SLERGWKq8P9azDHEWmu2uVc3dYdzqlhpYQon2gm
X-Gm-Gg: AYBFou0yofVpuFUMPFVdXaHN9AAOEgU4KXroQAjLqwfFtjlOenMVVR4N5M9LvD8fjAJ
	vPzPtSESCk3eRdUQ5WKr+mrYdigV3/OAabYaVc+bg02TsUYUEhVeCe/E7OQi472OiUlNbgKJl+i
	PFdANpWMA8g6O5DShru7Iln6+xt0KT6E4LuJuu4dfw1JhQGpraNFjpyBxhbv4iaR+LKaO/OWdDy
	W+wUykHxsNCHrVdXotnaLG8FrNbt6PNwVlfMEVK7hBvyO7KROMh7FQOh/2glzIQNNH1/AuW/HR4
	I+O0F8sEKDir2VLcqlL0fOzN1NP3JA8e/t2Bbx40roJb7KG9gymXfVz3Enn42JFmzr5j37O5tGz
	8FB0z5P6CGp5aRmMgkNsNSX6EQwOV3GVRjVYBq0f5rappbeTDMo+fizVryCRtQB7hv2HijdxvTb
	ozIscPFsKxW8TgzzBnllu7iXq6y0aF2Q53KgAf6RPjWK8dFcNARByjUlLiqGr6DmN540kd5zhDk
	iOFx0Dc3ULyZzGccJyDgi3HQSrGA/OFhsQPGqJ/oIGMVBQ=
X-Received: by 2002:a05:6122:4885:b0:5c9:c60e:3a45 with SMTP id 71dfb90a1353d-5cb0c52dc01mr5085924e0c.23.1790600518484;
        Mon, 28 Sep 2026 06:01:58 -0700 (PDT)
Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com. [74.125.227.39])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde02784b7sm8734186e0c.0.2026.09.28.06.01.53
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 06:01:54 -0700 (PDT)
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5cd13e9ec34so1143438e0c.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 06:01:53 -0700 (PDT)
X-Received: by 2002:a05:6122:1da7:b0:5c7:a9ee:dcfb with SMTP id
 71dfb90a1353d-5cb090282e5mr5364701e0c.5.1790600512952; Mon, 28 Sep 2026
 06:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org> <20260903205153.283553-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260903205153.283553-5-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Sep 2026 15:01:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUdALBm4qBpobaSN-O99Sqzf373tyMVOix252E7Mqjt6Q@mail.gmail.com>
X-Gm-Features: AclHuK8yjcBPkmYx_9D-prY3k3lNAhlUTr3iLBx-i-uhHIvrir2OFt7Ni-g4t9c
Message-ID: <CAMuHMdUdALBm4qBpobaSN-O99Sqzf373tyMVOix252E7Mqjt6Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: renesas: r8a779g0: Add PCIe
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
> Renesas R-Car V4H documentation R19UH0186EJ0140 Rev.1.40 , Aug. 7, 2026
> attachment R-CarV4H_UM_009_SRCRn_FSRCHKRAn_FSRCHKRBn_r1p40.xlsx rows 410
> and 411 describe PCIEC ch1/ch0 Application/Local register reset. Add the
> matching reset into both RC and EP DT nodes of both PCIe controllers.
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
