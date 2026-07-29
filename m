Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7333A49252E
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332093; cv=none; b=PG7PpqgQPJz9QtsU2Lq+YxF1V/sfa9HTCPeRTRRKGrr+GbBRrBiYNjNSrceTvge45yI8bHYDDZ1qjo7/kQZiioFKI+hu4lNkLFzzWlkSeKOHtaol2tXdjdF8TyBBpPlJGJrgQrKP4DHaaLVvEixlr+aZi96EuoRawK836V64j9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332093; c=relaxed/simple;
	bh=tsG39eaBXBLq5QKuB+C9FK4uxneayJqQEqV0aOFt+ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItkfZAmZ0N7n/ngO3DOZiKy5Rd72hC1pOmYdeVGlZm34e6RGp07xhtqPiZUI2ePf4aEKWRfoFlSUdbe4zsCBz+zaQjQ8yoUII+HUv59M9SO87pq9jN/yBgT1Mq1gSaqFT0ZN4jt/WK8iuBx9N4jZB3rII5EbO5S4t8IEIsHe/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hlGEXYP+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IIYjA7eJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hlGEXYP+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IIYjA7eJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TD7vSb3073831
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2Ky9CLoS8ejaDmM4u5+HYyMycyV65WpL3IBWmOMdg4Q=; b=hlGEXYP+2EVnAClc
	xFkS0mdOSQ6+KDC07lSPFvsanSiT06nj/+rjyNSSxHXrgYllQS/480+oLDKDuJ8X
	3yDNIeCzpHtcqQGlLQRzYigqovtc6OaBc3M3m7emSEWu/OZdYb305ttSwxEuSQe5
	n3Ihtn9h1yUBZ92txKo63wlHN9mg35iwVgcld3FcSpBLO7XB1+PqjxJSpBsJpwsY
	wH8zxBbhg1qmDPJ7IbubJssGsO+VlKXEaxIbDhzTnaMgQ9zo39lumYorHU5Juoqa
	G42K0xvSo1zhcdBkWfln+rrpPLpGcNAQr7XtqzbxvuvsXRiVrEoi9xEVBAC0/jXq
	RyzNZg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3mrc1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:34:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e538afe65so115731085a.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 06:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785332087; x=1785936887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ky9CLoS8ejaDmM4u5+HYyMycyV65WpL3IBWmOMdg4Q=;
        b=IIYjA7eJb/pFiv1+omdFGNlyzH5WyNlSyhRZbFrq5GGqOI7DNxDxtyVOIPVBlqAR+u
         piWhYxF3JvCY8IGhdjpfwNi8DGs250TZapbSTRVj1V5j32JYB8cGmhcHc43ofurr//pG
         WskNsPEIORGuLa1R9jqELDgzdpxRxpsi0nXIP+byTWK0nXioByyHM3y2aCMtR0S3CJBk
         u8tz1AVUXpwI1oWKHeXL5xdEIz9SNCodFcIIazxVfSmEgE6eHkOUE3W/40d5woxkN/n7
         W6HNi4jz7ygZYJfAwjCJaOezROopDLNvHN2Mh/r7JKWNUqRZEOoOdZK8xiCPLM97JQZ6
         uPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332087; x=1785936887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Ky9CLoS8ejaDmM4u5+HYyMycyV65WpL3IBWmOMdg4Q=;
        b=rVaFl1BRlaOo78J+l/dmnnlb+KNje7rCekNyVaGSOWUSZ/E514DVYJuP4tZ0F6scrk
         6gT6uvsaXPsxJd4Yd3BCx+FxhAXVsl2xV+kaGraHswVgAQpG/EilIPzqqx5RStNpPQHL
         lh4dJU0BzXtkaGVU23aYfLkKgSTkxPrZ3Kp44Kf+kAXWb2hH7+RWXO73xtoyL5tw+kXs
         4dtIbauqsJakNrHFeUz0/qoc6xx8lcEkUglQy5EVhPRF2N0qjf+epAuhp1GNKjGcgeQb
         dWv7prLOaRKjn78xwmcJZSUJCl7X6EH/0rSHBh7bbcWDzziP0+dVgXOLJi6m1/4AM8KH
         7Rfg==
