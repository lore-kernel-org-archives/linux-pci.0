Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924752;
	b=t4qMeid2or7otB81Fqngm3GhCDBl8yXdfLhdR4KhdW/78zrnj3dOdHOyLeophrdpfbRU
	 qdvVCB+QbbBvT5xuyFeWyljkx1mNhe01lXeI8RASFwNDakRXipECZcsVxuKHOi7OjX/cH
	 FUY9p+fpyMyI/EN+1F50oVV+zDc1nso80yNayMsztVc2bLsFzvcZBqxzaJsJNd9RZXJU/
	 0aDjE6m1SjymtE+9JNgjiwz72m6/Di3QiBfvta7tPB3OkW863c/LaNGdr3UbBc8yVyBtB
	 l60JmeTn5JDpgWzoMuZER7YNpBC+w8bwJ7mo6vCLCl6bgu0QgoYCq2XD6ufLFKbhv/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X97KLM2kc+1MOkKgI4F1FwrxFLI65NOxfbxMj5IVHe8=;
	b=gnxtcvQODD/FolAU81m4s82krbeh0u7dr4susWnBh9lkkJn3HWUG7tdTkX7qmq9RuEiO
	 wY3Onv/p8OtGVvlCqxG18H4HQhxrUVBMPHpSpaQjQ7kWYQv3pqIoVL+1TFDxzNWr9DC0W
	 wYA6fbx6xpjHCz136Gy9tAwmEqAwIAcvR36bNKLYHS4YAboLk9VjGdPF7Jyljhd7ZfaXY
	 JBWMvsfLroZERvMmxDOKOzvtPijcFfLuDIgnU9IK/aw3ivO9RESIm/kcZKxGmAO02/e/E
	 gTuNHm9C8GIN7rgi0ypO1fVsg/Y9F+HYoOJ8+4sI+CpO+MN5bh41mbVYWH3iEN01J7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=exabit.io;
	spf=none smtp.mailfrom=exabit.io;
	dkim=pass header.d=exabit-io.20260707.gappssmtp.com header.i=@exabit-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bo4GSKea;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA7F606A89A
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 14:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AA7F606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exabit.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=exabit.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=exabit-io.20260707.gappssmtp.com header.i=@exabit-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Bo4GSKea
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so2278592b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exabit-io.20260707.gappssmtp.com; s=20260707; t=1794924751; x=1795529551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X97KLM2kc+1MOkKgI4F1FwrxFLI65NOxfbxMj5IVHe8=;
        b=Bo4GSKeaMWBcCzBQUj30BiVDaBCBzDsrtg0JghncdHHEJhWe3A8ZjwoR+gn1zHiKzU
         uwoCRo1HYZ8Vcf3wHIIHfM2fhFHdVDdbI+qRVrYCdx3LunVxsDienj03k2kIVvbQrDmu
         Yj4ClXAsqfBFFlUd2WJPEMV3cyCf8LqvFsWDpygOochRGDtYOD1o3xKGfx3C5QnltGMs
         nIaeFzqcVi3Oc7VfmOEKhxI88Xm6rsZxegW1ymQiGD0lWZ9iPky3HDbSVOv1sf1UQfJM
         PlzC3KhruPsA9KSJw/bYCEp2hwwhcaD93e+Hkpih9RjDTt35IQvgPnYeBJ23lEyrvvjY
         a+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794924751; x=1795529551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X97KLM2kc+1MOkKgI4F1FwrxFLI65NOxfbxMj5IVHe8=;
        b=Zbfdocm63tSNLdpuWgxrScQ8XL9RK7WB3nL1txvYfntKziEiBCMKhULnCG9d5AsB33
         AcYpqNyprs3AhdRa0+7SLm75UdtSa2FBBF7fKyFqjzXmPF0IPJk4l4SSTVgEN03KeWj1
         wKAmM5Bi6RsD8KfLHf731Zj67JBy0EIs9SFdhSVYEsq7+MSOufEub9Fc+dcWE95z9YwG
         0a4C/NtRm3NXEy3iTlKgrSJFQJK68vNpP3fGqbanx8vL1xr40aLI90l4o0NSlfbe7QaC
         lCprf9O0xVxTBFmI5cKU9blIAiIzm6PHeB8xDbR5Og4KHtUmzSG5c3JE7QqSSeBLRkir
         saDg==
