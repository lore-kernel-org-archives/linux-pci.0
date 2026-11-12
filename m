Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794508788;
	b=oxDkYgDd0k9oeX4hNOobB8GelDGwlzTDlyLwwkJoEU9gc+ag2EEX9pTn4XpEEiMqm+SR
	 3OOHImkfWivJgBnWngayVdo14r/3mhe3X7k2yXREFcg74vtrPgjJgaNYPgUs+iTgf3Emi
	 rX9EJvL99fxhiKx7JJgxjuUpMW9MvC+StCmf43hBSus4B3eoGNaOx0xhtem1zyoNpEZDE
	 iJX6e6La8wxnqQQ+tU1oRcYKgNHSQYTG1g9TDFgfg3ky3RiS1+BQsu2+7y/mcaAEhsx8F
	 IkkoZHnB70Nrc5rK7jwyVEKMKOPst/QeZleQ8ac0IhR7c/gdiTDU8Yar84egMMdxTgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=i6MYREZ9DJVIZIXy4iFOVHblxNTs+WTNzj/lKTj23uA=;
	b=RU8k0Krbv1yju1g0ptdUo2GesglFrx0hctJ7PUhdt+7OCujV9tU2k1Zf/Hkr23I4uqbo
	 RBpjs+jJbAjjTdxo1US4ZPd6pK54Yqmv7nLyrt//4LthFMznPzA4uo19d4QZU4+k9YcwS
	 W0nFmNtRO9+IuIEDA7rqKeauIj6qXJPwa4J6OP4ZrTcSDljxAiLAMCxDecKnKfiZizt6w
	 Lm5g13BmXPE2NCOidlAocJ78wvoW08Y3xlllJQMvfnjLg6LQLSh53b/spn7sDhIKR5Y4L
	 S0ZFtcu7ArVNIlsfdLcAfJBw+fzPDAlDWjoM6SMPaDyx2V2gYo80Qhrs+v5m07wQbiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="I3k3j/mY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A18606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 18:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29A18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I3k3j/mY
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67bee1f693bso91232d50.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 10:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794508787; cv=none;
        d=google.com; s=arc-20260327;
        b=niyFrcxJ6FkKwc+6+ozTZ1VLWEF6ad6u1OIeIV4OSr5wdkghNiFz1my6snEwOtuLiY
         ExA++77QJcAep/CqM66Bmd4CxZe3bVxpONTNhc5gSTy+Jr8o599s3gW3YrN8Vbg4l7I0
         tRXu9PRdqYPr0wR0+y4BTot96PGiCujrzrkxpD1w4W0UEjR0yYaPNj3IUNw+u3jF7eqz
         PurIkScAYOflFb0FTSLL2DbJ1JFyr/AdoWrxqVJEml0aAhJBNmM+gvr1MqgRAnnmL3j9
         VgBiTfi29IdCKGyOS714Pm6DtsyY5OaZdKoLz3GKF2HSFVbKOx3W2UG9QmoytE+SvB6a
         pIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=i6MYREZ9DJVIZIXy4iFOVHblxNTs+WTNzj/lKTj23uA=;
        fh=uYUGq41yGFPJ6/976hDf6y+kxYp7kxg3tGggCy8eif4=;
        b=NIiM7Yl2Kc6nFBRM0HMd9gsF2YqMyLKcv9teiGA8XnlF8l/RgvQn5iLHY8e7vYIF4S
         xjBi7pJmu67lWsC2s/ylXXNWQ/Ka/JLUmMgzZeft4GzzQis7qMloO80vQBHT9TY7sxxv
         tSqV9VgMAkmXOIk+c805VNd3cF4OqOd8+pWERrh3JJ7NOivrZOE9wkUIAt0ryvyyXa63
         5vdGE/rfonXZFK9B2A5kN2Pb0VVSvod/LPQJLAn//AMfS7kkZUbdkg5JBrkBTdlmCc94
         mN6cDSp35m2VA/AAVC3pJI7PSPrrrJDrO1865HDEFQeTKRCe0YATDQYCpoiuwL9Wfopw
         Kqzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794508787; x=1795113587; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6MYREZ9DJVIZIXy4iFOVHblxNTs+WTNzj/lKTj23uA=;
        b=I3k3j/mYTGTMw/FTBPOP4HB+6ZhJfLYWSOZ6mfORv6arkKqEd9eYgj0c4y6HbtZ8sB
         IdFGTCAvNPynYPbO3LPein1BbBql3tUwQFx17Aef7RbiS07ckfzQdIsnOsHI4NejsBFN
         e8/sXG54bec0YuOi3HRZs9toEDblWvD47qGgJFp3gTh14g150slY7xcn3lBEQ2OiyJ5x
         50b95w5f+LSzvGV4ah04jqbIQSCvW3upSHnNeefPhpSzcXZsItC8nHzN/Uhg8a/cajdC
         sVa0lS85MQq3xKuqZxe65/MbCAZM1J6KScUceRAKL6Toc6EjWLueW8yHRfvfIaJGG9mn
         rXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508787; x=1795113587;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i6MYREZ9DJVIZIXy4iFOVHblxNTs+WTNzj/lKTj23uA=;
        b=jpcPe3T82sPZ4nv926Rp8ie5pu0PDxuE158jnetoB3FfwUCOWjbPsLpj26LiD8cqY4
         H06swl/ICcGeY/on7F8tY1ptaiCpEUQeSJAkWiatpLEobRiDYzi3bjSjuCTDn8Wo/vPp
         U+UlJHvtcxN2F5lUOFbwEo7EYnqubfLFyHkVdFv6yQjpvZdNj66TKSjKGnhECTu4djqY
         37VVYb4b0JzggPm5JrQQqYgNEbYe0RXE7OsXkaSGRsLxwp2U2UQBUL4qbnXy51bFhG79
         MBJDYU4OrDr+LouQLYdlWHR/cS1HK8Z4R5WahhIiQ1FzwFGzAy3gJheIfKLDoBwd0Xk/
         APgg==
