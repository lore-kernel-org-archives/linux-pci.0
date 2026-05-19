Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8A286A4
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149270; cv=none; b=mYa/ze6Y+Wi4QGR5djxgk+LEZ9lG6Ge9+wUz8RNyvqefrx9RFiCwdx2JqFE4m393yvO1JxMu7TZgk7ZB7+7JpFqNs+QksljBD8hbux4hUt+GE/iGJ+4GtiJYSZya6Ge2ffzAi7XBBWX4DaG9e+gDwA9RB40jj1ofUP7Eb8Wziqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149270; c=relaxed/simple;
	bh=Kiklfbf/mOtWhM3nzZ61qTH+SlUMKusCDgEcCZ/kXsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxjaaDlOa0hpWKPV2teeX+LU639Dzqw738BrSvNjEVL3xu+mf3Y/4kB7TJzUr3xmtQrH+ni4VWEf660ntz4L/d8M1rdKQLu6O+h3Ft0s78uOREFjdjLffHh/t4pi5uIw3xG+LzUpcolmX1eylCAOOwVjSqc6LRgB+zQf5CZnvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTKgYWsy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTKgYWsy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2baef9f5ecdso23411105ad.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149269; x=1779754069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMisq1x8LSsDQmwweu++ThsrVVeqT8H4PNPNw49rVmw=;
        b=VTKgYWsyEcNjJnNzMND/nDwD74GG3fjp/gGHyxHxBsRW2PnA4wZ++eGb3NqLGWUQl5
         GfsUrpgHNwmnweki8ASoZkxqwc3lwEf7NkWiyykNE7vN7Bj2gMXkrOEcwZrZr5lMBtEE
         JkR/ubwSd0J++7Nn4gi5ZSfUloNn8/oG3pBquQblwGI5bGEnOIbX7uC/5pgbQmq9tyjr
         CttxRLUpnDS5JLG9FTSf1dGZXGANEhOWssU7WJXDzvtY/p3gjuWwDBuZsBJ1SwWKRdVT
         FPGALtkzI4l9x3xV6o1HYIq1OXr7+ScVh53poiWDQghrNlE8vGa2zn4kFAvLQx1aEWQe
         5rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149269; x=1779754069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMisq1x8LSsDQmwweu++ThsrVVeqT8H4PNPNw49rVmw=;
        b=pL5kckReJUWN/UpqYibNbf/sQPDGSu+DV7hlpczaBFtcjQ6lqPgN5NteErByoUaVA4
         9bZNwRzTsAAB2+mzvxTzCt80BJovmhPVgkwysw2IKeCAM8v4wV1zfeFRM5InbqKiGban
         nd1HZ/RZnJslUFzlS5LkWVq92Aq+pNRHhSdxwUXh5oJIV3G3SHKyz+pGyuX+a3Ak90Y2
         FiWIMZjmSItfdf5ezwFkJileutj/fxwe7Dr1pduxcMwg4Dt8HfIIEVzVKULGzwbs7+nN
         N09i+LTtkRaxFCnaXBKgtI7jxA9uA3bryj3/G0G8cvlClDnP6SSJBZVXWRSfwS9SEANf
         qc1Q==
X-Forwarded-Encrypted: i=1; AFNElJ9J3J5NwkpkIqYQCaBC8wQJRug41U2Vl3NBgjTquIMurqEtoKTzUcR63+N5eNzQNBTjPQXzTGf4qx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwaz525ivoLue+A0FvM1Fa/Dz7ICO9325JXkJ3pw/oiU5zisvP
	kkmHoOgrjzw+ckg8ckT9RwCqiehg1asfG25xNGRFPvnxGv+lfTqwbZVv
X-Gm-Gg: Acq92OHXukl3zoLO6pcXCCc8Vt7/KR6tzDIRXqgJP415+YlvwbO2yGHvOJzpWup0vGy
	UHwoz28Gk/NW8za1jzbi479+rYwpCMv6WtmyJaY92JwVUdNj+7qFuCHh6RSn2GD0/etAZ6JFmWz
	naf9Ag4mDX4RApU9CdC7s/fqA5L4mwv90eFgfVY7AlZ304HqYYW49R8BYBTTICwWtfKYAmL0YbC
	ig9WfwhHGKJEjck8SgdAJJX7Y8JMpXlVKZ1mucnQ3myHOb7nIQg7ku7a0F58PMmJqCBAvV2vkJT
	4yMwsB5kg0FRgoS4k8fz4CR7Au6UFPvnNy06U8JTqKCSw3T/t5hRaKx3EQ+TM9XJYW/hSM/Vyo5
	rdkfSqblWcTcOGsh//+Wy40xJp57enjREQRnvO8Gllundogoqms2w6m+JfY5beW/BS1AW34paz8
	gGH+q6XADWCpY2l58H1MJjMw==
X-Received: by 2002:a17:902:db06:b0:2b7:aba0:ac10 with SMTP id d9443c01a7336-2bd7e7bdd1cmr181280395ad.11.1779149268954;
        Mon, 18 May 2026 17:07:48 -0700 (PDT)
Received: from mincom1 ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc58575dfsm79021755ad.20.2026.05.18.17.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:07:48 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	Yaroslav Isakov <yaroslav.isakov@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH v7 0/2] AMD Promontory 21 xHCI temperature sensor support
Date: Tue, 19 May 2026 09:07:30 +0900
Message-ID: <20260519000732.2334711-1-hurryman2212@gmail.com>
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

Changes in v7:
- Tie the hidden PROM21 PCI glue option to the user-visible
  SENSORS_PROM21_XHCI option instead of enabling it for all x86 builds.
- Drop an unnecessary NULL check after successful xhci_pci_common_probe().
- Use a goto-based cleanup path in prom21_xhci_create_auxdev().

Jihong Min (2):
  usb: xhci-pci: add AMD Promontory 21 PCI glue
  hwmon: add AMD Promontory 21 xHCI temperature sensor support

 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/prom21-xhci.rst           | 101 ++++++++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/prom21-xhci.c                   | 239 ++++++++++++++++++
 drivers/usb/host/Kconfig                      |   6 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-pci-prom21.c            | 137 ++++++++++
 drivers/usb/host/xhci-pci.c                   |  11 +
 drivers/usb/host/xhci-pci.h                   |   3 +
 include/linux/platform_data/usb-xhci-prom21.h |  22 ++
 11 files changed, 532 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-xhci.rst
 create mode 100644 drivers/hwmon/prom21-xhci.c
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c
 create mode 100644 include/linux/platform_data/usb-xhci-prom21.h


base-commit: 4d3a2a466b8d68d852a1f3bbf11204b718428dc4
-- 
2.53.0