X-Forwarded-Encrypted: i=1; AL+hErG+X+RrxVtMrHA9biVnIUT9hSfQrLNHHR7/AJ1sA9FOnSTVIoP5pMHspK/61o47m1CDyJh5CmPAnzQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z94mn21lK2SpBIOXqyIMxC5Fm3MgD8zDJ1PfWTzubHdVFzMu+hp
	KG0OVtjlrhEHMU3umYvS+bvB+6YCkuGZb8//2dhC/X1ll/F1Ckl0Hsi/7zZAeU3wasQ=
X-Gm-Gg: AYBFou3v6QGgxNgBLMP5tISYPwy60KM0IJ9cMKu+Y3LXLkHaM3D7rRaEeCb3D0qkzCU
	+qPQZNkhUbzRTUrMgUTBd1mzaSV1BCGatNg+W3PoA3Gzx8OepWjiXiPkJW2gSDxMPoBMzEVUKR+
	cm0ntfCkrT5vkb14IYiXuo2pEQEsGyGlrBvq4JYCyW5Dai4gjrcpgNjrhiWkQLxD1bAfvo9lhBd
	VSClBX6vYtPFZW3qXxG4I+heKwGjLTPFUi13KV3YwrNUraI1Hpmwj38UsLKOIeEeEuIs9uBxLjj
	4r3RGynQxmTCJ9oa3pAwu9mxV1LEz0Nvn9vIOFUfdBZmUiLDuaWq9LyhmHpddj5KiK+A5Nz6u+b
	adMDsVLqHEtN1VfMwVG397m0wMPDNZc/jV+iKjDPIU6ZFad2AgK16In3ctF6EnGMNXYSGC+rCNO
	bP0bhPTnwv570PYyffyaI7zaZ1YPp8bBicBnY7V7bwiWyAPZv/WoR/cKFbE6vLOwH3bK7uETsOm
	Is8IML2gzs4OIeG3VK5QfTs8liHXJnsSnRfWfQQHnGI02h8iFEhqO0XHToNI/i4vM7NCMMPC/Zn
	detzIERKOHPi9kHV+pXSDoTA/x/nSvvfDp1cQQVQS/P30bCS6C6FKRwTjoWjXKnEDLA8NWQvLzq
	zfDPeVyLbDN7mZFX8eOfTHdIzyXiXcTNdCa0kGEYwkj3Fpr/UcMeGId0=
X-Received: by 2002:a05:6a00:2daa:b0:8b5:b10d:3c0c with SMTP id d2e1a72fcca58-8beaf3a8079mr12420935b3a.0.1794924751156;
        Tue, 17 Nov 2026 06:12:31 -0800 (PST)
