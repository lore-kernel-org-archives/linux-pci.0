Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672483;
	b=0pZEQY8RL5KxsOgSi15mlzGWWs6QaBDwxAuab5L+PLztj6k9UGN9P5VIWiQsELoXJVKy
	 3Gm7oP+mlvsnLEQyLPCAAAjJ8tij7fofIUG/BQgl1oT4EPORr+vdvM1D9gfZ+Rja0vBxw
	 Z8/S7v7721srnVpCJGL6Uns9jCaM2eu9mdyXS4kHc2eFY8pvrjxGg07UAR3cLjr1+7zmp
	 fMdJ6tHbcF6Cg5vnVyraO7DBTKnVsDWnhr08jBRHWwAXiMNTOYK8g5SjZmQtaAwQD3biC
	 G2jblQ6QtDNK8Y4dfCHEGjuhTXZWCmivYiKJ83CZPZ4ToDGoysHrOfWdRHFN+S8xgSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
	b=yg1uS/Ff0N48GGBJQ+e1OaGlVm5bnJDufK4OrRtGe4uX5R67MVpb8XyQvXJkheA5zOK6
	 7dlgPuZAfvh4RKEa64Uor9TR2vT9ygeEaq91jp7fZxv6tMCCePuvsOLvH28unIpaFWTuS
	 DleDXNw0VQ/N5WNjDo6f01QNvOO5mlV57Prv4TTgtDA+yFQFZtgEWodkMwj261lZ6yWbo
	 B5iRJahKBt9kEUDrRUIxQulHsTqFsz2rJo0aVqlFKCFd8kdsiZOHJewmtvPzg2/KmUZc6
	 9sx+xqZMzWMKAWp2mCbcPFrhhliH6q9lLaNo8mMoLir7hFIy7MdYgSOch/mswSYZz9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvgdC3Sl;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A271606A333
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A271606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YvgdC3Sl
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so5973892eec.0
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794672482; x=1795277282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
        b=YvgdC3Sl06c5qLDneQThCyVbVmbW7zoeqyvL5D+M9KKgFoajBZBXSK2EMmrk4NOG5/
         yvCl310GqDC9LZ6ED1jLwce1aFeAYkqot15Ff+om0sICZ+/ru8OO2oAxXEX7FZT/CLJ7
         kJQlcF8QPJ9SWXmcWxwE4RYDY2gPEvz/d8fziBPsWfzIgBmPR2GfapD6ZvUAAFOJ4oPP
         VTBNjN8L8aoROkNbxvOIQOuEWMDLMq2Q2aWbJiAi7O2q6x76vqYz694Le0MwKGktxtxc
         zUw9Z7iDKhiY+1WIkYYBCO23zCaOAbuZkd0vh7eAAbi/Y19F2AJ9seTO/HiA9AmWm7nZ
         QeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794672482; x=1795277282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=547AYHesvWuVRdGCIewRd+N2Li/XBFq8XpI3l0Qzhfk=;
        b=RjTUzdX8nAiXbjCofAcgqS8kZIAcXquRbMqprfj1ZseTd0W/sTAY9/9YgZMQEcj64z
         rSogYiP44+lJTcFFdt+apezR1B6MWvf5GBsuG1hQ7wdwb5JNLqACAKQgPh7Cycq2H2u6
         8/4GTiRylSoJKntYDgWhvaydiaTy6iKcULnoLhVBjNgDa3uADszd0UDEyoeOr9aHIgwF
         K9+LSzXwJ1Fj4llISwv4QlN8C8sLncmepgfSwBVW0cOaWvOGhmMm5fttQD2KZEByxkZ+
         t6iKU9iyv8AqGh2xJdmM6yNsd6wk7jBdlDtWmITOPhUh8qZH2Jc9Gagz7YBgHNH06exg
         uzKw==
X-Forwarded-Encrypted: i=1; AL+hErFUxaR2jYL1n29ydh+7tZHhac98XjRq4ZF5wKS909q4KgNJXTGRLPa25nhwr+fLb6+9qQ4zXmCRKrw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4mdzpPa6ErOUaOQbT4sJuZp/T6CSyrOu+mrXF+xGhdVvIE8zN
	yhMnqUTTLhbX7fHUwukhEP+3bHnAkB0atYcunmKburHYi0xdRGqZCfA=
