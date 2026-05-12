Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3E38657D
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622024; cv=none; b=QWiCYlDzJN3YS/HxRnjBKVjHqh1Dws3ncU/sN6a1SFtJUAq+MCH7i+n+uQj16UcKF0TUi97SHBymxXaDyPLx0NmHNQ7gcNk6+HBVRb2noCnaKgRYe6XUg9o+PqGcpuG7mvljiVvpXwZm8wdPXhY4sK/FLW4HFMyML4V+4khGjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622024; c=relaxed/simple;
	bh=sTJxJ/xasIqDRCeYM0JtmkGU7hXrTwpbCDass0bVHps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pH4aMTlSg1Qaits9OnQXvSqbsH17LcCsyhHox1QjOla9lNVQX4Zk+ZdMWwrLLUUdtS0hopwugq6/auxT3jwyTYTt0oH0e689Xo+5gWfNkJJRo5pgAiOtqzQJZ9QMg+aJLO7SWGK7n8+MURHM6K+iPRmfj9Qyvkix51R/fG8Ulxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQWdnaij; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQWdnaij"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bccb978bd9so15257985ad.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622022; x=1779226822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuJpPqhDcONg49vri+mgJGghvc2o/ilLGU2ZfssziEI=;
        b=OQWdnaijZ1h7L8r1EP1KKJUSbtDYxqsiw2/0vKLvMvQLdrb9ZVGnOOp2Gbe+jUMvYP
         PVCkgYSFZtaLFcaLWJxW4EL95IZznbDnPWDEsv845ZFoxjpn+JZSxi2ASVX/asrez5N3
         C++ah2Bt+sYUOE4mVfIa3Hiovmzn8uVee1VKr8VwD2DQFKyJ9B/UAWk4wH7g121HrhSb
         9EnoRB2tI4jdGbHrVW1IT0Q6ChG15TTtxdvMgF+15GAdv/tyoXrKB+reAvow7lj5cgx0
         e9IzOSlonqDlYRfOaIVga0qdurXUtBxkpjQKvhUPhCp7xT82X3TCCo/X0gP7wMsORNae
         mZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622022; x=1779226822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuJpPqhDcONg49vri+mgJGghvc2o/ilLGU2ZfssziEI=;
        b=ld2FfhXrjZUXePJPkmB8PpcQv4EzHCdCVs6fhfLM7+QGYN9P3Df8bZGtVFe9ItS+Lz
         1S4GYzIg0eLRJ29sLcVs7noEXp7mbcUBuS+sPDwjheycbatrYtdSvsDDTGIWK1zYIYUc
         dfkcmGH09G+w4wWdpyYm92w0/D/RVtq0mfZP4NDTbfS2CyY/D9u/7otdEW6caZIUI7Xg
         HPvx7eCL7q6CqnuaealFMyhhRgBxJCD63gkEZpSi7Zuw4Q5NzixRWrZFtvPPCmniXzWh
         S7+sgI0BkZM6qaF9L9iRTtXHdIMmI7BrkivGxCe4+r54uEXkxstPZaLAZ8EgWAwwmev3
         Ji/g==
X-Forwarded-Encrypted: i=1; AFNElJ9AEsNAXurcAaw328WdJPm4y+LCN0XqEg0PAQTW+JHQzhOyhksHnTiguWEgjrsV8qkTlLiet4GMxo8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+IHfImthYJJbqkUIAj8nq4Kfyn30ygsiyxotFZy1z70rSA4q
	BXswHRkFsNyEpGod4UxyFwc5/6ADJK3hQQUjFQN07hhGeCWEIDqvBbmY
X-Gm-Gg: Acq92OGYe+DaovLmCEFzd6RxVJpgh0xOw+dbDbkxpotJNLmXftqbsourM/yI3J5rvI8
	MeHB65HBzpdW6Y5e5ibSfaWIx6KlojaF9SUkbiEhYSrPeIR+jNhderxxRp9QQJ3BF4ETAryh7Fi
	/KA0j+fnuG1uFnw3h0YDqdvwWoSgQSYMWhCgJpJ+p8Ehve0grz6ZZoqVDRV7MkKoTJ881TBvJfN
	ciM755IpcaGHzJEYKmp3DCBn252VBwaMVW3TKFevZp3kHJpVO9n7fnzVNYAucwwi+j6ARdBOHdu
	1vqjTbuN4Qn34Zxf3r05nS+4yjnAUmqg48lI83ih3FAAW0G+iiq7J0fDO40T7vez3SDGhCFqKWR
	xSP2beuzo1lhAe9bvoTqs9ERcJFeWi/bXfX5f6hq1PFW3fN1TacD72JdWJo8bDjfhNys8nAF3YO
	dfqcRiDMgCcZy4I7flwTD0HQoQd+gPIZw=
X-Received: by 2002:a17:903:3b8e:b0:2ba:7617:a755 with SMTP id d9443c01a7336-2bcfd48ace8mr55972255ad.25.1778622022203;
        Tue, 12 May 2026 14:40:22 -0700 (PDT)
Received: from mincom1 ([27.232.220.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm143949895ad.32.2026.05.12.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:40:21 -0700 (PDT)
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
Subject: [PATCH v5 0/2] AMD Promontory 21 xHCI temperature sensor support
Date: Wed, 13 May 2026 06:39:08 +0900
Message-ID: <20260512213910.871859-1-hurryman2212@gmail.com>
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

Changes in v5:
- Add support for AMD 1022:43fc PROM21 xHCI controllers and document the
  new PCI ID.
- Make USB_XHCI_PCI_PROM21 depend on X86 and default to USB_XHCI_PCI.
- Keep the PROM21 PCI glue built-in-only when enabled, while allowing the
  hwmon sensor driver to be built as a separate module.
- Move PROM21 xHCI PCI device IDs to xhci-pci.h so xhci-pci.c and
  xhci-pci-prom21.c use shared definitions.
- Pass the parent PCI device, MMIO base, and resource length to the hwmon
  driver through platform data defined in a common header, instead of
  inspecting the parent driver's drvdata from the hwmon driver.
- Remove the private hwmon mutex and rely on hwmon core serialization for
  this driver's callbacks.
- Clarify that the driver only serializes its own hwmon callbacks and does
  not synchronize with firmware, SMM, ACPI AML, or other possible users of
  the PROM21 vendor index/data register pair.
- Use readb() for the temperature data register, validate the value before
  writing the output pointer, and drop the 0xff invalid-value check.
- Use pm_runtime_put() after successful reads with the parent device active
  so the PM core can re-evaluate the parent device's idle state.
- Simplify the documentation and use more precise terminology for the
  supported device.

Jihong Min (2):
  usb: xhci-pci: add AMD Promontory 21 PCI glue
  hwmon: add AMD Promontory 21 xHCI temperature sensor support

 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/prom21-xhci.rst           | 101 ++++++++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/prom21-xhci.c                   | 238 ++++++++++++++++++
 drivers/usb/host/Kconfig                      |  20 ++
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-pci-prom21.c            | 123 +++++++++
 drivers/usb/host/xhci-pci.c                   |  11 +
 drivers/usb/host/xhci-pci.h                   |   3 +
 include/linux/platform_data/usb-xhci-prom21.h |  22 ++
 11 files changed, 531 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-xhci.rst
 create mode 100644 drivers/hwmon/prom21-xhci.c
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c
 create mode 100644 include/linux/platform_data/usb-xhci-prom21.h

-- 
2.53.0
