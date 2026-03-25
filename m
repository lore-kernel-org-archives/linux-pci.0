Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37893CFF42
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439683; cv=pass; b=iyAdLjFGkfO059saxYioAaQVOGha4TTOLSMzWzPxhWWcfoDqBBiUAyc5fzZuCueuFOfeExS89fPwOlfZfl8IWpoMOjmQR0C8yqcXpY/j76sYI9y6FcYui+OdjHeti0TJAo41T5NhgTIvOsLMg4RBG52TKkDLUiGXs1ZSOuhh6JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439683; c=relaxed/simple;
	bh=0MrcNmicBRchhkdmfDJ8rKh5Sk2NMVxCsAhKDXICGBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yo/792iURZDfKMGbo8ulkZropt/8aL1EfVjCVkqiUYBz2D7gf+4Md40NxoR3xw9r7TVuw5HVNC2lqM48rEVsBMDiGdaHYwun1xtxoXNUjTjRsuptq61AobGGz9spQGuCHN2P9enyp3F7eokDcB+f4FsFxsjeSiup9fmlTnDOT7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnHRw1jp; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnHRw1jp"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b4915161fso4754965f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 04:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774439680; cv=none;
        d=google.com; s=arc-20240605;
        b=Hg9oZ4GX7FKiTPX5QegWNslp3xavoEry8SbhacaWgUFN2hjnHoL8liDbYm6pwbIsuc
         0q9zKMG+zWd1szk8RYZByTJVQHTiBokoh2V9B7N1quTnupJVVGdtglj4V7RAYTR+n6sk
         ZHsTQkh59CvndMkPwtfGB1Y6+j4x6U4G2n297YySQA7RBvDhs7sGHjXls+Fl8H4vCYvk
         UEYkMVETXT0HpxsGvJTl8Pvl4gi9cnUtxBz0i8FG46MARz2kNh0oY0dvPBXpgBf3C5u2
         AhPiN4KgdOgCY/yw7tyMfeaTwZ0BdHuiBZvNCGE2v+PFsNY3vPw03thcw24XrQovQA6V
         uPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NTtiC/H6aEdIPYVK6aeTMwBZxiD7QRg2sxYnmAcsygw=;
        fh=W8vG8JV+fCUvgAPwt2o4qhSqOkhXhS/hsezhMiu5Sf8=;
        b=AOCT6X4JNwUk87hGfqIdSLtBM0s8s1AdNJh/vMLFtcXpX34vMQt+srNqEXk7Q4fZZE
         +atyYbqlv3gLMSdnSBMQU+boshMQ12ngxnGtAeNDde1OD1VrXxDn8uxr5iNf86d4/zhU
         IFtiDu8ODuVR1KnCWlIvhq1taGXSHZTJ3LICDV23+HSeF3CQ2VFk5IPXeJJLBpUeQ8o+
         CSutSb0x3DMw2jCcSpXGkuX0e3ScIjs0fqO9Tt03CBVNsFkyIDaY5VqwxgMCedj552PU
         vnPVv2NbQmjVKqiQW1CoNxN59jR8+6AWaSeu4kXTxlokep/oEAqJ2LWkxJNvGhEpUh6m
         ZdAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439680; x=1775044480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTtiC/H6aEdIPYVK6aeTMwBZxiD7QRg2sxYnmAcsygw=;
        b=LnHRw1jpt+J9xTzRv1r1iLrPWnz5wzfWKLV4MV69ZmXAtUXYmMOw3cqkseXOQtE/ky
         QJ/cedw4xkmEZuNkoF6nLlK76x1NH3yzueuzl0Jp1kOidwMPYy+/wL9Y1a2eGIxVfbR/
         D0M+C37vPjnUyt1xTLxzZToS0UWu1PnSv9eqxEI9RDvn9hvM4M1oI68xO4vlDNKfmUMk
         W2+HbU0EAqF2w/TDD/GwjK0qKkdP5rgfO/gHOq1yTXEmP70LybTkrUG3ssF61dvVpaUL
         rIlJJWZ+pjNtpfRNGxr0PUv3iJYep0JAHQEhe6W5FNGYQR+G2T2AO0F/fDL9tM0DUwAB
         r3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439680; x=1775044480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NTtiC/H6aEdIPYVK6aeTMwBZxiD7QRg2sxYnmAcsygw=;
        b=oXH997Vw7LoqHBjJ6TexGiZdI+6JB3IuPEhlcKiu7lEBXKYS9h29TRZsg8vOlAub7S
         2fJGQ3a7zC74ktX5sYmTG4Wodvm7Abilu+9i/vpUOOaM40C1TsYdKBRLPdPIYJp0Jenm
         gOQ+J6r1kV+xRWQ6H0kEdsmcAbAWkWlX6/GDTgx2I1GhEUT2ChDlWBxAStpLYhxwquG+
         8WvuUZBy2FLF1Neag4geQbiBSRivbUo+t0yYwXGvAur9IbsHVoTiJ7lG1yo/XJh8bb2w
         f7W9kd7KynyxHaDiJ9FxYYSv3GnvHtS/Bg2hv8fJCilmtP0myK5zL9zVH438lD+9/Rxf
         7+pA==