X-Forwarded-Encrypted: i=1; AHgh+RqgHYmfuuyoXIk1f2yTQL1gixkcJzy9E5nb21sAmAU+bF87sT1Q9z7yt4782Xxyz8oCNDciYL0E9eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKYSRwowZw0aHx0NP+B4jkVXYf0ohgksrvyniRbQAwpBEiwNy
	CtSXIPca0G/MNDwgMiXTxCpc6fKZ5pSRLFSdemqKHAlY+Azgrj7BOOG6Xu2sZ1Hc/wnuV9jTIue
	3ZukZPBRxgrYEYjsKu9gvA11cBpTunZMOHW/AqizHeQM8h/jT2yj6bV8U9rysbAG3ZhVHOj4=
X-Gm-Gg: AR+sD12MUE4BceIVyn95dqR6b7mV1l/9QoFNlp3kZX1+tN2NR+V7H5Hb2mVHQh0MjkJ
	dbI5g6HfRelhgxrp87Vp6THObv3pMk7zN/vdEB+qH5na5M7zLio6zviglrBgb0kI+VqomjHBy2X
	WKcGHyYps5UQbUzFh27hiVkHWIIj4FpXOaVDSDkgCE4vnrCQBFi3M7sY/aW47eG0HX4yIBjnf+L
	sDWc2Ho1mlbHZEsyeRxRUsUL+zEqa1eNULitt5dvpmHkl+apaA2KVhQiC3hGecjHtj2XfFg4G3F
	yRGVsNveAhyfN7icg4IjKJIBks1KnAhoLb/mLGN0un9eVUU4HeVwOx57ycKc2Ay62uN3Kv9Xdgs
	0IgWGn9kXWbJn6os=
X-Received: by 2002:a05:622a:82:b0:51b:eb07:28bf with SMTP id d75a77b69052e-529d70f651emr59125961cf.22.1785332087124;
        Wed, 29 Jul 2026 06:34:47 -0700 (PDT)
X-Received: by 2002:a05:622a:82:b0:51b:eb07:28bf with SMTP id d75a77b69052e-529d70f651emr59125401cf.22.1785332086449;
        Wed, 29 Jul 2026 06:34:46 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f5d541bf7sm4328071fa.0.2026.07.29.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:34:45 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 15:34:25 +0200
Subject: [PATCH 1/2] PCI/pwrctrl: tc9563: rely on regmap APIs
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-pci-pwrctrl-tc956x-regmap-v1-1-20ce61a3ce12@oss.qualcomm.com>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExMiBTYWx0ZWRfX01NZzJcsvmCa
 136erFXZ2FLYAGH7O+1ZqrWJN0WbqsacqsC4TI7iq00gWkBkUZ0HdVTUMVNLWt9QA2ycCU/kmaB
 duD07ehJzxgUlTGgheVY6Y3BtPAGHjOvF8ZElgR5vbShJsqzX8lt4darsFdIiskVLvLRMbm0yuH
 6RBVIZEkkQc3EM0FQP9bdinSJoB5+f+pbW/OtES8o/zmPTEgX1H0x+4epbMX7ZxZASxniJfhTaY
 IEZnpKzkaIadgp3Wz9t7JBjamYKv48yA6PocWYeikNuLjr/g2Q+3AYy92ZPqr8FYD1donMrKN+V
 Dg4gRs/lG3QHAxatAV+AKM7u0HLKnHLScejLEOY6dtxa/LT3Wb5BAIVJr4uxnILK8EaKxugcMW9
 S6n/DHzD904UnhhpCBBYoZFaNENhFmI0t+BgF7gdWt7yFskmi8blowl854PD8y5COf3EFN8rtV7
 NeB13U82D44gROZnP+A==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a0178 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=-HNuO67INYoN09regHEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: _N9sXEvE_qjbQlLMaW_tOTgIGJRC9Cr8
