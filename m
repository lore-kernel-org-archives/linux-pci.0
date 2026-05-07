Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6A22DC764
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124751; cv=none; b=XZyLrXwd3QToMfNC1LoZISHtN3fbkxYXF5U9Cb9XqE5ZOwsxUciAFmbXG3CHBVUxhyrYt/B4PQG/dACkCdl/AQw88VmaQJE512WLztkbCd+fZf/wMe74uuOD0Q6L8sFZUewwZ7nHwU7Iy+kjds4U3/Uoq4Itb0Na/Hc9F4nHSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124751; c=relaxed/simple;
	bh=ORhq2WDO7G386LW9/s0FeNCzLmO7VAx5a4PnwuQg/2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfnUMDc4veYQEG+lOP0hksRHO1mU3OIQ92c2tENrp80xuxXBuhvXwqkRtaBBII9bqq1DdczUbhvAWZCkfL4i9IOx2CLlLdH8pIt88jQrnANIotKc3QFwPLNnHIcsdF9aITwzOrk9yu2rNHOndM2KrLxAeq4bD2YsD/2TaAXSZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffS7Tg6Z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffS7Tg6Z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-836ebdeb969so125908b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778124749; x=1778729549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUVy+5q9S7S6S1WSUJI/Uw4Ov4EFwj2BrsC/teNmfkM=;
        b=ffS7Tg6ZswgLakyFHZM5Bs378MGWNUdniuvrOIuYVw6V6wP8J3VxEcz6nauEn1+5/T
         v2Nj1+G/jNNaEXc9L+ab81G/wpok9p79WLwsZ6IntkCfZEzlZ2Iz85KTtUzQUIgpwjEb
         omG/hy3uj/EGVg0xyP++n7H1iq7AMF38sslj2NVMi7QroqRgrFbuejBX4LdLhlXg0s/v
         XMoDml82CH2rjx5nZIaApIzPBPG89J5oMj+OZE2EkIXqDRC4PO1Koa6ltGNXGjAAHktL
         +SZB7hM9zgSoGJtFCAKjBPOTKKqIA8AIAl51j1M66ihnIASbcFAfZOGlHOsXVI0pg7Y2
         mStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124749; x=1778729549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QUVy+5q9S7S6S1WSUJI/Uw4Ov4EFwj2BrsC/teNmfkM=;
        b=CGExY82lgAbF+enafIzWKf1FNM7P4kqP0fg9AlRu4J0RHm013m0+oDWy0a/qXsR+js
         gSuE7V5SSVx39o4YxeWy7FGDJXysZxamALmJJ0c3rquPHw5im/wyf41j/m64uZPq0bHL
         GV+njRNzwhYSIewHpFpvdhQYfIXDMuNbjrasgDPOIpkk1Vsg0QEw3bYL3UkaqO8+OBNK
         PuJALuDHZzGJRVPuqSBI9tDlcNomsw0jCs2GvD3g82XW5a8YaBcM3DH8iqzWBWEOgwPg
         WTCWSBmj8SezoYu1ETPvIvN+EqmrNjvjECeC/UR7A4683G56Ra/tGLvIyDJupBgBG5U5
         fl0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9pc9i7WKn8xK4Knw7bR0ERaSJPPbnCdEnyH+ApqAoroRB03dIAdBJHWyHZITKawuGc38wdYCcrouQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGiRH+m4yYWRxthHReMJkk+aIPox/FzD7wEhcbqhOLtQzU8Srl
	cDP6CJo0LWxK/38bjgffO4Bcbrx7MTMc3WyQZ51D5MUa9XLB3pakBe6H
X-Gm-Gg: AeBDieu2m8ng6l2znlfStere1c3UsBXYjAqcb2KaamEgkDcra42Y17XkDKcQOCo1fnx
	6cM+eGj343Idaor40CC2ERHtK4W8BYs6sW9ZVYi6mJMMgP1IGl3+c8tvDjFKWDj0mw/X5V9Kdqs
	Fnt8z+hwPrZyCy+6Bi8jvXzE2Dnd9BvcAeDdNVuRx6HMl+ppWhKEySwh4XeJ5cmNDJFtE+K+l/b
	ExfWizj+n0+r+gN87c5asNtF8DpLzzlRGSzYf9DK5O9doa7a1m/OHKWH45HUFXg+rC5gkiZqlPj
	y/V9//lgh71DJTU8xwUNksexGXkS4kcv/TzA7MB877+R6KufILDZX9HsOZ9wDe0j3no5iWEnbCX
	C9wnPRHazjeckehMIurh5dCoWGhrQ7glh72jIoNZU+Or5NQhaHBQQESjeG/D9uIqNjYo/RCvN55
	zF6L3RqLIZdr5QX6kd8LLrr4TRqnqE5EE=