X-Forwarded-Encrypted: i=1; AJvYcCWiKjRni5AllyDkiZf/pcPcYDO0H8wUf/Pq4BeQIYlX+g4VvytOW/5+9x7/uuDpdNksBKzQI/qMwBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhYwM5lhVvYs7wYlFsb24jY8v1YJ/j0MEW0oM+uavByydQu2xE
	Z9dKMzDkQjO9J0fz4zUjbBmXW2RZ52o17SH1F5LTUpBcbfzJweVLctRzpU0Bnkp0rnVtFNgu82P
	jXO6v6gkK6hkyQZ7rCIEaZ0DSjywqFwY=
X-Gm-Gg: ATEYQzxgEemXVQARHrTdDfycypIdwss5qiasjJoxAW2UHpl+JAPuQo9Q8Zti8fyyWN8
	W6/BfFsPdS9dgKcsAJadF7R8x9SAcVSANdjMN55JzE2j6OKCzFWAgKK2lPL5coE9px/DSsQb/mF
	XK6gucnphY1v8YqdLhaYx2V2dxRsqOAJ5b0PiqYv5vN0wo0HwWxgJt12BJym+1s2m1bMx0SHTJP
	gRR528xg6jP2JijY3Q/2hTpWmT4USI1UaEnaJ53Fjwu6Per10LbHjBSrriwqVAQ3kiYngf7L1Fn
	NWKRSvf4mTVsvmtFwv6jJYjAAXt3vWKXeHE/RaAURJzPIilZR5RWZrUU5IsyVUvqYjRN
X-Received: by 2002:a05:6000:144f:b0:43b:42af:75e with SMTP id
 ffacd0b85a97d-43b88a1c6e6mr4638167f8f.44.1774439680037; Wed, 25 Mar 2026
 04:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260318124450.163471-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <c2c56940-e14d-44fb-9b9a-9aff70998bd7@tuxon.dev>
In-Reply-To: <c2c56940-e14d-44fb-9b9a-9aff70998bd7@tuxon.dev>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 25 Mar 2026 11:54:14 +0000
X-Gm-Features: AQROBzCVUCaqQkG9OKxvNMfyAeiAVuBU-qZHdIwjDOsY515WjKNxFvBFEZYatKQ
Message-ID: <CA+V-a8tv7JG6TJY2FfQweNd04G6Vm-k8P7tYNbajqca_yZ6vrA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: rzg3s-host: Prepare System Controller handling
 for multiple PCIe channels
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	John Madieu <john.madieu.xa@bp.renesas.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

Thank you for the review.

On Wed, Mar 25, 2026 at 10:19=E2=80=AFAM Claudiu Beznea
<claudiu.beznea@tuxon.dev> wrote:
>
> Hi, Prabhakar,
>
> On 3/18/26 14:44, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Prepare the driver to handle multiple PCIe channels with distinct Syste=
m
> > Controller register sets, as required by RZ/V2H(P). The current design
> > stores a single sysc_info structure per SoC, which is insufficient for
> > multi-channel configurations.
> >
> > Introduce channel identifiers and extend struct rzg3s_pcie_soc_data to
> > hold a sysc_info array indexed per PCIe channel. Add a channel field to
> > struct rzg3s_pcie_host and select the appropriate System Controller
> > information during probe based on the channel.
> >
> > Keep existing single-channel SoCs functionally unchanged while
> > preparing the driver for RZ/V2H(P) multi-channel support.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >   drivers/pci/controller/pcie-rzg3s-host.c | 48 ++++++++++++++++-------=
-
> >   1 file changed, 33 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/con=
troller/pcie-rzg3s-host.c
> > index c61e011f8302..a629e861bbd0 100644
> > --- a/drivers/pci/controller/pcie-rzg3s-host.c
> > +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > @@ -241,6 +241,18 @@ struct rzg3s_pcie_msi {
> >       int irq;
> >   };
> >
> > +/**
> > + * enum rzg3s_pcie_channel_id - RZ/G3S PCIe channel IDs
> > + * @RZG3S_PCIE_CHANNEL_ID_0: PCIe channel 0
> > + * @RZG3S_PCIE_CHANNEL_ID_1: PCIe channel 1
> > + * @RZG3S_PCIE_CHANNEL_ID_MAX: Max PCIe channels
> > + */
> > +enum rzg3s_pcie_channel_id {
> > +     RZG3S_PCIE_CHANNEL_ID_0,
> > +     RZG3S_PCIE_CHANNEL_ID_1,
>
> Just saying... based on Bjorn feedback on patch 3/5 the names used here w=
ould
> have to be adjusted accordingly. Maybe controller_id? Same for the other =
patches.
>
Agreed, I will rename it.

Cheers,
Prabhakar