X-Proofpoint-ORIG-GUID: _N9sXEvE_qjbQlLMaW_tOTgIGJRC9Cr8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExMiBTYWx0ZWRfX8/vyS7uWAlxa
 6u6wLMqgrDKRHr2zNx5rtJiXY5MUgfZeWmeAxaXOaHdorCkRDCT5Twoq3n5xi25iAyf9EckKVV1
 Ne7u7x+CaSrZeHeamzX5L3yKOjpR70Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290112

Replace the custom tc9563_pwrctrl_i2c_{read,write,bulk_write} functions
with standard regmap APIs. The device uses 24-bit big-endian register
addresses and 32-bit little-endian register values over I2C, which is
directly supported by regmap.

This removes the open-coded I2C transfer handling and lets the regmap
core handle formatting, locking, and multi-register coalescing.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/Kconfig              |   1 +
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 153 +++++++++----------------------
 2 files changed, 44 insertions(+), 110 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 9eec767cda86..1952ab4f29b6 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -29,6 +29,7 @@ config PCI_PWRCTRL_TC9563
 	select PCI_PWRCTRL
 	default m if ARCH_QCOM
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
 	  switch.
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index db744fbfc09a..8bccf3abd189 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -17,10 +17,10 @@
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/unaligned.h>
 
 #include "../pci.h"
 
@@ -71,11 +71,6 @@
 
 #define TC9563_L0S_L1_DELAY_UNIT_NS	256  /* Each unit represents 256 ns */
 
