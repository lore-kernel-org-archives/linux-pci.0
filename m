Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E233C9EE9
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422029; cv=none; b=e7QBJwAjrglO80EgmsDZsnoppIW7mJBgweW/Z3xlyXccv7XAVXdiowU8v21AHKiTYHhRLAbQyZnSvaG6nJImrR8jjhpzlKw3yiaMMMji0vGdvMFGBGhlaYtAgpPWzjW8CjTT6IWe9DQC0TGTg999THiLzXCan4bKB9Kd/uDDl04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422029; c=relaxed/simple;
	bh=dC1TmoCxNKoe1ZHT/oRYda4bb6bgtNVLvwsF793C1Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLQacxhkynyLCEvlrWMrjyZHiik0gJ58H+NrIbZm+dfSY/5YquyPTggG0Djl1nBGUbMwNxkDl8ujgC0WqkP8U1Pq3eBWJG06g0E6u0TOaAt4o1qPg9OQI1fl+9sp2mGhx+PFXoTGF1WgHNiueODmkzpYw5YG7+Y+tfvhsHB+KCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ULr4dj4L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kwGzq5xK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULr4dj4L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kwGzq5xK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6835le7V3176911
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 07:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L4B18C8BAWnluvJtgs6sahdr+TMhXOEeOZlUfDbIV58=; b=ULr4dj4L7fEobU5T
	77M/v6YLabRJr1eKiiFatkWPda1vEYdhKQDcSwGCIU9idyOExuyqJ3UP43UawC/1
	0Jw1ZRhjvJgRBu5s/DUyFUcYbeit1FlVacFlbveQYPf1GmIxpe9C5bbuH0qVbSy4
	wytlF2UWY/DBtCiWbUkvjgpBcycZ0lKhDEehkWqMMfqKeGfOpeogYShPaQezpH+3
	WRnV1q2r8LH6Oeyn6GWpeHZeqir4q3UYQkfEKfu/lr8HcN6rGwyKJ63v7OtTunKi
	GgWXiyIq8U1dJ/NpNU1bT7Uw15ILFBbGfY1W4iDocptQxCZ2MYbXxPtmaWL2B2eB
	i4q7ew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemj4v5gv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 07:53:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so149223385a.3
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788422025; x=1789026825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L4B18C8BAWnluvJtgs6sahdr+TMhXOEeOZlUfDbIV58=;
        b=kwGzq5xKBFSDH2YFtTrdWbr67ZD971ECSZ1G1g77A3Bq1bVo+KX5mRU1GIeRmZHA4R
         VhW6+Po2ebqJgm580gTfYrs2MkbNvgOHWiOdz47ampyfiZ1ypyJPhA0e5WormCgZX7ZW
         eXo4lTT8cEbXEk70nhImEkTiJwYH72yyfjJSozjof+p6KzppMT+7rA5q/Ut/6CXw3Yca
         d4ihMQ4iqX2OhUzfhOkzZec+jIDcSQiDqEsnetWg8kKXDmhZd91/0XPNiWCxONG3i3FH
         fJFAzuRbzZEJGNm/NuMxzcKu9UBQaKtweqCnh2XkTt2xUaUBCcp+MQG761qnT8F6ieBk
         rd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422025; x=1789026825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4B18C8BAWnluvJtgs6sahdr+TMhXOEeOZlUfDbIV58=;
        b=pwS4RTYcSQuT0hONtNhd4Y63XhYApWrWJJDhhJMVHxKPz/VlgzWtTWlS9FglVQBe2s
         CmJOyMTuID7cyFc77ec6uWFWHXmUMOsRwLF6FFKtmWOTqeDhJTt4LaAKunr30adT+Jg1
         yGI6dRFDtj4287ibYjvpK5YFUmoWOWgsb6ZBTAu7dl9L/mflA+IY8KyS9sqXjJgexfmh
         4vcK3rQKkl4av6cw6WiEfRwzLZix+m++G6W9Y0eUxNrQFFLZGK0vmh0AwADJCIp6Yuzm
         GQX6IyIi4wcm37wHoY1w/NFNqdWuPcT/mNu12iNyRX8Z3B+yREKCuUplnoxj2o3xBAbF
         shJg==
