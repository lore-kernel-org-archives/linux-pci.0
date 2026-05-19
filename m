Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86D128816
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149280; cv=none; b=UR8qIEejTEfyqrECwvdiWyD7sS9btbzpn2AfN5YELRGOC3lhzpStOsKTkdN6B067hklPdBdxdsRQdehpQFyabfxgwru7t4EToPai1QTHPJPsJSvIMLsASBkcdksSXVI3St7aVwmWJfG6FyFCwwWztuuBZMrJIZclGdrwBm6kbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149280; c=relaxed/simple;
	bh=B9osKUrtRag8dtNM/J+awtHqk7IngzgmolC3NDcI6Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf2+GrWtWzSX4TSM6YRKmdrnmb1SOK68xJtei8gjtNqZhZp+mMYWZWVN+1TZDyrywoVdX9OAnn+WRLQ0lpXJ3s4nBv5TZTiBza3R155xJ1reDHxYxptGr+Ou8Am9BZyAOT/cqev+rAc7vKRFBmyHrvSJOTIhmGu66uJW37V673Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQsm6TvE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQsm6TvE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b9e9a6802aso11507325ad.3
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149276; x=1779754076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6ziD8m7WKgKCsBYKM0LVOj0fx6FtMzc9DWoHsTlFww=;
        b=NQsm6TvE9p/ddCKUXucvAzPMYUJl14u6tfjviGiJSpoMa3P3hD/QEYAyUQF6WkWZQA
         Li+WQ3sXcdSxGxaRuIKHfEM9nWjSIpSI/A8nqm939M6AvhMaaniiDKpvw/pMNcdNFbFZ
         qxF/9zADl3MYGcRINp2PbObmek1r82lylIxY4rwIGN7mbVdZ9fmYOpUgeOfwR1Jc1Wap
         amkAlPJM9bGlrfmk0etWyr4ydK4qhZ/SOA8J5+rXukA/4HzkxtsIa0176+mBHmUCGtnX
         qGQrR0Z0xqVmRW5/XZG+eQjJ2BIJJCPwbJYzmZgMV/YGOyjBz87jc88eJ8bM66rDVZiG
         2a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149276; x=1779754076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D6ziD8m7WKgKCsBYKM0LVOj0fx6FtMzc9DWoHsTlFww=;
        b=gCe9zcyjjiRonbRsTDi8X/5hmiCkLCLdhgrL35052+OCs/llmyPv7LDqMKDN/q/iAx
         HMSMOLKrXrS+ZfXdDuVgKSBAIbqVO+IRHXD6CwWi5Dk5D5SCcYYwER3hNIj+1UL1rWEX
         q3VKCrv3Uo3k519Huy1YCuSkPEubVFpSx41mWYtA7nSX+4ZY1+rcST7GZG0OGVrHF0D7
         Sf8mQNWvzSPfX8swGjXRILMevxqH6ThNkG8VwNRNTAgbUskIb+LsRwwJ0sizpSakMoBf
         kiWfHUNQh2QYzDBlI+M+XwfhQsNfycg3o39YMzc/n7b3RcpR8csqxglr15ydUpbZeUzj
         1IdA==
X-Forwarded-Encrypted: i=1; AFNElJ/oBHKWkYI/UZ0y4PHp1pZ+SPrgIpxy0Lru9cP9rbNMVw+sZpwUIM+nRgFVPyOC2jQvW2B+gzNhtLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7QehRfeTYkg6Wo54rmuthLFOwzTJC7v6D0CDDzyMYo1c+VDM
	kwROsikpZVTbnjANu5CBx699tjVi9b2L8NAG/LgEW0OFjyawwIVHy/U2
