Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86171263F44
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315279; cv=none; b=Mpeg/xkzTm65NLXq9YXHaAHKY80IjMpiuOeeQ+x1cp1y8FLeBoJJAxO8Wpc5HI3utNSpxkW9XRVmuBLPKsnkfIo+mPZT3SOW8bTlT/Sw51nDxVjz13azbN9sY+VrH279aYMlX2DwV3TIiYc4HjyA73reuPApLfjPxB9S4GyEqLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315279; c=relaxed/simple;
	bh=1UCIQAMaTfESmQmryakYLGh5ALkY+Rp7DT+TZUGcZKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GN6Q2qEcyfwJ4JO3wBdPNC1W7G0ERcx8DdAZG3HrSvuJ8iQ3JH2ntPDBJNA75ZJc5KLFK2MmU0QaJkfRFbtlr0+9Vya15/2DXLdNBP/aNbSscfed/IgUgpNWYfEl08b9bB9wRWU5uUzKwtQjgxlb5prhYlGjbYe1n0bYbjwBArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdRFFhAb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdRFFhAb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483770e0b25so33221775e9.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315277; x=1771920077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLI1c+BVCTXh+QgGz9la+7RtF/6HCUTH3kkMfNUqGzw=;
        b=RdRFFhAb5fdirRQqxSGbijNEdqTvfEJYAN5lpEuaQAYmq4Kh6+XrvehyPicFspCI/S
         BgiLIpgGlMfikp5k6DMARk1qdx9Wj6+8fTV61NItkrIexERsFCcITOiRK1VBmSq6VQqU
         VUsKjQayqc+hkUU5ceXM+H+kV4rNRy/jR5CQBx359c26GSbat9KbrsIAGEA+8bmf3oWl
         Pzj75wRSbezyx+jfLR+O/CNw8AESF5sqWVONEBAnaPfsYPAyC/+Nd+ZyDsitUJIyjUgp
         yPCmCpEKspal1EKQC+syf/ycqTMrRuOYKnGQvo4jJYrhPZvz4/7d08yUyB2a9d9uFtPa
         v7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315277; x=1771920077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLI1c+BVCTXh+QgGz9la+7RtF/6HCUTH3kkMfNUqGzw=;
        b=NIVMbweu92pyW4ajr5iTYVHonon2/CT7JYH/YLne8y+TIN0rIJdl2ELknK6pZIiwZq
         OR+C0VK3LIinP7Vlf2Uu5o8ETO3yO8f3MeGqipYOBABUWvI6kNpGXIJd3tayk0JCYdHb
         b5QyMlIDWK2vkdL2uvDvNYZDCdoPsK8hXZereK5iMsFRDjFUCgmZu6/Kjs2nqVBH6OCu
         SBOYzUevGw65M5LX8M2VMb32+HY4ZQVVfr7PqsbAl9gD6m+GWPjeW6icfb9rZGHlNhH1
         OLI7SfIGynDrFkz2+HRvg00yZIP/kuzYws3ihBBfPJdT+29VLh4zcGG7sMml0X352oS2
         sZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipz5MMwUSRVAiaqm/t9VzFiwVmBG/7RGbPOWdIrip2mfLY++OwdEx9tOxnZIo5MIj/yrrhIIdzSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjIUpis4IRz8mgJgY4En0M5SjsOpKtxfuJ4K3WhnWOgdeSZCn
	JT1COkwY/dobI3IiCsX4qSigUDtS54zVuy4GEA3pmQwStr5tMsLwS1xb