-struct tc9563_pwrctrl_reg_setting {
-	unsigned int offset;
-	unsigned int val;
-};
-
 enum tc9563_pwrctrl_ports {
 	TC9563_USP,
 	TC9563_DSP1,
@@ -112,13 +107,14 @@ struct tc9563_pwrctrl {
 	struct gpio_desc *reset_gpio;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client;
+	struct regmap *regmap;
 };
 
 /*
  * downstream port power off sequence, hardcoding the address
  * as we don't know register names for these register offsets.
  */
-static const struct tc9563_pwrctrl_reg_setting common_pwroff_seq[] = {
+static const struct reg_sequence common_pwroff_seq[] = {
 	{0x82900c, 0x1},
 	{0x829010, 0x1},
 	{0x829018, 0x0},
@@ -141,7 +137,7 @@ static const struct tc9563_pwrctrl_reg_setting common_pwroff_seq[] = {
 	{0x829114, 0x1},
 };
 
-static const struct tc9563_pwrctrl_reg_setting dsp1_pwroff_seq[] = {
+static const struct reg_sequence dsp1_pwroff_seq[] = {
 	{TC9563_PORT_ACCESS_ENABLE, 0x2},
 	{TC9563_PORT_LANE_ACCESS_ENABLE, 0x3},
 	{TC9563_POWER_CONTROL, 0x014f4804},
@@ -149,7 +145,7 @@ static const struct tc9563_pwrctrl_reg_setting dsp1_pwroff_seq[] = {
 	{TC9563_PORT_ACCESS_ENABLE, 0x4},
 };
 
-static const struct tc9563_pwrctrl_reg_setting dsp2_pwroff_seq[] = {
+static const struct reg_sequence dsp2_pwroff_seq[] = {
 	{TC9563_PORT_ACCESS_ENABLE, 0x8},
 	{TC9563_PORT_LANE_ACCESS_ENABLE, 0x1},
 	{TC9563_POWER_CONTROL, 0x014f4804},
@@ -157,85 +153,11 @@ static const struct tc9563_pwrctrl_reg_setting dsp2_pwroff_seq[] = {
 	{TC9563_PORT_ACCESS_ENABLE, 0x8},
 };
 
-/*
- * Since all transfers are initiated by the probe, no locks are necessary,
- * as there are no concurrent calls.
- */
-static int tc9563_pwrctrl_i2c_write(struct i2c_client *client,
-				    u32 reg_addr, u32 reg_val)
-{
-	struct i2c_msg msg;
-	u8 msg_buf[7];
-	int ret;
-
-	msg.addr = client->addr;
-	msg.len = 7;
-	msg.flags = 0;
-
-	/* Big Endian for reg addr */
-	put_unaligned_be24(reg_addr, &msg_buf[0]);
-
-	/* Little Endian for reg val */
-	put_unaligned_le32(reg_val, &msg_buf[3]);
-
-	msg.buf = msg_buf;
-	ret = i2c_transfer(client->adapter, &msg, 1);
-	return ret == 1 ? 0 : ret;
-}
-
-static int tc9563_pwrctrl_i2c_read(struct i2c_client *client,
-				   u32 reg_addr, u32 *reg_val)
-{
-	struct i2c_msg msg[2];
-	u8 wr_data[3];
-	u32 rd_data;
-	int ret;
-
-	msg[0].addr = client->addr;
-	msg[0].len = 3;
-	msg[0].flags = 0;
-
-	/* Big Endian for reg addr */
-	put_unaligned_be24(reg_addr, &wr_data[0]);
-
-	msg[0].buf = wr_data;
-
-	msg[1].addr = client->addr;
-	msg[1].len = 4;
-	msg[1].flags = I2C_M_RD;
-
-	msg[1].buf = (u8 *)&rd_data;
-
-	ret = i2c_transfer(client->adapter, &msg[0], 2);
-	if (ret == 2) {
-		*reg_val = get_unaligned_le32(&rd_data);
-		return 0;
-	}
-
-	/* If only one message successfully completed, return -EIO */
-	return ret == 1 ? -EIO : ret;
-}
-
-static int tc9563_pwrctrl_i2c_bulk_write(struct i2c_client *client,
-				const struct tc9563_pwrctrl_reg_setting *seq,
-				int len)
-{
-	int ret, i;
-
-	for (i = 0; i < len; i++) {
-		ret = tc9563_pwrctrl_i2c_write(client, seq[i].offset, seq[i].val);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
 				       enum tc9563_pwrctrl_ports port)
 {
 	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
-	const struct tc9563_pwrctrl_reg_setting *seq;
+	const struct reg_sequence *seq;
 	int ret, len;
 
 	if (!cfg->disable_port)
@@ -255,12 +177,12 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
 		return 0;
 	}
 
-	ret = tc9563_pwrctrl_i2c_bulk_write(tc9563->client, seq, len);
+	ret = regmap_multi_reg_write(tc9563->regmap, seq, len);
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, common_pwroff_seq,
-					     ARRAY_SIZE(common_pwroff_seq));
+	return regmap_multi_reg_write(tc9563->regmap, common_pwroff_seq,
+				      ARRAY_SIZE(common_pwroff_seq));
 }
 
 static int tc9563_pwrctrl_set_port_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
@@ -276,14 +198,13 @@ static int tc9563_pwrctrl_set_port_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9
 	/* convert to units of 256ns */
 	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
 
-	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
-				       BIT(port));
+	ret = regmap_write(tc9563->regmap, TC9563_PORT_SELECT, BIT(port));
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_write(tc9563->client,
-			is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY,
-			units);
+	return regmap_write(tc9563->regmap,
+			    is_l1 ? TC9563_PORT_L1_DELAY : TC9563_PORT_L0S_DELAY,
+			    units);
 }
 
 static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
@@ -298,8 +219,7 @@ static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc95
 	/* convert to units of 256ns */
 	units = ns / TC9563_L0S_L1_DELAY_UNIT_NS;
 
-	ret = tc9563_pwrctrl_i2c_read(tc9563->client, TC9563_EMBEDDED_ETH_DELAY,
-				      &rd_val);
+	ret = regmap_read(tc9563->regmap, TC9563_EMBEDDED_ETH_DELAY, &rd_val);
 	if (ret)
 		return ret;
 
@@ -310,8 +230,7 @@ static int tc9563_pwrctrl_set_eth_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc95
 		rd_val = u32_replace_bits(rd_val, units,
 					  TC9563_ETH_L0S_DELAY_MASK);
 
-	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_EMBEDDED_ETH_DELAY,
-					rd_val);
+	return regmap_write(tc9563->regmap, TC9563_EMBEDDED_ETH_DELAY, rd_val);
 }
 
 static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
@@ -344,14 +263,14 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
 		return -EINVAL;
 	}
 
-	struct tc9563_pwrctrl_reg_setting tx_amp_seq[] = {
+	struct reg_sequence tx_amp_seq[] = {
 		{TC9563_PORT_ACCESS_ENABLE, port_access},
 		{TC9563_PORT_LANE_ACCESS_ENABLE, 0x3},
 		{TC9563_TX_MARGIN, amp},
 	};
 
-	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, tx_amp_seq,
-					     ARRAY_SIZE(tx_amp_seq));
+	return regmap_multi_reg_write(tc9563->regmap, tx_amp_seq,
+				      ARRAY_SIZE(tx_amp_seq));
 }
 
 static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
