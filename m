Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501D3AEF58
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100067; cv=none; b=jdB3wt8/8YGe5qKFFL54G34Rgr6Or9Ew/HJX8LGz5c2AN9/u/3TSDfXZOtiu6v9KeQyHekCXtIchBX6cq4VdH5ZELUpQZ2JR80dwI9+McKt06ndGJf2ukhGXdSOAafmKYel6PHCp68CUYUmTgbk8JYPMuGw0jwwmjGHMrrX2pGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100067; c=relaxed/simple;
	bh=nwMTT29u+LtI5G8+J6EFC1XOkB4xEsTMIqDwnxcz9Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWlyd12IO44S8YN6v+7gYVTmx2alJAVbAdHH34TRMfEirkCe26Ngwa+JVOcaUENm3Upe0zG0YXUf+Y1vbipETy4/G1YxXQHFSQO4LJ3yH3DgvyicfN8Nf0H8D579p6qxYgKliT1yYKl0sIbegCoVnPt9tUCqXRMTF/nHwwd8HNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InBuJGoz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InBuJGoz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so17819b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100065; x=1778704865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyxqAtQD7rFyDCTSlxuj0U/JQIdGBWrp6vzNhFMX1Po=;
        b=InBuJGozng7EOMhxS4cLWBMS0cxZPUPm4i4IPsY0ybRPb0h8PpcZd+u+Mzt6Odjsog
         p0DoPjmKUci4S5sCT4Fx5ri017jfys3d4ZcN6TLytTdjKCknUR4aprs6BwxMpeSd1mBQ
         uTkllzWC8qadsXtgOeZKrDL8X2k62009UHlpLnBBGOFfg1xF8+7hfV5Eb/oAUc9b0JUK
         vx1FaVbexHLIrUkh6h93q2HBGD1Kpt4zA2ZjcTEOyglQnWXo3deprEaNR8GSFy053Unt
         okT4+Sn+a+FhSTXNtf3spUIMEzd1z8CySeErGp/Qv4N5EuFL7xeqNfL1jz6hp5HtHbsA
         dVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100065; x=1778704865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyxqAtQD7rFyDCTSlxuj0U/JQIdGBWrp6vzNhFMX1Po=;
        b=sQGL8eRSHTUksB04QsdyK4NrtwFWLuSPjDy82S4RfIGkgBH4oo7f0m7IlxqGteN1o6
         3sV7+agEurmMsCPGHsM9UJJ1jwn4V+H0GjEK1RqJhnyMChhSFud8/CN8p+k2f/nHlEWI
         7pWWe8Bq9tTZ6pIUopR63iS42niprJIUWoXQLozOEZsaUICGKkFUr1uU9ZE0wl+SDDOd
         bQMBZivKMXfGPTBtmt2Ovbldb8szpEi+2ZqY8UVLt1kq+aBriT4h9sJ129zPWechMTXw
         EcGWc34d8cjm0dBBIJLrLh0+aYLVLJCltdTiteRM82iUZmEfLSKuzkCCW9HnL7cLBX6M
         Y/UQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jpgQaO8Pzus6FWthQWzz6zVwVKCcN5QrA0c6ObMFK+6HWv9RHEtI7i3PkAZJ0PGWydpPEghihS9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEl7dVZc1+oKVQ9pm3Rlb9W683IvomrDyKD+HkitnNUDTPrUz7
	OYnb1aS3LoCKvFTWVQaihAiMRSHWLC6cxssLMYNk05pZ6mU9zjfped+q
X-Gm-Gg: AeBDietliKGURX887sLmom8O6p6McD4cGhtiR9tNa6uzo1csq1VoyHXbSXlG80P9G0s
	6RrNyAuNp7tEk5yJ5xIK2UwXE5NW1D8xuiLSir+NNY7OdXAkeTc+gSOnF4IdsnBD9v25WVzfScW
	jsVU0uQ4PDkbPxazK7Gt+QVXCBXyNJkv7nQUASJc8t5jxJyQNdTnP8930pTZbaheaCu+rhyha3S
	DLYceQGezlVKCH8VPZQftgLNJmP6Ql7XYb16T3t4qnHv5CJmYtJP2pjI6aCXdHe3wGVcBozFNlD
	BmcJoEbO6CySPysgZdQKFZzlcRvH73tUF7PpcNaHOpHJUxsMJanO92lUZd3zQm5RU1htdgVxHxg
	jqbWDshbGjh6GNa62FkX/2+rJ0vqjiOZM3uKhLiMMvLwEWQpMRGtsWmxarKK/JQ+IVNI6QpF32P
	qgEn2ALME78Asy5Wj1bGZJK25o2CJWWMU=
X-Received: by 2002:a05:6a00:1742:b0:839:12a7:70f7 with SMTP id d2e1a72fcca58-83a5d6812eamr4873400b3a.31.1778100065250;
        Wed, 06 May 2026 13:41:05 -0700 (PDT)
