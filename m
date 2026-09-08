Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940133128CC
	for <linux-pci@vger.kernel.org>; Tue,  8 Sep 2026 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881365; cv=none; b=d4E63NngUDkaeqDq3G5pMid7E1qLbN+pGzCOBQ5uSxwYsQ2xapXxDJZyqDD0lw65GiyqyzzoknRZioJesznTd0qen6uNp/GgJtr3QEWJuBbJsNTUZna0S8vhBm63XgYMP4eLjecdswckoubM4C+xa5jHCZOVU476lDPI54H3RuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881365; c=relaxed/simple;
	bh=1R6Utv+qvsm3BmK4wvwwfQiFexp4no+IiiaI9utxCE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3JjyyIRe8sCSJ4QeQt6M2YFtUD+QKF2LCd9QrT7jfdz9Zk1wMj5fiNf9TdUWkQmP3o1Rq7l/17j5J7aACDnOU/pg3QBB7U7JlBCdkv/uEzJWTp13x/PFHs6lZXeK80pQ+RNncGN3KISLeASf2U7e/c/O4KSyVPSp4o19FLQPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0KNZc4w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HeNZYZdB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0KNZc4w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HeNZYZdB"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688FOc6b3930853
	for <linux-pci@vger.kernel.org>; Tue, 8 Sep 2026 15:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9GSXR5NyPzEt9NCTK8oySpuhpLuRDFNxcln3x4lU6wo=; b=f0KNZc4wk3ZYMGK8
	htNKWoQ74sk+cmq9sAx89wnaEDgqmEC+G24vYuL0q1kZ9f+Omi8B5w9O9SlIlFgw
	mj3d4m2j43/ERXPaFno4Oa0HUfMop5bbcJqPe2mOLTzgIbu5kJlxxNbLXkQwRNL8
	STrdKwVs6CdgigFzrsIh59UbCX6yGXeCzcSNDY/PemN7DBSeS7Rak04DMPa5qvqX
	NxHa7vKcdtYKjYPKBY+KbEphIviLQfxpd/1Bm2908qtJ85wUOAj/guxJEXqImBV2
	QD7tq0cmtcWgTVq+6a7j9IwR4rPtlf/fXAkamKDC809EbwN2iV0tLZAh28T4lGXR
	afiDYQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjfp49guw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 15:29:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9394ad7f64aso738932285a.3
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788881349; x=1789486149; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9GSXR5NyPzEt9NCTK8oySpuhpLuRDFNxcln3x4lU6wo=;
        b=HeNZYZdBB97fClg2nmVnq4W4qa80Ojs5I8V/yhOFeWr3l+9kKwCEDBeEEOFS8PDJX1
         mRZ7UeB8QPjaGiGSuZ3574rVox23JPBXPSQjj4Nl58pd/oxfZ/E7vMNT2ShL6h/+XFpP
         NgRiMGUE+lhunL/xVYpAh9pVhN6oclyXz429nE6MKR4U0bfAwTy0d4CD1M6r4BPTHeSn
         6FSsgi27XO7q56xWFbcu+et25751++QpVXNzre6PoqDkFbdwqifluiJ5FLoQYVCxYRxo
         n+yEFn2tzKyGjvjtzJKID/Bs2dDZ+xq6ngyFsPx0QHzhSzdvd/Cym3tPs+5GObI+U9OK
         mV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788881349; x=1789486149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GSXR5NyPzEt9NCTK8oySpuhpLuRDFNxcln3x4lU6wo=;
        b=rPDKfej5StyiKQkzKvCLMFSj/nNkaXckwPjacZkwGGxKHu8ig3NicqCHzqG0m7fW1o
         uYrT+0LwMB9F80eHdQLk3hduk/Q/pjhzsSEFzzve1pIoj7tJxqsSIJqNL/XUjDEVhAmr
         +cZrlalwz2q/3An3FblBkX7FukRfDqDj/lYBEUGxv7S/jJ36CH7oQH7ooIxKbjREo4HA
         sSZZLp4edA2tUHlBUsBJe8KvtlKvQ0rUe51+HR8FpmK0ocFidsBoue1ZmK5BSHjpcj7M
         kdxqCNARIHaGthyAb/ywh2v1unXc/8LiwQP6Igqceyc29yk6lVLFuefKuTMp2cyUY3nV
         E77A==
X-Forwarded-Encrypted: i=1; AKwUvBwyHUFqJl/DANAUUWC9CL3lcS64fmj2mY7Jo+ECcj1SZBozV422M0jdn61zhREDRl2C1RQ1hb+W+Ao=@vger.kernel.org
X-Gm-Message-State: AFuF++kNvs5lIK1nPo9zp/5rwGEHyWH6d6qA45VbOpXgq3U6qnj6zgcM
	64weOWWryiSl3AVXS95Fp0iIQEvDuT6TCX39mKyKFNjiit5ztyHpWLhmYYlT/0BLW/LHFaFwNMM
	8hW3i1p5w/ffulwQnxWz0Fyfk9YfEEdFKQCfs4R5PCXXfGCo13TsuP4/92Ipk0+KtvVMBKnE=