@@ -384,7 +303,7 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
 		return -EINVAL;
 	}
 
-	struct tc9563_pwrctrl_reg_setting disable_dfe_seq[] = {
+	struct reg_sequence disable_dfe_seq[] = {
 		{TC9563_PORT_ACCESS_ENABLE, port_access},
 		{TC9563_PORT_LANE_ACCESS_ENABLE, lane_access},
 		{TC9563_DFE_ENABLE, 0x0},
@@ -398,15 +317,15 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
 		{TC9563_PHY_RATE_CHANGE_OVERRIDE, 0x0},
 	};
 
-	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, disable_dfe_seq,
-					     ARRAY_SIZE(disable_dfe_seq));
+	return regmap_multi_reg_write(tc9563->regmap, disable_dfe_seq,
+				      ARRAY_SIZE(disable_dfe_seq));
 }
 
 static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
 				   enum tc9563_pwrctrl_ports port)
 {
 	u8 *nfts = tc9563->cfg[port].nfts;
-	struct tc9563_pwrctrl_reg_setting nfts_seq[] = {
+	struct reg_sequence nfts_seq[] = {
 		{TC9563_NFTS_2_5_GT, nfts[0]},
 		{TC9563_NFTS_5_GT, nfts[1]},
 	};
@@ -421,13 +340,12 @@ static int tc9563_pwrctrl_set_nfts(struct tc9563_pwrctrl *tc9563,
 		return 0;
 	}
 
-	ret =  tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_PORT_SELECT,
-					BIT(port));
+	ret =  regmap_write(tc9563->regmap, TC9563_PORT_SELECT, BIT(port));
 	if (ret)
 		return ret;
 
-	return tc9563_pwrctrl_i2c_bulk_write(tc9563->client, nfts_seq,
-					     ARRAY_SIZE(nfts_seq));
+	return regmap_multi_reg_write(tc9563->regmap, nfts_seq,
+				      ARRAY_SIZE(nfts_seq));
 }
 
 static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
@@ -435,14 +353,14 @@ static int tc9563_pwrctrl_assert_deassert_reset(struct tc9563_pwrctrl *tc9563,
 {
 	int ret, val;
 
-	ret = tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_GPIO_CONFIG,
-				       TC9563_GPIO_MASK);
+	ret = regmap_write(tc9563->regmap, TC9563_GPIO_CONFIG,
+			   TC9563_GPIO_MASK);
 	if (ret)
 		return ret;
 
 	val = deassert ? TC9563_GPIO_DEASSERT_BITS : 0;
 
-	return tc9563_pwrctrl_i2c_write(tc9563->client, TC9563_RESET_GPIO, val);
+	return regmap_write(tc9563->regmap, TC9563_RESET_GPIO, val);
 }
 
 static int tc9563_pwrctrl_parse_device_dt(struct device_node *node,
@@ -573,6 +491,13 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 	return ret;
 }
 
+static const struct regmap_config tc9563_regmap_config = {
+	.reg_bits = 24,
+	.val_bits = 32,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
 static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -603,6 +528,14 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(tc9563->client);
 	}
 
+	tc9563->regmap = devm_regmap_init_i2c(tc9563->client,
+					      &tc9563_regmap_config);
+	if (IS_ERR(tc9563->regmap)) {
+		ret = dev_err_probe(dev, PTR_ERR(tc9563->regmap),
+				    "Failed to allocate register map\n");
+		goto remove_i2c;
+	}
+
 	for (int i = 0; i < ARRAY_SIZE(tc9563_supply_names); i++)
 		tc9563->supplies[i].supply = tc9563_supply_names[i];
 

-- 
2.55.0

