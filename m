Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28C4ACC76
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440016; cv=none; b=dJ4UQ+fUH33NSGYnkWuXSuIv2LUdNS5R9k/OkRK3TrFynbBCfqIUdNrit/KYjaGvKnGAfy9Auqq9rMDuyus+WEmlxbgAz6aOMz2x19PF4zkSadFu9jakk+WoIRsks4zagGZiU93B5M2qQCIbDSekOaKLmJsq3HhlRRHhgHwCERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440016; c=relaxed/simple;
	bh=dHxgVoXugnnTmSqU/QbhM/ywN/YiWktpg4R2HHANpxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic5wBPCJdx48m6aA3+4JUbE5RgX5Qr8DPDOYDGWh07YmecTs/p0pvUz6V8UMLrW+RSZyDki4v8rFwYigy4s317DBfKHnuwkuiwFUB6Lf1+uTdYYjVMk1CLJC2Fpz5VNFlQ7s+d3dkGavWmKm3JinVwTAc79DYP5rsZ88GxYWQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso1889132e0c.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788440014; x=1789044814;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rOaM/A6xTTi3n14xGii1RnS5RLxKPImxgE8KsoH56tk=;
        b=shxiogBGTYGYaH/kD7tGztA/kSzcPjd0GOVo8pFFYrNsk8csWJRw3diGO01yqy/EeF
         kWD7IHXxegyotneTWXPacyyAbEo3u8NW+lQ5ZfDfnlLfNNJ+YGwvfJjDfPVllVRQ4ZN9
         IkidKFPwiFE/NfLgcMtkvP4KV/X97Eexlz5FZvQY1ZA4OWU7XHf0VwgB9Y31HCn/F44s
         wTDNBzwZFZjIctYpJ+qsQpviUlYyiu7sztZ7/dZIskP1SSZ950q7RQVg36zRYO4D051O
         bZGjvyNC6hNBijL5SiBSieRmdplcjMc1JRjKInlW3xcAYKGJVV3okr+tjl36sJ69XyIp
         FOMA==
X-Forwarded-Encrypted: i=1; AKwUvBzPQ6n6Nv/Ys+iwfkC7qkxXEWxg03/+3YkGCUrA7cfOFyw8K/iJqjVQBke6QzWZCtI5PVqqRFqbgk8=@vger.kernel.org
X-Gm-Message-State: AFuF++le2StQR+rUO73GpAXITKc1nT7zNAbV+bAAtE7K+vaat66AnFmC
	efZQ/98frvsEGczSWP8Q95WW/EJqtrSoL87vvbjCQzO0s37ohUDT5f5d4gKmJDxvb2k=
X-Gm-Gg: AYBFou0vZkxsx6C0MV3ln458KRCKyIcZdoAqA49J3ryTzT63Wegf8yyPCvAMpOaSnhA
	JYoh4dsB4UULYHOntGkh3xeR1Z0R9lk63LfCkE7t/S/1CMrWMqnEz1z00cnhTKZAAFg89uTZcbz
	w/9V4E/A8WSnEA0oV0nKRH8eHe9cy3VX4A8yR/vFHgaILEWzIYwacboZAqwdCuwtELq1AC8VMPo
	dnuviYWX0pqfBLQi+5VoejzqYI5z/mrbKf3R4d0Kra4RbBTR1jEnp10laPwmJoe1pCgP4efR5O4
	gRH7Iv7jG03k8YSg+MjRJ8aoH1AmklyHhTVmc03RYX67QODJ1QOe4MlRI/aAm8wkf53WBP8Oh/F
	lM3oRmx03P9Zai9QRKqUO/TaYQ0SIXD8dbFVWUPOWc+P5KaDIkXT0aNOuhZZ7jdBNbi43E3+xEc
	8YSE+40jdofh2UD71XReJalnq4y2tgavXr0caNFIzFoB9SXaMG1VA+A3vtamyLy7CWjt/tVOPNQ
	XnOHrrAARyqLeZo+2Wk+m7eIUcLyK7HhsWj
X-Received: by 2002:a05:6122:3123:b0:5c5:ad20:1fc3 with SMTP id 71dfb90a1353d-5c7d28170a8mr5405769e0c.5.1788440013549;
        Thu, 03 Sep 2026 05:53:33 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7cd73a0c1sm4229695e0c.4.2026.09.03.05.53.32
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 05:53:32 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97c940ef65cso1220380241.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:53:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwOlFyUuu1Vl18RraCRLt5Ki12352qu59sylW+VLh6KY946JiGAKVqeSPY8CRHF17CxgFgQoi2MC7A=@vger.kernel.org
X-Received: by 2002:a05:6102:2c03:b0:785:8f76:654d with SMTP id
 ada2fe7eead31-78a1f4c036amr4772497137.13.1788440012478; Thu, 03 Sep 2026
 05:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825095047.9971-1-biju.das.jz@bp.renesas.com> <20260825095047.9971-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260825095047.9971-4-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 14:53:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXpMW4GJzgf6MSw+rwNjw6d9sHnR9J9NxoKh-2cXJwNLA@mail.gmail.com>
X-Gm-Features: AcwNN1WEDUqTnWdhnLOvtpe3Al5LdzBVrMsYUowriY_1M3N1Njo7kHKct1Dq1Gw
Message-ID: <CAMuHMdXpMW4GJzgf6MSw+rwNjw6d9sHnR9J9NxoKh-2cXJwNLA@mail.gmail.com>
Subject: Re: [PATCH 3/4] PCI: rzg3s-host: Add support for RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 11:50, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add SoC-specific data for the RZ/G3L (R9A08G046) PCIe controller and
> register its "renesas,r9a08g046-pcie" compatible string. RZ/G3L reuses
> the RZ/G3E config init/deinit callbacks and power resets, with its own
> L1-allow syscon offset and mask.
>
> Also increase the timeout in rzg3s_pcie_set_max_link_speed() to fix
> the "Failed to set max link speed" message seen on RZ/G3L.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