X-Forwarded-Encrypted: i=1; AKwUvBwZysgRkEdkGqrrfwOiweoSdXxPXD3kQIarL590b5sYf0Gr97uwZgHjgkIbRRNkffJbRGT59sjhrZA=@vger.kernel.org
X-Gm-Message-State: AFuF++mzapA4wyxX388QU19JNMpFf9OlEP/Nrs/d+tTComaMZPf7AYzi
	Sfw3C7JIOTHnapH6ndmbLgdbbmtcsD5AysuNK22/fZ7LA1ATXNUg1ll25CstrOnGwIqZGPRKbT7
	zUbduMZbTT7ftp6pLlnI14+Xh0P3A0i8Vz4X+tsEGt4oDrFtmcjjkMgh6zZ2Bno0=
X-Gm-Gg: AYBFou2mC5IlY+CWMLqNCaGYf1sAHmNw3TRQPPx9E0rf2g6NGhhEB0Sk+GQeLffU9pW
	6JgVF4O++qf0hVOcG0arXUIMlSCrXjLB+4OkLrk42rGW4XjZdL6LCa05oJMm0UmDUadNesDvr27
	U5/nTQTNb1VipKWO4fGHBAQRPTX+3q65oE4NQfHPx4EC+ULzw4aiZJlJUZba21j9M1xe2JlFW5V
	u/sy/k4P5WDfOx4Ax9Ackckopc2A/iChCBAZca9xxIA66zRiOfaYwYqRF4WQaihP7AT8tRR3biD
	r5fAZQqMJNNHFK0zAJMLWsq/9X0LneqILWjWr36d9scgCysCrjlLVXKrIEZEHyPZtbRkpvqdnTs
	SBStJztdPAAAPDA==
X-Received: by 2002:a05:620a:72cb:20b0:934:97c1:ca5c with SMTP id af79cd13be357-93960dff178mr986226885a.16.1788422020550;
        Thu, 03 Sep 2026 00:53:40 -0700 (PDT)
X-Received: by 2002:a05:620a:72cb:20b0:934:97c1:ca5c with SMTP id af79cd13be357-93960dff178mr986224785a.16.1788422019980;
        Thu, 03 Sep 2026 00:53:39 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e80388sm13415139f8f.14.2026.09.03.00.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:53:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 09:52:58 +0200
Subject: [PATCH v2 2/5] gpio: tc9563: add support for the embedded GPIO
 controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pci-tc9563-aux-v2-2-34c625b542c1@oss.qualcomm.com>
References: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
In-Reply-To: <20260903-pci-tc9563-aux-v2-0-34c625b542c1@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Daniel Thompson <daniel@riscstar.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX5CSf74+a6Frk
 3fpem5NspWvX6f4xS8rVv63kria7gCBQ/gnQUwkxQZMqJWdnPgtrHqokP6bov9Iw1I+/IIdsuMy
 o+lbMXXr3sek35m65XFbtuEWduGkXDHMULx31Pk4rC/GXxKJOuzKRJmftt3X01YIyT1cpT+Z+WR
 vy/KYOASSQ0XXavn319MhJ0NOHKrQzyc0gBodWzDXZsPqhAJgPdNTkb9vAUOcHdqz6GNWClSl8R
 oMVgZE10iJ1xdBWSF3PYWJNPng1HavZE6RVxqanhN9W+Ogamji/vClZJddDcTPmIZBzVxJddhCz
 hxu8SAa7HzM1has5G6G147UihHr219NFlWdEv9QImNE1mAPux2wzimfYNETvBba91lnzc0X7Fru
 C0JENxneM4ST0mR6u/nv4ckh8IYPKzC6cft51yjeXW23p16pdzgJQ/3wpdtj6KkbGdGS6bSPXKl
 ab8QvDY3Ez7pKtu1JnA==
