Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592926B2CE
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844417; cv=none; b=txOICq0YpKOACvXr6Hd1/MqTYbi+Q+OaNKScQqhRI3TsKDN1rvErycsW1PBlXgmTF8JRJ5ayq5Wnim1rWFj5JjXLt7a1Ghg1CHXbnRRWq4k7YH0kIUOdK9oe+2f6TDn4/K8eny0TCnxkPljwIYL7am9TveexI5Zex2m2qi00kro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844417; c=relaxed/simple;
	bh=Lm81v3X2hopJu4HkS2XTSZZIGVqR68LKUdtuY/WsRic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1VmI4jC6pelcyjPYDe+gxpVkZ4qT6gDmwx1JrWA24POap2CDKmnttJxxbwmnL4y+DqlwD7yHR8+28MLK0r8QVVEN35qAhzQAGZjjymQwXx4Jmy7jwER2KgWRTYp7hqKIoWA+SRthDnqYwiPjFo56Eo/44PUUmuRa9fyjXqg+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56b6c7c8d00so3168462e0c.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 07:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773844415; x=1774449215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0dzTiRw9+wmXHZEQW0d3m+CW5azAN7PobPRJxwWyKM=;
        b=mo5y8bJzDtgZNV+mld87JpQ0cyYBXxkKFuH1/kFLDH9SYVW1zTmkyNgNhA8FdS+o96
         n3d5Ux0jDS8AsXSlt7/hNu/P9YcKoFMz/lfjsQBSRCdVwrcfwsCZNLnn0Gw4yMZou7/u
         uMRAExty0yHGvqyiV7k4Dd71g1/NvUJqC+xnDtXYpQzOcvROHQoR4nQmdFqWKb2Kh5Yh
         d6pi+ldEQR0xDib1eduH+93epJU1HJXpgwGrYrOySgUfoXnjNgixSbRHDUIsHbkZj//s
         ijCCjh7eHTfUyHFoMBjKQ53FdE161fFVRQqVOu615jDPqD0xleZ489RbFLVfSBCDExv2
         hnUg==
X-Forwarded-Encrypted: i=1; AJvYcCWy2afuB9TO7Z/SE8VSzCnchNCG7xnuTzv+xUTyC1zO5SgUBgZCbDmYQbPucZKvWPm1LsWbh1vv2o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtXz9FhTGQMIouYOAClWQS7zpJUAR6j17xEJZYig3m3LIqOag0
	Akxghm07m/lPuBC8CpuhsrvLmo8tTX3kUU2ejtmAXimWf31mPSXE8XDff+gcTJ2nzy8=
X-Gm-Gg: ATEYQzxFvRKrXNT6p/XzEzKY/mn08d4MKip5uLphGpLU/E9T/0oQ/TeWJQ0BNLopaNR
	vLXpjaW0tY+CUN0fLLIBRvmYxW/Smlo3exlRtI5HKhKuwjRZL6nDKFcora9LGp3QtBMA2trtRFR
	xaNCCtI2t0kMeH8+ymQAr86QgCiODFlYUdCdXPo+9xOmQuKam/6Ax0V6vKI7w4oX0Y4fYkTZHEE
	EhuzmI2pfPNOY5yvPhsP0yq/CTHG0KE0IHBk+ndk2OElJAOUluNxeO5baVcKBaOPhM++PSS+xWB
	gaNxYk+PEOAQ1uz0768y02DoUrxBbs20BM3FN6J0IJFmeFLM5tMSAXXXC5MZ9BedUosgkokvqsI
	U0amYvorYDVdR3BwmkBDYdY0efhzGjwc/5sKQQBoTi6cvcIsfkUhOAuatqPifp0LA3sdqNVpUUI
	61cyeIHknEuU9GqBzyc8Ye8Krd2p7dbtFcHEtjm1Qbn1Gzox5xG1/xlc/8k/fu
X-Received: by 2002:a05:6102:370c:b0:5db:d6dd:81c6 with SMTP id ada2fe7eead31-6027d2c032bmr1921071137.18.1773844414527;
        Wed, 18 Mar 2026 07:33:34 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-951032a2eaasm1360374241.6.2026.03.18.07.33.34
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 07:33:34 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94acb3d6cceso3833125241.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 07:33:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcudAy/NB4i6dNPzQd2gaqQ/88RyLAAviLxZVpYqXSFVO+ZTXznQQeHPPBVs1R7T1g5DeZDcLZmCE=@vger.kernel.org
X-Received: by 2002:a05:6102:370c:b0:5db:ca9e:b57d with SMTP id
 ada2fe7eead31-6027d2c07acmr1775626137.19.1773844414146; Wed, 18 Mar 2026
 07:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318085119.44717-1-john.madieu.xa@bp.renesas.com> <20260318085119.44717-2-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260318085119.44717-2-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Mar 2026 15:33:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXzYa-+oP+Kg4cFmoZ64s-7GcFW_NQ1SgC2y1OZB-S=7w@mail.gmail.com>
X-Gm-Features: AaiRm53aZ3vOKz3xOV0p41g2dKm3hv4oZar4whKMHd360-1-SNNOc-RjUNHJAH4
Message-ID: <CAMuHMdXzYa-+oP+Kg4cFmoZ64s-7GcFW_NQ1SgC2y1OZB-S=7w@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] clk: renesas: r9a09g047: Add PCIe clocks and reset
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, john.madieu@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 18 Mar 2026 at 09:51, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add necessary clocks and reset entries for the PCIe controller
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Looks like you forgot to apply a few tags from Claudiu and Prabhakar?
Fortunately b4 kept track; will queue in renesas-clk for v7.1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
