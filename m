Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795559570;
	b=pD5h6UZNZMrPCaZmAB7HcXuFyzIwpz4N/a1x0Zk98IfvmirrcNMp+bP6FA61f1Kjc/24
	 z6QUGPXgaQke71udSqe9S59SxJGO+Jt/j5256CXtjlSulcDbDF6ASTKqd7F6WBoI/f0Rw
	 ME7fTPo8kRR1iSdSojD86UZki8JlTOnb3q/tlJ803o+vtOYkrsvlVZ3NG48dBNF0q3bSp
	 aF34YTJxdcmn6QQfmzfxUUxn9NImsjR733ouC8qZJ4e2sL/Cj/hTUCEmxmtPTtTLy7tF7
	 XM4pmKFZhIcPeA95sgcXPP/+Rh9WQa232uO2uYQpkiQbo21ujecB/vZJEWVqiCUezPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
	b=tFDGPFP2mJ2cJIK1GigoOztoHKgh0/KpIgqHX7wgnf5djWzcAd9NEx3vhTI/u8jjpuLZ
	 FScUjy4dXvrFo5TE3eswsF+3dwRBEmrl1F93E/H6QWnZb9GFG6Ql1WijB+lBqdjMe1VdJ
	 0tEq9GTi0m9Q5jwOR0VJJpmHAe40x3D33iRhD7/3A0n30SiTsaUB9LclULYjo/jt42jHL
	 sW53y4sxRT2z5ZKwKZugKhQV3qsXzsfzzEjFudV80FD2wB2I/ytQrOHy5VDelC1AIgBLM
	 sv4ZuX2kgzKjuClJmXAbB566wfghCMs0iqt+G1QDqqyt5NItkRTkjWOXDwD93cAOhQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W74C66Fa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2F606A323
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 22:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A2F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W74C66Fa
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55be673e029so978321cf.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 14:32:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795559569; cv=none;
        d=google.com; s=arc-20260327;
        b=phdxysxc2ca5KRJ5J8rC5Vrzf2lGJ46EH2WyO1uojkum2WtaRkc71ighXn86m97vUO
         wEkq3ppzFAHunWDdEkmrvEKB8CHAp9UIvlX0JwxxgWO39cdPNWbaUitYFAVfQaCrGIAG
         H01vP4rjdrudID2o66xQjuJPdsLED/th2F3PSNucQ56CYjogt8pZdc/ir+KfX/ACLCHm
         PlEFlhawTUEf2ABE1mEpyU5cM5ok1xqti01BIMTbRJcVgy1HcaAOiFrA1JLgt4wqsaKy
         3Pmv2gEnpAeUCC8nbX85due5gi11LC/gBk+/0NuRCuaEEIsyoXVRriwBdVrlx7vO6DkJ
         jkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
        fh=ylyVexEsNc5ga80+ofpBnDlhv9NnrOJ8t1/JnFS0KfA=;
        b=PFJ9x1K2wfSrExUkY4S4YxHezp7gR19LXqvWaC2Dv6KvaEMTHDRJ+U8JUZfciiYjxZ
         txIKgSzWiKNfqdKW3BYsG20c05kObKCv68UOOWJaYFDxIeXDHlOq4ZkZDy/Mxfq9KugT
         N+c9W6+JyF6io7pimlH+efe7RSpKOotDX+wHN3iDkBPFMK9KY7OnU2L0mOTpt41RvYCo
         gIKNv7VA2ux0wuWahWVvxUtuNhMj1cd67HFDYCcyJnaO4w0w/rVo9GB8oqJetL+fJUne
         ECUaw/M33s1aiFzhDeQqRJHGlrx1UUksM5BSAVnZvyjfHAXbKfOXGB17r1JYtqbZZEEa
         Nehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795559569; x=1796164369; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
        b=W74C66FawSRrw2Bcns9NHAdWHYdXdeQOb1vpanibp8GQEg/b7PuABno3yHvIneX9ZE
         +nAapSLMlEZnDsrNJ11JH+RPjkoHlH0N3GZr7Jdga5LjOFFAbygZXpuFqAa0UbGZ36Wf
         AEWrULFouzHDfmyZdaZcJVIqZGq1DWMckJgwQNe+vURL3WzhpgUPtQqDeAIGqB4h6+0s
         g/vbusd3iW6o0765uV2FC22n5stJAKZ0gFeYJPg4pG6cwsNvZgQ820BgcQszGVjg30lC
         g3xKPaobLiiUggWyCVqFqzBpOtpFeAcD5xn9WDbEps0ZX5a8D4yoH77RwosYIgHmHKyW
         nVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795559569; x=1796164369;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YztxYMampkDgsp5B8qRmLm7qNVSv46tGRVgcB1aXKs8=;
        b=t8CyhBnGv2oEFjM4Yzq82AvXZjsAVrASx9ved3R5smPcQwN6op46aiKzSUhoQsdIVy
         8w47ydjA6eKnDCEYwPgfwPHDR650UJOi8k3WzwgOI0RmiYdx3Q2ZH6kyRu3czkdZor0A
         x3N082wBWDkgvc+Y2E9meVhbjP5hc2ZDUZqXLbj1aUhE/v9i0yQWDApFiYXQU7zFsMtz
         xn2fIpyMyOr9ZE6ouIstFcxpNyXNE1RgLEhRGjDYYtpHzl7YhrwdWW0/NwattNnj/56Z
         jbhpVIreEFbSW5G0PwmwK0kGlVGr2mJAzZy3cB4R81hnj05v7s8TNqyoxKuY7lprwQib
         TCqA==
