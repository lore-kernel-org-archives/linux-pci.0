Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FB213254
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441846; cv=none; b=rYt++ZIy/QkCYt6Eb1+4BRL3ZDKibvdFzk/I4Mf/E9Bka6A8e81U7X7Rr77GiP0E/srzl8bkkeVp2mItSVNzer/08NhBSCBu6bt50fb8wVDwPNjHncRsoTieoDDdjCWlWl16DNaioZHBYdyYo2xo4STH+ILXIYZ8f3D67Wygiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441846; c=relaxed/simple;
	bh=f7Iqm23CyhCZNlQSgebFwaEFnlASpLDGTdD+2Mkgv+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hv9xqxUWKsIiKu42Ftw63lJqFjuRLe1nke4tpa1pGw2oV8j/hzQ9v3HSLmJ0f3uOg89bjRrI0yjiLb91UHUnARZDrt10kb1oC+OmDHHIB8pTseDiVOREI5HQvBZkX3K2pTr1pd0h+83n7Q03Tfth5QVD9stTvuVC1YHp4iWmOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Aqct1f6s; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Aqct1f6s"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76c9df1so35856271cf.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789441842; x=1790046642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YKF9FJ3sfZcV6ZcqIr7QU8JMz0GcZ7UOcl6ndWiktF8=;
        b=Aqct1f6sH9d1/GpE3gqjmQYrRSIij4gsXYiEUWF4QZIYa8YmmUWqqw0zFKn3q1E5Ns
         hHff7zcaWFDTNzq3vmlxax6FJu0JebP7XQDRzcbmafCHdxEGiGfp7AMp4jWt8P8VNJF3
         JeLbodxr1j7nKoNS75lbXaXb2WCApj1gBb6JMEMUjNsdO64PyZQoQ70Q017qHrEhQUw1
         +c8eKQ03JWKMOo1PB0CmMs6HPin0fVrJGEi+Z7MYm7Fhz+GY7AC8RaLspwMsj/P27D0p
         W6YLSfQaj58riIqnqQlM3YCJYz/lgsMjrTazIUFjUYbetBLJ/hidhwRgVaDd03qMGD4O
         bxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789441842; x=1790046642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YKF9FJ3sfZcV6ZcqIr7QU8JMz0GcZ7UOcl6ndWiktF8=;
        b=yxx5GYJnyimuXhjuZhYWwIP9J7EvcDc2Crzf7Ov8Ndz3kl1j68PCXmgSLYRRxWqDID
         b4PwCQYmL4HAoPn7a6tC93392G1ExpBZZNUGeuCuzuiCTewBYOeryAbqA67e2115UOvG
         egtvc8/9LVaVexZerJIimVlKk2azhBWmR4Za8LRtjZiTFyPdk2bRU+79Oow3fxcyDz2A
         LaH6WTBp3mdgVc2716P9DWarUvnHis3TNQ/32C90xZnH+oNltf1ei4waDpB2tNNd57n2
         s5vB/CeCp20RuD44y8tJ0655hkPlVcwykuvVi3qv7TOFPEGXHhtr0aGRUSf4h/w45/Uo
         ocsw==
X-Forwarded-Encrypted: i=1; AKwUvBzUfnDT0LtnV5+rPn79/nic5BzosqvZLU6WZMxf3Kn632z/opbcIBhvjxrZXBPctjxhLVZdyUP0C9Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mqRqdsQU491d2fURq+ZP+osLEUiLzgeUhwfFEPkiQWzHbTQado
	e/9DBBflx+f+ecY+lCdjPjCJZKcoyUXAnhzo+7QdTscGBC3qSavXbY5u/vrb89r64rM=
X-Gm-Gg: AYBFou1nDzosRadmAfeFQkkhIuJQA48UKkzgdUiTnMgjd7OrVBO7mBkN5WDlqGdWEsT
	uO8XqE671+ec/D8/x10eJHPYMp3HbS0/wYF2C42tKRWpq+cHlf2BBIe8LiRtI4/45y23ZFHtHhS
	QCK9sjEUbrKpWgMaZl2OVUFynr1BvPabaa1WIMC0lTMxtuimJdAly7Cdr1dif4eyN7Ld4apyC8e
	PESMRR3wMljgEPoSpp4qd+M7sF2RgfUj4ejrzQ3GzNjH5bw1T44I9EqutIXTeBcBW9LdguDNyhc
	oWvXUwBRIHFEpkhggQMX/EBUqt3Y2IL6P1HbQhz8lh02+UTYoQrWu369RZR+crVbH62r9qZW3He
	YPVOWHdg86MZ8wYK7GPN8AGnwPd2nhwOiC8+OPX9+ZlQ9oF/W3L6D0gKFpXqXUUEtNirq9Mhtxz
	xXLO0ix3VuwhGenlzmRZzwOQHexOW4ErTAHVT7UmOQTqJTt3IFX3xlfvP13Iead31MwnCW6EHlh
	JU=
X-Received: by 2002:a05:622a:2285:b0:530:fe26:50c8 with SMTP id d75a77b69052e-5310d0308c1mr80574991cf.39.1789441842008;
        Mon, 14 Sep 2026 20:10:42 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ce4ec298sm118563841cf.16.2026.09.14.20.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 20:10:41 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org
Cc: daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PCI: introduce TC9564 misc driver
Date: Mon, 14 Sep 2026 22:10:34 -0500
Message-ID: <20260915031038.1087264-1-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Toshiba TC9564 is specialized SoC that implements a PCIe switch as
well as an Ethernet AVB/TSN bridge.  It also implements other functions,
including a reset and clock controller, an address translation unit, and
a few other devices.  PCIe BARs provide access to registers that manage
these IP blocks, and the SoC is modeled using a PCI endpoint bus in
devicetree.  This allows the IP blocks to be bound to platform drivers
using MMIO through the PCI BARs.

This series introduces the simple PCI driver necessary to implement the
PCI endpoint bus.  It enables the device, enables master access, and
then scans the devicetree subnodes to discover any devices defined
within the endpoint buses.

The driver is placed in the "misc" directory, following the practice
of other PCI endpoint bus drivers.

					-Alex

Note: to work correctly, this series depends on this:
  https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/

Between version 1 and version 2:
- Updated the block diagram in the binding to include BAR2 and SRAM
- Use KBUILD_MODNAME for the driver name
- Removed bogus initialization of pci_driver->driver field
- Added the third patch, which defines pci-ep-bus DTS information.
- Now based on the Qualcomm for-next branch

Version 1 is available here:
  https://lore.kernel.org/lkml/20260813222943.1655453-1-elder@riscstar.com/


Alex Elder (3):
  dt-bindings: misc: introduce pci1179,0220.yaml
  misc: tc9564: introduce base PCI driver
  arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses

 .../bindings/misc/pci1179,0220.yaml           | 154 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |  30 ++++
 drivers/misc/Kconfig                          |  10 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/tc9564-pci.c                     |  83 ++++++++++
 drivers/pci/quirks.c                          |   1 +
 7 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
 create mode 100644 drivers/misc/tc9564-pci.c


base-commit: 27b3028b7d65cbc44fc5b60d2e977ce55cf186f1
-- 
2.53.0