X-Proofpoint-ORIG-GUID: xhOJk4HKrXGfaevLKDmt36gh-s4-9TM3
X-Authority-Analysis: v=2.4 cv=MdhcfZ/f c=1 sm=1 tr=0 ts=6a99278a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=xgoTPrYxRPbxS4DbvaYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: xhOJk4HKrXGfaevLKDmt36gh-s4-9TM3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2OSBTYWx0ZWRfX5zafn1tKg3cD
 IRsmEtZIjyLiwDybARX7NYwXAkX2w+prkX63R69r6SahemVXzunslrZEP0XcyVb4OVf4QV8UAKa
 1nQ5RzjZCNnVoRNxChWHAYbcs/Yuqh0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030069

From: Alex Elder <elder@riscstar.com>

Add a driver for the GPIO controller embedded in the Toshiba TC9563
PCIe switch (and the Qualcomm QPS615). The device implements 35
GPIOs using two register banks: three registers control the first 32
GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
GPIOs 22-24, 27-28, 31, and 34 are input-only.

The driver is registered as an auxiliary device driver; the TC9563
power controller creates the auxiliary device and provides a regmap
that gives access to the GPIO registers, so the gpio-regmap helpers
are used to implement the GPIO chip.

Signed-off-by: Alex Elder <elder@riscstar.com>
Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/gpio/Kconfig            | 11 +++++
 drivers/gpio/Makefile           |  1 +
 drivers/gpio/gpio-tc9563.c      | 99 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/tc9563.h | 19 ++++++++
 4 files changed, 130 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a48586bb8edb..2179eaffcc48 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1830,6 +1830,17 @@ config GPIO_LTC4283
 
 endmenu
 
+config GPIO_TC9563
+	tristate "Toshiba TC9563 GPIO support"
+	default m if ARCH_QCOM
+	select AUXILIARY_BUS
+	select GPIO_REGMAP
+	help
+	  This enables support for the GPIO controller embedded in the Toshiba
+	  TC9563 (and Qualcomm QPS615).  This device connects to the host
+	  via PCIe port, which is the upstream port on an internal PCIe
+	  switch.
+
 menu "PCI GPIO expanders"
 	depends on PCI
 
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index dc9e6d643b5b..792faa2668c9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -182,6 +182,7 @@ obj-$(CONFIG_GPIO_SYSCON)		+= gpio-syscon.o
 obj-$(CONFIG_GPIO_TANGIER)		+= gpio-tangier.o
 obj-$(CONFIG_GPIO_TB10X)		+= gpio-tb10x.o
 obj-$(CONFIG_GPIO_TC3589X)		+= gpio-tc3589x.o
+obj-$(CONFIG_GPIO_TC9563)		+= gpio-tc9563.o
 obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
 obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
 obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
