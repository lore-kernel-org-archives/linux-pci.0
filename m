Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792950743;
	b=YIkIfDiO/E+W0NGzwCoElqYZsiBBFXdoF0LFF2M/kstDiajIrTBG8EJWO1gWVMreIJ6q
	 GKKBHXJpWusHIxnY2ArQ2pTDXlwoFoCPKTHcXohinGbfBFscE7UTQkuBTuddsVe/84r/K
	 kGqAo2JK7oGyPLlpC14kzovMtuTu6D9F/syzjWDYUWyMEdmpyyeDeXM7bdKGB6mWAhU5b
	 ce5P6KtXawt0NLO831y088iQ5gM+sRysPDK09UsaSWa+IR7XiL1xMqJ9S8ATvgTzdK7Z6
	 9EQrOtRXMV7qx1nFYncEbWB+RuyzF8UKqlx1gi/vStJw7eKqmOQKqnBE8lTQ7+mvubg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
	b=t2UJySTZKVPTRp5hY8r8vkEKvo5Hyb7au7F15S6345o/AG6sqf7IvE+YHmkWDQUsdUG7
	 m4vmEM7+zwMR20+e8U1JRcYyxI+IKePB2oPF3tDrC1SkZC3xDvWq5PEWPjHFUIyv9/vhY
	 sDsaZcuVwv3IUZ+IJiVWuKEJyJSs8eWqyc3tkbbuUFLVMIXZvU7k5x9077pylqnJxfPv1
	 vs9ran6DFzCH9nrB1bcwL4Z2VNPnb5SYmtoaofdl+khwsYE91+TjBDbF1rawK+LkjLAUL
	 UbfzMMhTV6xK7wbrSGNlGXkF10WJJbwa3OJjCiJrgjS3WWHsC7sGQz1YuYwkE3IXywg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FC6HUzYm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A8606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 17:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A33A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FC6HUzYm
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c418e215671so289874166b.0
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 10:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792950741; cv=none;
        d=google.com; s=arc-20260327;
        b=ac6Grcl0wnhSntkx7F7mDp4akyHVJWktA1AMuRbi061cNIfLL55al3zT4s1f4zOV1z
         75u2b1TY/al0Adeb7VmJepQ8O9ihDaVS5IqqvQE9eatAOGOUurHE/poUUY9ziXxIvvvO
         iDLPWcgnLmEVqZRV3tE/OIqkloiKcPYmsBqNpgYRUuCKKcxlLmIxmpu/hJ7/iiEdh+iH
         RURmY6UTJpi6G1l8XeoGUZZSMlhbXLLrS8uCE6ukRkZdwEyDUYhsHyc2v29E385RoBuG
         RzxovhlE6bO0UVQobUfYE1QaA4ZpliY26FMINZxutQJxmqbdzmcEwh06cuqKjg4GxTZ8
         ITmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
        fh=DzEduu48ZZj0A60YMce45T5stbxYKzdprjOs4OCV6KU=;
        b=Od45I/+DSnv/VKB1e8K2aor6GZ1+QK1ijqZ+9B3EsH/5GbFEFBKDjEjj5W7gLqkKkv
         Y+aCa71dfFNZwzZ7OHrI46qFOAIMWC8ACOEiazkMIb6BclNv/ziJb+9uZ/T+bkeTfNrx
         H33Vz88AJjae/KxP6I6MWa1gDbyhWSG65BnA1HpzqnySFL0o/KHSBvIkjd7DopZ7P9JR
         e9PGmhW04Je2uVv0EdGeEmPw8YOcCaiPjgc0cxMo4Je5mu21BGYVVhtbgL92dNKecjFO
         w9J2d0EBnSWGYIZAqQhc/wqDjEFBBRTtFyt+F8aent/60L0O5WsJN82T44WnDorErbR2
         zbSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792950741; x=1793555541; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
        b=FC6HUzYmMNQxSMmCXmfY45ZCuO/QTfl4IX7GWuzE+msxmYINvXAo6QHDZeyEiSHCJX
         L2PHiLT28UoHFEosGOk9U4m+39P4IKoyBS5McHyEcRkFC+3hV4BsXrEjmRk7DEzawapX
         VSuY0cUGX3gBsgSAdNjNzyMKf9fOPNMzn6Z1c8jMvlxdAYMTMExd+UI9ZLeGnH8PqUCN
         y4Y0RridFPMkvhRla0ZTxu+O9HQD9fK08Jnf1N/UtW43eyx8wBe6CqhXP3sXSjmGFf1h
         yw4V1AcDslf+F5ZpJPBH3UAUlMPpHHKQdgRYj/P2dc/YlzRLEd20N4BbEpmhYC9iahwA
         TbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950741; x=1793555541;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7aFt4J3E+xSQOGJ2c0aTTJGMbHVCzTORiyeLEMNWLak=;
        b=z2xWjcjW+Wr/ufbt2DvI9BGINHgjVHJmhozNhMmjL7LLkAX0og9kafDzwYbo/1Nn5+
         +CLE/dLCRHG97r0RjafA9IiPuCQ0C66zWn2vCGKbLSSxWHWNwuzuusE8Gzz7n2sxc/5C
         qoWeKqLXBqn8X40XVaHBpgYW4Bka1qK5KLxTHYkwdSGMUb8r18M4OtnwFyIwoSK/qPm7
         uUlGlM3yW1M128PEdyBCzOAECMx+e3OLrryl5ilOLRkq4CDtq3rBiST/K6n3AZres2d7
         4dXrtHvdGXRL62kQ39S+OnUuhUjrwUwIMSxuANvdsTyaBHp9g5hNJDNJYRKXqMboa9hp
         5bXg==
