Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900886;
	b=CTV42S75ueRxP6UKmKWqB50UbiTPhW0M+ZSx5Y3aT8pEZ9GqJGusvsgS9OBwbt69QzyS
	 ZjgzV1lKxQCGBFtnGkzkhMsExZEW7i6pNpXa69CuRwaJCj1cIDSNuA9vCEBKQxGSM8m1L
	 2KUV2qzdjKwGBSeZiU3qT7X7bxFFXzuDHxJIIWFZSOqbC36G7xib/zlqpxq68odEFyzPJ
	 6hww8xAjCywK0V/TkpvJVV8O1+3YTYDBNnGCXOpl+k7ZzW7Im+clKJeZog0UGUrJUF2B+
	 puAeXvRFG1nPceQB7USLji3sXijTo8T+yUoSrE3FL0pvlcFq9dN4Yj07yR9gRTgtEOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
	b=M7YE0pLxwzfXiIXjgslXZdn+oxgpMcFEDbsCDuQCVNjalPkgHseKuykbTRuEB8S28XoN
	 b5RpKxMa2emhYOxvsFGzVP7gTl96vOhJW3JKVgQrtCse8rmEh83UGI0sBCIfzgWv12OaR
	 bzfCZj44FyVrNOkE1+kC0J6xY+hvGox3+csCxTg7JxfzXJTuNaPwjrX5hrBUS5ZpMLSX5
	 0As05K2VHUptSF0p2qb2NBLiwOqacSWDyd6ZWAhBD5O4E9Xj3Vn+B1baIkrqWlurD+YcT
	 sNzkuojlwWZ9jL6phpmrKPfAWYrycSoooWy9MNO/IM57dLXS+GMaRr7VuJn5gmdd6bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UcHVUAhj;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D02606A31B
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22D02606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UcHVUAhj
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so3432498c88.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 21:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792900885; x=1793505685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
        b=UcHVUAhjlOgC5vn+r/DfTojBQILIlvC796CCzLjdttaWMezCI1GUNgehXALAKecE1D
         lmPt1BgkKzuiENImuapUnFft0fV54XJWiF12/HPmRCJlppWOGTMrEfXchqp+FiQa4Krh
         rADvqEcrmwAQASEiYlXEQHF/5F/L+6l100i8qytWolKaeMUfyrKBzjW0XDgbKJ/uruB/
         v+O9P8yZIiW5cBlkaRyDAQZwFVxvCodXp81DLNrhAoICsKpe3EYbFFzl75NLCR78rR5y
         3mqPBHwZHkd9x6ZtK1aMrh6mjpJjgXjSu8vBSH646/oA/ugNCgK41C2PQvFKzj3awNmy
         IQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792900885; x=1793505685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lv7p0AUZ948zcVcPc4Q28K28YGEwBExkgg3ueLIutWo=;
        b=kn4PoUtwA+lqkOnflo5p85+pKy+Bevayg4C5GuBbyHLaO/RY71IdLM79V3cQORoU2m
         mjNi07geHNfYHs6zQBD2pc8pvpl6coY/5CPLlgJtdO4TwbgTit0B6GNNYDWBf85Y293A
         Na0mIUHVh9ciiiXMx2ETgvGEiLl8duVhtpgJT7GcRr+/7gGahGPHYUjpw/NZpqLztTc1
         4h/uwII50J2ah0XUodSvzEj8yhlyve0MsCYMN310eyJ5mTllMRzGM78w1SlfDhxQ2Ry1
         1jR+usbTL2yZMR9KWUZMAI1eS5jMcZYYdFaTSxKQ/QiYjcpD/Hai54CbMusWMxHuNi3L
         N2IA==
X-Forwarded-Encrypted: i=1; AKwUvBz5eVT9mLLjSrOVhiamkmvIkDnVUxqZDPzbEzhPaGDOSCC87SRvHf29DOqcgeY2nw2nLBO3sVvmY7o=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpUUowYc54ardX5t4aJlzGi9GeyDDUlWbFMnsNt5rFQpdap68i
	JdhRZ2vb9wGF0n+bXvndv99sVgftO7lzd6y4EhBfQKucCO3T0j54Hjs=
