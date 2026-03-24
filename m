Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7B3537D9
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338529; cv=pass; b=aerxTWjbNDHCP40fG0D4aMC13J4YqtVyV5SLotc9ZQcQr16Swj1VqHXeu3+G4Cccqz1vGhusecZn9rm8i5Z+zYQvYP3QtKZVnmmasTJAkd3VcgjmcuSU/kHnD9hbhF5WyMGzMGjPrPa3VWb50FWWMr7P3UN9NdrqJV8Ze2+DjPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338529; c=relaxed/simple;
	bh=r88t12xQjw1ZcZFIz7T8sZYTRbI5R2UuPgSTXUv+zR4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HhNvpG0yXBCg7l+0nHHhXRaXtQtSXmAnESM9CE/mMRiY4Es1b2Q9wd7+ThAIs5SAg967F/kLTo/O7X45Ru1aq4sqT66XeWpOpc/d2UohsXbmyOsVX3G+3BNW0ocJLLLvIvKnBtjPrFukrpCZJB9z/gjrH3FXWDl4lyIlujo6KUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrRP2Mdg; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrRP2Mdg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b97a06d7629so664516066b.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 00:48:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774338518; cv=none;
        d=google.com; s=arc-20240605;
        b=Yil6HG48jbGZ29fILQRAVckCyConlFs0n2LT2Evc4aKm+S85IqWGhVAJpjyuD/JnfC
         XDdRiINgf8WZHY7CwxwZ0cu0zesIfSYZpbtUbNDUuEynrxzIGJMuF2tsSgXuxxBmT/Ze
         /TJ7stEnTTSOTGjqYl28B1iDkz080DTaCKRJ/HIu4PvPh7HodHW3YPvDQlxvK56tWst+
         IqFyIMe6VI0w+FHDA++KLDAfXa9wO+W6HuFO3jFJyEWGbkmkjQIXp9a1adYOeXq4FLHK
         px161K7wm2cibyKLT74xFxprQdyMsN3WrZqwxDkzL1TAQWIF5vU4bLv7AOikK794oXFS
         2SCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=r88t12xQjw1ZcZFIz7T8sZYTRbI5R2UuPgSTXUv+zR4=;
        fh=EfujMstWYmdFvPeCBAhLBiPi7yWFoNM15oJi8Rh/J0k=;
        b=QuLA9ZVU2EHeBCON/DMjZLRFZ2qX5IqIhZzZO9JKQRq+r63INNYb5hE9e7WZkOutZg
         HiYzE5F9uJwlr0xgsw2jsJAIo2J9LymY6T81/ZP3OTZXNxsyOEB6iC6cW2DGyrPQJzVL
         fR2nUPXpovBpJUk8RPjR4axDw1CCJqrlo+QcJVN0B0A5n2MPc6R3Sy8KNk+m9RNiZOeX
         SMQmEQJ+i1nImpyVr0KSVBsLWjCHWtf8GTuNC5MgW1sGHzYXkLYnP052ttZdszA4snqq
         wbL+GypG2mYAMW3DHnkzt1Mj7zdIqU5Ohm8X0fU1BKVcVUWWoGU0IS4/lHaSVqffhpUv
         7Q2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774338518; x=1774943318; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r88t12xQjw1ZcZFIz7T8sZYTRbI5R2UuPgSTXUv+zR4=;
        b=CrRP2Mdg4oGhDb9rBfgoczzf//nU6NCq19SqGv/bIfX2RINBcFXL2h7XSiScEqgays
         I7qTyAYNczAQQeGRGIgKMFhVk6Jf9ERjPw3hvbg+Y/+zgU7WB7fWQTAelWOQnxs7vo0L
         W/hEyeVucKb+P4imlFaj3lvIPGBrMAYjVt1ORgb9PIZE1JHSt5rZofgpU+majv9nRKej
         9kjM0+4Cwsp5JEeodjy2/gtnwBoVvjhrZIA6UHfckM+K5Pod1/I7r4r5sm8GoxwvCszm
         dejOjx/ZSYZOUwkkJ0W6ocKEw4IVT8QaJdjO5BRDjMP2MXWnn1iiK4X5d/OVTkLugzii
         i/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774338518; x=1774943318;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r88t12xQjw1ZcZFIz7T8sZYTRbI5R2UuPgSTXUv+zR4=;
        b=QQRJ0asczvo4n/UzmyTYrsbWS/LId/xnMfdqrGaTZ56o7RuiOCl87UqLRgm4BuLS5l
         OzXaXuHXYd8mGOkPL1WIT6FoPLCuDvXXP1Z2BDGJ0lmEDE1c3Y+e2TxfdWvtP31KI43l
         i71hxkSlBm25MxZtS9bzxjfXJ9zK5+FifGnAHTV+us/fhj65JqHXmnM6qr7lHvhE+a0x
         yeFENUSf7Xgu0NZtPSxp68asKuTw38TWO82HjgmewHDl3T6Rsc4fT+vox5WNmgsMtQhm
         hJfzzH/M9zyMmfHOP/AU3Mwgj7dh9DOV5rtE50uoox5Z7rC3Ow7H0QFOstiM2/MMw5A/
         SYIA==
