Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5F4BB274
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495818; cv=none; b=Bj4glTikPld9Bap63qUVLYEFZUjYLwNCJvi43++T9+Z3bw9wsbx6UKkfdCx/MCltodPb5o+GKOi5/wonynpifJNheddLQK+3zoKQvn2SqLPZaOt29Ys3VV3UHnD+ri23q6OUJqbSHuHUGNRe0cRhiu969lv6bgoSXGts4mWMc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495818; c=relaxed/simple;
	bh=z8HNl0xymtC9OMb9m4yWES1OaOT9HUEDb8ymvvRc7Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbD5oq+/O1MpzYG5MOLaGUf9EFSKgLwTSnSaA3o0XpNdXyVIjSfFafqxUwd80gTWWnPId+mns5hNxM3dIiqPVReN+dizpG37lpJlEpDiVxUKwdCMjS1A33+kTNIBNvlthP3pH9vGBYd+dZjDpGlSi2t8Mn3x5P+NqwOyKeq4gBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=SzCA8IUm; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="SzCA8IUm"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c9ff1fso8405185a.2
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789495812; x=1790100612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=22xfVV5hCviOiMQtMKw9vaS9SNxAHQv+tM1KVgQ9uIM=;
        b=SzCA8IUmoQ9ZYG85USPg8wdsLibCOnCyr919jnxtJLMNW1VS0NgN0V0WGA1QODzXxt
         3+Nh5zRpDiS9gQwHs9zIGK69Eukdve095ubRQWxBTKxvlHeBQ6CMzBANGqeDuVjlxrYJ
         ERG25Fs6Ls1y3HVQ9OYD+OhD7zcPkrs0DTgHcSgsqxZBVeHAJiYxF+ztGHpo8V1vOnQM
         Q7OPuNuxm2Enj753hB19YdLKuqRfMlan26zciN21qhAT9bb5/CNXQDtk3+j/HMLo87PC
         6yc5MrC1oIszqvn2FB7RXhohWGxC54Mr5C+uOtSYZm7aUCY9yRMeDo572BTCmTnuerQo
         +LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789495812; x=1790100612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=22xfVV5hCviOiMQtMKw9vaS9SNxAHQv+tM1KVgQ9uIM=;
        b=jaWtltY6DDI4nCTuXT8Yg/NHwILIZgPU1dYcUu4xwihE814AgWBxzCKNApyu+ZHr1V
         d1qNIy6zj+yTrb3qe0rh4N+KAXBNkOTRgsX54P83Yb/d98b7F0CETsH3B4SRj2anVANV
         YN1sSVl32EsutjWxHDdfT/crywNZu1L6CaKp8Id+DaTGtLjPGfrvfX1ziDqixTwKqxWR
         Tu/5p7il9+FKuOHCOP3MSAelgJOghBnu5+bGu7wYpEUjuBxqbsaa5s4UIiyFsDT7oXmL
         NT/1NH+oOy//9ai53n8oY+Zg2c+W1jLF2QvnCRn7LDZTlLYct4YGuUm96oZD49IbI1hz
         bz3Q==
X-Forwarded-Encrypted: i=1; AKwUvByORNjF5nnFMbv9lSUD3XA1NVgBWuMDbzraAN/pBl6pTcw3hBHHHNFmoXmSm+dRVJaTovoviml2e1I=@vger.kernel.org
X-Gm-Message-State: AFuF++mqkqhx3d/hh3EVSHsk1gCObQZZa8RGbYzctmx3o6N91oqlZH/B
	9cJfYAGSR4rrSDmaUWbgTDhFTM0V8ltRVBzE8t0TH7yEXU0Q+2OsjZvpbOys71b6jBk=
X-Gm-Gg: AYBFou0hNvLfUQaphnvpmsjG5ji7XdhqW2YDoG5uPzXhfHO/rufVcuxidJhf1liyOzu
	Tswf+61toMpAXbizTDkevgdDMDT8FAAlRK06PNgxgJP+Z5CPjRF6fGpjTWsumlIhcy89rlPPKoU
	ixeBQ1odA9FDM0Qhh+bMTTBM2bwW+GIBc9SKp8V2P5AH0PdJhQRtLMo9/Lbcun9hXYVbKRWjZMZ
	1WRKdvySjZj7+LEbZX3NFfpkabhms/ny8O2UVG9NGYEXckgyIUHousj1SPC7QiaxvE5ueVqW8bV
	+05R7k7XMlcBRsGy0VgEgHTO0kdlv+8wQh+xYlNussYeqARPi/ffaYdSqjFFUw73fGYgYQwdGXk
	jeILdmWBoo3MFNlxXeh40dTkVP8BARLSGmkkIPtoFY646dGV+4yTY/jsUFEZrgdkfkC5tieTl78
	Jghk+G7Cm9LwoPzxvKroGokcDITSCk09Ham7A8csZe2TkE6e9frlZYvAeCdauBuQhA4QE7NAR1I
	vs=
X-Received: by 2002:a05:620a:2809:b0:939:5ab4:e6ab with SMTP id af79cd13be357-93a40752e39mr312131285a.5.1789495807276;
        Tue, 15 Sep 2026 11:10:07 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b7824f72fsm14648485a.28.2026.09.15.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:10:06 -0700 (PDT)
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
Subject: [PATCH v3 0/3] PCI: introduce TC9564 misc driver
Date: Tue, 15 Sep 2026 13:09:59 -0500
Message-ID: <20260915181003.1633543-1-elder@riscstar.com>
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

This version of the series was sent quickly after version 2, to just
address some very simple Sashiko-reported observations before others
had a chance to comment.

					-Alex

Note: to work correctly, this series depends on this:
  https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/

Between version 2 and version 3:
  - Call of_platform_depopulate() if case of_platform_populate() returns
    an error in tc9564_function_probe()
  - Eliminated an unnecessary dependency in the Kconfig file
  - Updated "parent addresses" in the DTS file
  - Fixed a dumb typo in the binding
  - Note:
      - Ignoring the Sashiko report about the place holder ranges
        possibly not being updated at runtime.  (The above-mentioned
        prerequisite series will cause them to be updated.)
      - Ignoring the Sashiko report that the pci-ep-bus nodes should
        include a reg property that matches the node's unit number.

Version 2 is available here:
  https://lore.kernel.org/lkml/20260915031038.1087264-1-elder@riscstar.com/

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
 drivers/misc/Kconfig                          |   9 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/tc9564-pci.c                     |  84 ++++++++++
 drivers/pci/quirks.c                          |   1 +
 7 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
 create mode 100644 drivers/misc/tc9564-pci.c


base-commit: 27b3028b7d65cbc44fc5b60d2e977ce55cf186f1
-- 
2.53.0

