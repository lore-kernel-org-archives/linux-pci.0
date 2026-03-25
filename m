Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A503ECBEC
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454752; cv=none; b=o3PpoMLJvKlsyiPfIxb5/dwSyS5tEqTdcynFrCZ4Dcoet/CDgrLGC2qyJET05DwlM9uOXJ+mqS2Ve9tdTk2VhnpdnDyBK68WBvF2H1vnv/GJqPDsvM+KvhW2HG6BULTvXrpaK1SwQwstY/Jup5N6dhRhBlK5wDB7bih7u1mtIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454752; c=relaxed/simple;
	bh=4RYRYnx/N+uB3nG/PmCpdDFzhigjOZcdXVf1qTaHjTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9TK1A5I+q6/K4V/gAQ+jnfkOC6ZrDZwTO54eeJh3YuHJVdpMtKZ/i/uJWMVdMEyFGf/XL/xAZQbovY87AcsSEhax5hQPhvM8hhNq08iSHkyPBL74KL+ghuNvfwJ+Cf3l+RE/fEGvAZJhPqCyji8sUFllAu9LE4RCBTJ7xGuSNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso3221632a34.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774454750; x=1775059550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTYn6c2oWhs1HU9mLDTjqKGDTTeJkf0Hf24+Mstq7Ik=;
        b=HLF2ZhDXn0d4HXEyWB9WppVlW0WRVs0qCOoBpOXSiIHqfLMAQPPDadaeopp4gSUC2t
         OAqJneSycSjeLA31i+op1glQlQpL0DE3FPGVjpb53Ka0wq+k+t4hdc9RYVdID9XmxNQA
         VdsPZh5UtPYP1t1Wvtlqg6Xw3RCPGeaWtwcJx33QJxdzukDEQ9ozHOJJP0r1zs1eWgov
         LqLixXDfkosrlGvP87e7Tju6Lhz0dvnbvmhb+QQm6csjAEqychGnaPyCDl9ABR9GEDhg
         TZolXy8hmte8tPiZHKUOzeXIqT2aBD0soVK8p0mVOuiX8opv3L/peoQmGXlhL3r0n6TR
         fPpw==
X-Forwarded-Encrypted: i=1; AJvYcCWKlLS+8L0zaQ0EKUoSlKhTuEt7zwa2A1wbswsAGi363PiTN24deKOeT2UOL0xuZJKZ3BusmpJR10A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmt+VK4Xc4xJgGtD4X16Z+DXhQNJWbB3bNrMyyLU7ZL8FOlyie
	79J/m6CmhZ9jNl33kqJS0yr/6BWCT6hxKFdeS5q63Djk+CO01jasaJ/JqaUh4JXWeE4=
X-Gm-Gg: ATEYQzz8mI79htiV1crFKMNb7SGrVvOGzhJo+XekZcfDV1PJG7Q8J3yG2rCFhp9lxw6
	XKm3q9JCVCot3Vm1tHZg5L1uNWXzfD05/Am8qRkX0TWm3vaA5mOBwf3c9rFi6tLw3v8KM6CEyzh
	y1wijgEJht0ZmSQSqRJ+MDRpoSWZCGMBBNRxNvuouFeJVJhRtn16k6hPvgmCmlElvGoBtf3gaqd
	WDOKqH34dEfVT+IkxQGuJkU27nYNIdb2bZb6szYvD3+zfpPQdC1Auy9miZCF8zPHcruc1+DYoMu
	Gw144tNYGJtzkTvCFLV7EbS6R2M4/WGN/hKPNJxRsAUVvpk3zNSeoHzSeFZ9dxwm1mv69zFYIee
	UdiaFSWbuijh+6dydEos4gbZa1jxnoxeN5xkzg4l+ccbVmzIXZ9AgvbNs6OO/MFSk4xED9z4QaQ
	lLe5563uNPnXm62OTM7KmZx6oKXMf7QvHTw/m46u37EpMySnmfLWPCEj8wUZED
X-Received: by 2002:a05:6830:6689:b0:7d7:ef0a:1ce9 with SMTP id 46e09a7af769-7d9d661ee8amr2312078a34.14.1774454750350;
        Wed, 25 Mar 2026 09:05:50 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5ab2sm34252a34.18.2026.03.25.09.05.38
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:05:41 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso3221352a34.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 09:05:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVzumfNuqCp3yVJtstFQBv5rV6U4GEiRhSMGazYBqBtbrK65gmKZfJ6WLuwfHSkxBYjWpLUaMQuuI=@vger.kernel.org
X-Received: by 2002:a05:6102:83cb:b0:5ff:be25:8936 with SMTP id
 ada2fe7eead31-6037901966dmr1857866137.5.1774454381452; Wed, 25 Mar 2026
 08:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318085119.44717-1-john.madieu.xa@bp.renesas.com> <20260318085119.44717-3-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260318085119.44717-3-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 16:59:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXwtniV=_gywHfDCBQ_+660aV4+K2SXbfM3c9guNrbng@mail.gmail.com>
X-Gm-Features: AQROBzASFVBtfoGlkigJX5s9euj0nyf-Dtn2deDVkxMdGhdHzx7S7UnqewbVbV0
Message-ID: <CAMuHMdXXwtniV=_gywHfDCBQ_+660aV4+K2SXbfM3c9guNrbng@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] arm64: dts: renesas: r9a09g047: Add PCIe node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 09:51, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> The RZ/G3E SoC family features an x2 PCIe IP. Add the PCIe node.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