X-Gm-Message-State: AOJu0YwTUZLmUHhzk2aiA+V/yWXCmUKBqyLIs8CVJATYuQZx6RouvIOS
	+qTD65PDqTTpNAflo70muif3Krq/I5aFsukHdjdO7dMy408XzBef7fYrSzfZhbmjNrwF9Jj25RY
	h+oNLfKwM8yh2pved/NJ054y8QSuUO9aencSi8vo=
X-Gm-Gg: ATEYQzznixVW6XfYw7g24GOoqBWRe7qtt2pKA0GviP8mtaQTMLpEE2zQFSIXIvvjLpF
	vM7AWQjFPfUck2VCquFSsOi/IfO++D0YnjehFi/eFYW3QJvtXpRWei9gp6N1rvOVCMJq64JYjgH
	FhXWQwPyqvURtQoeMfPwlsxVTK4XTZktbkGQRJrxIenOk5ibKOvu1eRcQQdsHE2Wkz4mqja+9l+
	QOUMGm00QOgAodNwdsglq6MBqoiTBBXs/qNU84AAHSZkmNEKvz41ooVMIebFBBVzgY3josaldLw
	HRfYe9r06KsJLIZqjSP5pwtM6BBNaaoUfpG50ZixzZ/6RXB98Q==
X-Received: by 2002:a17:906:e07:b0:b96:e0b1:ccf4 with SMTP id
 a640c23a62f3a-b982f3976bbmr828515566b.47.1774338517946; Tue, 24 Mar 2026
 00:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Michal_Babi=C4=8Dka?= <michal.babka@gmail.com>
Date: Tue, 24 Mar 2026 08:48:27 +0100
X-Gm-Features: AaiRm52EhVPktEnbKgwvu1sJq6a_4s2WuszE-GtAHaNhOtcuGR3hgljWDWC4p5A
Message-ID: <CAF4axAeYmNTyU8bzuQuaaxTe1c2=7sNg-GbZ-JJ5nS-20vZbUA@mail.gmail.com>
Subject: [BUG] Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window /
 BAR allocation failure prevents NVIDIA and AMD GPUs from initializing
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am reporting a reproducible PCI resource allocation problem on an
Apple Mac mini 2018 with a Thunderbolt 3 eGPU enclosure.

Hardware:

Apple Mac mini 2018
Razer Core X Chroma
NVIDIA GPU tested
AMD Radeon Vega 64 tested
Zorin OS 18 Pro
kernels tested: 6.12.x and 6.17.x

Problem summary:
The eGPU enclosure and GPU are detected and enumerated on the PCI bus,
but GPU initialization fails because PCI bridge windows / BAR
resources are not assigned correctly.

This reproduces with multiple GPU vendors in the same enclosure on the
same host, which suggests a PCI / Thunderbolt bridge resource
allocation problem on this platform rather than a vendor-specific
driver issue.

Expected behavior:
The kernel should assign valid PCI bridge windows and BAR resources so
the GPU can initialize successfully and become usable.

Actual behavior:
The GPU is visible on the PCI bus, but bridge windows and BAR
resources are incomplete or invalid, leaving the device unusable.

Observed errors include:

bridge window [mem size ...]: can't assign; no space
NVRM: BAR1 is 0M @ 0x0
RmInitAdapter failed

For the latest debug boot I used:
BOOT_IMAGE=3D/boot/vmlinuz-6.17.0-19-generic
root=3DUUID=3Df0048c61-b4fe-4edb-9af5-bc756f9e2e7d ro quiet splash
"dyndbg=3Dfile drivers/pci/* +p" vt.handoff=3D7

I collected full logs, including dmesg, lspci, /proc/iomem,
journalctl, and per-device dumps. I can provide them in another form
if needed, since my previous attempts with attachments were blocked by
mail policy.

Best regards,
Michal Babi=C4=8Dka
michal.babka@gmail.com