X-Gm-Gg: AYBFou18VMpo4wEE3CFTWz0yEAgn5CqmRJF/iAQJNHy4sDQEwizMT9UjYoCONXxPuZl
	ggIdw6TgrfoQeQ+wbbBazr5Twd9GRFZ2ep1Vplnbi8JvQVk1NaCDgYBGH+iLPjQFH4+HtcSUtjq
	wNkujjwYSxOfyNke157aBh7m76/9gAF5HNERVp1Vt6cLoesGwl2Zr4K7K+ZxzjQ2H5H+U9v7bvs
	uV2wNxysFp6/wpxALpuxPr6pA9IwOBVAbjQ/JW/oRaxXeg0JK2GiuwAnJiBekjuHmj5Hwtm2g4i
	gcY8dNy01+PGz8yVnHSkBuNRQUbV1yMcUq3Hbr+gEfgpA8zYs9qqbuue3UYred+9G8uOKPrzUR1
	XC1Gkt88nn0qgbWTrosl1FEvkwvWLjURUZ8aPslW1/Ae5ba8nXVnVfDK29jtyZOkrkKwNsjndUb
	c0vG7jbhELlp4mSkRiyJ+8rlpGWRqnQgARofneHFLNMvmYUJVwbPOuIli1cfwcU7NNfphrHZ2MU
	iawy2JrPvayBdX9GAhcdKhOFlcVtz5if5R6spbu/1vR+2DfJ2sXJwchFlK8JB2TjEzCrJ5Um64/
	SzCFbJgugF1Rask=
X-Received: by 2002:a05:7022:5f09:b0:15e:6541:3099 with SMTP id a92af1059eb24-19933e10e21mr5393203c88.7.1792900884823;
        Sat, 24 Oct 2026 21:01:24 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.221.76.40])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a32ff780sm11635283c88.22.2026.10.24.21.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 21:01:24 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andre Eikmeyer <dev@deq.rocks>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 00/13] Fixes for apple-gmux and runtime support
Date: Sat, 24 Oct 2026 23:59:36 -0400
Message-ID: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series fixes apple-gmux on T2 Macs (2018-2020):

  - Fix interrupt handling
  - Automatically turn on dGPU when a external monitor connects.
  - Fix base register read/write
  - Fix power handling
  - Improve documentation
  - New module parameter to toggle boot GPU.
  
It also adds vga_switcheroo runtime power management for T2 Macs, built
on gmux power control, so the dGPU is powered off automatically when
idle and users no longer need to toggle it manually.

Andre Eikmeyer (6):
  platform/apple-gmux: Write switch state to EFI on MMIO devices
  drm/amdgpu: Add Apple GMUX runtime PM support
  drm/amdgpu: Catch register access while GMUX keeps the GPU off
  drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
  drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
  drm/amd/display: Skip panel power savings on eDP links without a panel

Atharva Tiwari (7):
  platform/apple-gmux: Fix power for MMIO systems
  PCI: Disable pcie port and access on D3 on specific amd devices
  platform/apple-gmux: Fix MMIO interface
  platform/apple-gmux: Fix Interrupts for MMIO systems
  platform/apple-gmux: Add parameter to configure boot gpu
  platform/apple-gmux: Add check to detect FSS
  platform/apple-gmux: Add documentation about iMacs

 arch/x86/pci/fixup.c                          |  30 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  60 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  45 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    |  24 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/pci/access.c                          |  18 +
 drivers/pci/pcie/portdrv.c                    |   2 +-
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/apple-gmux.c             | 377 ++++++++++++++++--
 include/linux/apple-gmux.h                    |   1 +
 include/linux/pci.h                           |   7 +
 16 files changed, 554 insertions(+), 71 deletions(-)

-- 
2.55.0