X-Forwarded-Encrypted: i=1; AKwUvBydsS022tfFCZvRvwEaXFzHp89So+qdHVjn6GUP6hFm8fzWGnyTcc2wr9rb3Gc7rVdzUcCg0el7IqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIty4J783l4HfUNx4V2j9wSB7KfeMNiGmrbsG2toDeRCQ/FacpF
	S8Qlyuux/8rs1w6q+c2GTZEOFYOa5IT5fAis7+PoRlkMq5/xy7JjMNC4Pf7pvPYP2LlBaVZwKuo
	vSsuBlOchspp0AJYVhuLd78Tzg0crl2eSrokb
X-Gm-Gg: AYBFou0qYOcws4y0/shL/G0G5aTQcX1mkhZwQcYTnB4OMQ7QxgVwzYfhVT6nzKQkXSk
	udubUwvljB1lVT8fUqDKgK4cyE8Q0Q+yuQpcyb8nio7U3mzFMXQzy+GqoZAiuzbJ9vSokOU3jl8
	+kB/nWXvXKm43pihEFPXn36WhLqmkQ5/ZVHpDXC/ZpdzcY1Ai9SSaFZTzOVfwyPCTT8SzBtvcTk
	AdNa7J6g7pmOqYrWFjVXeh69tyNnvqiJeRI0yoAyzZC9aymIQX7kCgBQsxeclkVuoL6Vg1CMfBs
	W+LVETSHckxy6DKq8gtf1Le39fyH700yHLRu4u3i1R6eU7tHiNBLCpcFAKWeUFSPSAQ8lS8gHKh
	J2jOPGNaXVlG8Ho11FMojuAhyTjy+Tf+We8SqR0ddWW9qsx0P/s1rxwzlUvHudZ0vKt18UVO2hK
	3m6nxcmFy6POZLboULUVKGcUMiU5IDUgDX0Hy9/r2AQGgvEtNv9OI=
X-Received: by 2002:a17:907:9711:b0:c46:7b82:27b4 with SMTP id
 a640c23a62f3a-c46bddc9600mr600371766b.19.1792950740660; Sun, 25 Oct 2026
 10:52:20 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOz=NNVc4C3aSC+VL59V31==P_sfgCkjSK+nG3LAByUF84OVVQ@mail.gmail.com>
 <at41Hdy8ATMj9LRC@wunner.de>
