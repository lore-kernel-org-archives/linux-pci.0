Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2702BEC5F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969086; cv=none; b=pQTDb//aL7dqi8RTdzpRR+VcREB/67QjlcirWDjkE4shx8P65C8pdBXIgRapmyiywqy1Lv9M6JyMTShqFt8stq3w7z6UjVXfHDW11LeQs1yLs+ID2frI4488FyMNlDaX6tHcOn/MgoSpHfs82nRoUZd3IJaK7OAL0MCH3RnDF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969086; c=relaxed/simple;
	bh=d1/YJ892z0vcx8jDYlrUylhDVYM11kKTI14OWQayQjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEnhz9HuKJh/gVmTtMT+ZMu6F0ecMSClINNzTt8YgPKFERotfPLdsNM86YtpsZzdoXWOa6BeBPk6pquqgrw94KG/1yGn+TPdajn5hECkmW5lkgEaH357+YpJXKGQTM8UxmeYnDau0vPADEl3n2VUkjJlAem/0r00rGZ/SKZPwfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVzbXwLa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=coOq0tfl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVzbXwLa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="coOq0tfl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZlqT2888767
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3znjpq1VMhLR3xATCqKWt5J2KBKxhkyj4nghsC1lq20=; b=SVzbXwLaEe7tpEw/
	fzNLSPQToFPNFyB1jehlbeCPs0XAKB7HLNixY/SHq9EXf4l/ixai4ohMNvvjrtOZ
	yNn9+/zMfJarK0umFrg5PLyAd/mRMNeMIDFBgf3F/r6j4wMi3865XhInEYN9hH5l
	kTv/e9/qoTU9csP/FyV/efSBkB+agwMlZPXpwRL25K771my2m7qlxq3GNlotGAeM
	5PMSHSvlS01uGa5mdAw6zwlscbyZVUeu9b1Z4b8IzTlcCKQNxf1Ps/jysRjYXWwI
	x8/P8IFR97dcyiIEzcfnCxP9gQNQEBrSLM+NzJcU2FkKJqGg7pfbZwXr6JIzeSx1
	CuWhtg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq7991v7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:38:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39512608fb1so6594453a91.1
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789969080; x=1790573880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3znjpq1VMhLR3xATCqKWt5J2KBKxhkyj4nghsC1lq20=;
        b=coOq0tfljA+FSXytvdW0KcHFjeybbWta2l8+AN8onTXV07/BfpeVxsOBFayT36s4a/
         ZF5taPMWtCla1Qtu/bxLcwTsKpG2uYXUHtlMpXE7tBeOPRna23ua6K/IMYqW+czpE3+j
         fmsY7VN8/i2Ma+5j9PLgeSw2BBH5xQfkdz0Rx5onBK3WdVRf8l1XnPW5PStMBgjdSA+N
         wCXP0X/I9gO0x33NdrWTj3xL3vI2RRnyU3/8rI46jOU2bt8VE7m9JMaNZ3hzJsbO/EZn
         LGo6+Fd2WCDe3yunh1MQhNFvrmhTwSFn8a4T5u7KA9bMMx/ye8BPMkudaM62X5+0sxT5
         893Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789969080; x=1790573880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3znjpq1VMhLR3xATCqKWt5J2KBKxhkyj4nghsC1lq20=;
        b=qaZYSh/f6c3nueMGerj8RyA6TNNYvJsLTgCNi4pVOfqkWV9ogblVzfK/AfTpS9oSW0
         tAi6xNSufUx3Jdh656C0R/FZJMabVtmeaKktvUui5XWuiMXmV//K0NH65+v7G3fP6xDc
         t1rrGd9dT09uoxJENPOts61aTXhdOIhwFwl+z1BCirzHhReWxa91nd4LSmgPQt4hWyyl
         muEoSS/jHr0ZZ494kdynCmzjt80Jaav5q7vm90Ej6U/bj9FHUkwzfEFE3mbqspQ5S4lu
         JXvvNG6IMbfngeY4ZIXGqN9IGAESDR2qNSX8SyNGnrF5+D3s6j9AT/S3paPMVpuRdjzm
         ZKoQ==
X-Forwarded-Encrypted: i=1; AKwUvByiZuUjFLpN6bRR18O3G4Bx9X8gwhv9ITkk7R76emtHu8RCDb6PFYVynEssu0bHCjRoi8moMRdbQlI=@vger.kernel.org
X-Gm-Message-State: AFuF++nzBvZFO9FIek7HhIbY6DT9b739uXIQ/gNIDnRDhLqwPCDcswpS
	aZ0apEeEmQRoaC6yirVfL/y+TmtIRawiTV4QyMViq4vwiNzNFjQxC2sdZwt7rkgPIXkCvhnIzyk
	+r3RicKu87o57P64BJinZiv2LtSM5jh+ZtQYmR+/VlAealX7d+LsIOQHwopZaLm8=
X-Gm-Gg: AYBFou2aKeZIZUYDJBeRT7HVqRfRcNBmLV7Xy0bQw4X40wKYgeLnK6XZD7sZ7h7HXzM
	1cTIa6onrpcUpIhFLzYmDfG5daYhfG7CTqflgDecYf4b78siLLhhfF1Z624PCgWP1GAjbHq0MBB
	rqseT7Qy47km27sTI8QF+QLz9OV5ODt1Dccqt6BWgU1EilcLiC+jZplAIfA1K6gW7RTq+5awZI4
	010UBDg3CHuDRXctSgM0ibCfS2OniwtyoACqlf9xjSRDA+gf1oTPQEwRL366GfZPur6fe8UTL7j
	7JtP+9mpceXRypEkft7lAOy53NEZMCcjtLwmpxJRriPMtEBwfEs4rDdIsnzBv5lBm2yM44H9Fwh
	/LBJTLXO3wTHGsNABU5VgHyQ1h9LbOcqoWQ==
X-Received: by 2002:a17:90b:5830:b0:39e:6a82:afd3 with SMTP id 98e67ed59e1d1-39e6a82bb9emr10156272a91.37.1789969079169;
        Sun, 20 Sep 2026 22:37:59 -0700 (PDT)
X-Received: by 2002:a17:90b:5830:b0:39e:6a82:afd3 with SMTP id 98e67ed59e1d1-39e6a82bb9emr10156220a91.37.1789969078376;
        Sun, 20 Sep 2026 22:37:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55d45a6sm15054568c88.9.2026.09.20.22.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:37:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:07:14 +0530
Subject: [PATCH v4 6/6] phy: qcom: qmp-pcie: Add Nord Gen5x16 PCIe
 multi-PHY support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260921-nord-v4-6-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