Received: from mincom1 ([14.67.155.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f11csm7952185b3a.3.2026.05.06.13.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:41:04 -0700 (PDT)
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
Subject: [PATCH v2 2/2] hwmon: add initial support for AMD PROM21 xHCI temperature sensor
Date: Thu,  7 May 2026 05:40:34 +0900
Message-ID: <2e2ea249b30168a2eab62fc110c226a511f21bf2.1778099627.git.hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778099627.git.hurryman2212@gmail.com>
References: <20260506032939.92351-1-hurryman2212@gmail.com> <cover.1778099627.git.hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD PROM21 xHCI controllers expose an 8-bit temperature value
through a vendor-specific index/data register pair in the xHCI PCI
MMIO BAR region. Add an auxiliary hwmon driver for AMD 1022:43fd
controllers and bind it to the xhci_pci.hwmon auxiliary device
created by xhci-pci.

The read path verifies the parent PCI function and uses the
initialized xHCI HCD MMIO mapping. The vendor index register is at
byte offset 0x3000 from the xHCI MMIO BAR base and the vendor data
register is at byte offset 0x3008. The driver writes register selector
0x0001e520 to the index register, reads the raw temperature value from
the low 8 bits of the data register, and restores the previous index
before returning. Expose temp1_input and an xHCI label through hwmon.

Register the hwmon device under the parent PCI function so userspace
reports it as a PCI adapter, while the auxiliary driver still owns the
hwmon lifetime and unregisters it from the auxiliary remove path.

No public AMD reference is available for this value. The conversion
formula is derived from observed temperature readings:

  temp[C] = raw * 0.9066 - 78.624

The temperature register did not return a valid value while the xHCI
PCI function was suspended in testing. Keep the existing behavior by
default and allow temperature reads to wake the xHCI PCI device. Add an
allow_pm_switch module parameter so users can disable that behavior;
when disabled, reads do not wake the device and return -EAGAIN if it is
suspended.

Document the supported device, register access, conversion formula,
module parameter, sysfs attributes, and sysfs lookup method.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 Documentation/hwmon/index.rst        |   1 +
 Documentation/hwmon/prom21-hwmon.rst |  84 ++++++++
 drivers/hwmon/Kconfig                |  11 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/prom21-hwmon.c         | 300 +++++++++++++++++++++++++++
 5 files changed, 397 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-hwmon.rst
 create mode 100644 drivers/hwmon/prom21-hwmon.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 8b655e5d6b68..0d85b78596cf 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -215,6 +215,7 @@ Hardware Monitoring Kernel Drivers
    peci-dimmtemp
    pmbus
    powerz
+   prom21-hwmon
    powr1220
    pt5161l
    pxe1610
diff --git a/Documentation/hwmon/prom21-hwmon.rst b/Documentation/hwmon/prom21-hwmon.rst
new file mode 100644
index 000000000000..965a50595b47
--- /dev/null
+++ b/Documentation/hwmon/prom21-hwmon.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver prom21-hwmon
+==========================
+
+Supported chips:
+
+  * AMD PROM21 xHCI
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
+Since the xHCI controllers are integrated in PROM21, this temperature can also
+be used as a monitor for a temperature close to the AMD chipset temperature.
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
+allow_pm_switch: bool
+  Allow temperature reads to wake the xHCI PCI device. This is enabled by
+  default. If disabled, the driver does not wake the xHCI PCI device from a
+  temperature read. It reads the temperature only when the device is not
+  suspended. A read from a suspended device returns ``-EAGAIN``.
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
index 14e4cea48acc..da2266807f06 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -940,6 +940,17 @@ config SENSORS_POWERZ
 	  This driver can also be built as a module. If so, the module
 	  will be called powerz.
 
+config SENSORS_PROM21
+	tristate "AMD PROM21 xHCI temperature sensor"
+	depends on USB_XHCI_PCI
+	select USB_XHCI_PCI_AUXDEV
+	help
+	  If you say yes here you get support for the AMD PROM21 xHCI
+	  temperature sensor.
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
index 000000000000..179d2f206c7d
--- /dev/null
+++ b/drivers/hwmon/prom21-hwmon.c
@@ -0,0 +1,300 @@
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
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI 0x43fd
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
+static bool allow_pm_switch = true;
+module_param(allow_pm_switch, bool, 0444);
+MODULE_PARM_DESC(allow_pm_switch,
+		 "Allow temperature reads to wake the xHCI PCI device");
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
+	 * the parent xHCI PCI function is suspended. By default, resume the xHC
+	 * before touching MMIO. If allow_pm_switch=N, do not resume the xHC from
+	 * a hwmon sysfs read; only read when runtime PM reports it as active, or
+	 * when runtime PM is disabled and the device is not marked as suspended.
+	 */
+	if (allow_pm_switch) {
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
+	if (!ret || pm_runtime_status_suspended(dev))
+		return -EAGAIN;
+
+	if (ret == -EINVAL)
+		return 0;
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
+	if (pdev->vendor != PCI_VENDOR_ID_AMD ||
+	    pdev->device != PCI_DEVICE_ID_AMD_PROM21_XHCI)
+		return -ENODEV;
+
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
+	{ .name = "xhci_pci.hwmon" },
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