In-Reply-To: <at41Hdy8ATMj9LRC@wunner.de>
From: Patryk Janik <patrykjanik1710@gmail.com>
Date: Sun, 25 Oct 2026 18:52:09 +0100
X-Gm-Features: AclHuK88Z2QavAmx4mSXDSBISgT_e3iYcuZ7GDfDRBk8SUdPo9i421telRTgTEI
Message-ID: <CAOz=NNVW9khnnt40Bm_ddiNeZ+4Jr6pEPjSLb5Ezq0gAi6Y7uA@mail.gmail.com>
Subject: Re: [PATCH RFC] PCI: Don't restore state of a device whose config
 space is inaccessible
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, alex@shazbot.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, Oct 25, 2026 at 05:58PM +0100, Lukas Wunner wrote:
> Config Space Writes are Posted Requests. There are no Completions
> sent in return and consequently no Completion Timeout is observed.
> So the above paragraph doesn't really make sense.

You're right that the writes aren't where the time goes; the
paragraph is worded badly. (Strictly, Configuration Writes are
Non-Posted on the link and do get a Completion, but with ECAM the CPU
doesn't wait for it, so they don't stall either way.)

What stalls are the config *reads*. The trace is in pci_mmcfg_read()
with RCX = R13 = 0xffc: when every header reads ~0,
PCI_EXT_CAP_NEXT(0xffffffff) is 0xffc, and
pci_find_next_ext_capability() re-reads that offset until its ttl of
480 expires. pci_restore_state() does about ten such walks, so a
single restore issues several thousand config reads to a device that
no longer answers, each one stalling until the Root Port's Completion
Timeout. On this host that was ~56 minutes in pci_restore_state()
(and another ~33 minutes in the subsequent save for the bus reset).

I'll fix the commit message in a v2.

> The outcome was that there's a firmware fix available and a quirk
> should at least differentiate between good and bad firmware.
> Or the fix is to update the firmware and then we don't need a quirk.

Agreed on the FLR failure itself, which I'm pursuing with NVIDIA
separately (for this SKU, 10de:2bb4, no newer VBIOS is published yet).

This patch is not a quirk, though, and not NVIDIA-specific: it doesn't
touch the reset, it only makes pci_restore_state() bail out on a
device whose config space reads ~0, the same way pci_save_state() and
pcie_flr() already do via pci_dev_config_accessible(). Whatever
firmware the device runs, once it has fallen off after a failed reset
the kernel shouldn't spend an hour in soft lockups restoring state
into it. The same applies to any device that dies during reset.

I left dev->state_saved untouched on the early return so a later
restore can still apply the saved state if the device comes back.

Thanks,
Patryk Janik


On Sun, 25 Oct 2026 at 17:58, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Oct 25, 2026 at 05:37:39PM +0100, Patryk Janik wrote:
> > After a failed reset, vfio_pci_core_disable() unconditionally calls
> > pci_restore_state(). When the device did not come back (FLR timed out,
> > config reads return ~0), restoring state walks the extended capability
> > list and rewrites the whole config space. Every one of those accesses
> > stalls for a completion timeout, so the host spends minutes in soft
> > lockups instead of failing fast.
>
> Config Space Writes are Posted Requests.  There are no Completions
> sent in return and consequently no Completion Timeout is observed.
> So the above paragraph doesn't really make sense.
>
> > - "PCI: Avoid FLR for NVIDIA 5090 GPU" (linux-pci, 2026-04-16), where the
> >   underlying FLR failure was described as a known device firmware defect.
>
> I assume you're referring to:
>
> https://lore.kernel.org/r/20260416070707.3242381-1-yuan.gao@ucloud.cn/
>
> The outcome was that there's a firmware fix available and a quirk
> should at least differentiate between good and bad firmware.
> Or the fix is to update the firmware and then we don't need a quirk.
>
> Thanks,
>
> Lukas
