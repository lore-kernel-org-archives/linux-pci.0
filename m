Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7A361972
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464764; cv=none; b=dUOS3YUxHZ13WvsUzAS0j4oGEyp+8y9itYxs2Q/Zg0xGLDf+tGuEM6bcMPnMlncED8sjGEb2ruTwGdzsYTz4DorSAFsf8XVu+KpgrIvrLN19XqkeHTM5ozaaMtMRxvF3r9GyflsbC4QRlgt7cfC9lr6YyOam5SNAKCxS4a13cYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464764; c=relaxed/simple;
	bh=IoF7WM2BoEUQmn0Zu1Bt76I4sljyLoCivSIbiJCQIVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TT8ie/6h1jD+A3aTrmfyaVhChLcfUJ3eaD8HFDY2WQVvxyM6oNL6Oo6NpniL+Qt9Y/N+mKUFfbSFJtefvnic1rANpBAgs61KUi/sIpbUh9TAlOzEiiaLp6kzbvsLMXXa+W/TDji1NMR6WAJTI00RL5JnUDomUGHBCjQ7/tIwOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Os5zSREg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CSarTKZM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Os5zSREg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CSarTKZM"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX51o767022
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 16:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UvbYGlBQ0+54fqa2nzlVV7
	veLHHzznEOFsTjsNmU6Uw=; b=Os5zSREgld6zTzTAD8uPPxIS4ctIyYDPkXeis/
	BBpaXVDNTasDWoe6PQF9OKY3NTO2r/paLBBbQNGYsqrQanlnil20cAYEPmhuFNzz
	JjN3FoBjXkxY4eMbdphHpTbWkh8LnM6r9MCCGWDDhCfgRnUS7gq0HRIczq/xv2cs
	c5KBzaG9TZxz3xuVbKw7hjJ11+CfEpEEmGduOMeZpkMrfZN8/gTamJkzL7LV3TUH
	OJnYRotAI6aFoPtfM73GhRZFuPfQC/eqSllqZvX66WEfCmilPwdlRt5CTF7rk+4n
	DeDZ7rIe2SPjo7wkNRTkSxdZoxkc9shrpGDOBRunfWzJ0VaQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc1euu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 16:12:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-392cf18db8eso48375a91.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786464759; x=1787069559; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UvbYGlBQ0+54fqa2nzlVV7veLHHzznEOFsTjsNmU6Uw=;
        b=CSarTKZMrejovl7oucmB7lvJeydlD0+wl7rCrfvrSnGbej76+oHBQ3NQixr0lOqgSB
         0EiAfpJ3cRi23cpZGdSTRCrXQu7UN1VgVXXREm5ow2Kw/w5ERFkniKuwXhWEqOR1ApZV
         sxEj11tG6N9lKXtNNWGj8z6OUft3SR6QIBpqn0xluE55ynhnlzseRtc08n5WiczFmhMH
         csU9DBnb7KK7SaKERsP6ipo2YWamRUsZaii+Hby6Pc4KL52Qgx5i5TUT0+uHeMfB0nh6
         jvHeIK0VfccgMv8oP4kmpSFxoXN3pXU4fO6h2R3NMalXnlynQE6xhWFoqbQR6CWsXjXm
         owJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786464759; x=1787069559;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UvbYGlBQ0+54fqa2nzlVV7veLHHzznEOFsTjsNmU6Uw=;
        b=QJqC6Xcj1QtNgQ/8hn1qMvgSDL2oOiEa7VlDiGr7bOH5Nz0iOWpJg4lzLU1lobD93P
         zQm5CzgFPSYJTrAOPGLwfn4FOKKHNIv18NE/qS023knUlGw5V5gzyzc7bF6tqOeVC72h
         XZ/Iafh3080VYNFxK/wSoO6TcwmhyL8A7Z6tuhyNb+dPxO7FhcGJU9wLKltYoObFa2OO
         AMEXXvxXJFXZuOX3PfsqokkfZRfr3EhY/Kfit2OvebDK2qu/AWKpdemQiurlhm1khrk9
         /j0zq0Vz+Rq09zTySUPy6J+ABI07HyJbHRZV++MEfQg/7P7yK1sdogplxukwuXlNOi35
         6OPQ==