X-Gm-Gg: AZuq6aIrczwPbEh9hynG7RzrggNuhG4JezRuAjVwjWvcT+eox/8QKPQTX1Wb6k1r1gk
	12/I0zc9Y2PMX1zTRfo0Yk0GWVz/Bb/rP8vLYP9FqwJQngHGueSf9Be+PBjc+RR/v0z2A94MNd1
	ch9g04t2J32wFdoSUuqY+uO+UcAzU6QEsx6AExjzLssSSQkB6skbV8JjN1E75yH5VgRLxnOi8Re
	wVccgfxMi28y6I28JwWMOhEOc7G59shNzctrV/ZZYD8tpZNwvQIOQ4+wOLxI8tm5AxPGyW6l9UP
	cZc9tVbLaA1gtdLet6LuIiD5RC1ygVtZRP83Bs4v0TbgXUdW1DCjxQ3SFuAo6Xr1QEnjj2x+ZIF
	yhSvcG7hImtmy1YvHGwWBo+4pzHSv31FwiLtyl10v+7gjIrsz0aoJSyr5Y6tbhbyHCHTWzyY6+c
	1RQqomlP8DCL9nETVk4PZJOKSdv4AJa0huXepoYz4d99bjc/eb88RAIMHah2o=
X-Received: by 2002:a05:600c:474e:b0:479:3a86:dc1f with SMTP id 5b1f17b1804b1-4837109740amr239415095e9.37.1771315276687;
        Tue, 17 Feb 2026 00:01:16 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:16 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ionut Nechita <sunlightlinux@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [RFC PATCH 0/3] PCI: Add PCIe Gen 7 (128 GT/s) speed support
Date: Tue, 17 Feb 2026 10:00:56 +0200
Message-ID: <20260217080102.206581-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut_n2001@yahoo.com>

This RFC series adds initial kernel support for PCIe Gen 7 128 GT/s
link speed, following the same pattern used for Gen 6 (64 GT/s).

PCIe Gen 7 doubles the per-lane data rate to 128 GT/s using PAM4
signaling with mandatory Flit mode encoding (1:1, no overhead),
providing up to 256 GB/s unidirectional (512 GB/s bi-directional)
bandwidth on an x16 link. The specification was announced by PCI-SIG
in 2022 and targeted for member release in 2025.

The series covers:

  Patch 1: UAPI register definitions (LNKCAP, LNKCAP2, LNKCTL2) and
           pci_bus_speed enum. Widens supported_speeds from u8 to u16
           to accommodate the expanded Supported Link Speeds Vector.

  Patch 2: Core PCI infrastructure - speed detection macros, bandwidth
           calculation with 1:1 Flit mode encoding, link speed table,
           display string, and a pcie_speed_requires_flit() helper
           with Flit mode diagnostic warning for Gen 6+ speeds.

  Patch 3: Subsystem updates for bandwidth control (bwctrl), port
           driver, and PCIe thermal cooling.

Not included in this series (not yet defined in the specification):
  - Equalization presets for 128 GT/s (PCI_EXT_CAP_ID_PL_128GT)
  - DesignWare controller preset programming for Gen 7

This is marked as RFC since no PCIe Gen 7 hardware exists yet to
validate the implementation. The register encoding values (LNKCAP
SLS=0x7, LNKCAP2 SLS bit 6, LNKCTL2 TLS=0x7) follow the sequential
pattern established by prior generations and are subject to change
when the final specification is published.

Tested: compile-tested only (no hardware available).

Ionut Nechita (3):
  PCI: Add PCIe Gen 7 (128 GT/s) register and speed definitions
  PCI: Add PCIe Gen 7 (128 GT/s) speed detection and reporting
  PCI: Update bandwidth control and thermal cooling for Gen 7 (128 GT/s)

 drivers/pci/pci.c              |  7 +++++--
 drivers/pci/pci.h              | 28 ++++++++++++++++++++++------
 drivers/pci/pcie/bwctrl.c      |  7 ++++---
 drivers/pci/pcie/portdrv.c     |  2 +-
 drivers/pci/probe.c            |  3 ++-
 drivers/thermal/pcie_cooling.c |  1 +
 include/linux/pci.h            |  3 ++-
 include/uapi/linux/pci_regs.h  |  3 +++
 8 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.53.0