diff --git a/drivers/gpio/gpio-tc9563.c b/drivers/gpio/gpio-tc9563.c
new file mode 100644
index 000000000000..f8ea3fc35c6d
--- /dev/null
+++ b/drivers/gpio/gpio-tc9563.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+/*
+ * The Toshiba TC9563 implements a PCIe Gen 3 switch that connects an
+ * upstream x4 port to two downstream PCIe x2 ports.  It incorporates
+ * an internal endpoint on a internal PCIe port that implements two
+ * Synopsys XGMAC Ethernet interfaces.
+ *
+ * 35 GPIOs are also implemented by an embedded GPIO controller.  Three
+ * registers control the first 32 GPIOs (other than 20 and 21, which are
+ * reserved).  Three other registers control GPIOs 32 through 36. GPIOs
+ * 22-24, 27-28, 31, and 34 are treated as "input only".
+ *
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/soc/qcom/tc9563.h>
+
+/*
+ * There are two sets of registers, each representing (up to) 32 GPIOs with a
+ * stride of 4 bytes (IN1 is 4 bytes past IN0, EN1 is 4 bytes past EN0, etc.).
+ */
+#define TC9563_GPIO_COUNT		37
+#define TC9563_GPIO_PER_REG		32
+#define TC9563_GPIO_REG_STRIDE		4
+
+static int tc9563_gpio_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	/* GPIOs 20 and 21 are reserved */
+	bitmap_fill(valid_mask, ngpios);
+	bitmap_clear(valid_mask, 20, 2);
+
+	return 0;
+}
+
+static int tc9563_gpio_probe(struct auxiliary_device *adev,
+			     const struct auxiliary_device_id *id)
+{
+	struct gpio_regmap_config config = {
+		.parent = &adev->dev,
+		.ngpio = TC9563_GPIO_COUNT,
+		.reg_stride = TC9563_GPIO_REG_STRIDE,
+		.ngpio_per_reg = TC9563_GPIO_PER_REG,
+		.reg_dat_base = GPIO_REGMAP_ADDR(TC9563_GPIO_IN0_OFFSET),
+		.reg_set_base = GPIO_REGMAP_ADDR(TC9563_GPIO_OUT0_OFFSET),
+		.reg_dir_in_base = GPIO_REGMAP_ADDR(TC9563_GPIO_EN0_OFFSET),
+		.init_valid_mask = tc9563_gpio_init_valid_mask,
+	};
+	DECLARE_BITMAP(fixed_dir_mask, TC9563_GPIO_COUNT);
+	DECLARE_BITMAP(fixed_dir_out, TC9563_GPIO_COUNT);
+
+	config.regmap = dev_get_platdata(&adev->dev);
+	if (!config.regmap)
+		return -EINVAL;
+
+	/*
+	 * Only some of our GPIOs are fixed direction:
+	 * 22, 23, 24, 27, 28, 31, and 34 are input-only.
+	 */
+	bitmap_zero(fixed_dir_mask, TC9563_GPIO_COUNT);
+	bitmap_set(fixed_dir_mask, 22, 3);
+	bitmap_set(fixed_dir_mask, 27, 2);
+	set_bit(31, fixed_dir_mask);
+	set_bit(34, fixed_dir_mask);
+	config.fixed_direction_mask = fixed_dir_mask;
+
+	bitmap_zero(fixed_dir_out, TC9563_GPIO_COUNT);
+	config.fixed_direction_output = fixed_dir_out;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&adev->dev, &config));
+};
+
+static const struct auxiliary_device_id tc9563_gpio_ids[] = {
+	{ "pci_pwrctrl_tc9563." TC9563_GPIO_DEV_NAME },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, tc9563_gpio_ids);
+
+static struct auxiliary_driver tc9563_gpio_driver = {
+	.name		= TC9563_GPIO_DEV_NAME,
+	.probe		= tc9563_gpio_probe,
+	.id_table	= tc9563_gpio_ids,
+};
+module_auxiliary_driver(tc9563_gpio_driver);
+
+MODULE_AUTHOR("Alex Elder <elder@riscstar.com>");
+MODULE_AUTHOR("Daniel Thompson <daniel@riscstar.com>");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Toshiba TC9563 GPIO Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/qcom/tc9563.h b/include/linux/soc/qcom/tc9563.h
new file mode 100644
index 000000000000..086f37a40d80
--- /dev/null
+++ b/include/linux/soc/qcom/tc9563.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
+ */
+
+#ifndef __QCOM_TC9563_H
+#define __QCOM_TC9563_H
+
+#define TC9563_GPIO_DEV_NAME	"tc9563-gpio"
+
+#define TC9563_GPIO_IN0_OFFSET		0x801200
+#define TC9563_GPIO_EN0_OFFSET		0x801208
+#define TC9563_GPIO_OUT0_OFFSET		0x801210
+
+#define TC9563_GPIO_CONFIG		TC9563_GPIO_EN0_OFFSET
+#define TC9563_RESET_GPIO		TC9563_GPIO_OUT0_OFFSET
+
+#endif /* __QCOM_TC9563_H */

-- 
2.55.0