X-Gm-Gg: AYBFou30l2Ua6FAfIxZ/D0TL9PnhFVB45anYSVgHKarvNjDnCROGq/EuKfRAxpywYAw
	8ogV8lVVbHrirmv3ZATTdXGT2xOzAZ6iULKvgNErPaYkmwSVf/i2FCVYIsPKSXGM3vaglZxgL1T
	iD44P+qEc7rv6NC4uvlXoXzTbKVjCuUfLGkCa8IWrz8Rq1vRVg4h/iwOg+RI94Obljg5b9rBmCa
	/L4zQKY/l1joxuhdhJbqyRL93Nj8pUzeObcSwSIbz28VEOR5upJslcMSAojjEtLrgGaeGDLNf/O
	c2T+RKJIpLZyn4BeILz7G4XVc/h8VSvx1cuVP1JTvymhtsKJIBxUGx+qYE2cEE2FJhZpemy6V4M
	6NHGKN6BpnCQ7ew==
X-Received: by 2002:a05:620a:880b:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-9398033d269mr3260456885a.15.1788881349077;
        Tue, 08 Sep 2026 08:29:09 -0700 (PDT)
X-Received: by 2002:a05:620a:880b:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-9398033d269mr3260447985a.15.1788881348496;
        Tue, 08 Sep 2026 08:29:08 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm531623155e9.1.2026.09.08.08.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:29:07 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 17:28:35 +0200
Subject: [PATCH v4 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-pci-tc9563-aux-v4-2-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
In-Reply-To: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
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
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Qu9uG1yd c=1 sm=1 tr=0 ts=6aa029c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=ee_2aqc6AAAA:8 a=EUspDBNiAAAA:8 a=xgoTPrYxRPbxS4DbvaYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-ORIG-GUID: BI8WiEFrd16eK2tedFMt4u_ypJeZkbpn
X-Proofpoint-GUID: BI8WiEFrd16eK2tedFMt4u_ypJeZkbpn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfX6FyFKm8nlGIG
 0ynAY5jaX/BokWAafjjSIUrjqEofW6I67YmYF3Rm1wrBoieUYcgsJs76cYe3TCKcYDeCesQ6bBQ
 RcfQS+9loav42+7SULfKPz6SsgR+4K9NR52Ue7A10eAkpnCKb4zfjzsUdnTAPaLtUugblojTIC7
 rPDG7Fbkt71cIZsl4lNwrRLjiL2pPFrWnmtgZQiRkcMH359gaYwDXNDLIwS4T0IcF9wjR4H5u0e
 pVtkq01AwzKnyEtiKMfgp+3iapmxStf3VUIyURrZQLtomgXPJGkaiXtF7R7liA5Z4GFpwgndse+
 oOjbmEQBwK7nH9f1a2hHMBH8zDblhsNwmr9WiH0IPX40sHDyaW8VshGW6GED0jzBfq3ijyFOaQj
 5FFqWXeXzwKR6W2IEfEhGtuBE01exHSWYeQqLgRygWzvfRPHV6B+UkvVejDnmL/pBPGQBT0ELxu
 e51OzmuH2mL+sxMl91g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE2NyBTYWx0ZWRfXzQzNOBYDnq+7
 S48TG8EtZxhry8pM/wab1VZEiByLKay9uF348XN9HjZ7X0fEze3pm3hW0ZILmWypFMKqFSz4Xz3
 sOoMm4JPL52ougz8PFhW5vd8tuzv4Kg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080167

From: Alex Elder <elder@riscstar.com>

Add a driver for the GPIO controller embedded in the Toshiba TC9563
PCIe switch (and the Qualcomm QPS615). The device implements 35
GPIOs using two register banks: three registers control the first 32
GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
GPIOs 22-24, 27-28, 31, and 34 are input-only.

The driver is registered as an auxiliary device driver. The TC9563
power controller creates the auxiliary device and provides a regmap
that gives access to the GPIO registers, so the gpio-regmap helpers
are used to implement the GPIO chip.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/gpio/Kconfig            | 11 +++++
 drivers/gpio/Makefile           |  1 +
 drivers/gpio/gpio-tc9563.c      | 99 +++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/tc9563.h | 16 +++++++
 4 files changed, 127 insertions(+)

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
index 000000000000..68c20c8cba79
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
+ * upstream x4 port to two downstream PCIe x2 ports. It incorporates
+ * an internal endpoint on a internal PCIe port that implements two
+ * Synopsys XGMAC Ethernet interfaces.
+ *
+ * 37 GPIOs are also implemented by an embedded GPIO controller.  Three
+ * registers control the first 32 GPIOs (other than 20 and 21, which are
+ * reserved). Three other registers control GPIOs 32 through 36. GPIOs
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
index 000000000000..0dfd25747b9a
--- /dev/null
+++ b/include/linux/soc/qcom/tc9563.h
@@ -0,0 +1,16 @@
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
+#endif /* __QCOM_TC9563_H */

-- 
2.55.0