X-Received: by 2002:a05:6a00:4195:b0:835:3949:3c22 with SMTP id d2e1a72fcca58-83a5d285a4cmr5938356b3a.27.1778124748618;
        Wed, 06 May 2026 20:32:28 -0700 (PDT)
Received: from mincom1 ([14.67.155.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a103esm9171580b3a.51.2026.05.06.20.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 20:32:28 -0700 (PDT)
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
Subject: [PATCH v3 2/2] hwmon: add AMD Promontory 21 xHCI temperature sensor support
Date: Thu,  7 May 2026 12:31:59 +0900
Message-ID: <0c35058bb088213397b42fca8d51e9ad0bba5169.1778123510.git.hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778123510.git.hurryman2212@gmail.com>
References: <cover.1778123510.git.hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PROM21 xHCI controllers expose an 8-bit temperature value through a
vendor-specific index/data register pair in the xHCI PCI MMIO BAR
region. Add an auxiliary hwmon driver for PROM21 controllers with PCI
ID 1022:43fd.

PROM21 is an AMD chipset IP used in single-chip or daisy-chained
configurations to build AMD 6xx/8xx series chipsets.

The vendor index register is at byte offset 0x3000 from the xHCI MMIO
BAR base and the vendor data register is at byte offset 0x3008. The
driver writes register selector 0x0001e520 to the index register, reads
the raw temperature value from the low 8 bits of the data register, and
restores the previous index before returning. Expose temp1_input and an
xHCI label through hwmon.

Register the hwmon device under the parent PCI function so userspace
reports it as a PCI adapter, while the auxiliary driver still owns the
hwmon lifetime and unregisters it from the auxiliary remove path.

No public AMD reference is available for this value. The conversion
formula is derived from observed temperature readings:

  temp[C] = raw * 0.9066 - 78.624

Testing showed that the temperature register does not return a valid
value while the xHCI PCI function is runtime suspended. By default, the
driver does not wake the parent PCI device from hwmon reads and returns
-EPERM while the device is suspended.

Document the supported device, register access, conversion formula,
module parameter, sysfs attributes, and sysfs lookup method.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 Documentation/hwmon/index.rst        |   1 +
 Documentation/hwmon/prom21-hwmon.rst |  86 ++++++++
 drivers/hwmon/Kconfig                |  11 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/prom21-hwmon.c         | 293 +++++++++++++++++++++++++++
 5 files changed, 392 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-hwmon.rst
 create mode 100644 drivers/hwmon/prom21-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 8b655e5d6b68..41072977f0ef 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -216,6 +216,7 @@ Hardware Monitoring Kernel Drivers
    pmbus
    powerz
    powr1220
+   prom21-hwmon
    pt5161l
    pxe1610
    pwm-fan
diff --git a/Documentation/hwmon/prom21-hwmon.rst b/Documentation/hwmon/prom21-hwmon.rst
new file mode 100644
index 000000000000..0ba763e68ae9
--- /dev/null
+++ b/Documentation/hwmon/prom21-hwmon.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver prom21-hwmon
+==========================
+
+Supported chips:
+
+  * AMD Promontory 21 (PROM21) xHCI
+
+    Prefix: 'prom21_hwmon'
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
+No public AMD reference is available for the raw value. The temperature
+conversion formula is derived from observed PROM21 xHCI temperature readings:
+
+  temp[C] = raw * 0.9066 - 78.624
+
+Module parameters
+-----------------
+
+pm: bool
+  Allow runtime PM state changes for device memory access. This is disabled
+  by default. If disabled, the driver does not wake the xHCI PCI device from
+  a temperature read. It reads the temperature only when the device is active.
+  A read from a suspended device returns ``-EPERM``.
+
+Sysfs entries
+-------------
+
+======================= =====================================================
+temp1_input		Temperature in millidegrees Celsius
+temp1_label		"xHCI"
+======================= =====================================================
+
+The hwmon device name is ``prom21_hwmon``. The sysfs path depends on the hwmon
+device number assigned by the kernel. Userspace can locate the device by
+matching the ``name`` attribute:
+
+.. code-block:: sh
+
+   for hwmon in /sys/class/hwmon/hwmon*; do
+           [ "$(cat "$hwmon/name")" = "prom21_hwmon" ] || continue
+           cat "$hwmon/temp1_label"
+           cat "$hwmon/temp1_input"
+   done
+
+``temp1_input`` reports millidegrees Celsius, so a value of ``50113`` means
+50.113 degrees Celsius. If the raw register value is invalid, ``temp1_input``
+returns ``-ENODATA``.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 14e4cea48acc..06d81cc29fec 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -940,6 +940,17 @@ config SENSORS_POWERZ
 	  This driver can also be built as a module. If so, the module
 	  will be called powerz.
 
+config SENSORS_PROM21
+	tristate "AMD Promontory 21 xHCI temperature sensor"
+	depends on USB_XHCI_PCI
+	select USB_XHCI_PCI_AUXDEV
+	help
+	  If you say yes here you get support for the AMD Promontory 21
+	  (PROM21) xHCI temperature sensor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called prom21-hwmon.
+
 config SENSORS_POWR1220
 	tristate "Lattice POWR1220 Power Monitoring"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 4788996aa137..7693ed3b3f72 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -196,6 +196,7 @@ obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_POWERZ)	+= powerz.o
 obj-$(CONFIG_SENSORS_POWR1220)  += powr1220.o
+obj-$(CONFIG_SENSORS_PROM21)	+= prom21-hwmon.o
 obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
diff --git a/drivers/hwmon/prom21-hwmon.c b/drivers/hwmon/prom21-hwmon.c
new file mode 100644
index 000000000000..1c137304d65d
--- /dev/null
+++ b/drivers/hwmon/prom21-hwmon.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD PROM21 xHCI Hwmon Implementation
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
+#define PROM21_HWMON_NAME "prom21_hwmon"
+#define PROM21_TEMP_LABEL "xHCI"
+
+struct prom21_hwmon {
+	struct pci_dev *pdev;
+	struct device *hwmon_dev;
+	void __iomem *regs;
+	bool removing;
+	struct mutex lock; /* protects removing and the index/data registers */
+};
+
+static bool pm;
+module_param(pm, bool, 0444);
+MODULE_PARM_DESC(pm, "Allow runtime PM state changes for device memory access");
+
+static void prom21_hwmon_invalidate(struct prom21_hwmon *hwmon)
+{
+	mutex_lock(&hwmon->lock);
+	hwmon->removing = true;
+	mutex_unlock(&hwmon->lock);
+}
+
+static int prom21_hwmon_pm_get(struct prom21_hwmon *hwmon, bool *pm_ref)
+{
+	struct device *dev = &hwmon->pdev->dev;
+	int ret;
+
+	*pm_ref = false;
+
+	/*
+	 * PROM21 temperature register access does not return a valid value while
+	 * the parent xHCI PCI function is suspended. By default, only read when
+	 * runtime PM reports the device as active, or when runtime PM is disabled
+	 * and the device is not marked as suspended. If pm=Y, allow runtime PM
+	 * state changes while accessing the temperature register.
+	 */
+	if (pm) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			return ret;
+
+		*pm_ref = true;
+		return 0;
+	}
+
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
+		return -EPERM;
+
+	return ret;
+}
+
+/*
+ * This is not a pure MMIO read. The PROM21 vendor data register is selected
+ * by temporarily writing PROM21_TEMP_REG to the vendor index register. Keep
+ * the sequence short and restore the previous index before returning.
+ */
+static int prom21_hwmon_read_temp_raw_restore_index(struct prom21_hwmon *hwmon,
+						    u8 *raw)
+{
+	struct device *dev = &hwmon->pdev->dev;
+	bool pm_ref;
+	u32 index;
+	u32 data;
+	int ret;
+
+	/*
+	 * The xHCI PCI remove path destroys the auxiliary device before HCD
+	 * teardown. Keep runtime PM and MMIO inside the critical section so a
+	 * sysfs read cannot use the vendor register pair after remove starts.
+	 */
+	mutex_lock(&hwmon->lock);
+	if (hwmon->removing) {
+		mutex_unlock(&hwmon->lock);
+		return -ENODEV;
+	}
+
+	ret = prom21_hwmon_pm_get(hwmon, &pm_ref);
+	if (ret) {
+		mutex_unlock(&hwmon->lock);
+		return ret;
+	}
+
+	index = readl(hwmon->regs + PROM21_INDEX);
+	/* Select the PROM21 temperature register through the vendor index. */
+	writel(PROM21_TEMP_REG, hwmon->regs + PROM21_INDEX);
+	data = readl(hwmon->regs + PROM21_DATA);
+	/* Restore the previous vendor index register value. */
+	writel(index, hwmon->regs + PROM21_INDEX);
+	readl(hwmon->regs + PROM21_INDEX);
+
+	if (pm_ref) {
+		/*
+		 * Use autosuspend so repeated sysfs reads do not suspend the
+		 * controller immediately after each successful register access.
+		 */
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
+	mutex_unlock(&hwmon->lock);
+
+	*raw = data & 0xff;
+	if (!*raw || *raw == 0xff)
+		return -ENODATA;
+
+	return 0;
+}
+
+static long prom21_hwmon_raw_to_millicelsius(u8 raw)
+{
+	/*
+	 * No public AMD reference is available for this value.
+	 * The scale was derived from observed PROM21 xHCI temperature readings:
+	 *  temp[C] = raw * 0.9066 - 78.624
+	 */
+	return DIV_ROUND_CLOSEST(raw * 9066, 10) - 78624;
+}
+
+static umode_t prom21_hwmon_is_visible(const void *drvdata,
+				       enum hwmon_sensor_types type, u32 attr,
+				       int channel)
+{
+	if (type != hwmon_temp || channel)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_label:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int prom21_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *val)
+{
+	struct prom21_hwmon *hwmon = dev_get_drvdata(dev);
+	u8 raw;
+	int ret;
+
+	if (type != hwmon_temp || attr != hwmon_temp_input || channel)
+		return -EOPNOTSUPP;
+
+	ret = prom21_hwmon_read_temp_raw_restore_index(hwmon, &raw);
+	if (ret)
+		return ret;
+
+	*val = prom21_hwmon_raw_to_millicelsius(raw);
+	return 0;
+}
+
+static int prom21_hwmon_read_string(struct device *dev,
+				    enum hwmon_sensor_types type, u32 attr,
+				    int channel, const char **str)
+{
+	if (type != hwmon_temp || attr != hwmon_temp_label || channel)
+		return -EOPNOTSUPP;
+
+	*str = PROM21_TEMP_LABEL;
+	return 0;
+}
+
+static const struct hwmon_ops prom21_hwmon_ops = {
+	.is_visible = prom21_hwmon_is_visible,
+	.read = prom21_hwmon_read,
+	.read_string = prom21_hwmon_read_string,
+};
+
+static const struct hwmon_channel_info *const prom21_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL,
+};
+
+static const struct hwmon_chip_info prom21_hwmon_chip_info = {
+	.ops = &prom21_hwmon_ops,
+	.info = prom21_hwmon_info,
+};
+
+static int prom21_hwmon_probe(struct auxiliary_device *auxdev,
+			      const struct auxiliary_device_id *id)
+{
+	struct device *dev = &auxdev->dev;
+	struct device *parent = dev->parent;
+	struct prom21_hwmon *hwmon;
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
+		hwmon_device_register_with_info(&pdev->dev, PROM21_HWMON_NAME,
+						hwmon, &prom21_hwmon_chip_info,
+						NULL);
+	if (IS_ERR(hwmon->hwmon_dev))
+		return PTR_ERR(hwmon->hwmon_dev);
+
+	return 0;
+}
+
+static void prom21_hwmon_remove(struct auxiliary_device *auxdev)
+{
+	struct prom21_hwmon *hwmon = auxiliary_get_drvdata(auxdev);
+
+	if (hwmon) {
+		prom21_hwmon_invalidate(hwmon);
+		hwmon_device_unregister(hwmon->hwmon_dev);
+	}
+}
+
+static const struct auxiliary_device_id prom21_hwmon_id_table[] = {
+	{ .name = "xhci_pci." PROM21_HWMON_NAME },
+	{}
+};
+MODULE_DEVICE_TABLE(auxiliary, prom21_hwmon_id_table);
+
+static struct auxiliary_driver prom21_hwmon_driver = {
+	.name = "prom21-hwmon",
+	.probe = prom21_hwmon_probe,
+	.remove = prom21_hwmon_remove,
+	.id_table = prom21_hwmon_id_table,
+};
+module_auxiliary_driver(prom21_hwmon_driver);
+
+MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
+MODULE_DESCRIPTION("AMD PROM21 xHCI hwmon driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