X-Forwarded-Encrypted: i=1; AL+hErEMOZm58NnYBF3cNxbbEK94FXQvqFbHjQ7X+5JR42g2QHyeKZ+XdvyEwLOZoTwoZ6t8Y77snf7qzQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QjuX8JQgN2srJP47OY6N3SwooBbRiuEapAyEzPMzNOzM8DB0M
	1lzi0+DOGKgke2UziTs1VJ0eoNecYb8NhDRPL2TD1hbNfYxvwXuUqcJukTmKbtFszZHjESpL7CS
	4ZVIadYJauiP4kvKthTydcV0h7vqaBsQ=
X-Gm-Gg: AYBFou1BnZLPiVQfWlsTHo8zYX3DFoelFiGD7ZlhXCHbF3xAdsniqFeasf4nc+pZW/j
	yPCJHV5GT8H3vBADIH8TdDDJgeVXlG8svLVUzYpHDxxqgqwcQ5NX4visCkawLOF9b8O/d7ewYmm
	zF8Wyk/x+GQrzDPWfa+hQigC8s9YYruZoKcsHUL0w5EwPow+W0mdtvZuAznam8165flf4XlDPJJ
	a+VKL4OB/0y4Pl1/2IUxVso7l+oR1VMmCtTtej4Y1SfDGTbN7sM9Xt4JVrB3mYO7JAFevypRAfa
	6K0R5NLye/jqkXcmx5aXowhfKX71bRAg9bN2gyPxFHWtfS8JmnbHO337d3vctuVTbkiclD+j8yn
	h0p+pYQdAUPOnEpYR9HtVAtz/s4zn83A7FlhJIrzzZOoE2PxCfyETO8SS6euHaA/oJ6gDdg==
X-Received: by 2002:a05:690e:4884:10b0:67c:2674:ec72 with SMTP id
 956f58d0204a3-67d894503f4mr165883d50.4.1794508787147; Thu, 12 Nov 2026
 10:39:47 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Vanchez Rodriges <vrsmilemen4@gmail.com>
