Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCB4BB5A5
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446241; cv=none; b=d2oH/cE/qSewakkppo6Kgl75H9DT4iAltS67v+0xYEmUXMYduYYsKp9rXX4oKmiep8gFE/bIdgyH/jWTE9qY1MecaZh2uAuCJBc44LBw7EmoljpT9vHmXj2M1MStAG2y1XpTWJUYC/YzJEn/jyqL/sT4cwtT6/pNB1Fiq+zGjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446241; c=relaxed/simple;
	bh=EgTf7s6p/OpuqItVOOUp/ztuxNWO+Z2wO2pMRh0VkAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPAjiGXktFD5Df7DdTsgT/IWs55zpRzGer0JHhuxsTYeFCmWW2q4sjvAffieoWfae8VqQbwPSK1ymd3KF37RQWtvYpqyDfzUoVfSkJ8aDrQriMBS9hm0WEhe552tfvqy2DjwNIyS5dpIdSSpjcwxe56NcAH/XWXALL2hlx81xqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c25ed8a8a43so207859166b.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788446235; x=1789051035;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WCO6Njy+SVScNEjKtjF/KEIv67GhBtMhWY5Oh8v9s5s=;
        b=JXwyETsKFn1h+PJLQ+G5VcA86BFEZ1GL97B9XvLcdfwdyBm9kQRSipZTwHqnGgMGTU
         zBXOW6K1HQMgMVlQpg2Aybk1hSAQ7glSdYHiwHnYMeRR/BTTcwhX2RnUV6AvNdPq17VK
         ++RijgPWuEKt03ahQbhWslLe7+HJrLE+fEBXz2NlbVt1BzswKssAfaRy3RpnoROMqtW5
         IlRYYumVTBVc+FEZsqRDpcvwPRmcXsUvHG2Jwkg5TyOp7AAlZQLCedFD4eNdMh9cl+GN
         J0aWbjtU1FostDWx9UPBlyBhgxVqRIOU+YB7H+wLa1/8LNxg3X5YjziZm/hIbhlk/U/4
         HRVQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlaRI35FmgcLm5bpLH+KlBgaB/SNSyeERr68mR7slYuOQsnnveWDhHQYuJpcnB5iRXEjLXifSnJes=@vger.kernel.org
X-Gm-Message-State: AFuF++nSCoVlisZJ4zQEHci9K5qFPbOvw7lGsj+DJ10HDLXZqZEejlUh
	uM+FUwmQWT5h2Rg4ZJVKRivHAMSj+cZI9oZzQGb5e0XsuvPxUpNSP9FiI54ljnqjHyQ=
X-Gm-Gg: AYBFou1UTgUwTlbvfrlFFAnqh6xtmCC1k85FAJruSNrRysFfYmJXF0zvs2ioqAMTb3v
	RQ4GO5gu/qZ5iTC3NqSAihZpQjo26xa5rw56B5I3zj20kqNQJQ9c2TX2RHA8htVJs1MNo/JBSTv
	u3X7c9xtdaCyDmNK1txRc9XN1TgnHoJUjck75Ke0JRJfIvTzwiZkUEmLUIFnMAVagpxh79hiKXn
	xcezEUVU5PsuTctIx8gJi4V6Sqh4kXB7FwTDwR3cK93984TTjbPC38huCFPMgK3HbKp+4aIppXm
	ThmXWJRTH6wG9gj2RT0rXYzx6QliBpOs9b/4GonBOMNFOCgWFmoL0Jnv/pzdIklWJVM9IEfjcSI
	K7l7fDF9oFjEbMqgvcWSpQKMGLNzBCP1ZQ6p1QHN9LllfEEOGse18NWrfK+1zKd522LFi3bvFBw
	x5/XCBNHqP5udoIt+a04e+PvLK2ZgOQQWdqn/XELQehTK2bu2LitFiCeVaYqvKlWvWVbRHv4/st
	PIoCVOQODTxGTU10p7Sh3Tgh0Rj6MJh7mMZ
X-Received: by 2002:a17:907:d38c:b0:c25:1a5:62a4 with SMTP id a640c23a62f3a-c26047d0202mr75681466b.17.1788446234656;
        Thu, 03 Sep 2026 07:37:14 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f4238ac8sm109752266b.56.2026.09.03.07.37.12
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:37:13 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so3646890a12.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:37:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw9mM3TThK+DdGuXL3hfbPUG1lueY/K78lS7tZA9uBqB4MfhlE2q/Qq5LYuenTx73BOsaImwG2Don0=@vger.kernel.org
X-Received: by 2002:a05:6402:21d9:b0:6a6:54e7:2071 with SMTP id
 4fb4d7f45d1cf-6a7e5604c38mr260584a12.14.1788446231721; Thu, 03 Sep 2026
 07:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903133320.144245-1-biju.das.jz@bp.renesas.com> <20260903133320.144245-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260903133320.144245-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Sep 2026 16:36:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURMFo8WxiU5hWoPzJB=bqrAKaEqnss181hZo5MZPNFpQ@mail.gmail.com>
X-Gm-Features: AcwNN1VFbOkMZQ7k7yG1mxbk8AnGCfE-NTGC3-0u8uK9b0jPXfAHrXpyOz__lhA
Message-ID: <CAMuHMdURMFo8WxiU5hWoPzJB=bqrAKaEqnss181hZo5MZPNFpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Document RZ/G3L SoC
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sept 2026 at 15:33, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Extend the existing device tree bindings for Renesas RZ/G3S PCIe
> controller to include support for the RZ/G3L (renesas,r9a08g046-pcie)
> PCIe controller. The RZ/G3L PCIe controller is similar to RZ/G3S but has
> some key differences:
>      - Has 3 clocks compared to 2 on other SoCs.
>      - Has a different set of reset signals
>
> Add device tree bindings for renesas,r9a08g046-pcie compatible IPs.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped "or clock for L1 substate handling" from the description of pmu
>    clock
>  * Replaced enum->const for pmu clock

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
