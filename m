Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698647;
	b=40G3sssIWj0OAZ403qPrBBHTT/q55FQs0U30IO0/H2cJQdmw6QAVbZtEtmpylrzo3suy
	 7mc248c7j5edIhFNvKAOu2bBb5W99atiDUT2Nn9wTd+qT88EEnimVbTry2hxVsGSfYbWM
	 mYYBo8Dk9k+ytAor9xPVXhxUW+7FvcLZC1mV/fr6Z1W5/GN774ZguNcEhjOAApl70gHFP
	 aazQ32mqz4h3VMP3Q7lOC1X3nom7af0MqvsnbuV07P//GTd6OG7SB8PYKMF+ItjbNFbnV
	 Hl/A3C7Vm5YH9mEovT+YIhH4GA09fr6PdBSeqEDJRuQ7daXc7zfERhjPBW3p+qmAQqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698647;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=8lzx438I9zhWgrnJA+oH7tC0er2jtBCrxj4IPB3U0cU=;
	b=P2K74i7kJWaw21DF0BZWAx7nnPdy/IZEXll0nyO3AtD7JDHTuvoLrEEcADKOeLuG5AUC
	 GM6UUso7xtwGDAWkQiTezBdadd7rLabgfIGx2KiswjbPHYkLO1y6sup8m3QVi9yKN4P/u
	 STAYHwpD1U3PvhN91OIcdC3XfT+YttaHYTbzFqqLMlOEUGmPhx3o7iSZGltUVOZPb2g3b
	 IDoHk1KfD51oUbHGbqe4c+BIpW9DkevtZhm9lpQv31UtNSC0YPsoc2GSnaVi+fUg2wput
	 0TOo/+PwcVAYjcH+ou3SiGNEWtrMt1lGF3d4EAt6+AMQS3GBXMGK0N6oZYqwBU7eeTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FFC606A31E
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 13:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09FFC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-537548b811aso56663211cf.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795698646; x=1796303446;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8lzx438I9zhWgrnJA+oH7tC0er2jtBCrxj4IPB3U0cU=;
        b=MiCxANOHV9zAZ1W9KjGsLqszq3lV8GzN8m4ejTJhbbCqYm1klX7oHPE2Y47Yv6VfMC
         K8nHPSvwdD0XdFdfxyKb8gXTHwv2rWvXzscPBela6D5FE8H1vsFvaO6Ue+rWacCJLfEU
         6sxfpSJ9pKPpke74BqSLxkR07/CCF2k6JS/2RbC2duyO2yzVnvGYd9j5N1BoYQNiKfFH
         vBxfXuJ470WP4uy1nluAKIy33O9TXThg6Z015DIJ/K3aAV2g1P3yemNun/4pCVxkWG9t
         NKcfiY+PurHtTfJ6jU3RkKC0D6IQFKa6YpqOaz+2LSlwrfO91c4WSgA2Q10Zt4VCG+lE
         +TGw==
X-Forwarded-Encrypted: i=1; AL+hErHSnEABAi28RTas/qtqK5FiyVSd0DJ/FQ/mLSiXYR4uTXHRPkuk0QcG0k81kgCZAjK2+dEM8b0+jPk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MM2Bnt7bhnXzmcTqC0xgRm1gt2x3NOoHR9CmWZ01OnKjDVGSD
	ptv+q/YYEdHkOT1Z0TqyOQxBc+AJBbWABYQdnE0ZtTWMIU9KAl0feLDju5iyd58a
X-Gm-Gg: AZFdTZd1tnqrFYVzqdoekLNp+FtJxv1XiXKLJ69JD01FLtwXMlbQDQG1+Omvb+Wk/1F
	QXj+LAL7zZevgUyEFkVC5kc1IS3Ici3x44HTc66mFUPq7DyfGWSD8kJ1HVZmRm9v+WxdYb6XhX8
	NsT8hAF8cidB2ZgAIUqSMgsii0u2szUxLOmvnKI41TTae667T9m8kygaq91WGQhyOx55S1T53wL
	9qAWQGidOuJuprRD3t4cn7U58kOwirzy78xHG4+Wt73e0DjheVBMelbVZFvmC4qi6Paq83koH9P
	zd4gp7MPWBqY3VxBCzbSdcuSTCXyN8GHve00vTI/kv9gzS3CLFGfggBGvOq63f32mXNLkjf0/eh
	FAyWTffE1/FxkE3Z8RSqQ/mdyQqT1U1u7sLYlcKc4WW+XvoYV1JS5lmZ1zqNFYQgJ68LZ83s6FU
	UzM0QeErjjg3NHYx+/dqDOU/5byS8rlDB7XkHEYc6v9c7QehUOj5/lEG2UOa2wleVLq2HuGr2nu
	yUer7EUW9sP6/Xb+6QpsMSMZp4kPH8jualKWuedbrnrElciO8y/1ftSUxa9kRsb/tZdE0dZkB14
	PIjw2dIRp27rXCYDXv1OCPLGU43oGH/ZbVdbsTiswOYWtT4BR4t8/L62ZtUyLhItktY=
X-Received: by 2002:a05:622a:2447:b0:535:ed1:cdbb with SMTP id d75a77b69052e-55d7688e8cbmr370478461cf.1.1795698645707;
        Thu, 26 Nov 2026 05:10:45 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dbeae112bsm30588141cf.8.2026.11.26.05.10.44
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 05:10:44 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98c7798ce74so1950836241.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:10:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG/i/T3hrceF1cvbkNxIoOrAN8sM2m82GnNL03wtfta9BKmrJIS2egZMyhu7sQU2YljgxsD2/CdER0=@vger.kernel.org
X-Received: by 2002:a05:6122:1352:b0:5ea:d1c4:7cbe with SMTP id
 71dfb90a1353d-5ee8af79c4emr10201505e0c.23.1795698643771; Thu, 26 Nov 2026
 05:10:43 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020031049.969895-1-den@valinux.co.jp> <20261020031049.969895-18-den@valinux.co.jp>
In-Reply-To: <20261020031049.969895-18-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Nov 2026 14:10:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWk9pZdJ+eh0dNHrZSMVDe84_rsvmrD=pC1Fjy9wEyp1Q@mail.gmail.com>
X-Gm-Features: Aa3M54pKW-6JgYTYZWdXwvcVTMAw8E4E5W6RppZyD7aVJ1bsffJTTTgDbIyWkEQ
Message-ID: <CAMuHMdWk9pZdJ+eh0dNHrZSMVDe84_rsvmrD=pC1Fjy9wEyp1Q@mail.gmail.com>
Subject: Re: [PATCH v5 17/17] arm64: dts: renesas: r8a779h0: Describe the PCIe
 AER interrupt
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
> The PCIe controller reports Root Port AER notifications through SPI 454,
> separately from the integrated MSI receiver interrupt. Describe this
> interrupt with the "aer" name so the controller driver can use it for
> Root Port error reporting.
>
> Append the new interrupt to preserve the existing interrupt indices.
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
