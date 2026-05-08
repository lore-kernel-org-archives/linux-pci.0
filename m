Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0B3F7898
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251188; cv=none; b=TbhAzb224m5IMOd9rAe4w+67vp6B8yKtYlgm6FucionzpnmE9tL3DWefe1i31lo9qpb3CkwEX25wPLWiSopAjaXYtf49GvqVPWblSZeeNYt5xD8LDAsHOcuSet38VN6ETvi4qUNj6iZd/5D3W/jMfoiTLM8LQYFVCWTZbAwo570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251188; c=relaxed/simple;
	bh=itEiIvS5IQdmPyKV4TM5/IWsSeVIbKhHBAPSr//nzw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+/qZ+M9zU6DgR0ZD0DLWWw4TzOu4PltWlZ+BiEwgIijL7kEAMnyPTVVgkgqKvX9km9ObL4FDeatBv1QoNRgG7SaIk6OB0nL2xGsWhrNV6XUPwzLiiUyTOx1GhRgGzB13XHab+b+vE4ooteINapZDwZvwKlCqAiTXyYmy3F97bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4OHZ0G6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4OHZ0G6"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-837cd669be0so1604049b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778251184; x=1778855984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2HYUShWSK5X7dHT+11XldOT0jiE1N/UTPrbF9SDaeE=;
        b=g4OHZ0G64/MsIt/6SsNwYhk88nPo2OfaVz6WyaXMf+bek8AyP2mWmJN1qmCD9OMFXr
         hdsXSn1GYUdT65SG0lpQoIhB4l1qW89hYWm1jB1A7WTMvE3FgYup7MFRdvsZu3b4luWK
         NVSS8F2J/C7B8bpoHNT2r0ZoBBvWeCDbfmC8czg9QOvmAlhx8vO0hL3Mao9X/BvMVPM8
         Uk2bHLqoCHlkm+B30QmAfCIA0QOIjO6qE0rt+of3R3nVcxYkrf8sK9PN0AF3bWl8H8Js
         ltbN4NvJm7MrWHUPmVd4KbifBpyptmkaG8Qnu0pCIDw4Bmo0fg/OaMV/fK3hOp0zT9dd
         uLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778251184; x=1778855984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z2HYUShWSK5X7dHT+11XldOT0jiE1N/UTPrbF9SDaeE=;
        b=KSwsiJbkgFD3CvxTE6TIYmFbSQBWqYdXAUidJ8u9UoE+I78eySz6INfHGkvL/af3kA
         XJy2KYk+mKjvHy+H0zUyQwRtR2nQpChiQG9wG9v6lKG7J/S4y4uXYciQub4es1QK04r8
         FMDo4ELLzuEiGv1A2A96ytdCrSi0fi5YyqXyIATFR9IfBE4woBxMDKu0oftGajZKptvj
         KI6JvY0PwlLhz+Q5RDvCtjfwRU564zAwbY9Q9shP4ETgD4dxqcTwUQBzeF5EhuQgT20K
         gE+h3ScMo+XCpw1/SY3aL3ZsqJeFp4+aIhEiaXnzmuNmXKkzR04eA1110UGuJ+DWFWD6
         xAmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8n33pDpKf/VSExy4rMFQB58R5Kzj4xiPl7yKt3Ar7i+U45Druhbqms0585wyOGjvgY/gDP57K6sZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1DbJ+OrAtSWgEH0vflX5b+76SgSVMBiDKr/Nds7bdYzNl9lY
	p9X49mYhbkrIQHShqcZgGPinEVHS7TuL028inUcFJPxaDFu5yZn+tL/G