In-Reply-To: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789969033; l=66583;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=d1/YJ892z0vcx8jDYlrUylhDVYM11kKTI14OWQayQjE=;
 b=4TqbLsE0xoHKkKvl33Omo6ww+qhRltmfe0W4SgNC17KdLyK4TWN+sI4jp2j7PaG92x5lK9eMm
 PP9uWDy3qXWCI6rt/GBBo5y5VaL/jgZYC2NgmTnxJBuV2+43OzObXnp
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=aJ9lOr9m c=1 sm=1 tr=0 ts=6ab0c2b8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=YAFjNJcNphQevXYxupoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX6j2C06edNM/3
 tBaRntpxmMHISV0kAlC7r9Kqv+vKLRMFImsyEC+tbCnEJKghy3ittaCwYVRTZBjz/IMPUN5zqKj
 EaM31250IDJjsOechjxJ9xJusr7xKL4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA3OCBTYWx0ZWRfX3DonfIcTO9ML
 NmoguRuu8JZOM7+wMzQw///DyUNL0hBabWnWFQ+MkPULpovBx2pN1YgFRSHXB8BDlOj/7O5IO8T
 A/HBguQT+QR3ytu2klNUOOf1wbiIK4CVMfvRfAjZEj/fa3TlP8YgcrEgoVjukpEtxb3DolB8X7y
 GQ4wph3oS4cScZhVhlWId11LQ/VF2w5WnW+o3pSMrA2FgN9/pc15uYHDA95KfEBguOZRXSBd1Lw
 Wjfg/gnYeDeq/MGxdP8o/XfXhYd0z8sGAHtD3aXDmIrXm/1rZrUjBlodJ1lE861HVqyhs+Z6VOs
 fAlG+p3r3SMsPYbA86lfDb8LiBs5cVSJo0w99m/i0MvzeWYISAYwvNJBtd3pi2KkXpmJYhMXTA3
 RhkZcyannRV1sFuT8DpRKVm57+S/Cf957hhCkYvUc8IEmztyRaGoIYU5a/8OmuwRFZWPjpP8B2x
 PlXMLzWb1ATKWoLYwbQ==
X-Proofpoint-ORIG-GUID: wW976mrvQ0ika2VNifXqZeflVlFaLF7J
X-Proofpoint-GUID: wW976mrvQ0ika2VNifXqZeflVlFaLF7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210078

Add support for the Nord Gen5x16 bifurcated QMP PCIe PHY.

Nord has a single PCIe PHY block split into four ports which can be
used in multiple lane configurations: x16, x8+x8, x8+x4+x4 and
x8+x4+x2+x2. The active topology is selected through the link mode
configuration register, and the driver exposes the corresponding PHY
instances based on that mode.

Unlike Glymur, where the PHY is initialized by firmware, Nord requires
Linux to program the PHY registers. Add the PLL, TXRXZ, PCS and PCS
lane initialization tables, along with the required power-up,
power-down and soft-reset sequencing.

Add per-port and grouped PHY configurations for all supported Nord
lane modes. Also add support for regular PHY resets in addition to the
NOCSR reset.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c  | 868 ++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h |  55 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h      |  14 +
 .../qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h |  94 +++
 .../phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h        | 194 +++++
 5 files changed, 1206 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
index befca9b78ce9..f1267691bf32 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-multiphy.c
@@ -3,6 +3,7 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
@@ -22,6 +23,11 @@
 #include <linux/slab.h>
 
 #include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-common.h"
+#include "phy-qcom-qmp-pcs-v6_40.h"
+#include "phy-qcom-qmp-pcs-pcie-v6_40.h"
+#include "phy-qcom-qmp-qserdes-com-pcie-v6_40.h"
+#include "phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT_US		10000
 
@@ -30,8 +36,19 @@ enum qmp_pcie_glymur_link_mode {
 	QMP_PCIE_GLYMUR_MODE_X4X4,
 };
 
+enum qmp_pcie_nord_link_mode {
+	QMP_PCIE_NORD_MODE_X16,
+	QMP_PCIE_NORD_MODE_X8_X8,
+	QMP_PCIE_NORD_MODE_X8_X4_X4,
+	QMP_PCIE_NORD_MODE_X8_X4_X2_X2
+};
+
 enum qphy_reg_layout {
 	QPHY_PCS_STATUS,
+	QPHY_PCS_START_CONTROL,
+	QPHY_PCS_SW_RESET,
+	QPHY_PCS_POWER_DOWN_CONTROL,
+	QPHY_COM_BIAS_EN_CLKBUFLR_EN,
 	QPHY_LAYOUT_SIZE
 };
 
@@ -39,16 +56,48 @@ static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
 };
 