Received: from macpro2019-01.. (c-24-20-225-94.hsd1.or.comcast.net. [24.20.225.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a7edbsm5271795b3a.18.2026.11.17.06.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 06:12:30 -0800 (PST)
From: Nikolas Joshua Britton <nbritton@exabit.io>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com,
	Florent DELAHAYE <kernelorg@undead.fr>,
	Michel-Ekimia <contact@ekimia.fr>,
	Konrad J Hambrick <kjhambrick@gmail.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	=?utf-8?q?Benoit_Gr=C3=A9goire?= <benoitg@coeus.ca>,
	mumblingdrunkard <mumblingdrunkard@protonmail.com>,
	Matt Hansen <2lprbe78@duck.com>,
	Tilman Vaeth <tilman-vaeth@web.de>,
	Christian Homberg <Christianhomberg@gmail.com>,
	mccricardo <mcc.ricardo@gmail.com>,
	bnewell <bnewell@fullaware.com>,
	=?utf-8?q?Bernhard_=C3=9Cbelacker?= <bernhardu@mailbox.org>,
	Ton Gur <kvantorrr@mail.ru>,
	Alessandro <sandro.it@gmail.com>,
	Pedro Rodrigues <pedro.pfxr@gmail.com>,
	Amaury TC <amaurytc@gmail.com>,
	crysman <crysman@seznam.cz>,
	Moataz <Moataz.zakaria@gmail.com>,
	wilk <j.cubizolles@free.fr>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bradley Morgan <brads@mainlining.org>,
	Doug Calobrisi <doug@calobrisi.com>,
	Helge Deller <deller@gmx.de>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [RFT] Change E820 memory map handling
Date: Tue, 17 Nov 2026 14:12:29 +0000
Message-ID: <20261117141229.11971-1-nbritton@exabit.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110-superm1-genoa-mess-v1-0-bdcb3a6f2463@kernel.org>
References: <20261110-superm1-genoa-mess-v1-0-bdcb3a6f2463@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 10 Nov 2026, Mario Limonciello (AMD) wrote:
> Here is the flow I would like to see:
>  1. Test 7.4-rc2 (vanilla - no changes please)
>  2. Test this branch (superm1/genoa-mess)
>  3. If this branch fails, please revert this commit from the branch and test again.
>     commit 35c9c60ea8c1c ("Revert "x86/PCI: Add E820 quirks for Clevo NL4XLU and Lenovo Yoga C940"")
>
> In all cases please check whether your original issue exists and comment if it does.

I tested on the Mac Pro 7,1 from my bridge window report [1]: two Radeon
Pro Vega II Duo cards, four Vega 20 dies behind two root ports, BAR0
resized to 32G on every die. Both kernels were built from the same
.config.

1. v7.4-rc2: the original issue exists. Both root port windows stay at
   32770M, the second die's branch (08:10.0 and 16:10.0) gets no
   prefetchable window, and 0e:00.0 and 1c:00.0 are left without BARs:

  pci 0000:0e:00.0: BAR 0 [mem size 0x800000000 64bit pref]: can't assign; no space
  pci 0000:0e:00.0: BAR 2 [mem size 0x00200000 64bit pref]: can't assign; no space

2. superm1/genoa-mess (35c9c60ea8c1): the original issue is gone. Every
   BAR is assigned, both root port windows are 96G, and all four dies
   get their 32G BAR0. The layout is identical to the one I reported
   for v5 on v7.2.15 [2]. The first root port:

  pci 0000:06:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:07:00.0: bridge window [mem 0x9e800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:08:08.0: bridge window [mem 0x9f7ffe00000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:08:10.0: bridge window [mem 0x9e800000000-0x9f0001fffff 64bit pref]: assigned
  pci 0000:0b:00.0: BAR 0 [mem 0x9f800000000-0x9ffffffffff 64bit pref]: assigned
  pci 0000:0b:00.0: BAR 2 [mem 0x9f7ffe00000-0x9f7ffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 0 [mem 0x9e800000000-0x9efffffffff 64bit pref]: assigned
  pci 0000:0e:00.0: BAR 2 [mem 0x9f000000000-0x9f0001fffff 64bit pref]: assigned

   amdgpu binds all four dies, and compute and peer-to-peer transfers
   across them work.

3. Not needed, since the branch works.

As for E820 itself, 07eab0901ede removes a single descriptor on this
machine:

  efi: Remove mem126: MMIO range=[0x60000000-0x600fffff] (1MB) from e820 map

That is the first 1MB of ECAM (0x60000000-0x6fffffff), below all host
bridge windows. On the branch the line is gone and /proc/iomem keeps
5e000000-600fffff as Reserved. The firmware is dated 2026, so both
kernels print "PCI: Ignoring E820 reservations for host bridge windows"
and the restored entry could not clip a window here anyway. Apart from
the efi/e820 lines and what follows from the BAR assignment (amdgpu
binding two more dies), the kernel logs of the two boots do not differ.

Also, the boot failure on v7.3 and later that I mentioned in the v5
thread does not reproduce with v7.4-rc2, so both kernels here are
plain upstream. It does not reproduce with Ubuntu 26.10's 7.3.0-10
kernel either, and I have since tested v5 on that kernel as well.
Unpatched, it shows the original issue (two of the four dies without
BARs). With the 14 patches applied (they apply without fuzz and need no
prerequisites on 7.3), all four dies get their BARs with the same
layout as above, and a multi-hour inference benchmark across the four
dies showed no regression against our reference runs.

Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>

[1] https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exabit.io/
[2] https://lore.kernel.org/linux-pci/20261106152642.23118-1-nbritton@exabit.io/
