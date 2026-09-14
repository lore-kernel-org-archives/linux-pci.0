Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBE44C652
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389539; cv=none; b=lViAEyKqNtYoRxwBAY9asEXIqwjhG5GYoZSbvwkEqCi/mDLtsJWvkK4m6FSymR2nMAwyuUpvTHef0M8ycbBr7umtGfr8wdYY1QwC+uisQ0HfFk1YwgrqSNKCHZHiq3E7rd08ms+nUcoas8aKTg0V6aLdNmpy/0rWDAebPFCvP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389539; c=relaxed/simple;
	bh=alCv2i4afikLPEBE/ZSB/QPy8e/IVs00EB1s3dQO9nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUJ9yNchFNMme+yxay+J+u9UUI1cfIjDJC27kneV/kmgvnIFdTJLKxkmHubJ9HAC1NLoMKaXiaAsZ/4NE/E8rIz4kUIK5rGPlsc501q8Qc4osUsBCYoEDpbSt/QzbW35Ttz2zzFU5PJ4keKRkdtFVMop4truwtU3JU8pcbtMd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-785643199baso584325137.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 05:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789389536; x=1789994336;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OYAVE9OAvj5W369HdyvqFVzrTYEbVyLELurCOBH65i0=;
        b=ipf3gj5WzaQPc7oExwOKvAYjWR3y30CvrKC+ofeJWOvzec2vivI3GpTgeI+aX6Jt9v
         y0xty4+6V9SdunWwDgWW0VoO9Rnu72X8Ugh58fLIlXlMuF9US+DDnDhCLzpHvuq1OlPo
         CToD4XvJXVg8meSz/KDxuS2mIlsvTkpOrZskQlQ/fet/XR7UtXW4hrOb1GhYklyBixtI
         k/fszGujs5ZG/+uPTjEVqPnldBXVoLvnNHOJZuM07XTBPoeRnKF4UQC5HeO6kQIXlZxv
         0T8umurwZaqLESvFd610kxBljOwfrSkend1L3BgE3lL9uZaHuBzRDkCg2i+MtNH7Z/vP
         vw6A==
X-Gm-Message-State: AFuF++nR5d0zhHYUkfg6Gyr8ufyDhQiXxULuClCb+fwCLEQY+skaOMoe
	Vvm2AsNo4CInni2YkilR8D0Z0sDOH/faHRgmL8K61yFvbTzrcrstLyyXxOS0UIGz
X-Gm-Gg: AYBFou3cdzeuy3v1IzimGY4cmbpz04R+J2lOuR8PP5O9uOAlmX9TOj8xHb402IyCZdQ
	WAYJLMhTAPhq4Iv/WhR4PaFUiG6Ype5GrrYoTUPb97pyV2kECS+HSuIbwT0t1xRSmWqEv95WOVN
	BRZ4x0miLg1n/HbK6sHdTJfwAyuDc+0eo2cChvpWTlrUssFd5j/T4jS7pkGMHya0fIxhUVXk7sh
	gBL/3IWtWpl/hzXzHT4bYRVSPT1t6R+kadjA6x9zLCIx7+lLMt/1ul36qo5y7l7xXk1EdOmUOxt
	ksVuUIetXDfXfRKeKre4uS3eCXOlydCAMzr5hcm6KFElZ471YVH0N2K/9gZjaH3jS1kLf+GXmWr
	TF55zLi9axqS/NFaNZ1WSIqITZBoSvwQVOMmQyAGK1iWebKoGCEdBv4ouioNUK80WSnftteBZKJ
	jsihslqhGDu3z+qb9/uEANHXItoEmK0twL5HyPZwHT6q+NPSreCrED6hidJqcIfqoAdO/K+/nRB
	Z9pscCz/QKVdDKy+9belUy6gfvD+iFraQ2TYg==
X-Received: by 2002:a05:6102:b13:b0:785:35cb:e64a with SMTP id ada2fe7eead31-79b56aec238mr1106343137.3.1789389535736;
        Mon, 14 Sep 2026 05:38:55 -0700 (PDT)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com. [74.125.227.12])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7927cbdf149sm10186629137.4.2026.09.14.05.38.55
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 05:38:55 -0700 (PDT)
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78564319a92so430690137.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 05:38:55 -0700 (PDT)
X-Received: by 2002:a05:6102:54a9:b0:789:5f54:2367 with SMTP id
 ada2fe7eead31-79b579b0d38mr1196005137.4.1789389535416; Mon, 14 Sep 2026
 05:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909175922.161658-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260909175922.161658-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2026 14:38:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=gEiN37Su3hhVS+kdTiw2j8WXDtjy=bQy0M8drBa_kQ@mail.gmail.com>
X-Gm-Features: AcwNN1URkRSQsxTlCS1AkYCaZYHp_UGH2AcjGLEgcywIPONdLTrdjIQPHpbJFxk
Message-ID: <CAMuHMdX=gEiN37Su3hhVS+kdTiw2j8WXDtjy=bQy0M8drBa_kQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] arm64: dts: renesas: r8a779f0: Add GICv3 ITS and
 update PCIe nodes
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Koichiro Den <den@valinux.co.jp>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sept 2026 at 19:59, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> This SoC implements GIC600 with GICv3 ITS and PCIe host mode on this
> SoC can use it. Add GIC ITS node into GIC node, update interrupt-map
> and add msi-map into PCIe controller node.
>
> The GIC ITS does have master interface to issue transactions to RAM.
> The interface does support cacheable transactions, however, it does
> not support shareable attribute, because the AXI port signals are tied
> to inactive in this implementation. Therefore, add "dma-noncoherent"
> DT property into the GIC ITS subnode.
>
> The GIC redistributor does not have cacheable/shareable, therefore
> add "dma-noncoherent" DT property into the GIC node.
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