+static const unsigned int nord_pciephy_v6_40_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_PCS_STATUS]		= QPHY_V6_40_PCS_STATUS1,
+	[QPHY_PCS_START_CONTROL]	= QPHY_V6_40_PCS_START_CONTROL,
+	[QPHY_PCS_SW_RESET]		= QPHY_V6_40_PCS_SW_RESET,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_40_PCS_POWER_DOWN_CONTROL,
+	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN,
+};
+
 struct qmp_pcie_offsets {
 	u16 pcs;
+	u16 pll;
+	u16 txrxz;
+	u16 pcs_lanez;
+};
+
+struct qmp_phy_cfg_tbls {
+	const struct qmp_phy_init_tbl *pll_common;
+	int pll_common_num;
+	const struct qmp_phy_init_tbl *txrxz;
+	int txrxz_num;
+	const struct qmp_phy_init_tbl *pcs;
+	int pcs_num;
+	const struct qmp_phy_init_tbl *pcs_lanez;
+	int pcs_lanez_num;
+	const struct qmp_phy_init_tbl *port_split_pre_pwrup;
+	int port_split_pre_pwrup_num;
+	const struct qmp_phy_init_tbl *port_split_post_cfg;
+	int port_split_post_cfg_num;
 };
 
 struct qmp_phy_cfg {
 	const struct qmp_pcie_offsets *offsets;
+	const struct qmp_phy_cfg_tbls tbls;
+	const struct qmp_phy_init_tbl * const *pll_tbls;
+	const int *pll_nums;
+	bool port_split;
 	const char * const *reg_names;
 	int num_regs;
 	const char * const *pd_names;
 	int num_pds;
+	const char * const *reset_list;
+	int num_resets;
 	const char * const *nocsr_reset_list;
 	int num_nocsr_resets;
 	const char * const *vreg_list;
@@ -64,9 +113,11 @@ struct qmp_phy_cfg {
 struct qmp_pcie {
 	struct device *dev;
 	const struct qmp_phy_cfg *cfg;
+	bool skip_init;
 	void __iomem **base;
 	struct clk_bulk_data *clks;
 	struct clk_bulk_data *pipe_clks;
+	struct reset_control_bulk_data *resets;
 	struct reset_control_bulk_data *nocsr_resets;
 	struct regulator_bulk_data *vregs;
 	struct device **pd_devs;
@@ -89,6 +140,10 @@ struct qmp_pcie_match_data {
 	u32 num_modes;
 };
 
+/* QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN bits */
+#define COM_BIAS_EN				BIT(0)
+#define COM_BIAS_EN_MUX				BIT(1)
+
 static const char * const glymur_pciephy_clk_l[] = {
 	"aux", "cfg_ahb", "ref", "rchng", "phy_b_aux",
 };
@@ -220,6 +275,702 @@ static const struct qmp_pcie_match_data glymur_qmp_gen5x8_match_data = {
 	.num_modes	= ARRAY_SIZE(glymur_qmp_gen5x8_mode_cfgs),
 };
 
+static const char * const nord_pciephy_port_a_vreg_l[] = {
+	"vdda-phy-a", "vdda-pll-a",
+};
+
+static const char * const nord_pciephy_port_b_vreg_l[] = {
+	"vdda-phy-b", "vdda-pll-b",
+};
+
+static const char * const nord_pciephy_port_c_vreg_l[] = {
+	"vdda-phy-c", "vdda-pll-c",
+};
+
+static const char * const nord_pciephy_port_d_vreg_l[] = {
+	"vdda-phy-d", "vdda-pll-d",
+};
+
+static const char * const nord_pciephy_port_cd_vreg_l[] = {
+	"vdda-phy-c", "vdda-pll-c", "vdda-phy-d", "vdda-pll-d",
+};
+
+static const char * const nord_pciephy_port_bcd_vreg_l[] = {
+	"vdda-phy-b", "vdda-pll-b", "vdda-phy-c", "vdda-pll-c",
+	"vdda-phy-d", "vdda-pll-d",
+};
+
+static const char * const nord_pciephy_port_abcd_vreg_l[] = {
+	"vdda-phy-a", "vdda-pll-a", "vdda-phy-b", "vdda-pll-b",
+	"vdda-phy-c", "vdda-pll-c", "vdda-phy-d", "vdda-pll-d",
+};
+
+static const struct qmp_pcie_offsets nord_pcie_offsets_v6_40 = {
+	.pll		= 0x8000,
+	.pcs		= 0x9000,
+	.txrxz		= 0xd000,
+	.pcs_lanez	= 0xe800,
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE2, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2, 0xa4),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x52),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1, 0x3c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1, 0x3c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_POST_DIV_MUX, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN, 0x46),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CORE_CLK_EN, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1, 0x86),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MISC1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_MODE, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PSM_CAL_EN, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_3, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_8, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL, 0xaf),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_CMN_IETRIM, 0x0d),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_a_ovl_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9, 0x31),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_b_ovl_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9, 0x22),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_c_ovl_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9, 0x31),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pll_d_ovl_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_7, 0x22),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_COM_DCC_CAL_9, 0x22),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_txrxz_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B0, 0xcd),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B2, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3, 0x50),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4, 0xac),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B5, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B6, 0x52),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7, 0x3e),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B3, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4, 0x8c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5, 0x9d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B6, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0, 0xfb),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2, 0xe8),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3, 0x70),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B5, 0xf4),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B6, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_SUMMER_CAL_SPD_MODE_RATE_0123, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH2, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PHPRE_CTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TX_ADPT_CTRL, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B2, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B3, 0x50),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4, 0x9a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B5, 0x47),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B6, 0x52),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B7, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_3, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL3, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL4, 0x8d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOCK_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP1_DAC_ENABLE, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP2_DAC_ENABLE, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP345_DAC_ENABLE, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP67_DAC_ENABLE, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE1, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_FLL_DIV_RATIO_RATE_0123, 0x94),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_01, 0x66),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_23, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE4, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL, 0x58),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_MAN_INDEX, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_ANA_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_FUNC_CTRL, 0xd0),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KP_CODE_OVRD_RATE_2_3, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL2, 0x83),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL3, 0x44),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_0_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_2_3, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE4, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_0_1, 0x33),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_2_3, 0x33),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE4, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1, 0x22),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_2_3, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_DIV2_CTRL_RATE0123, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE0, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE0, 0x13),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE1, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE1, 0x26),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE2, 0x3d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3, 0x9c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE3, 0x3d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE4, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE4, 0x3d),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL3, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL4, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL5, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_CNTRL1, 0xe1),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE0_1, 0xdd),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE2_3, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_OVRD_MUXES, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE_0123, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE4, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE0, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE1, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE2, 0x35),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE4, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_0_1, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3, 0x22),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE3, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE4, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_0_1, 0x43),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_2_3, 0x44),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_TYPE_CONFIG, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CTLE_POST_CAL_OFFSET_RATE_0_1_2, 0x67),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_EN_LOWFREQ, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RES_CODE_LANE_OFFSET_RX, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE0_1, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE2_3, 0x88),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE4, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4, 0x56),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_CLKBUF_ENABLE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE1, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE2, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE3, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE4, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CNTRL, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_LVL, 0x84),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CAL_CTRL1, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL15, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL16, 0x52),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_CAL_CTRL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_POST_CAL_OFFSET, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_CTRL, 0x3c),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE3, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE4, 0x17),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2, 0x3d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG5, 0xe4),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG6, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG7, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_MULTIPHY_CONFIG2, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG2, 0xe4),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG3, 0x30),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG6, 0x08),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG7, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG8, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG2, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG3, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG4, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_RX_SIGDET_LVL, 0x66),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG1, 0xff),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG2, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG3, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7, 0x35),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG8, 0x3e),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG1, 0x06),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2, 0x1c),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG3, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG5, 0x90),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG7, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG5, 0x90),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG7, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG1, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG5, 0x90),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG7, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_COM_TEST_CONTROL1, 0x08),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_pcs_lanez_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL5, 0x00),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_port_split_pre_pwrup_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL, 0x91),
+};
+
+static const struct qmp_phy_init_tbl nord_qmp_pcie_port_split_post_cfg_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN, 0x00),
+};
+
+static const struct qmp_phy_cfg_tbls nord_qmp_pcie_tbls = {
+	.pll_common			= nord_qmp_pcie_pll_tbl,
+	.pll_common_num			= ARRAY_SIZE(nord_qmp_pcie_pll_tbl),
+	.txrxz				= nord_qmp_pcie_txrxz_tbl,
+	.txrxz_num			= ARRAY_SIZE(nord_qmp_pcie_txrxz_tbl),
+	.pcs				= nord_qmp_pcie_pcs_tbl,
+	.pcs_num			= ARRAY_SIZE(nord_qmp_pcie_pcs_tbl),
+	.pcs_lanez			= nord_qmp_pcie_pcs_lanez_tbl,
+	.pcs_lanez_num			= ARRAY_SIZE(nord_qmp_pcie_pcs_lanez_tbl),
+	.port_split_pre_pwrup		= nord_qmp_pcie_port_split_pre_pwrup_tbl,
+	.port_split_pre_pwrup_num	= ARRAY_SIZE(nord_qmp_pcie_port_split_pre_pwrup_tbl),
+	.port_split_post_cfg		= nord_qmp_pcie_port_split_post_cfg_tbl,
+	.port_split_post_cfg_num	= ARRAY_SIZE(nord_qmp_pcie_port_split_post_cfg_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_a[] = {
+	nord_qmp_pcie_pll_a_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_a_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_a_ovl_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_b[] = {
+	nord_qmp_pcie_pll_b_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_b_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_c[] = {
+	nord_qmp_pcie_pll_c_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_c_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_d[] = {
+	nord_qmp_pcie_pll_d_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_d_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_cd[] = {
+	nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_cd_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_bcd[] = {
+	nord_qmp_pcie_pll_b_ovl_tbl, nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_bcd_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl),
+	ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
+};
+
+static const struct qmp_phy_init_tbl * const nord_qmp_pcie_pll_abcd[] = {
+	nord_qmp_pcie_pll_a_ovl_tbl, nord_qmp_pcie_pll_b_ovl_tbl,
+	nord_qmp_pcie_pll_c_ovl_tbl, nord_qmp_pcie_pll_d_ovl_tbl,
+};
+
+static const int nord_qmp_pcie_pll_abcd_nums[] = {
+	ARRAY_SIZE(nord_qmp_pcie_pll_a_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_b_ovl_tbl),
+	ARRAY_SIZE(nord_qmp_pcie_pll_c_ovl_tbl), ARRAY_SIZE(nord_qmp_pcie_pll_d_ovl_tbl),
+};
+
+static const char * const nord_pciephy_port_c_reg_l[] = { "port_c" };
+
+static const char * const nord_pciephy_port_d_reg_l[] = { "port_d" };
+
+static const char * const nord_pciephy_port_cd_reg_l[] = { "port_c", "port_d" };
+
+static const char * const nord_pciephy_port_bcd_reg_l[] = {
+	"port_b", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_abcd_reg_l[] = {
+	"port_a", "port_b", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_a_reset_l[] = { "port_a" };
+
+static const char * const nord_pciephy_port_b_reset_l[] = { "port_b" };
+
+static const char * const nord_pciephy_port_c_reset_l[] = { "port_c" };
+
+static const char * const nord_pciephy_port_d_reset_l[] = { "port_d" };
+
+static const char * const nord_pciephy_port_cd_reset_l[] = {
+	"port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_bcd_reset_l[] = {
+	"port_b", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_abcd_reset_l[] = {
+	"port_a", "port_b", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_a_nocsr_reset_l[] = {
+	"port_a_nocsr",
+};
+
+static const char * const nord_pciephy_port_b_nocsr_reset_l[] = {
+	"port_b_nocsr",
+};
+
+static const char * const nord_pciephy_port_c_nocsr_reset_l[] = {
+	"port_c_nocsr",
+};
+
+static const char * const nord_pciephy_port_d_nocsr_reset_l[] = {
+	"port_d_nocsr",
+};
+
+static const char * const nord_pciephy_port_cd_nocsr_reset_l[] = {
+	"port_c_nocsr", "port_d_nocsr",
+};
+
+static const char * const nord_pciephy_port_bcd_nocsr_reset_l[] = {
+	"port_b_nocsr", "port_c_nocsr", "port_d_nocsr",
+};
+
+static const char * const nord_pciephy_port_abcd_nocsr_reset_l[] = {
+	"port_a_nocsr", "port_b_nocsr", "port_c_nocsr", "port_d_nocsr",
+};
+
+static const char * const nord_pciephy_port_a_pd_l[] = { "port_a" };
+
+static const char * const nord_pciephy_port_b_pd_l[] = {
+	"port_a", "port_b",
+};
+
+static const char * const nord_pciephy_port_c_pd_l[] = {
+	"port_a", "port_c",
+};
+
+static const char * const nord_pciephy_port_d_pd_l[] = {
+	"port_a", "port_d",
+};
+
+static const char * const nord_pciephy_port_cd_pd_l[] = {
+	"port_a", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_bcd_pd_l[] = {
+	"port_a", "port_b", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_abcd_pd_l[] = {
+	"port_a", "port_b", "port_c", "port_d",
+};
+
+static const char * const nord_pciephy_port_a_clk_l[] = {
+	"aux_a", "cfg_ahb_a", "rchng_a", "ref",
+};
+
+static const char * const nord_pciephy_port_b_clk_l[] = {
+	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b", "ref",
+};
+
+static const char * const nord_pciephy_port_c_clk_l[] = {
+	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c", "ref",
+};
+
+static const char * const nord_pciephy_port_d_clk_l[] = {
+	"aux_a", "aux_d", "cfg_ahb_d", "rchng_d", "ref",
+};
+
+static const char * const nord_pciephy_port_cd_clk_l[] = {
+	"aux_a", "aux_c", "cfg_ahb_c", "rchng_c",
+	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
+};
+
+static const char * const nord_pciephy_port_bcd_clk_l[] = {
+	"aux_a", "aux_b", "cfg_ahb_b", "rchng_b",
+	"aux_c", "cfg_ahb_c", "rchng_c",
+	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
+};
+
+static const char * const nord_pciephy_port_abcd_clk_l[] = {
+	"aux_a", "cfg_ahb_a", "rchng_a",
+	"aux_b", "cfg_ahb_b", "rchng_b",
+	"aux_c", "cfg_ahb_c", "rchng_c",
+	"aux_d", "cfg_ahb_d", "rchng_d", "ref",
+};
+
+static const char * const nord_pciephy_port_a_pipeclk_l[] = { "pipe_a" };
+
+static const char * const nord_pciephy_port_b_pipeclk_l[] = { "pipe_b" };
+
+static const char * const nord_pciephy_port_c_pipeclk_l[] = { "pipe_c" };
+
+static const char * const nord_pciephy_port_d_pipeclk_l[] = { "pipe_d" };
+
+#define NORD_QMP_PCIE_PORT_CFG(_port, _reg_l, _pd_l, _reset_l, _nocsr_reset_l, _pipeclk_l, \
+				_port_split)					\
+static const struct qmp_phy_cfg nord_qmp_pcie_port_##_port##_cfg = {		\
+	.offsets		= &nord_pcie_offsets_v6_40,			\
+	.tbls			= nord_qmp_pcie_tbls,				\
+	.pll_tbls		= nord_qmp_pcie_pll_##_port,			\
+	.pll_nums		= nord_qmp_pcie_pll_##_port##_nums,		\
+	.port_split		= _port_split,					\
+	.reg_names		= _reg_l,					\
+	.num_regs		= ARRAY_SIZE(_reg_l),				\
+	.pd_names		= _pd_l,					\
+	.num_pds		= ARRAY_SIZE(_pd_l),				\
+	.reset_list		= _reset_l,					\
+	.num_resets		= ARRAY_SIZE(_reset_l),				\
+	.nocsr_reset_list	= _nocsr_reset_l,				\
+	.num_nocsr_resets	= ARRAY_SIZE(_nocsr_reset_l),			\
+	.vreg_list		= nord_pciephy_port_##_port##_vreg_l,		\
+	.num_vregs		= ARRAY_SIZE(nord_pciephy_port_##_port##_vreg_l),	\
+	.regs			= nord_pciephy_v6_40_regs_layout,	\
+	.phy_status		= PHYSTATUS_4_20,				\
+	.clk_list		= nord_pciephy_port_##_port##_clk_l,		\
+	.num_clks		= ARRAY_SIZE(nord_pciephy_port_##_port##_clk_l),	\
+	.pipe_clk_list		= _pipeclk_l,					\
+	.num_pipe_clks		= 1,						\
+}
+
+NORD_QMP_PCIE_PORT_CFG(a, pciephy_port_a_reg_l, nord_pciephy_port_a_pd_l,
+		       nord_pciephy_port_a_reset_l, pciephy_port_a_nocsr_reset_l,
+		       nord_pciephy_port_a_pipeclk_l, true);
+NORD_QMP_PCIE_PORT_CFG(b, pciephy_port_b_reg_l, nord_pciephy_port_b_pd_l,
+		       nord_pciephy_port_b_reset_l, pciephy_port_b_nocsr_reset_l,
+		       nord_pciephy_port_b_pipeclk_l, true);
+NORD_QMP_PCIE_PORT_CFG(c, nord_pciephy_port_c_reg_l, nord_pciephy_port_c_pd_l,
+		       nord_pciephy_port_c_reset_l, nord_pciephy_port_c_nocsr_reset_l,
+		       nord_pciephy_port_c_pipeclk_l, true);
+NORD_QMP_PCIE_PORT_CFG(d, nord_pciephy_port_d_reg_l, nord_pciephy_port_d_pd_l,
+		       nord_pciephy_port_d_reset_l, nord_pciephy_port_d_nocsr_reset_l,
+		       nord_pciephy_port_d_pipeclk_l, true);
+NORD_QMP_PCIE_PORT_CFG(cd, nord_pciephy_port_cd_reg_l, nord_pciephy_port_cd_pd_l,
+		       nord_pciephy_port_cd_reset_l, nord_pciephy_port_cd_nocsr_reset_l,
+		       nord_pciephy_port_c_pipeclk_l, true);
+NORD_QMP_PCIE_PORT_CFG(bcd, nord_pciephy_port_bcd_reg_l, nord_pciephy_port_bcd_pd_l,
+		       nord_pciephy_port_bcd_reset_l, nord_pciephy_port_bcd_nocsr_reset_l,
+		       nord_pciephy_port_b_pipeclk_l, true);
+NORD_QMP_PCIE_PORT_CFG(abcd, nord_pciephy_port_abcd_reg_l, nord_pciephy_port_abcd_pd_l,
+		       nord_pciephy_port_abcd_reset_l, nord_pciephy_port_abcd_nocsr_reset_l,
+		       nord_pciephy_port_a_pipeclk_l, false);
+
+static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x16_cfgs[] = {
+	&nord_qmp_pcie_port_abcd_cfg,
+};
+
+static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x8_cfgs[] = {
+	&nord_qmp_pcie_port_a_cfg,
+	&nord_qmp_pcie_port_bcd_cfg,
+};
+
+static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x4x4_cfgs[] = {
+	&nord_qmp_pcie_port_a_cfg,
+	&nord_qmp_pcie_port_b_cfg,
+	&nord_qmp_pcie_port_cd_cfg,
+};
+
+static const struct qmp_phy_cfg * const nord_qmp_gen5x16_mode_x8x4x2x2_cfgs[] = {
+	&nord_qmp_pcie_port_a_cfg,
+	&nord_qmp_pcie_port_b_cfg,
+	&nord_qmp_pcie_port_c_cfg,
+	&nord_qmp_pcie_port_d_cfg,
+};
+
+static const struct qmp_pcie_link_mode_cfg nord_qmp_gen5x16_mode_cfgs[] = {
+	[QMP_PCIE_NORD_MODE_X16] = {
+		.cfgs		= nord_qmp_gen5x16_mode_x16_cfgs,
+		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x16_cfgs),
+	},
+	[QMP_PCIE_NORD_MODE_X8_X8] = {
+		.cfgs		= nord_qmp_gen5x16_mode_x8x8_cfgs,
+		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x8_cfgs),
+	},
+	[QMP_PCIE_NORD_MODE_X8_X4_X4] = {
+		.cfgs		= nord_qmp_gen5x16_mode_x8x4x4_cfgs,
+		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x4x4_cfgs),
+	},
+	[QMP_PCIE_NORD_MODE_X8_X4_X2_X2] = {
+		.cfgs		= nord_qmp_gen5x16_mode_x8x4x2x2_cfgs,
+		.num_phys	= ARRAY_SIZE(nord_qmp_gen5x16_mode_x8x4x2x2_cfgs),
+	},
+};
+
+static const struct qmp_pcie_match_data nord_qmp_gen5x16_match_data = {
+	.mode_cfgs		= nord_qmp_gen5x16_mode_cfgs,
+	.num_modes		= ARRAY_SIZE(nord_qmp_gen5x16_mode_cfgs),
+};
+
+static void qmp_pcie_init_port_registers(struct qmp_pcie *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_pcie_offsets *offs = cfg->offsets;
+	const struct qmp_phy_cfg_tbls *tbls = &cfg->tbls;
+	int i;
+
+	for (i = 0; i < cfg->num_regs; i++) {
+		void __iomem *port = qmp->base[i];
+
+		if (cfg->port_split)
+			qmp_configure(qmp->dev, port + offs->txrxz,
+				      tbls->port_split_pre_pwrup, tbls->port_split_pre_pwrup_num);
+
+		writel(SW_PWRDN | REFCLK_DRV_DSBL,
+		       port + offs->pcs + cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]);
+
+		if (cfg->port_split)
+			qphy_setbits(port + offs->pll, cfg->regs[QPHY_COM_BIAS_EN_CLKBUFLR_EN],
+				     COM_BIAS_EN_MUX | COM_BIAS_EN);
+
+		qmp_configure(qmp->dev, port + offs->pll,
+			      tbls->pll_common, tbls->pll_common_num);
+		qmp_configure(qmp->dev, port + offs->pll,
+			      cfg->pll_tbls[i], cfg->pll_nums[i]);
+		qmp_configure(qmp->dev, port + offs->txrxz,
+			      tbls->txrxz, tbls->txrxz_num);
+		qmp_configure(qmp->dev, port + offs->pcs,
+			      tbls->pcs, tbls->pcs_num);
+		qmp_configure(qmp->dev, port + offs->pcs_lanez,
+			      tbls->pcs_lanez, tbls->pcs_lanez_num);
+
+		if (cfg->port_split)
+			qmp_configure(qmp->dev, port + offs->txrxz,
+				      tbls->port_split_post_cfg, tbls->port_split_post_cfg_num);
+	}
+}
+
 static int qmp_pcie_pd_power_on(struct qmp_pcie *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -256,32 +1007,76 @@ static int qmp_pcie_init(struct phy *phy)
 {
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
-	int ret;
+	const struct qmp_pcie_offsets *offs = cfg->offsets;
+	int i, ret;
 
 	ret = qmp_pcie_pd_power_on(qmp);
 	if (ret)
 		return ret;
 
+	/*
+	 * We can skip PHY initialization if all of the following conditions
+	 * are met:
+	 *  1. The PHY supports the nocsr_reset that preserves the PHY config.
+	 *  2. The PHY was started (and not powered down again) by the
+	 *     bootloader, with all of the expected bits set correctly.
+	 * In this case, we can continue without having the init sequence
+	 * defined in the driver.
+	 */
+	qmp->skip_init =  qmp->cfg->num_nocsr_resets;
+	for (i = 0; qmp->skip_init && i < cfg->num_regs; i++) {
+		void __iomem *port = qmp->base[i];
+
+		if (!qphy_checkbits(port + offs->pcs, cfg->regs[QPHY_PCS_START_CONTROL],
+				    SERDES_START | PCS_START) ||
+		    !qphy_checkbits(port + offs->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+				     SW_PWRDN | REFCLK_DRV_DSBL))
+			qmp->skip_init = false;
+	}
+
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
 		dev_err(qmp->dev, "failed to enable regulators: %d\n", ret);
 		goto err_pd_power_off;
 	}
 
+	/*
+	 * Toggle BCR reset for a PHY that doesn't support the nocsr_reset,
+	 * or has not been initialized yet.
+	 */
+	if (!qmp->skip_init) {
+		ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
+		if (ret) {
+			dev_err(qmp->dev, "reset assert failed: %d\n", ret);
+			goto err_disable_regulators;
+		}
+	}
+
 	ret = reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
 	if (ret) {
 		dev_err(qmp->dev, "no-csr reset assert failed: %d\n", ret);
-		goto err_disable_regulators;
+		goto err_assert_reset;
 	}
 
 	usleep_range(200, 300);
 
+	if (!qmp->skip_init) {
+		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
+		if (ret) {
+			dev_err(qmp->dev, "reset deassert failed: %d\n", ret);
+			goto err_assert_reset;
+		}
+	}
+
 	ret = clk_bulk_prepare_enable(qmp->cfg->num_clks, qmp->clks);
 	if (ret)
-		goto err_disable_regulators;
+		goto err_assert_reset;
 
 	return 0;
 
+err_assert_reset:
+	if (!qmp->skip_init)
+		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 err_disable_regulators:
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
 err_pd_power_off:
@@ -295,7 +1090,8 @@ static int qmp_pcie_exit(struct phy *phy)
 	struct qmp_pcie *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
+	if (qmp->nocsr_resets)
+		reset_control_bulk_assert(qmp->cfg->num_nocsr_resets, qmp->nocsr_resets);
 
 	clk_bulk_disable_unprepare(qmp->cfg->num_clks, qmp->clks);
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
@@ -323,6 +1119,20 @@ static int qmp_pcie_power_on(struct phy *phy)
 		goto err_disable_pipe_clk;
 	}
 
+	if (cfg->pll_tbls && !qmp->skip_init) {
+		qmp_pcie_init_port_registers(qmp);
+
+		for (i = 0; i < cfg->num_regs; i++) {
+			qphy_clrbits(qmp->base[i] + offs->pcs,
+				     cfg->regs[QPHY_PCS_SW_RESET], SW_RESET);
+			qphy_setbits(qmp->base[i] + offs->pcs,
+				     cfg->regs[QPHY_PCS_START_CONTROL],
+				     SERDES_START | PCS_START);
+		}
+
+		usleep_range(2000, 2500);
+	}
+
 	for (i = 0; i < cfg->num_regs; i++) {
 		status = qmp->base[i] + offs->pcs + cfg->regs[QPHY_PCS_STATUS];
 		ret = readl_poll_timeout(status, val, !(val & cfg->phy_status), 200,
@@ -444,20 +1254,37 @@ static int qmp_pcie_reset_init(struct qmp_pcie *qmp)
 	struct device *dev = qmp->dev;
 	int i, ret;
 
-	qmp->nocsr_resets = devm_kcalloc(dev, cfg->num_nocsr_resets,
-					 sizeof(*qmp->nocsr_resets),
-					 GFP_KERNEL);
-	if (!qmp->nocsr_resets)
-		return -ENOMEM;
+	if (cfg->num_resets) {
+		qmp->resets = devm_kcalloc(dev, cfg->num_resets,
+					   sizeof(*qmp->resets), GFP_KERNEL);
+		if (!qmp->resets)
+			return -ENOMEM;
 
-	for (i = 0; i < cfg->num_nocsr_resets; i++)
-		qmp->nocsr_resets[i].id = cfg->nocsr_reset_list[i];
+		for (i = 0; i < cfg->num_resets; i++)
+			qmp->resets[i].id = cfg->reset_list[i];
 
-	ret = devm_reset_control_bulk_get_exclusive(dev,
-						    cfg->num_nocsr_resets,
-						    qmp->nocsr_resets);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to get no-csr resets\n");
+		ret = devm_reset_control_bulk_get_exclusive(dev, cfg->num_resets,
+							    qmp->resets);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get resets\n");
+	}
+
+	if (cfg->num_nocsr_resets) {
+		qmp->nocsr_resets = devm_kcalloc(dev, cfg->num_nocsr_resets,
+						 sizeof(*qmp->nocsr_resets),
+						 GFP_KERNEL);
+		if (!qmp->nocsr_resets)
+			return -ENOMEM;
+
+		for (i = 0; i < cfg->num_nocsr_resets; i++)
+			qmp->nocsr_resets[i].id = cfg->nocsr_reset_list[i];
+
+		ret = devm_reset_control_bulk_get_exclusive(dev,
+							    cfg->num_nocsr_resets,
+							    qmp->nocsr_resets);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get no-csr resets\n");
+	}
 
 	return 0;
 }
@@ -660,14 +1487,13 @@ static int qmp_pcie_multiphy_probe(struct platform_device *pdev)
 	int ret;
 
 	qmp_data = devm_kzalloc(dev, sizeof(*qmp_data), GFP_KERNEL);
+	if (!qmp_data)
+		return -ENOMEM;
 
 	match_data = of_device_get_match_data(dev);
 	if (!match_data)
 		return -EINVAL;
 
-	if (!qmp_data)
-		return -ENOMEM;
-
 	ret = qmp_pcie_read_link_mode(dev, &link_mode);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read qcom,link-mode\n");
@@ -711,6 +1537,10 @@ static const struct of_device_id qmp_pcie_multiphy_of_match_table[] = {
 		.compatible = "qcom,glymur-qmp-gen5x8-pcie-phy",
 		.data = &glymur_qmp_gen5x8_match_data,
 	},
+	{
+		.compatible = "qcom,nord-qmp-gen5x16-pcie-phy",
+		.data = &nord_qmp_gen5x16_match_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qmp_pcie_multiphy_of_match_table);
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h
new file mode 100644
index 000000000000..479f6d39d878
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_40.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_40_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V6_40_H_
+
+/* PCS COM — power, start, clocks */
+#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG2		0x06c
+#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG5		0x078
+#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG6		0x07c
+#define QPHY_PCIE_V6_40_PCS_COM_POWER_STATE_CONFIG7		0x080
+#define QPHY_PCIE_V6_40_PCS_COM_MULTIPHY_CONFIG2		0x088
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG2		0x0a0
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG3		0x0a4
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG5		0x0ac
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG6		0x0b0
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG7		0x0b4
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG8		0x0b8
+#define QPHY_PCIE_V6_40_PCS_COM_PCS_TX_RX_CONFIG10		0x0c0
+#define QPHY_PCIE_V6_40_PCS_COM_ENDPOINT_REFCLK_DRIVE		0x0c8
+#define QPHY_PCIE_V6_40_PCS_COM_RX_SIGDET_LVL			0x0ec
+#define QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG2	0x0f8
+#define QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG3	0x0fc
+#define QPHY_PCIE_V6_40_PCS_COM_DIVTX_CLK_DCC_CAL_CONFIG4	0x100
+#define QPHY_PCIE_V6_40_PCS_COM_OSC_DTCT_ACTIONS		0x194
+#define QPHY_PCIE_V6_40_PCS_COM_LOCK_DETECT_CONFIG1		0x1bc
+#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG1		0x1dc
+#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG2		0x1e0
+#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG3		0x1e4
+#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG7		0x1f4
+#define QPHY_PCIE_V6_40_PCS_COM_ALIGN_DETECT_CONFIG8		0x1f8
+
+/* PCS COM — EQ config */
+#define QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG1			0x380
+#define QPHY_PCIE_V6_40_PCS_COM_EQ_CONFIG2			0x384
+#define QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG1			0x38c
+#define QPHY_PCIE_V6_40_PCS_COM_G345_EQ_CONFIG3			0x394
+#define QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG1			0x3a4
+#define QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG5			0x3b4
+#define QPHY_PCIE_V6_40_PCS_COM_G3_EQ_CONFIG7			0x3bc
+#define QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG1			0x3c8
+#define QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG5			0x3d8
+#define QPHY_PCIE_V6_40_PCS_COM_G4_EQ_CONFIG7			0x3e0
+#define QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG1			0x3ec
+#define QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG5			0x3fc
+#define QPHY_PCIE_V6_40_PCS_COM_G5_EQ_CONFIG7			0x404
+#define QPHY_PCIE_V6_40_PCS_COM_TEST_CONTROL1			0x468
+
+/* PCS LANEZ — output signal mux control */
+#define QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL2		0x0e0
+#define QPHY_PCIE_V6_40_PCS_LANEZ_OUTSIG_MX_CTRL5		0x0f8
+
+#endif /* QCOM_PHY_QMP_PCS_PCIE_V6_40_H_ */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h
new file mode 100644
index 000000000000..c7ac7b3bd97e
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_40.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V6_40_H_
+#define QCOM_PHY_QMP_PCS_V6_40_H_
+
+#define QPHY_V6_40_PCS_STATUS1					0x010
+#define QPHY_V6_40_PCS_START_CONTROL				0x05c
+#define QPHY_V6_40_PCS_SW_RESET					0x060
+#define QPHY_V6_40_PCS_POWER_DOWN_CONTROL			0x064
+
+#endif /* QCOM_PHY_QMP_PCS_V6_40_H_ */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
new file mode 100644
index 000000000000..0eeab0693e9b
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-pcie-v6_40.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_PCIE_V6_40_H_
+#define QCOM_PHY_QMP_QSERDES_COM_PCIE_V6_40_H_
+
+#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE1		0x000
+#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE1		0x004
+#define QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE1			0x00c
+#define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE1			0x010
+#define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE1			0x014
+#define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE1			0x018
+#define QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE1		0x01c
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE1			0x020
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE1			0x024
+#define QSERDES_PCIE_V6_40_COM_DEC_START_MODE1			0x028
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE1		0x030
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE1		0x034
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE1		0x038
+#define QSERDES_PCIE_V6_40_COM_HSCLK_SEL_1			0x03c
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x050
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x054
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
+#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE0		0x060
+#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE0		0x064
+#define QSERDES_PCIE_V6_40_COM_CLK_EP_DIV_MODE0			0x06c
+#define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE0			0x070
+#define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE0			0x074
+#define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE0			0x078
+#define QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE0		0x07c
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE0			0x080
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE0			0x084
+#define QSERDES_PCIE_V6_40_COM_DEC_START_MODE0			0x088
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE0		0x090
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE0		0x094
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE0		0x098
+#define QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_1		0x09c
+#define QSERDES_PCIE_V6_40_COM_BG_TIMER				0x0bc
+#define QSERDES_PCIE_V6_40_COM_SSC_EN_CENTER			0x0c0
+#define QSERDES_PCIE_V6_40_COM_SSC_PER1				0x0cc
+#define QSERDES_PCIE_V6_40_COM_SSC_PER2				0x0d0
+#define QSERDES_PCIE_V6_40_COM_POST_DIV_MUX			0x0d8
+#define QSERDES_PCIE_V6_40_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
+#define QSERDES_PCIE_V6_40_COM_CLK_ENABLE1			0x0e0
+#define QSERDES_PCIE_V6_40_COM_SYS_CLK_CTRL			0x0e4
+#define QSERDES_PCIE_V6_40_COM_PLL_IVCO				0x0f4
+#define QSERDES_PCIE_V6_40_COM_CMN_IETRIM			0x0fc
+#define QSERDES_PCIE_V6_40_COM_SYSCLK_EN_SEL			0x110
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP_EN			0x120
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP_CFG			0x124
+#define QSERDES_PCIE_V6_40_COM_VCO_TUNE_CTRL			0x13c
+#define QSERDES_PCIE_V6_40_COM_VCO_TUNE_MAP			0x140
+#define QSERDES_PCIE_V6_40_COM_CLK_SELECT			0x164
+#define QSERDES_PCIE_V6_40_COM_CORE_CLK_EN			0x170
+#define QSERDES_PCIE_V6_40_COM_CMN_CONFIG_1			0x174
+#define QSERDES_PCIE_V6_40_COM_CMN_MISC1			0x188
+#define QSERDES_PCIE_V6_40_COM_CMN_MODE				0x18c
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_1		0x1a0
+#define QSERDES_PCIE_V6_40_COM_VCO_DC_LEVEL_CTRL		0x19c
+#define QSERDES_PCIE_V6_40_COM_HSCLK_SEL_2			0x21c
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE1_MODE2	0x220
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_CMP_CODE2_MODE2	0x224
+#define QSERDES_PCIE_V6_40_COM_HSCLK_HS_SWITCH_SEL_2		0x228
+#define QSERDES_PCIE_V6_40_COM_BIN_VCOCAL_HSCLK_SEL_2		0x230
+#define QSERDES_PCIE_V6_40_COM_CMN_CONFIG_2			0x22c
+#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE1_MODE2		0x1cc
+#define QSERDES_PCIE_V6_40_COM_SSC_STEP_SIZE2_MODE2		0x1d0
+#define QSERDES_PCIE_V6_40_COM_CP_CTRL_MODE2			0x1dc
+#define QSERDES_PCIE_V6_40_COM_PLL_RCTRL_MODE2			0x1e0
+#define QSERDES_PCIE_V6_40_COM_PLL_CCTRL_MODE2			0x1e4
+#define QSERDES_PCIE_V6_40_COM_CORECLK_DIV_MODE2		0x1e8
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP1_MODE2			0x1ec
+#define QSERDES_PCIE_V6_40_COM_LOCK_CMP2_MODE2			0x1f0
+#define QSERDES_PCIE_V6_40_COM_DEC_START_MODE2			0x1f4
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START1_MODE2		0x1fc
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START2_MODE2		0x200
+#define QSERDES_PCIE_V6_40_COM_DIV_FRAC_START3_MODE2		0x204
+#define QSERDES_PCIE_V6_40_COM_DCC_CAL_1			0x2d8
+#define QSERDES_PCIE_V6_40_COM_DCC_CAL_2			0x2dc
+#define QSERDES_PCIE_V6_40_COM_DCC_CAL_3			0x2e0
+#define QSERDES_PCIE_V6_40_COM_PSM_CAL_EN			0x2f0
+#define QSERDES_PCIE_V6_40_COM_CLK_FWD_CONFIG_1			0x2f4
+#define QSERDES_PCIE_V6_40_COM_IP_CTRL_AND_DP_SEL		0x2fc
+#define QSERDES_PCIE_V6_40_COM_PLL_SPARE_FOR_ECO		0x2b8
+#define QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE1			0x0f8
+#define QSERDES_PCIE_V6_40_COM_PLL_IVCO_MODE2			0x218
+#define QSERDES_PCIE_V6_40_COM_DCC_CAL_7			0x300
+#define QSERDES_PCIE_V6_40_COM_DCC_CAL_8			0x304
+#define QSERDES_PCIE_V6_40_COM_DCC_CAL_9			0x308
+
+#endif /* QCOM_PHY_QMP_QSERDES_COM_PCIE_V6_40_H_ */
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h
new file mode 100644
index 000000000000..1de976a4d787
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrxz-pcie-v6_40.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRXZ_PCIE_V6_40_H_
+#define QCOM_PHY_QMP_QSERDES_TXRXZ_PCIE_V6_40_H_
+
+/* Lane mode / LDO */
+#define QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL1			0x070
+#define QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL2			0x074
+#define QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL3			0x078
+#define QSERDES_PCIE_V6_40_TXRXZ_TOP_LDO_CODE_CTRL4			0x07c
+#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_1				0x094
+#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_2				0x098
+#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_3				0x09c
+#define QSERDES_PCIE_V6_40_TXRXZ_LANE_MODE_4				0x0a0
+#define QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_VREF_SEL			0x0bc
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B0			0x0f4
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B1			0x0f8
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B2			0x0fc
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B3			0x100
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B4			0x104
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B5			0x108
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B6			0x10c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE_0_1_B7			0x110
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B0			0x114
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B1			0x118
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B2			0x11c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B3			0x120
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B4			0x124
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B5			0x128
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B6			0x12c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE2_B7			0x130
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B0			0x134
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B1			0x138
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B2			0x13c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B3			0x140
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B4			0x144
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B5			0x148
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B6			0x14c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE3_B7			0x150
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B0			0x154
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B1			0x158
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B2			0x15c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B3			0x160
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B4			0x164
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B5			0x168
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B6			0x16c
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_MODE_RATE4_B7			0x170
+
+/* VCO / KVCO calibration */
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE0		0x1b4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE0		0x1b8
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE1		0x1bc
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE1		0x1c0
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE2		0x1c4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE2		0x1c8
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE3		0x1cc
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE3		0x1d0
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT1_RATE4		0x1d4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CTUNE_MEAS_CNT2_RATE4		0x1d8
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_0_1			0x1dc
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCTRL_RATE_2_3			0x1e0
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_0_1			0x1e8
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_2_3			0x1ec
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_INIT_RATE_4			0x1f0
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE0			0x1f4
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE1			0x1f8
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_CODE_OVRD_RATE2			0x1fc
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE0		0x220
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE0		0x224
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE1		0x228
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE1		0x22c
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE2		0x230
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF2_RATE2		0x234
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE3		0x238
+#define QSERDES_PCIE_V6_40_TXRXZ_KVCO_IDEAL_FREQ_DIFF1_RATE4		0x240
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CODE_OVRD_RATE_2_3			0x250
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE0	0x258
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE1	0x260
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE2	0x268
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE3	0x270
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_UPPER_FREQ_DIFF_BND1_RATE4	0x278
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE0	0x280
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE1	0x284
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE2	0x288
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE3	0x28c
+#define QSERDES_PCIE_V6_40_TXRXZ_KP_CAL_LOWER_FREQ_DIFF_BND_RATE4	0x290
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_SUMMER_CAL_SPD_MODE_RATE_0123	0x2a8
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL2			0x2c8
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL3			0x2cc
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_IVCM_CAL_CTRL4			0x2d0
+
+/* Signal detect */
+#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_ENABLES				0x31c
+#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE0		0x33c
+#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE1		0x340
+#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE2		0x344
+#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE3		0x348
+#define QSERDES_PCIE_V6_40_TXRXZ_FREQ_LOCK_DET_DLY_RATE4		0x34c
+
+/* CDR */
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOCK_CTRL				0x364
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE0			0x368
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE1			0x36c
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE2			0x370
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE3			0x374
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_FLL_RATE4			0x378
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE0			0x37c
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE1			0x380
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE2			0x384
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE3			0x388
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_CP_CUR_PLL_RATE4			0x38c
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_FLL_DIV_RATIO_RATE_0123		0x390
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_01			0x398
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE_23			0x39c
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_CCODE_RATE4			0x3a0
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_0_1		0x3a4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE_2_3		0x3a8
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FAST_RATE4		0x3ac
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_0_1		0x3b0
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE_2_3		0x3b4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_FLL_RATE4		0x3b8
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_0_1		0x3bc
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE_2_3		0x3c0
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_RCODE_PLL_RATE4		0x3c4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE_0123		0x3c8
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_TYPE_CONFIG			0x3d0
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_EN_LOWFREQ			0x3d4
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_LOOP_FUNC_CTRL			0x3dc
+
+/* Rescode / residuals */
+#define QSERDES_PCIE_V6_40_TXRXZ_RES_CODE_LANE_OFFSET_RX		0x3f4
+
+/* VGA / GM calibration */
+#define QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE0_1			0x404
+#define QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE2_3			0x408
+#define QSERDES_PCIE_V6_40_TXRXZ_GM_CAL_RES_RATE4			0x40c
+
+/* RX equalizer */
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL3			0x454
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL4			0x458
+#define QSERDES_PCIE_V6_40_TXRXZ_RX_EQU_ADAPTOR_CNTRL5			0x45c
+#define QSERDES_PCIE_V6_40_TXRXZ_CTLE_POST_CAL_OFFSET_RATE_0_1_2	0x478
+#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE0_1		0x490
+#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE2_3		0x494
+#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_MAN_VAL_RATE4			0x498
+#define QSERDES_PCIE_V6_40_TXRXZ_VTHRESH_CAL_MAN_VAL_RATE4		0x4bc
+
+/* DFE */
+#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP1_DAC_ENABLE			0x50c
+#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP2_DAC_ENABLE			0x510
+#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP345_DAC_ENABLE			0x514
+#define QSERDES_PCIE_V6_40_TXRXZ_DFE_TAP67_DAC_ENABLE			0x518
+#define QSERDES_PCIE_V6_40_TXRXZ_PHPRE_CTRL				0x51c
+#define QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH1			0x52c
+#define QSERDES_PCIE_V6_40_TXRXZ_TX_ADAPT_POST_THRESH2			0x530
+#define QSERDES_PCIE_V6_40_TXRXZ_TX_ADPT_CTRL				0x53c
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_CTRL			0x548
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_MAN_INDEX			0x550
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_ANA_CTRL			0x584
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_IQTUNE_DIV2_CTRL_RATE0123		0x58c
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_OVRD_MUXES		0x5ac
+#define QSERDES_PCIE_V6_40_TXRXZ_CDR_VCO_CAP_CODE_RATE4			0x3cc
+
+/* Clock buffer / LDO stall control (used by bifurcated pre/post-pwrup sequences) */
+#define QSERDES_PCIE_V6_40_TXRXZ_CLKBUF_ENABLE				0x04c
+#define QSERDES_PCIE_V6_40_TXRXZ_PRE_STALL_LDO_BOOST_EN			0x06c
+#define QSERDES_PCIE_V6_40_TXRXZ_LDO_TIMER_CTRL				0x0d8
+
+/* Restrim / VGA / signal-detect (v2-only) */
+#define QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_CAL_CTRL			0x0b0
+#define QSERDES_PCIE_V6_40_TXRXZ_RESTRIM_POST_CAL_OFFSET		0x0b8
+#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CNTRL				0x320
+#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_LVL				0x324
+#define QSERDES_PCIE_V6_40_TXRXZ_SIGDET_CAL_CTRL1			0x32c
+#define QSERDES_PCIE_V6_40_TXRXZ_VGA_CAL_CNTRL1				0x488
+
+/* BLW / VCO coarse-tune bands (v2-only) */
+#define QSERDES_PCIE_V6_40_TXRXZ_BLW_CTRL				0x594
+#define QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE3			0x5a4
+#define QSERDES_PCIE_V6_40_TXRXZ_BLW_MAN_VAL_RATE4			0x5a8
+#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE0		0x5c4
+#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE1		0x5c8
+#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE2		0x5cc
+#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE3		0x5d0
+#define QSERDES_PCIE_V6_40_TXRXZ_VCO_CTUNE_UPPER_BND_RATE4		0x5d4
+
+/* Analog backup control (v2-only) */
+#define QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL15			0x7e8
+#define QSERDES_PCIE_V6_40_TXRXZ_DIG_BKUP_CTRL16			0x7ec
+
+#endif /* QCOM_PHY_QMP_QSERDES_TXRXZ_PCIE_V6_40_H_ */

-- 
2.34.1

