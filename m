Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792864335;
	b=vbq6AyftsjW/9HKhCqRzzYyp4sAxYPvQmU1F+ss0px6frzNNRjA2fnDApXl1Rm5r3JQC
	 orrpAkNFr67JZbMUeWSvYdw86ddj4K0Ihi/hMt6Q2Tyqhwe4LjsKwDoGkTGl8K3qAOleM
	 wZh1njzfdLy9vhrQXO0B1qONk6VZmzGV+Nm24oirnmtm0uAnBst2zqsGC4zlQdvrsJ63U
	 Ycb8BYLWMUOTesHsZ70M47bjlhIYf5JV4tI7o41M86Hbu5ch9lEOiM8xmNbCQHyYdck1+
	 Sk5bwfEuySPMpvSJCqbE+FZ9BKU5ZrOt7a6Kgahel/V1aRiHMI5TKHUsjMLTAGQjt9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792864335;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bpEwuRreNChB+u1Z6agfQGrbJBQaLJYv0EH9wyrxoFE=;
	b=KSyp24fKeVoDf5btgMMf9LWwaLdQNm5/bbvtyabMeFQi7cOPzRit2Umr9ddgbI0TAhPP
	 Twdo+IH/V+ipCn2zr2yApxZ78YPL8zugQMA/SUuzQlooNbQ9xK7X+KmKh1PR4F5ofXqwe
	 B4sqp0czfUA+8Xaaj3OMHQkzYraR5UNInDiyfsit+jiU3C4PYmY6MII1NeroXpItYCJV0
	 7Fn6GaAODOu5DtxHX6vBFX1TwfUY0XvznwTRCDQfSz4utudWLVjrUZyidbDSdSxbbZA9L
	 Een2oREMirghbfy2r0FRp0TyS70+gjC9F13gXiCG0G9magb83fCpD8v9J+w2rI1BROg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BMsFzLFx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E9C606A31A
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29E9C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BMsFzLFx
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-706113e92f9so1107601eaf.2
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 10:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792864334; cv=none;
        d=google.com; s=arc-20260327;
        b=hn/ybW4rghD7HHsrRNJEucjyltVGds3XC3bmYV0WhFDBGL86z3qrCOI9l49KSSyeiS
         yOKARkQBkblRtWeQ1sa44y1c5ttCodAe8pJJV4OKGGHYEzK6tg2G+K1cZsVRxIMoAAVW
         NY0izRYbrsx+MMH8bCqWJYm8g6+bkKckuPqYTmkoRV6NF1JRnR20dUlurs2IHutODS7C
         xOUL/WA61CgP63i5jNHNz2f+9ha9NeKQZyO4ZUnOEeMoa2Y5iQ37TVufWVXiWRAgf9yz
         /3mxGb+tGmtm2KynfrEdE/x9jTEIMlFc0v2K2ZEnMW95MNZxot75YFG2w8aVi5UgaQy7
         On0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bpEwuRreNChB+u1Z6agfQGrbJBQaLJYv0EH9wyrxoFE=;
        fh=DY0DV8JL8RirWPbXdeMrhQ0m2yK3DdjqjwL6GjSKyh8=;
        b=dhMtS/gWb1kg2rW5d03zkNRBPl1NzbtxEgB8UOlGej5dss7t44+jZ68j6qSfoOJtyo
         MdbPNCe/puySs+uEsLs0PvK9oxDOt8XghzOOiZC07OwZf3XKnsFg7BoWYVkReJr+EyuX
         Bhu6s7CTd480sFYVjWIqh65ioDCr8IKZbxeaUQ5llXVZKaUn22V+9aL7E+a8GLUSuUla
         EbLlt78wnyzVq6pSdjQQjOKX1l+YcQBbpRdPM2Ngmi2rDqgva95PMX/gp3bh46XruWSh
         C0akm0HBFgSXz9Qdq5AvB9/lSAY0xZLTb2NTK55jEdr4mb3+S0K0itYyhzADF3JF1tm/
         1+NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792864334; x=1793469134; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bpEwuRreNChB+u1Z6agfQGrbJBQaLJYv0EH9wyrxoFE=;
        b=BMsFzLFx3LtutkGefGNi/ZDmwTWkJozZ+zkbE47xwz4ri+SpNNb28gTxC19glia4OJ
         NC8YdiMng31PeB1TQUmUjtnNQHcrMg1I3cDF0Mm+IPmzaU/qXWkK6kNLcYCecHFD06q7
         xTISCk/Yh2Hiov8JBavC7yZCG0Hn1xfVTCCXD4Gg6YYcVVYmq4YoT+L8ZiOUkEmQ1Jjo
         FQs4mIvcW5kQ8dlZRYoPnpR0JX4Ubgua8025OcwsRSoFQXmuWU78LOUdiGw/ofcjY0pI
         4u2UKKzQppWBdJyxPEN/NQA3WUWErZ+MQ/jBleBREFCg42KEo6KRgaYSfsCYlk50iHdy
         rBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792864334; x=1793469134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bpEwuRreNChB+u1Z6agfQGrbJBQaLJYv0EH9wyrxoFE=;
        b=dsAnQvWmF0FznF8lISSmgX7zoFiXy7KHtQHR9vFSMY6U4Tsy3LfZjMa/bOJJuue8mI
         oXEYyje5ZXngT3MCxU/Fr2q1ITFtuuEFfD5/uhSJkx2MPmB6pKjU5TGhrmhU0y0CE8c2
         Wu+4dND1/H+yORAd+SVJfeFJTKCj2qM33FQw9bWgo0D9Qcwaix7Q2hzC6ELcKMjk0ysg
         lsksJQUczSjRH/gcwuYYJQtfuosCX51gpZAtj/qjZVKXQipN8zgTjInj0rPVBOK0X2Oy
         B65cUUPmA3PlAfQfts43s7dXx9YV/i1sqit4dATQalmkF5HxZDBApk9Nuo29IpXdl3De
         HgXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwcN0QXPFXKAvQCEJdlyxZ4isbvJ28LR2Kxdf96nFE9zHAsDlnwu8s29+FGJk94sPq0Kt3nyH5wUEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK84VpfZDLzqHMJflXdhL9LbVPmwDmlTM1TOmfQkZHqTTjOo5pX
	I1VmRoNg7D4yG6aVS1zySRosl59lvHLPVn3QTquQDgF0PWtjBNnY7IH7Fm4+Wrq/kZ4KT7cwHLa
	dc+ynYOJ/chLuepSXav37Id35QpI++Rk=