X-Gm-Gg: Acq92OEgROP/GGXUaowVJvSV20CboJMbe4i2c6ad/CdWiu/FKPnH+4oflVOHn2++OyE
	efOUHs45z0KFR/hLnrvvE6Ee1loPT0UAHrRSHy+5TCrzcR5Mw15dUhgJiFG/icg2f/o+OnxvFct
	+1jHRkYLt4TQPHudTu5wvpAPbp5DLyi9I+6nLCXh9/tsZ37tYf68u+xVj1HvMyp/7drVGEQux/S
	raj+b6Ho/HRenhh5yxC4CyhEHgKhi6ez9N0JNd5hWUjtz2eXy2ZICZlgd4rl6TYGQUEE6cSyKQ9
	kj1angKQcqzwxJ6/MCrVfk7+QwZDbyrZrxedmyl774cqBzjQ+EgNDjjsQMNtGNGuPqe04gczSJm
	NFLBk/vorN4V1xpQpRzRKJUKyuxzfTh8YVpSvvzpuY2+jAa1PseadUnk1x5ydG/Rr1dFdNJW2aP
	Nz+vIuLh9O47PS8JsCE2V2aw==
X-Received: by 2002:a17:903:1b45:b0:2bd:93b0:2c1c with SMTP id d9443c01a7336-2bd93b02ea0mr142388835ad.3.1779149276393;
        Mon, 18 May 2026 17:07:56 -0700 (PDT)
Received: from mincom1 ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc58575dfsm79021755ad.20.2026.05.18.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:07:55 -0700 (PDT)
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
Subject: [PATCH v7 2/2] hwmon: add AMD Promontory 21 xHCI temperature sensor support
Date: Tue, 19 May 2026 09:07:32 +0900
Message-ID: <20260519000732.2334711-3-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519000732.2334711-1-hurryman2212@gmail.com>
References: <20260519000732.2334711-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an auxiliary-bus hwmon driver for the temperature sensor exposed by
AMD Promontory 21 (PROM21) xHCI PCI functions. The driver binds to the
"hwmon" auxiliary device published by the PROM21 xHCI PCI glue and
exposes the sensor as temp1_input under the prom21_xhci hwmon device.

The sensor is accessed through a PROM21 vendor index/data register pair
in the xHCI PCI MMIO BAR. The driver consumes parent-provided MMIO data
from the PROM21 PCI glue instead of inspecting the parent PCI driver's
drvdata. The read path restores the previous vendor index value after
sampling and does not runtime-resume the parent PCI device; reads from a
suspended parent return -ENODATA.

Document the supported device, register access, runtime PM behavior, and
sysfs lookup method. The documentation also records the observation
method used to identify the register pair and derive the conversion
formula.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/prom21-xhci.rst | 101 ++++++++++++
 drivers/hwmon/Kconfig               |  10 ++
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/prom21-xhci.c         | 239 ++++++++++++++++++++++++++++
 5 files changed, 352 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-xhci.rst
 create mode 100644 drivers/hwmon/prom21-xhci.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 8b655e5d6b68..324208f1faa2 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -216,6 +216,7 @@ Hardware Monitoring Kernel Drivers
    pmbus
    powerz
    powr1220
+   prom21-xhci
    pt5161l
    pxe1610
    pwm-fan