X-Gm-Message-State: AOJu0YxivHlGeZgnjDPx735dNs74smuK3/PC4bsz6Ub8NMoVONacH5E2
	XTjwASKZMBUYzembweyQqFhW4u9JbEYs7PtJAVE15jR5ig8MFmM3os9CJq5nX+yrxw60wiQ/qMX
	z8RoPoPKLkX0ID+ATRKLUHh8PNCk7i1piUtM8QiwVRQIQUM6KSaqL9tyhaui1g4MsBfBOXy8=
X-Gm-Gg: AR+sD12BeM8n6mVLymSmq566kJhpCB6P1YsbB1FF55OZpGlQHuC3jq2QpmYIihx1Gd0
	miwU/1lUSMkJ0M+7XjaLA4q9l3y5HCcUQa5MDokcr9bSoSN1qkAxYJs2CVG+OjCdIe3aHAy549p
	rdMHxTCVI7jqOawjfkEUEpRgpC7Dx9ykupIaWWujZKUOw919Svx6KspJf6Y6Xt0pXoywGg3Lusj
	62Pn3fQJ8mMqyVDeAUPOdJfctlqvFTXoi7awUcLCkR1D2m2PsrYRHiXte0o45m79RN4YH2tJMhf
	kB4rq7IrVbiRk00QwdDaIn4y227oopH30dwqu7OPX1m3YZo59Zax7vGDyKlpCvSo/VtyopL4/JI
	G+wdjnn6jcs08W6m9+QSFY8AFwq8qgydur68=
X-Received: by 2002:a17:90b:17cf:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-392ec33737amr4696168a91.5.1786464758997;
        Tue, 11 Aug 2026 09:12:38 -0700 (PDT)
X-Received: by 2002:a17:90b:17cf:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-392ec33737amr4696063a91.5.1786464758336;
        Tue, 11 Aug 2026 09:12:38 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6d7a3c7sm1300033eec.29.2026.08.11.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:12:37 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 21:42:23 +0530
Subject: [PATCH] PCI: qcom: Add register dump support for PCIe Link Down
 events
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-regdump-v1-1-f22db3fb37c2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOZJe2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0ND3aLU9JTS3AJdQ0NzQ8s0c9OUVINkJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tAETpwgprAAAA
X-Change-ID: 20260811-regdump-11719f75de0c
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786464754; l=17718;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=IoF7WM2BoEUQmn0Zu1Bt76I4sljyLoCivSIbiJCQIVw=;
 b=fLqvoPr7RRuD7x4X75SGaAoIPJDVt+HYL8dcWN9aSsrlxizgChPLOTRd8MIzEwSVr+eDMTk42
 dm/7jrwhVhYAQ9V8YqGH/Rh9rP25YEocWet5x/fpgYBiuGvUO4wIPLM
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzNSBTYWx0ZWRfX5BU9FUYLqErI
 FuHj5dR/efhrH3VR5amrkzQDtau2CXFLZn71GmijVriha71+lhICzqJII2SSsRqmeEE49Z5SIH3
 LrMDtpGMaPTV/w03N8pYcqa5FmNI7NE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzNSBTYWx0ZWRfXyMbxA37MnF2/
 /xMnom+B7/wOcPhBP3TW/Za+U/T1SgHJZtMWWahHccNtOYr6QJKOPa80F+SAEpmkTKmK6H7eajO
 rXXOLj/9GCtFawwZrHloXgJhT5ES7Pz1v+qZVsLqZlZ8tetN2d5nkCxqAFKSFnJblsbBVMw3Kse
 dHfMe7DORs3A/ZOOcyPjA5VsXsmxyp+u7/KSlDgVyusHI0FakTG9ZTogkZWxOvJRSVfWCjjeSMR
 V8bAdFSbfqx1TQ773cfQb5HKki7mrgQ4IbQ/Ukpd1+I6wwjgPKESco/E3D97ygKGYCCTj9M6u+l
 9Tr63Cqz7eJ07iOGYBigimnTDtjUghA0ZWLTbrVQgXiaTZIg8UqroTBZ2Av19FwNzSFBRxIIqi9
 zjRJQiFoC/AnUcuKhOMzOig8tE0lI3cSM9U+efemhttyQtBt0D5xOFtp4OtWE0mOYtE+28ssK2T
 E0Km3Tdqa/74fspQy7g==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b49f8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=D3F8pNBI7PI_tEzsiekA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: G4jjZoxStv6PEAcIBF4SphObzcuBM0In