X-Gm-Gg: Acq92OFZLo4FSTsFlcxPDDxnWzL9+tK1YhFT4TmhCzBfkg8gsqzm1s6/4nz7mhAn6ZO
	S7vKgAx9Aue9kQjedm+VcarevBCRZBXmlfsFS1tU2mb6iPypT5TYzNFPQmJXaDu7bVkPGBBCEec
	0/E9a8l2qksLJxt4688gt9KG7PgvWRRs4V15BTOUKHsUgxobxvA4Z/D9UKuy7Kk7eOpZ3qsCeAC
	lcjpNn2AtiAxoBTHvilGuITwj2StHSuG0hrvK64tbcbe3xeHkWbHp6RXWG2l1i3SMEZ92rUlmIU
	g0qeqKGGPBo0NWp84iEUFpndtFEsb4wSQIxV94gsj+ArKSsD7+gQn7A+LOhExTdNPPKt1ZpEQqb
	eiswL6ddzQGVGXiowd4XJbPx08QI0zcIJ2Jf6DAXy62WCvdzJLGhHRuRia6VufVvtLgIn3Qjo1h
	oUMqFF47tN4pOG6KiZCvo=
X-Received: by 2002:aa7:98c6:0:b0:83b:c487:43d2 with SMTP id d2e1a72fcca58-83bc4874759mr5837605b3a.36.1778251183526;
        Fri, 08 May 2026 07:39:43 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8462sm12395499b3a.38.2026.05.08.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:39:43 -0700 (PDT)
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
Subject: [PATCH v4 2/2] hwmon: add AMD Promontory 21 xHCI temperature sensor support
Date: Fri,  8 May 2026 23:39:10 +0900
Message-ID: <20260508143910.14673-3-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508143910.14673-1-hurryman2212@gmail.com>
References: <20260508143910.14673-1-hurryman2212@gmail.com>
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
in the xHCI PCI MMIO BAR. The read path restores the previous vendor
index value after sampling and does not runtime-resume the parent PCI
device; reads from a suspended parent return -ENODATA.

Document the supported device, register access, runtime PM behavior, and
sysfs lookup method. The documentation also records the observation
method used to identify the register pair and derive the conversion
formula.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/prom21-xhci.rst |  99 +++++++++++
 drivers/hwmon/Kconfig               |  10 ++
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/prom21-xhci.c         | 250 ++++++++++++++++++++++++++++
 5 files changed, 361 insertions(+)
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
index 000000000000..10d03c4476c3
--- /dev/null
+++ b/Documentation/hwmon/prom21-xhci.rst
@@ -0,0 +1,99 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver prom21-xhci
+=========================
+
+Supported chips:
+
+  * AMD Promontory 21 (PROM21) xHCI
+
+    Prefix: 'prom21_xhci'
+
+    PCI ID: 1022:43fd
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
+suspended device returns ``-ENODATA``. Sensor reads do not mark the xHCI PCI
+device as busy or schedule autosuspend, so polling the sensor does not delay
+runtime suspend.
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
+``temp1_input`` reports millidegrees Celsius, so a value of ``50113`` means
+50.113 degrees Celsius. If the raw register value is invalid, ``temp1_input``
+returns ``-ENODATA``.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 14e4cea48acc..fe0f14e247b5 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -951,6 +951,16 @@ config SENSORS_POWR1220
 	  This driver can also be built as a module. If so, the module
 	  will be called powr1220.
 