X-Gm-Gg: AYBFou1UzPzvkxLSZLrOoC2lsyMaItzfvISsvhHBQ/VD5pC/hiGkBOOe64EWJ68YVcf
	hhWmd7TRgTlG6b6jBkVlH6VntJ64rrs6GwEqXHInIyZDi04rgqLfSotApxeP2payO4ejmrPZsTb
	xSCLmr6BbMx9hxRnbMLv7gslpbdVeMvbniOd3P7XSruQIau00w2RGXPXmyR38j4bGBhhuJeHqm+
	fCniSbxSIWiMrijvO3c9lp2AQ7DjfLw5BnYPiE79uG/iWOM52wA84qWPXI8WdUWMTxEurNgoyVk
	1Nbbw96vlJC9ZIIzi68Bu9ZW1Uyvmm3m+N6OmbO3kF4MY8Xwx37xHHLyuASGIyXh28rUT/JSGGz
	V9UOV5ZzDUCmBXaO6OTStDcPwEs+2egVGNPh4BJ3Y7KMAzYLCcl8W5eh9FBNdgqKcJ0GRyGjrb6
	4KZKKq+TjHtBRwjfyPTi/FUbAGx9M/+1oAf3S00i/ZoHwXpiNWYyn3RlQKlXM/0BJp+/AspwVe4
	KJ2vG5boA0ui1DLoKu6gwVa2O6UV2pHnbF50P4lUqnBTaDlfMJ3oVEKXfvnNyNIWVgmYNdcZdUg
	oHGjuhhE7DdqXCzHjR8mtjH5P9Wn5eJvhEtcsQOF1h2EYtPngdXYXuNnWq2bp/belQ==
X-Received: by 2002:a05:693c:8212:b0:36f:550f:bb0d with SMTP id 5a478bee46e88-37963953f17mr6197803eec.5.1794672482123;
        Sat, 14 Nov 2026 08:08:02 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.127.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0919sm17567582eec.29.2026.11.14.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:08:01 -0800 (PST)
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
Subject: [PATCH v2 00/12] Fixes for apple-gmux and runtime support
Date: Sat, 14 Nov 2026 11:06:24 -0500
Message-ID: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
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

Changes in v2:
- Check the discrete pdev config before GFX0 restore (01/13)
- Don't save bridges state when state is VGA_SWITCHEROO_OFF (01/13)
- Fixes discrete_pdev initialization (01/13)
- Used PWRD on 15,1 and 15,3 aswell
- Add quirk to 0x7360 PCI id aswell (02/13)
- Add 15,1 and 15,3 and its gpu's aswell
- Removed ignore_access code (02/13)
- Initialized val in read functions (03/13)
- Fixed permanent mutex block on failure (03/13)
- Only resumed when pm_runtime is available (skipping on iMacs) (04/13)
- Corrected ordering of interrupt_work (04/13)
- Notified drm about hotplug change (04/13)
- Checked if EFI_RT_SUPPORTED_SET_VARIABLE is available before writing
  gpu-active (05/13)
- Wrote gpu-active on shutdown aswell (05/13)
- Dropped boot-gpu parameter (06/13)
- Checked if vga_switcheroo has been initialized (09/13)
- Added additional pci_is_thunderbolt_attached check to
  amdgpu_device_supports_gmux (09/13)
- Removed duplicate check (10/13)
- Renamed gmux_off to runpm_active
- Checked if adev->dev exists in dm_dp_aux_transfer to fix null ptr
  deref (11/13)
- Removed GMUX specific code (12/13)
- Initialized edp_sink_present in testing code (13/13)

Link to v1:
https://lore.kernel.org/all/20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com/

Andre Eikmeyer (6):
  platform/apple-gmux: Write switch state to EFI on MMIO devices
  drm/amdgpu: Add Apple GMUX runtime PM support
  drm/amdgpu: Catch register access while GMUX keeps the GPU off
  drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off
  drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended
  drm/amd/display: Skip panel power savings on eDP links without a panel

Atharva Tiwari (6):
  platform/apple-gmux: Fix power for MMIO systems
  PCI: Disable pcie port on specific amd devices
  platform/apple-gmux: Fix MMIO interface
  platform/apple-gmux: Fix Interrupts for MMIO systems
  platform/apple-gmux: Add check to detect FSS
  platform/apple-gmux: Add documentation about iMacs

 arch/x86/pci/fixup.c                          |  43 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  61 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  48 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_reg_access.c    |  24 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   3 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  19 +-
 .../tests/amdgpu_dm_backlight_test.c          |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   1 +
 drivers/pci/pcie/portdrv.c                    |   2 +-
 drivers/platform/x86/Kconfig                  |   1 +
 drivers/platform/x86/apple-gmux.c             | 365 +++++++++++++++---
 include/linux/apple-gmux.h                    |   1 +
 include/linux/pci.h                           |   1 +
 16 files changed, 534 insertions(+), 72 deletions(-)

-- 
2.55.0