X-Proofpoint-GUID: G4jjZoxStv6PEAcIBF4SphObzcuBM0In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110135

When the PCIe link goes down unexpectedly, being able to inspect the
state of key controller registers at the time of failure is valuable
for root-causing the issue.

If a storage endpoint is present downstream, the dump is printed
directly via dev_err() so it is visible in dmesg immediately, since a
devcoredump read from userspace could otherwise race with a storage
failure. Otherwise, the buffer is handed to the devcoredump framework
so it can be collected from /sys/class/devcoredump/ for offline
analysis.

To keep the dump readable given the number of registers involved,
entries are packed as "offset: value" pairs, QCOM_PCIE_DUMP_REGS_PER_LINE
(4) per dmesg line, with a section header ("DBI registers:", "PARF
registers:", "MHI registers:") identifying each register group.

Also expose the same dump on demand via a new "regdump" debugfs file
under the existing per-controller debugfs directory, so the register
state can be inspected without needing an actual Link Down event.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h |   6 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 328 +++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h                |   2 +
 3 files changed, 336 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 1d2139474157..14d6d441c1a5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -290,6 +290,12 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+/* SD-EQ (Gen5 32 GT/s per-lane pre/post cursor equalization) registers */
+#define PCIE_RAS_DES_SD_EQ_CONTROL1		0xd0
+#define PCIE_RAS_DES_SD_EQ_CONTROL1_LANE_SEL	GENMASK(3, 0)
+#define PCIE_RAS_DES_SD_EQ_STATUS2		0xe4
+#define PCIE_RAS_DES_SD_EQ_STATUS3		0xe8
+
 /* PTM register definitions */
 #define PTM_RES_REQ_CTRL		0x8
 #define PTM_RES_CCONTEXT_VALID		BIT(0)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..a9b1d8327c72 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -12,6 +12,7 @@
 #include <linux/crc8.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/devcoredump.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
@@ -44,6 +45,8 @@
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
 #define PARF_PM_CTRL				0x20
+#define PARF_PM_STTS				0x24
+#define PARF_PM_STTS_1				0x28
 #define PARF_PCS_DEEMPH				0x34
 #define PARF_PCS_SWING				0x38
 #define PARF_PHY_CTRL				0x40
@@ -62,11 +65,17 @@
 #define PARF_STATUS				0x230
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
+#define PARF_CLKREQ_OVERRIDE			0x2b0
 #define PARF_DBI_BASE_ADDR_V2			0x350
 #define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
 #define PARF_NO_SNOOP_OVERRIDE			0x3d4
+#define PARF_CORE_ERRORS			0x3c0
+#define PARF_L1SS_SLEEP_MODE_HANDLER_STATUS	0x4d0
+#define PARF_L1SS_SLEEP_MODE_HANDLER_CFG	0x4d4
+#define PARF_INT_ALL_2_STATUS			0x500
+#define PARF_LINK_DOWN_AXI_ECAM_BLOCK_STATUS	0x630
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
@@ -83,8 +92,12 @@
 
 /* MHI registers */
 #define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L1SUB	0xc08
 #define PARF_DEBUG_CNT_PM_LINKST_IN_L1		0xc0c
 #define PARF_DEBUG_CNT_PM_LINKST_IN_L0S		0xc10
+#define PARF_DEBUG_CNT_AUX_CLK_APP_REQ_EXIT_L1		0xc14
+#define PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L23	0xc18
+#define PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L1	0xc1c
 #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
 #define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
 
@@ -188,11 +201,48 @@
 #define PERST_DELAY_US				1000
 #define FLUSH_TIMEOUT_US			100
 
+/* Dump buffer size for the link-down register dump */
+#define QCOM_PCIE_DUMP_BUF_SIZE			SZ_8K
+
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
 #define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
 		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_get_link_speed(speed)))
 