X-Gm-Gg: AYBFou2HixAJ0mYvhbqo82Km4k+gBeUoYKqUoDyiHOLSvvfw9Az9yRGcKuvYYoRd8R/
	27CQViUe9iKyNild6Mt+YY9YwQPk2/XUL0H2MFR3F5jIUc1dEuzkOtZnnlXAVP4P80U1r2mcgHu
	CKBjv+JmtrOuSqEHwmL1WzaeMfXK7Kfs4MjwKc7CWZ+koEY9SM6W3ypH62F9m2ob+QbYSlpTjCf
	B5lII/esEu0eXdpJrYwqbDq/qvzNBpfiFYafboZbyhUH7T6xSUIhRvTZ/rXaSG9j1lnw7dmkQ7V
	UDFr0PMHQqbB5xGFVPZv36ZikC7Df+PbfjchtAriwGVn3MJACtksKshvfk4pf7Z9dGprTipjbJj
	YD6fglQmb3fptC6MswUbrYub2nSXtu8epNw==
X-Received: by 2002:a05:6820:3285:b0:6d0:1fe7:1744 with SMTP id
 006d021491bc7-70ba0ff44acmr987867eaf.83.1792864333972; Sat, 24 Oct 2026
 10:52:13 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024172426.85842-1-kmehltretter@gmail.com>
In-Reply-To: <20261024172426.85842-1-kmehltretter@gmail.com>
From: Nicolas Chauvet <kwizart@gmail.com>
Date: Sat, 24 Oct 2026 19:52:02 +0200
X-Gm-Features: AclHuK-D5m-VTC9W4g1jyUecKnd6iuPcMx40ZM19rHe_pOaJrrAaaS8tE7DJczw
Message-ID: <CABr+WTnD8RXfth=MT562uPT5qn6VefvcF0CbEn+Ye++nFRji3A@mail.gmail.com>
Subject: Re: [PATCH] PCI: quirks: Skip nv_msi_ht_cap_quirk when host bridge
 00:00.0 is absent
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 24 oct. 2026 =C3=A0 19:25, Karl Mehltretter
<kmehltretter@gmail.com> a =C3=A9crit :
>
> __nv_msi_ht_cap_quirk() runs on all PCI_VENDOR_ID_NVIDIA devices to
> enable or disable HyperTransport MSI mapping relative to a host bridge
> at bus 0, slot 0, function 0.
>
> On NVIDIA Tegra SoCs (such as Tegra210 on Jetson Nano), the PCIe
> controller exposes root ports at 00:01.0 and 00:02.0 with no device at
> 00:00.0, and the root port's HT MSI mapping capability is already
> disabled (found =3D=3D 1). Looking up 00:00.0 returns NULL and logs a
> false-positive warning on every boot:
>
>   pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
>
> Return silently when no 00:00.0 device exists on the domain, matching
> nv_ht_enable_msi_mapping().
>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Observed on a Jetson Nano 4GB (Tegra210, p3450-0000) booting v7.3
> (c03c1a14507d), where the Tegra PCIe controller (1003000.pcie)
> enumerates the active root port at 0000:00:02.0 ([10de:0faf]) with no
> 0000:00:00.0 device on bus 00:
>
>   pci 0000:00:02.0: [10de:0faf] type 01 class 0x060400 PCIe Root Port
>   pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge

There is this patch that was well tested on the tegra side (but likely
less on the older x86 nv cases)
https://codeberg.org/libre-tegra/linux/commit/63f7810994f4d2866a27b753ec8d5=
bc36e84373c