X-Forwarded-Encrypted: i=1; AL+hErGRWQDTp68Pb4oZqWZRoWAnXF1u7RoyN2ZmHy4XSnLYqhcEAtacOC0p92kTqPl32mD3SEYvAXh84yQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MCKHyqn9IQzg/e64saH9TCkHzkMSdu9cvFYy6oP/2iYXpwHpI
	Ek+E+NbhgcSaHc98ZPeWZbbJ/1fn+CK90SLwGahCYSbbEtuzwJlL/t5cZe3AcizrvMlxXHhB1yd
	XmTaHlk+l6dgx2/Nxae1gg5zv8lsRscMJ/TJG5yim/3PsGG6U9dNkCW67X7M=
X-Gm-Gg: AZFdTZdKkvRQgmZnqcCvCiR3ywkLEn42Rdcwrt91K3b5Y+ShHhzB0Qwh15elOnVhw4p
	TE7AaYUZAFcYA4hMPk7oPatyQtK2iR1bf6anWztb5EkUIrfMhbxAHsUAjavfXrxnaI871pLozl6
	CnmG8EaAl7X+uXJ2ccpE0nWkECLOSyBzsnvdfB8APrl4YmB+pLUBi7BPaZeC4YTqXYHKp4EizEi
	h5cd1A1k41zdyANVFxZdAA4RzNWFMm+zsovZ4nEKw4aUAicS7wtAjJpJM1u6AmJF6SF6cKY3AfY
	/dJlHqAS2TLmy4kkyxNwS/8Jbe0IZTE2awb4RtifZl5GjFhuOlYkTEUzDvrZlfR+y1L06WaV55w
	KLm8cUY4OP6dyN0mB8vZ8P9VJAlbhpyEh4a+HUN7qQtrVMv7UY8BKRZ8EBkPp9B1Gn5breAMDFz
	B+Yis1CnP64zO/oU/KmK3sFWo9Cyrs6++FP0fz7z68p5WdO7WuEMnUCQWyiNzG41I2k3Do1JsGT
	oeoQ0h3CiH9mlNMaA==
X-Received: by 2002:a05:622a:114c:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-55d88138bddmr71826311cf.4.1795559568208; Tue, 24 Nov 2026
 14:32:48 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org> <awXXSfrhLHK7TNbp@google.com>
In-Reply-To: <awXXSfrhLHK7TNbp@google.com>
From: Esther Shimanovich <eshima@google.com>
Date: Tue, 24 Nov 2026 17:32:36 -0500
X-Gm-Features: Aa3M54pF9USwoeiXdEoOFQBIYzN0mq-CawtxtSt4Q5TgH548xzZqipxFMopdNWE
Message-ID: <CAK5fCsAk8kMCn-VPsLEo=34LvH3=Dar9jG+vXX-0e8mF_Zp5pQ@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Looks like this caused a regression: on non-x86, dev->untrusted is never
> set to true for any device (so we *never* enforce DMA protection from
> externally plugged devices), since set_pcie_untrusted() solely relies on
> arch_pci_dev_is_removable() which is implemented on x86 only (on other
> archs it is a stub returning false), without checking
> parent->external_facing on other archs like it did before this patch.
>
> (I found this by looking at the code, not by testing.)

I agree, this looks like a bug I introduced during one of the rounds
of feedback. Happy to implement a fix, but I no longer have access to
any devices I could validate a fix on, as I have switched teams, and
am no longer on ChromeOS.
