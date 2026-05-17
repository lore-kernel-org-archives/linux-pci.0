Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4A37B3FE
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023078; cv=none; b=X1PZ9kembiTrPGoiJTVZaH6b60hDaoYjRBRS1okdCOKohcncStcQT0n0nlZ78rKwJVI1XBNC3LIs/yd3wOdHmFgOQwzagbUOc8bO0UOrmAdHPC9eS439TJyjMDJb0qm4SfLhJdE1mqwhHGlwoTFFep9FVdrMPE8L6J47WSLani0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023078; c=relaxed/simple;
	bh=LeWHHqCWtRB6/iOFzUEGlxNN/mbW1NUBtdf1HtpuOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nGvJLGaGhAwhstFLlyzGDIu7SDbNkfRpD9fJUFR3Qe1lHUWSFKqAG7DbDiRTkeQqGMk05zbisuoX6rp7fw/yegAbTV7V3aadpj7wimDuYnWyyp8FeyEDulQZPZy4D8ASmb/PoBYBaej51xVcVTquKfbJ/xXLNKM7TLFpfw5JCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI3IXRyF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI3IXRyF"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so1213682a91.2
        for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779023062; x=1779627862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmrD4XCw/ddiD1eD+XE4KxmCSjyDbYSOCXwkAExthfA=;
        b=KI3IXRyFIToM1BOabyqiJXZANtjQirFVaVz9VJPHyxWo6dBbqtfnNR78d7kmpz45Wa
         mobSq+A+ZwugG184a5IK6RoJ+T18iNaEvnOWcB5JJ9XJ8mJGG+gEvpXHZET1oA8uaiUM
         Ktxt57oqZp8kBCDkS5w7wke+34eC77LMIoDvmXUVxMaP6ONZRA9CxCXopZO+RUCSSYNN
         YleCpuRh5Bo0L8e0NH4w2dEg+y3h7ixHKfDkolY0rVAFv2em3nWHPm5LMf4FzjOuLs9p
         QqLKpXdfAMO56q9c7yRfpry+APnNq0xnhAz3C5+ZBLRJdqS8IKhuEwx8XFVqRafxVt5K
         +jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779023062; x=1779627862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmrD4XCw/ddiD1eD+XE4KxmCSjyDbYSOCXwkAExthfA=;
        b=ZCtGnTTjVM9WjO5ESxFk9DNhLMKxtKFZdJ6snr1vcBSFo/BLY9M4GvgRABsZPXckSL
         n2Kg8QoQYSBAlDnk+vu43E+gvjNBHN0emc7EIhtG7DfQZ0Gkb/IxSaDo7bUN43Yu0+Sv
         cvodgMTcot941myy9DNeGT4VfLhzvRcjjm9TC7d5FVHpBBPzSnoKnSL9YVlDCMCGsoiI
         oemURNCZUnc+eSTAsyujq+pWB0HCz8RLKBFvydXAOGxSLTvQ+KbwV+HsdQhayBt1kemE
         ElDzdL5hoqHIN/F3iCQP97s+vuzr0tRqjU31KzHMC7JDpUlwPwKIdyS794oYx0zOudg4
         u2yg==
X-Forwarded-Encrypted: i=1; AFNElJ9bu9qNk7xT4MTwUImozJ0zzKqn12IHashqD91Re4srJfiAFIMUf0S5Wui9DWXew546zxojUCPwlDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gxEloGHX0wtZ6cYBQxED1fLy7BcA+1Naurs412PPmKmZpCB2
	adCCfLWu1/yDEdlkYeA/lgWPrxHIYlfXWeAOkhjEJwBnhPVNwedevQKZ
X-Gm-Gg: Acq92OFBRYe4BEVm0zXTbfNe+sTxN7Qsmb/D+h40JrvbDpwunFLfPXP3KnaEr5hSPB3
	oDCIOdYDAEcJnPoGNXN++b+R96EqVrlgtO7ngsxqrJyJbptWIDCMDJ14WNgZEn/VHpu6Woh7ZCs
	9W4QZCgQneLxMCCv4kFIos7P+we786cpB+J+cC12y3+w5T/nprhzw50ZtEv9nVTBdf4TuS/qHrU
	ErDW+SeXiTiT9H8FSiEENU1lfCcChsQfOlXEGVmAHoAaifiNn51zycy1w8ADhjru/fmRN1NzKoz
	j35Z7MfA3BWZzLrZDsxNrSE21pS2XC70kW5MdutlDFc00NvDHfaZDjNThACO1LFgvWWo31Zr2hL
	K2OQ501VRT0vCQ8L48IZbkn/PrEEinJVyYhFDCkcJg2TfUDdatDftGGvb2x+axCPi9hRqZB79lx
	6cnDRcIgujvgIxQV+5cteIaw==
X-Received: by 2002:a05:6a21:3386:b0:39f:794f:94d8 with SMTP id adf61e73a8af0-3b22ec9aecemr12673319637.29.1779023062153;
        Sun, 17 May 2026 06:04:22 -0700 (PDT)
Received: from mincom1 ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c77822sm11712607b3a.41.2026.05.17.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:04:21 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH v6 0/2] AMD Promontory 21 xHCI temperature sensor support
Date: Sun, 17 May 2026 22:04:05 +0900
Message-ID: <20260517130407.795157-1-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds temperature monitoring for AMD Promontory 21 (PROM21)
xHCI PCI functions.

Patch 1 adds a small PROM21-specific xHCI PCI glue driver. USB host
operation is delegated to the common xhci-pci code, while the PROM21 glue
publishes an auxiliary device for optional sensor support.

Patch 2 adds an auxiliary-bus hwmon driver that binds to that auxiliary
device and exposes the PROM21 xHCI temperature value as temp1_input.

The hwmon driver reads the sensor through a vendor index/data register pair
in the xHCI PCI MMIO BAR. It does not wake the parent PCI device for hwmon
reads; if the parent is suspended, the read returns -ENODATA.

Changes in v6:
- Make USB_XHCI_PCI_PROM21 a hidden tristate that follows USB_XHCI_PCI,
  so the PROM21 PCI glue is built in with a built-in xhci-pci core and
  built as a module with a modular xhci-pci core.
- Use an IDA-allocated auxiliary device id instead of encoding the PCI
  domain/BDF into the auxiliary id.
- Use a 32-bit read for the PROM21 vendor data register and mask the low
  byte instead of using readb().

Jihong Min (2):
  usb: xhci-pci: add AMD Promontory 21 PCI glue
  hwmon: add AMD Promontory 21 xHCI temperature sensor support

 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/prom21-xhci.rst           | 101 ++++++++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/prom21-xhci.c                   | 239 ++++++++++++++++++
 drivers/usb/host/Kconfig                      |   7 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-pci-prom21.c            | 136 ++++++++++
 drivers/usb/host/xhci-pci.c                   |  11 +
 drivers/usb/host/xhci-pci.h                   |   3 +
 include/linux/platform_data/usb-xhci-prom21.h |  22 ++
 11 files changed, 532 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-xhci.rst
 create mode 100644 drivers/hwmon/prom21-xhci.c
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c
 create mode 100644 include/linux/platform_data/usb-xhci-prom21.h

-- 
2.53.0
