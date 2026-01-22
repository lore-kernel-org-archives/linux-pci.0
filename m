Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A73009D4
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104175; cv=none; b=PPoAApZtnpUQmFAuddc4NWB5Hl1MXF7cHyBZRQ7pEAdwtF78SsfcjAuTwxIYx79PZoA1iwpqy4Qtl4TWDPhf05mHj/E6B37FNyAZXFLt6RmMT6y+TGRdabEGuT2YDl8Hdhhv6xjQDsYKYESJA0grc1xFvdlSD/Av0o6zBzgNDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104175; c=relaxed/simple;
	bh=PPSbiTfVEGExWa8EuuY6a6EN8vMNdxghuY659RvCiCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j1CK1bwmOf7Ev+sSQ87YeF1API3jleduUYniLI8iNxz355WtzB+94j/Y5Cd7FALYnczyOr1NZbZj8MOPHj+SIYh2S0ZgrK0XKA75CE9xgCDKqUSS/XpZ/feu1YnjG2eWkyyGp9oydJQfKuugGIiE5ZVp+bYDzodojPu4M16PluA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OQXnEp90; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQXnEp90"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121bf277922so2268295c88.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 09:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1769104145; x=1769708945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3WbKmVrq7sm/5pwwqVvAut+xxxGLtgFYQpauTPoz70=;
        b=OQXnEp90kPXwTCa2gO7xkl/5bNSZs9gW56JSbAhBCXgNyrTa8fEUdjmcwGvXh5yrgl
         CpJrbsh94R0REe5TcF1qA/S7dc8DicsXjOVUCGQiUlIzsW5Gga0fZxjmeoG3yBUteyYN
         WL+JdjWSDsUgn4Viqg0ISIm+ihWz+B9i+9I0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104145; x=1769708945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WbKmVrq7sm/5pwwqVvAut+xxxGLtgFYQpauTPoz70=;
        b=KaS+EaBEyea1XbL2GiOHdDRHG5F3KYfFbp0RSMX13l+HkfAApyYxvBlwZOV6/53Y4h
         8IroObT1sFemCWy3zp86k7OOzfKif1hOFItPacUj4Ngt8x6Lo9ZGMKr4JUm3WXWJp0B8
         LRF2KS6VQaKGHB0QdjIcURzOYzq5bm5y2JQutE2TXynrgWfa0w8D+/RToVVkgYW3hEou
         xgrjBffomrBykrO3afBLvCw0BGLlizl8Gvg/9r1S0mSHQ71FEZSfVJb6zgjLCuxN9LpL
         fB2Ymv8IMBTXMB6cM3kHveSTCxT74RGuoNCUQ7eimAUA7grYgOLfOmGgcleikUYglnH2
         QjDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTJUndIhvBJicW6XG5y7hilOepJJzReEd+v4zni8r6Bqva7fQc5q6CtLg0FqxUW6DZ1WcJNTeXVL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdYdumrYMNJR8YSUJL6aeIhCAAWmZHoCj9hHfZ5w/Jis5LsZS
	CClBzDDnzGhaJeyOlrgJ7Bn1ZoPyAfTiv+Xxyn3VtkZd/uaJHZMOcYu8gbJ2wdgcQw==
X-Gm-Gg: AZuq6aJAD460QppQNIo8zEJIDZlTOM4gUhyX2dcaBa/fD0IzAIY+8EvcM//zFTXBtqj
	pqDfRrlVRzqv/KZtU/91jC4PYaq8Y3VQwv+bw40auT4XcSXQ/0KWIrijeX0JYY97NEBv2bvqMBc
	Dqu1D1SDewlEf/G2SkDM5CCu9OkpYgCCh8a3RJxG+Jcxkh0M1Y3FwhNIjVCh34cX95piImuxZNS
	eaAldRdrSjhmJ1JUB7Jt2cfl65cPJv1Q3iqwzNjc6CDrONooNFS+EIWUuaXQ/KissuemIU8rFSG
	Vj71rpFLbPr1PMHnOVk0OikWl6SCVgEshBusLIvmLVf9HwXbnEJ15uY3b7dW0ZC8PnsC9+QZWV5
	cHs4OIeYE1zk7aw3D/OdtGBMndDib0yNbz7IoPSVLG7q4qipOweckE1kTLLeTgsbHU88+wOa3uH
	unbWHBUwvCbOl7KhiF2TL5M6clqunz5xh/F2mIfPsFQS9/+fqmUQ==
X-Received: by 2002:a05:7022:126:b0:123:2d38:928e with SMTP id a92af1059eb24-1247dc082b1mr61654c88.35.1769104144779;
        Thu, 22 Jan 2026 09:49:04 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:f995:553f:5ab5:f684])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1247d9981a4sm164342c88.9.2026.01.22.09.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 09:49:04 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are fully initialized
Date: Thu, 22 Jan 2026 09:48:15 -0800
Message-ID: <20260122094815.v5.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, it was possible for a PCI device to be runtime-suspended before
it was fully initialized. When that happened, the suspend process could
save invalid device state, for example, before BAR assignment. Restoring
the invalid state during resume may leave the device non-functional.

Prevent runtime suspend for PCI devices until they are fully initialized by
deferring pm_runtime_enable().

More details on how exactly this may occur:

  1. PCI device is created by pci_scan_slot() or similar

  2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
     prevents runtime suspend prevented via pm_runtime_forbid()

  3. pci_device_add() adds the underlying 'struct device' via device_add(),
     which means user space can allow runtime suspend, e.g.,

       echo auto > /sys/bus/pci/devices/.../power/control

  4. PCI device receives BAR configuration
     (pci_assign_unassigned_bus_resources(), etc.)

  5. pci_bus_add_device() applies final fixups, saves device state, and
     tries to attach a driver

The device may potentially be suspended between #3 and #5, so this is racy
with user space (udev or similar).

Many PCI devices are enumerated at subsys_initcall time and so will not
race with user space, but devices created later by hotplug or modular
pwrctrl or host controller drivers are susceptible to this race.

More runtime PM details at the first Link: below.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
Link: https://lore.kernel.org/all/0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com/

Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
Cc: <stable@vger.kernel.org>
---

Changes in v5:
 * Put pm_runtime_set_active() back where it was, to ensure our parent
   can't suspend before we're really ready. (See bug report in 2nd
   "Link:")
 * Add comments
 * Update commit description with Bjorn's rewrite
 * Add Marek's Tested-by

Changes in v4:
 * Move pm_runtime_set_active() too

Changes in v3:
 * Add Link to initial discussion
 * Add Rafael's Reviewed-by
 * Add lengthier footnotes about forbid vs allow vs sysfs

Changes in v2:
 * Update CC list
 * Rework problem description
 * Update solution: defer pm_runtime_enable(), instead of trying to
   get()/put()

 drivers/pci/bus.c | 7 +++++++
 drivers/pci/pci.c | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 4383a36fd6ca..90954f81962b 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	/*
+	 * Enable runtime PM (and potentially suspend) only after we've fully
+	 * configured the PCI state.
+	 */
+	pm_runtime_enable(&dev->dev);
+
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..07b0d029aa51 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
 poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
+	/*
+	 * Mark ourselves active now, to prevent our parent from suspending
+	 * while we finish configuring the PCI device.
+	 */
 	pm_runtime_set_active(&dev->dev);
-	pm_runtime_enable(&dev->dev);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.52.0.457.g6b5491de43-goog