+#define QCOM_PCIE_DUMP_REGS_PER_LINE	4
+
+static const u32 qcom_pcie_parf_dump_regs[] = {
+	PARF_LTSSM,
+	PARF_INT_ALL_STATUS,
+	PARF_SYS_CTRL,
+};
+
+static const u32 qcom_pcie_ext_parf_dump_regs[] = {
+	PARF_PM_STTS,
+	PARF_PM_STTS_1,
+	PARF_INT_ALL_STATUS,
+	PARF_INT_ALL_2_STATUS,
+	PARF_CLKREQ_OVERRIDE,
+	PARF_L1SS_SLEEP_MODE_HANDLER_STATUS,
+	PARF_L1SS_SLEEP_MODE_HANDLER_CFG,
+	PARF_CORE_ERRORS,
+	PARF_LINK_DOWN_AXI_ECAM_BLOCK_STATUS,
+	PARF_STATUS,
+	PARF_SYS_CTRL,
+};
+
+static const u32 qcom_pcie_mhi_dump_regs[] = {
+	PARF_DEBUG_CNT_PM_LINKST_IN_L2,
+	PARF_DEBUG_CNT_PM_LINKST_IN_L1SUB,
+	PARF_DEBUG_CNT_PM_LINKST_IN_L1,
+	PARF_DEBUG_CNT_PM_LINKST_IN_L0S,
+	PARF_DEBUG_CNT_AUX_CLK_APP_REQ_EXIT_L1,
+	PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L23,
+	PARF_DEBUG_CNT_AUX_CLK_APP_READY_ENTER_L1,
+	PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1,
+	PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2,
+};
+
 struct qcom_pcie_resources_1_0_0 {
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -275,12 +325,15 @@ struct qcom_pcie_ops {
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
   * @firmware_managed: Set if the Root Complex is firmware managed
+  * @has_ext_parf_regs: Set if the PARF block implements the extended
+  * register set used by qcom_pcie_dump_regs().
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	bool override_no_snoop;
 	bool firmware_managed;
 	bool no_l0s;
+	bool has_ext_parf_regs;
 };
 
 struct qcom_pcie_perst {
@@ -1597,12 +1650,14 @@ static const struct qcom_pcie_cfg cfg_1_0_0 = {
 
 static const struct qcom_pcie_cfg cfg_1_9_0 = {
 	.ops = &ops_1_9_0,
+	.has_ext_parf_regs = true,
 };
 
 static const struct qcom_pcie_cfg cfg_1_34_0 = {
 	.ops = &ops_1_9_0,
 	.override_no_snoop = true,
 	.no_l0s = true,
+	.has_ext_parf_regs = true,
 };
 
 static const struct qcom_pcie_cfg cfg_2_1_0 = {
@@ -1624,6 +1679,7 @@ static const struct qcom_pcie_cfg cfg_2_4_0 = {
 
 static const struct qcom_pcie_cfg cfg_2_7_0 = {
 	.ops = &ops_2_7_0,
+	.has_ext_parf_regs = true,
 };
 
 static const struct qcom_pcie_cfg cfg_2_9_0 = {
@@ -1633,6 +1689,7 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.ops = &ops_1_21_0,
 	.no_l0s = true,
+	.has_ext_parf_regs = true,
 };
 
 static const struct qcom_pcie_cfg cfg_fw_managed = {
@@ -1760,6 +1817,274 @@ static int qcom_pcie_set_max_opp(struct device *dev)
 	return ret;
 }
 
+static int qcom_pcie_has_storage_ep_cb(struct pci_dev *pdev, void *data)
+{
+	bool *found = data;
+
+	if (pdev->class >> 16 == PCI_BASE_CLASS_STORAGE) {
+		*found = true;
+		return 1;
+	}
+
+	return 0;
+}
+
+static bool qcom_pcie_has_storage_ep(struct qcom_pcie *pcie)
+{
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+	bool found = false;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_has_storage_ep_cb, &found);
+
+	return found;
+}
+
+/*
+ * qcom_pcie_dump_advance_col - advance @col and append a separator to @buf.
+ *
+ * @col tracks the current column within the active section and must be
+ * reset to 0 by the caller at the start of each new section; a newline is
+ * emitted every QCOM_PCIE_DUMP_REGS_PER_LINE entries to keep the dump
+ * compact in dmesg.
+ */
+static size_t qcom_pcie_dump_advance_col(char *buf, size_t buf_size, int *col)
+{
+	*col += 1;
+
+	return scnprintf(buf, buf_size,
+			 (*col % QCOM_PCIE_DUMP_REGS_PER_LINE) ? "  " : "\n");
+}
+
+static size_t qcom_pcie_dump_reg_val(char *buf, size_t buf_size, int *col,
+				     u32 offset, u32 val)
+{
+	size_t len;
+
+	len = scnprintf(buf, buf_size, "0x%03x: 0x%08x", offset, val);
+	len += qcom_pcie_dump_advance_col(buf + len, buf_size - len, col);
+
+	return len;
+}
+
+/* Same as qcom_pcie_dump_reg_val(), but tags the entry with a lane number
+ * since the RAS-DES SD-EQ status registers are read once per lane at a
+ * fixed offset, so the offset alone can't tell entries apart.
+ */
+static size_t qcom_pcie_dump_lane_reg_val(char *buf, size_t buf_size, int *col,
+					  int lane, u32 offset, u32 val)
+{
+	size_t len;
+
+	len = scnprintf(buf, buf_size, "L%d/0x%03x: 0x%08x", lane, offset, val);
+	len += qcom_pcie_dump_advance_col(buf + len, buf_size - len, col);
+
+	return len;
+}
+
+static size_t qcom_pcie_dump_reg_table(void __iomem *base, const u32 *regs,
+				       int nregs, char *buf, size_t buf_size)
+{
+	size_t len = 0;
+	int col = 0;
+	int i;
+
+	for (i = 0; i < nregs; i++)
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					      regs[i], readl_relaxed(base + regs[i]));
+
+	if (col % QCOM_PCIE_DUMP_REGS_PER_LINE)
+		len += scnprintf(buf + len, buf_size - len, "\n");
+
+	return len;
+}
+
+/*
+ * qcom_pcie_fill_dump_buf - fill @buf with key PCIe register values captured
+ * at Link Down time.
+ *
+ * Returns the number of bytes written into @buf.
+ */
+static size_t qcom_pcie_fill_dump_buf(struct qcom_pcie *pcie, char *buf,
+				      size_t buf_size)
+{
+	struct dw_pcie *pci = pcie->pci;
+	u16 exp_cap, aer_cap, l1ss_cap, secpci_cap, pl16gt_cap, pl32gt_cap;
+	size_t len = 0;
+	int col = 0;
+	u32 val;
+
+	len += scnprintf(buf + len, buf_size - len, "DBI registers:\n");
+
+	exp_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	if (exp_cap) {
+		val = dw_pcie_readl_dbi(pci, exp_cap + PCI_EXP_LNKCAP);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     exp_cap + PCI_EXP_LNKCAP, val);
+
+		val = dw_pcie_readl_dbi(pci, exp_cap + PCI_EXP_LNKCTL);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     exp_cap + PCI_EXP_LNKCTL, val);
+
+		val = dw_pcie_readl_dbi(pci, exp_cap + PCI_EXP_LNKCTL2);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     exp_cap + PCI_EXP_LNKCTL2, val);
+	}
+
+	aer_cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_ERR);
+	if (aer_cap) {
+		val = dw_pcie_readl_dbi(pci, aer_cap + PCI_ERR_UNCOR_STATUS);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     aer_cap + PCI_ERR_UNCOR_STATUS, val);
+
+		val = dw_pcie_readl_dbi(pci, aer_cap + PCI_ERR_COR_STATUS);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     aer_cap + PCI_ERR_COR_STATUS, val);
+	}
+
+	l1ss_cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (l1ss_cap) {
+		val = dw_pcie_readl_dbi(pci, l1ss_cap + PCI_L1SS_CTL1);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     l1ss_cap + PCI_L1SS_CTL1, val);
+	}
+
+	secpci_cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI);
+	if (secpci_cap) {
+		val = dw_pcie_readl_dbi(pci, secpci_cap + PCI_SECPCI_LE_CTRL);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     secpci_cap + PCI_SECPCI_LE_CTRL, val);
+
+		val = dw_pcie_readl_dbi(pci, secpci_cap + PCI_SECPCI_LE_CTRL + 4);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     secpci_cap + PCI_SECPCI_LE_CTRL + 4, val);
+	}
+
+	pl16gt_cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PL_16GT);
+	if (pl16gt_cap) {
+		val = dw_pcie_readl_dbi(pci, pl16gt_cap + PCI_PL_16GT_LE_CTRL);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     pl16gt_cap + PCI_PL_16GT_LE_CTRL, val);
+
+		val = dw_pcie_readl_dbi(pci, pl16gt_cap + PCI_PL_16GT_STATUS);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     pl16gt_cap + PCI_PL_16GT_STATUS, val);
+	}
+
+	pl32gt_cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PL_32GT);
+	if (pl32gt_cap) {
+		val = dw_pcie_readl_dbi(pci, pl32gt_cap + PCI_PL_32GT_LE_CTRL);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     pl32gt_cap + PCI_PL_32GT_LE_CTRL, val);
+
+		val = dw_pcie_readl_dbi(pci, pl32gt_cap + PCI_PL_32GT_STATUS);
+		len += qcom_pcie_dump_reg_val(buf + len, buf_size - len, &col,
+					     pl32gt_cap + PCI_PL_32GT_STATUS, val);
+	}
+
+	/*
+	 * Gen5 (32 GT/s) local/remote pre/post cursor status, read through the
+	 * SD-EQ registers inside the DWC RAS-DES vendor-specific extended
+	 * capability. For each lane, write the lane selector into
+	 * PCIE_RAS_DES_SD_EQ_CONTROL1 then read back
+	 * PCIE_RAS_DES_SD_EQ_STATUS2/3, which carry the local/remote pre/post
+	 * cursor values.
+	 */
+	if (pcie_get_link_speed(pci->max_link_speed) == PCIE_SPEED_32_0GT) {
+		u16 rasdes_cap = dw_pcie_find_rasdes_capability(pci);
+
+		if (rasdes_cap) {
+			int num_lanes = dw_pcie_link_get_max_link_width(pci);
+			int lane;
+
+			for (lane = 0; lane < num_lanes; lane++) {
+				dw_pcie_writel_dbi(pci,
+						   rasdes_cap + PCIE_RAS_DES_SD_EQ_CONTROL1,
+						   lane & PCIE_RAS_DES_SD_EQ_CONTROL1_LANE_SEL);
+
+				val = dw_pcie_readl_dbi(pci,
+							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS2);
+				len += qcom_pcie_dump_lane_reg_val(buf + len, buf_size - len, &col,
+							lane,
+							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS2,
+							val);
+
+				val = dw_pcie_readl_dbi(pci,
+							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS3);
+				len += qcom_pcie_dump_lane_reg_val(buf + len, buf_size - len, &col,
+							lane,
+							rasdes_cap + PCIE_RAS_DES_SD_EQ_STATUS3,
+							val);
+			}
+		}
+	}
+
+	if (col % QCOM_PCIE_DUMP_REGS_PER_LINE)
+		len += scnprintf(buf + len, buf_size - len, "\n");
+
+	len += scnprintf(buf + len, buf_size - len, "\nPARF registers:\n");
+	len += qcom_pcie_dump_reg_table(pcie->parf, qcom_pcie_parf_dump_regs,
+					ARRAY_SIZE(qcom_pcie_parf_dump_regs),
+					buf + len, buf_size - len);
+
+	if (!pcie->mhi)
+		return len;
+
+	len += scnprintf(buf + len, buf_size - len, "\nMHI registers:\n");
+	len += qcom_pcie_dump_reg_table(pcie->mhi, qcom_pcie_mhi_dump_regs,
+					ARRAY_SIZE(qcom_pcie_mhi_dump_regs),
+					buf + len, buf_size - len);
+
+	return len;
+}
+
+/*
+ * qcom_pcie_dump_regs - capture a PCIe register dump on Link Down.
+ *
+ * If a storage endpoint is present downstream, print the dump directly to
+ * dmesg via dev_err() so it is immediately visible even if userspace is not
+ * available to read a devcoredump after a storage failure. Otherwise hand
+ * the buffer to the devcoredump framework so it is accessible under
+ * /sys/class/devcoredump/ for offline analysis.
+ */
+static void qcom_pcie_dump_regs(struct qcom_pcie *pcie)
+{
+	struct device *dev = pcie->pci->dev;
+	bool storage_ep = qcom_pcie_has_storage_ep(pcie);
+	char *buf;
+	size_t len;
+
+	buf = vmalloc(QCOM_PCIE_DUMP_BUF_SIZE);
+	if (!buf)
+		return;
+
+	len = qcom_pcie_fill_dump_buf(pcie, buf, QCOM_PCIE_DUMP_BUF_SIZE);
+
+	if (storage_ep) {
+		dev_err(dev, "PCIe Link Down register dump:\n%s", buf);
+		vfree(buf);
+	} else {
+		dev_coredumpv(dev, buf, len, GFP_KERNEL);
+	}
+}
+
+static int qcom_pcie_regdump_show(struct seq_file *s, void *data)
+{
+	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
+	char *buf;
+	size_t len;
+
+	buf = vmalloc(QCOM_PCIE_DUMP_BUF_SIZE);
+	if (!buf)
+		return -ENOMEM;
+
+	len = qcom_pcie_fill_dump_buf(pcie, buf, QCOM_PCIE_DUMP_BUF_SIZE);
+	seq_write(s, buf, len);
+
+	vfree(buf);
+
+	return 0;
+}
+
 /*
  * Qcom PCIe controllers only support one Root Port per controller instance. So
  * this function ignores the 'pci_dev' associated with the Root Port and just
@@ -1864,6 +2189,8 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 	pcie->debugfs = debugfs_create_dir(name, NULL);
 	debugfs_create_devm_seqfile(dev, "link_transition_count", pcie->debugfs,
 				    qcom_pcie_link_transition_count);
+	debugfs_create_devm_seqfile(dev, "regdump", pcie->debugfs,
+				    qcom_pcie_regdump_show);
 }
 
 static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
@@ -1878,6 +2205,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 
 	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
 		dev_dbg(dev, "Received Link down event\n");
+		qcom_pcie_dump_regs(pcie);
 		for_each_pci_bridge(port, pp->bridge->bus) {
 			if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
 				pci_host_handle_link_down(port);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index facaa324bd86..0e82d89e747a 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1176,12 +1176,14 @@
 #define PCI_SECPCI_LE_CTRL	0x0c /* Lane Equalization Control Register */
 
 /* Physical Layer 16.0 GT/s */
+#define PCI_PL_16GT_STATUS	0x0c	/* 16.0 GT/s Status Register */
 #define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 #define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
 /* Physical Layer 32.0 GT/s */
+#define PCI_PL_32GT_STATUS	0x0c	/* 32.0 GT/s Status Register */
 #define PCI_PL_32GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 
 /* Physical Layer 64.0 GT/s */

---
base-commit: d55d5a8f3d852baab49dba910dcb04b6d8091b05
change-id: 20260811-regdump-11719f75de0c

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