+config SENSORS_PROM21_XHCI
+	tristate "AMD Promontory 21 xHCI temperature sensor"
+	depends on USB_XHCI_PCI_PROM21
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
index 4788996aa137..0bda542e8e2b 100644
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
index 000000000000..f91303ce3428
--- /dev/null
+++ b/drivers/hwmon/prom21-xhci.c
@@ -0,0 +1,250 @@
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
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#define PROM21_INDEX 0x3000
+#define PROM21_DATA 0x3008
+#define PROM21_TEMP_REG 0x0001e520
+
+struct prom21_xhci {
+	struct pci_dev *pdev;
+	struct device *hwmon_dev;
+	void __iomem *regs;
+	struct mutex lock; /* serializes index/data register access */
+};
+
+static int prom21_xhci_pm_get(struct prom21_xhci *hwmon, bool *pm_ref)
+{
+	struct device *dev = &hwmon->pdev->dev;
+	int ret;
+
+	*pm_ref = false;
+
+	/*
+	 * PROM21 temperature register access does not return a valid value while
+	 * the parent xHCI PCI function is suspended. Do not wake the device from
+	 * a hwmon read; only read when runtime PM reports the device as active,
+	 * or when runtime PM is disabled and the device is not marked as
+	 * suspended.
+	 */
+	ret = pm_runtime_get_if_active(dev);
+	if (ret > 0) {
+		*pm_ref = true;
+		return 0;
+	}
+
+	if (ret == -EINVAL && !pm_runtime_status_suspended(dev))
+		return 0;
+
+	if (!ret || pm_runtime_status_suspended(dev))
+		return -ENODATA;
+
+	return ret;
+}
+
+/*
+ * This is not a pure MMIO read. The PROM21 vendor data register is selected
+ * by temporarily writing PROM21_TEMP_REG to the vendor index register.
+ * Serialize the sequence, keep it short, and restore the previous index before
+ * returning so this driver does not leave the vendor index/data register pair
+ * in a different state for other possible users.
+ */
+static int prom21_xhci_read_temp_raw_restore_index(struct prom21_xhci *hwmon,
+						   u8 *raw)
+{
+	struct device *dev = &hwmon->pdev->dev;
+	bool pm_ref;
+	u32 index;
+	u32 data;
+	int ret;
+
+	ret = prom21_xhci_pm_get(hwmon, &pm_ref);
+	if (ret)
+		return ret;
+
+	mutex_lock(&hwmon->lock);
+	index = readl(hwmon->regs + PROM21_INDEX);
+	/* Select the PROM21 temperature register through the vendor index. */
+	writel(PROM21_TEMP_REG, hwmon->regs + PROM21_INDEX);
+	data = readl(hwmon->regs + PROM21_DATA);
+	/* Restore the previous vendor index register value. */
+	writel(index, hwmon->regs + PROM21_INDEX);
+	readl(hwmon->regs + PROM21_INDEX);
+	mutex_unlock(&hwmon->lock);
+
+	if (pm_ref) {
+		/*
+		 * Drop only the reference taken by pm_runtime_get_if_active().
+		 * Do not mark the device busy or schedule autosuspend from the
+		 * hwmon path; sensor polling must not keep the xHCI PCI device
+		 * active.
+		 */
+		pm_runtime_put_noidle(dev);
+	}
+
+	*raw = data & 0xff;
+	if (!*raw || *raw == 0xff)
+		return -ENODATA;
+
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
+	if (type != hwmon_temp || channel)
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
+	if (type != hwmon_temp || attr != hwmon_temp_input || channel)
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
+	struct device *parent = dev->parent;
+	struct prom21_xhci *hwmon;
+	struct pci_dev *pdev;
+	struct usb_hcd *hcd;
+	int ret;
+
+	if (!parent || !dev_is_pci(parent))
+		return -ENODEV;
+
+	pdev = to_pci_dev(parent);
+	hcd = pci_get_drvdata(pdev);
+	if (!hcd)
+		return dev_err_probe(dev, -ENODEV,
+				     "xHCI HCD data unavailable\n");
+
+	if (!hcd->regs || hcd->rsrc_len < PROM21_DATA + sizeof(u32))
+		return dev_err_probe(dev, -ENODEV, "invalid MMIO resource\n");
+
+	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	ret = devm_mutex_init(dev, &hwmon->lock);
+	if (ret)
+		return ret;
+
+	hwmon->pdev = pdev;
+	hwmon->regs = hcd->regs;
+	auxiliary_set_drvdata(auxdev, hwmon);
+
+	/*
+	 * Use the PCI function as the hwmon parent so user space reports it as
+	 * a PCI adapter. Lifetime is still owned by this auxiliary driver;
+	 * remove() unregisters the hwmon device before xhci-pci tears down the
+	 * HCD.
+	 */
+	hwmon->hwmon_dev =
+		hwmon_device_register_with_info(&pdev->dev, "prom21_xhci",
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