Date: Thu, 12 Nov 2026 20:39:35 +0200
X-Gm-Features: AclHuK_bSBYZdCtuoiVdZFboVrMKpHYHDVsA8gPuh0MKzFXHdyBQBj2cHtvPzxw
Message-ID: <CAEoJKMuqFEZO2wfV09ea4ioKeExbP53Jhn2yQ6Wnxp+fpA6yGg@mail.gmail.com>
Subject: PCI: pciehp: spurious "device replaced" on resume, Acer Nitro
 ANV16S-41 NVIDIA dGPU (same as MSI Claw A8)
To: lukas@wunner.de, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Derek John Clark <derekjohn.clark@gmail.com>, 
	pgriffais@valvesoftware.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This is the same problem as in the MSI Claw A8 thread, on a different
laptop:
https://lore.kernel.org/all/20260806214808.1202819-1-derekjohn.clark@gmail.com/

I am not subscribed to that thread, so I start a new one. Here the
device is the NVIDIA dGPU, not a card reader.

Hardware:
- Acer Nitro ANV16S-41, board BRZ_SKF, BIOS V1.14 (2026-04-02)
- Root port 00:01.1 [1022:14ed], HotPlug+ Surprise+
- 01:00.0 NVIDIA [10de:2d18] (RTX 5070 Laptop)
- 01:00.1 NVIDIA HDA [10de:22eb]
- Kernel: Ubuntu 7.0.0-43 (based on 7.0.14), s2idle

What happens:
- At boot the firmware writes Subsystem 1025:1969 into the GPU. The
  kernel caches 0x1969 at enumeration.
- After the first D3cold cycle (runtime PM, before any system sleep) the
  register at 0x2c reads 1025:1883. sysfs subsystem_device still says
  0x1969.
- On resume pciehp_device_replaced() sees the mismatch:

    pcieport 0000:00:01.1: pciehp: device replaced during system sleep
    pciehp: Slot(0): Card not present

  and the resume hangs. pm_trace points to device_resume() for
  0000:01:00.1. No pstore, no lockup or hung task report.

What I checked:
- It hangs with and without the NVIDIA driver (module_blacklist), with
  pm_async 1 and 0, and with the GPU kept in D0 (power/control = on).
- In ACPI (SSDT), the power resource of the root port, PG00._ON, writes
  the subsystem value through a register at 0x40 of the GPU
  (PEGP.SSSV = DSSV), only in the path after power-on and reset. Writing
  0x40 from the OS with setpci does not change 0x2c.
- If the kernel caches 0x1883 instead, the problem is gone. I tested
  this two ways: GPU removed and rescanned after one D3cold cycle, and
  GPU re-enumerated by pciehp after a resume. Both sleep and wake fine.

Workaround that works now: a oneshot unit before systemd-udev-trigger
removes 01:00.1 and 01:00.0, waits for 00:01.1 to reach D3cold, then
rescans the bridge. After that the kernel caches 0x1883. Two lid-close
cycles passed (25 s and about 1.5 h), with the NVIDIA driver loaded.

So this looks like the same firmware behaviour as on the MSI Claw.
Lukas, your quirk_msi_claw_cardreader() in that thread
(https://lore.kernel.org/all/any5ciFCjh-0cGkB@wunner.de/) matches only
the Realtek device, so it does not help here. The same kind of
SUSPEND_LATE quirk for this GPU would be: NVIDIA 0x2d18 with cached
subsystem 1025:1969, set subsystem_device to 0x1883 (the value the card
reports after power loss, not the vendor/device ID as on the Claw).
I have not built a kernel with it, so this is untested.

Your other patch for the removal path
(https://lore.kernel.org/all/any3vMJMpxdK8Ekp@wunner.de/) is also
relevant: here the hang is in device_resume() of 01:00.1 (snd_hda_intel)
while pciehp removes the slot. I have not checked where exactly it
blocks.

Other ANV16S-41 owners report the same hang on wake, for example with
RTX 5060, so the IDs may differ per model.

I can send the ACPI dump, lspci -xxxx before and after D3cold, or a
full dmesg if that helps.

Thanks