diff --git a/Documentation/hwmon/prom21-xhci.rst b/Documentation/hwmon/prom21-xhci.rst
new file mode 100644
index 000000000000..7984fb187bd8
--- /dev/null
+++ b/Documentation/hwmon/prom21-xhci.rst
@@ -0,0 +1,101 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver prom21-xhci
+=========================
+
+Supported chips:
+
+  * AMD Promontory 21 (PROM21) xHCI USB host controller
+
+    Prefix: 'prom21_xhci'
+
+    PCI IDs: 1022:43fc, 1022:43fd
+
+Author:
+
+  - Jihong Min <hurryman2212@gmail.com>
+
+Description
+-----------
+
+This driver exposes the temperature sensor in AMD PROM21 xHCI controllers.
+
+The driver binds to an auxiliary device created by the xHCI PCI driver for
+supported controllers. The sensor value is accessed through a vendor-specific
+index/data register pair in the controller's PCI MMIO BAR.
+The auxiliary device is created by the ``xhci-pci-prom21`` PCI glue driver.
+USB host operation is otherwise delegated to the common ``xhci-pci`` code.
+
+PROM21 is an AMD chipset IP used in single-chip or daisy-chained configurations
+to build AMD 6xx/8xx series chipsets. Since the xHCI controllers are
+integrated in PROM21, this temperature can also be used as a monitor for a
+temperature close to the AMD chipset temperature.
+
+Register access
+---------------
+
+The temperature value is read through a vendor-specific index/data register
+pair in the xHCI PCI MMIO BAR. The driver uses the following byte offsets from
+the MMIO BAR base:
+
+======================= =====================================================
+0x3000			Vendor index register
+0x3008			Vendor data register
+======================= =====================================================
+
+The driver saves the current vendor index register value, writes the
+temperature selector ``0x0001e520`` to the vendor index register, reads the
+vendor data register, and restores the previous vendor index value before
+returning. The raw temperature value is the low 8 bits of the vendor data
+register value.
+
+The hwmon core serializes this driver's callbacks, and the driver restores the
+previous index value after each read. This does not provide synchronization
+with firmware, SMM, ACPI AML, or any other user outside this driver.
+
+No public AMD reference is available for the register pair or the raw value.
+The register pair was identified on an X870E system with two PROM21 xHCI
+controllers. One controller was passed through to a Windows VM, and the same
+controller's PCI MMIO BAR was observed from the Linux host while HWiNFO64 was
+reporting the PROM21 xHCI temperature. In the test environment, the reported
+temperature was very stable at idle and the displayed sensor resolution was
+low, which made it possible to look for a consistently repeating MMIO response
+for the same reported temperature. During observation, offset 0x3000 repeatedly
+contained selector ``0x0001e520``. Writing the same selector to offset 0x3000
+from Linux and then reading offset 0x3008 reproduced the same raw value, so the
+offsets are treated as a vendor index/data register pair.
+
+The conversion formula was empirically inferred by matching observed raw
+8-bit values against HWiNFO64's reported PROM21 xHCI temperature for the same
+controller. The observed mapping is:
+
+  temp[C] = raw * 0.9066 - 78.624
+
+Runtime PM
+----------
+
+The driver does not wake the xHCI PCI device for hwmon reads. It reads the
+temperature only when the parent device is already active. A read from a
+suspended device returns ``-ENODATA``. After a successful read, the driver
+drops its active-only runtime PM reference and lets the PM core re-evaluate the
+idle state.
+
+Sysfs entries
+-------------
+
+======================= =====================================================
+temp1_input		Temperature in millidegrees Celsius
+======================= =====================================================
+
+The hwmon device name is ``prom21_xhci``. The sysfs path depends on the hwmon
+device number assigned by the kernel. Userspace can locate the device by
+matching the ``name`` attribute:
+
+.. code-block:: sh
+
+   for hwmon in /sys/class/hwmon/hwmon*; do
+           [ "$(cat "$hwmon/name")" = "prom21_xhci" ] || continue
+           cat "$hwmon/temp1_input"
+   done
+
+If the raw register value is invalid, ``temp1_input`` returns ``-ENODATA``.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 14e4cea48acc..1e770b548810 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -951,6 +951,16 @@ config SENSORS_POWR1220
 	  This driver can also be built as a module. If so, the module
 	  will be called powr1220.
 
+config SENSORS_PROM21_XHCI
+	tristate "AMD Promontory 21 xHCI temperature sensor"
+	depends on USB_XHCI_PCI
+	help
+	  If you say yes here you get support for the AMD Promontory 21
+	  (PROM21) xHCI temperature sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called prom21-xhci.
+
 config SENSORS_LAN966X
 	tristate "Microchip LAN966x Hardware Monitoring"
 	depends on SOC_LAN966 || COMPILE_TEST
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 982ee2c6f9de..f833aed890d8 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -196,6 +196,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
+obj-$(CONFIG_SENSORS_PROM21_XHCI)	+= prom21-xhci.o
 obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
diff --git a/drivers/hwmon/prom21-xhci.c b/drivers/hwmon/prom21-xhci.c
new file mode 100644
index 000000000000..d40d0c53ce45
--- /dev/null
+++ b/drivers/hwmon/prom21-xhci.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Promontory 21 xHCI Hwmon Implementation
+ * (only temperature monitoring is supported)
+ *
+ * This can be effectively used as the alternative chipset temperature monitor.
+ *
+ * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_data/usb-xhci-prom21.h>
+#include <linux/pm_runtime.h>
+
+#define PROM21_XHCI_INDEX_OFFSET	0x3000
+#define PROM21_XHCI_DATA_OFFSET		0x3008
+#define PROM21_XHCI_TEMP_SELECTOR	0x0001e520
+
+struct prom21_xhci {
+	struct pci_dev *pdev;
+	struct device *hwmon_dev;
+	void __iomem *regs;
+};
+
+static int prom21_xhci_pm_get(struct prom21_xhci *hwmon)
+{
+	struct device *dev = &hwmon->pdev->dev;
+	int ret;
+
+	/*
+	 * PROM21 temperature register access does not return a valid value while
+	 * the parent xHCI PCI function is suspended. Do not wake the device from
+	 * a hwmon read. On success, hold a usage reference without changing the
+	 * runtime PM state; if runtime PM is disabled, allow the read unless the
+	 * device is still marked suspended.
+	 */
+	ret = pm_runtime_get_if_active(dev);
+	if (ret > 0)
+		return 0;
+
+	if (ret == -EINVAL) {
+		if (pm_runtime_status_suspended(dev))
+			return -ENODATA;
+
+		pm_runtime_get_noresume(dev);
+		return 0;
+	}
+
+	if (!ret)
+		return -ENODATA;
+
+	return ret;
+}
+
+/*
+ * This is not a pure MMIO read. The PROM21 vendor data register is selected
+ * by temporarily writing PROM21_XHCI_TEMP_SELECTOR to the vendor index
+ * register.
+ * The hwmon core already serializes this driver's callbacks, so this driver
+ * does not need an additional private lock. That does not synchronize with
+ * firmware, SMM, ACPI, or other possible users. Keep the sequence short and
+ * restore the previous index before returning.
+ */
+static int prom21_xhci_read_temp_raw_restore_index(struct prom21_xhci *hwmon,
+						   u8 *raw)
+{
+	struct device *dev = &hwmon->pdev->dev;
+	u32 index;
+	u8 data;
+	int ret;
+
+	ret = prom21_xhci_pm_get(hwmon);
+	if (ret)
+		return ret;
+
+	index = readl(hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
+	/* Select the PROM21 temperature register through the vendor index. */
+	writel(PROM21_XHCI_TEMP_SELECTOR,
+	       hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
+	/* Use a 32-bit read for PCI MMIO register access. */
+	data = readl(hwmon->regs + PROM21_XHCI_DATA_OFFSET) & 0xff;
+	/* Restore the previous vendor index register value. */
+	writel(index, hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
+	readl(hwmon->regs + PROM21_XHCI_INDEX_OFFSET);
+
+	/*
+	 * Drop the usage reference taken by prom21_xhci_pm_get(). This is
+	 * enough because the read path never resumes the device; use the normal
+	 * put path so the PM core can re-evaluate idle state after the read.
+	 * Otherwise, a racing xHCI autosuspend attempt can see a nonzero
+	 * runtime PM usage count and skip autosuspend, and a later
+	 * pm_runtime_put_noidle(), which does not check for an idle device,
+	 * would leave the device active.
+	 */
+	pm_runtime_put(dev);
+
+	if (!data)
+		return -ENODATA;
+
+	*raw = data;
+	return 0;
+}
+
+static long prom21_xhci_raw_to_millicelsius(u8 raw)
+{
+	/*
+	 * No public AMD reference is available for this value.
+	 * The scale was derived from observed PROM21 xHCI temperature readings:
+	 *  temp[C] = raw * 0.9066 - 78.624
+	 */
+	return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
+}
+
+static umode_t prom21_xhci_is_visible(const void *drvdata,
+				      enum hwmon_sensor_types type, u32 attr,
+				      int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int prom21_xhci_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct prom21_xhci *hwmon = dev_get_drvdata(dev);
+	u8 raw;
+	int ret;
+
+	if (type != hwmon_temp || attr != hwmon_temp_input)
+		return -EOPNOTSUPP;
+
+	ret = prom21_xhci_read_temp_raw_restore_index(hwmon, &raw);
+	if (ret)
+		return ret;
+
+	*val = prom21_xhci_raw_to_millicelsius(raw);
+	return 0;
+}
+
+static const struct hwmon_ops prom21_xhci_ops = {
+	.is_visible = prom21_xhci_is_visible,
+	.read = prom21_xhci_read,
+};
+
+static const struct hwmon_channel_info *const prom21_xhci_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	NULL,
+};
+
+static const struct hwmon_chip_info prom21_xhci_chip_info = {
+	.ops = &prom21_xhci_ops,
+	.info = prom21_xhci_info,
+};
+
+static int prom21_xhci_probe(struct auxiliary_device *auxdev,
+			     const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	const struct prom21_xhci_pdata *pdata = dev_get_platdata(dev);
+	struct prom21_xhci *hwmon;
+
+	if (!pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "platform data unavailable\n");
+
+	if (!pdata->regs ||
+	    pdata->rsrc_len < PROM21_XHCI_DATA_OFFSET + sizeof(u32))
+		return dev_err_probe(dev, -ENODEV, "invalid MMIO resource\n");
+
+	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	hwmon->pdev = pdata->pdev;
+	hwmon->regs = pdata->regs;
+	auxiliary_set_drvdata(auxdev, hwmon);
+
+	/*
+	 * Parent the hwmon device to the PCI function because the temperature
+	 * value is read from that function's MMIO BAR, and systems may contain
+	 * multiple PROM21 xHCI functions. This lets userspace identify the PCI
+	 * endpoint for each reading. The auxiliary driver still owns the hwmon
+	 * lifetime and unregisters it before HCD teardown.
+	 */
+	hwmon->hwmon_dev =
+		hwmon_device_register_with_info(&pdata->pdev->dev, "prom21_xhci",
+						hwmon, &prom21_xhci_chip_info,
+						NULL);
+	if (IS_ERR(hwmon->hwmon_dev))
+		return PTR_ERR(hwmon->hwmon_dev);
+
+	return 0;
+}
+
+static void prom21_xhci_remove(struct auxiliary_device *auxdev)
+{
+	struct prom21_xhci *hwmon = auxiliary_get_drvdata(auxdev);
+
+	/*
+	 * The PROM21 PCI glue destroys the auxiliary device before HCD teardown.
+	 * Unregister the hwmon device here so sysfs removes the attributes,
+	 * stops new reads, and drains active hwmon callbacks before the xHCI
+	 * MMIO mapping is released.
+	 */
+	hwmon_device_unregister(hwmon->hwmon_dev);
+}
+
+static const struct auxiliary_device_id prom21_xhci_id_table[] = {
+	{ .name = "xhci_pci_prom21.hwmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, prom21_xhci_id_table);
+
+static struct auxiliary_driver prom21_xhci_driver = {
+	.name = "prom21-xhci",
+	.probe = prom21_xhci_probe,
+	.remove = prom21_xhci_remove,
+	.id_table = prom21_xhci_id_table,
+};
+module_auxiliary_driver(prom21_xhci_driver);
+
+MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
+MODULE_DESCRIPTION("AMD Promontory 21 xHCI temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

