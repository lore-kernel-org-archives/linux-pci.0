Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E326ED3E
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367917; cv=none; b=Uawn9FLvWyJrbw1pvFVPpd4S54HhC2ybmbLEaEU21+4QUj+oP4mhqboccS+22LYDMMKRQk1ixG28deYgp/3w5kjbFxv3EbEPJuei5Ejus+Issq1ASfkQCABEUNk7YIt5/kRG+knqmzclyzLJA2N78sT2TPkO2jhGggy8kw6uGAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367917; c=relaxed/simple;
	bh=rqLb0leokYtiOyN/1dnd6EJFd31J2CbTZT4kf3PL2IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jlrBkDtIxiMz27LOwovre+n3JUPESvpfgkmwebb+d7sWFFIu8aB0d97E9mqScFpw52u7PpRNaRj4nX3GKz/gWXP/vYQtIzT2kXowIGXdQjkyrqlwg89XDrIz6gecf8pCEnf4QXuQRngzRLTxI65YNrRgrq93sXRzjFSINgl7AaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RK37kGTq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O3reUCi4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RK37kGTq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O3reUCi4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACj5XR1367817
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 13:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lCRftOPaRKiExM66EvRPfB
	NvSrEFplSk2TDdjjmFwQc=; b=RK37kGTqDSqTbchU8nESS5egxAaANgyWv6dcdf
	5SKiQ7CsuPTBoGsNwb6X2LVRVj1xICYcMH5BJttB3l90sXVfUYzDPQ60GEZJEs9Q
	QTRzKFlXd9+l6xhqYT/q0QY61YaO+uv2UIaT8CtVoWJLpFQwzIlugyQDt1CshnDN
	+oVA6jjtWU0G6GgLUbsLj8DwrfbTd4g3TD7L5NcLaPny1c+Ntp8QLjy4MSwTfi0o
	rpTZAAzmk7MeOUDzTzZKzy56VCFQzKCDlVX+XvRjbifTxJMakipgepigiOoAxLaX
	KPUs6qtMtmmbNboSdGovkCb21VTgnFakfYOfKYhX8jzAY/uA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v49nek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 13:18:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cce14a21faso31900325ad.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786367914; x=1786972714; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lCRftOPaRKiExM66EvRPfBNvSrEFplSk2TDdjjmFwQc=;
        b=O3reUCi414ph57TC9M5NuTHZ9JwiC6wzn2vG0R+JaNjZ+vwUY11FwjbNdAeUg/gh6a
         k84HYS4WW1QhISDZOSWKH9YbKEU4FlTbSSNYwvdsMo5XSmrZX2ZPJ9dId4XIXM/NUHUo
         f5vy3PLbUq0Y19UvnVpLKkZvrWhovb5FI01ZnNFZ5CNLqFgvlgHGVVYsyPLryCSYzFQK
         tb7waotV2vC0AWUTWm1QxK6jNCU/6ujbHdVCqLL67n2khpNJSoamgAVVWFMI7tIZ0bTL
         s0m6hqpNL8fqJjmGNwzrad3tvM16xWypyPN6KgXIrQVx0cSS1CuZv8B0K0os9iyLOyBZ
         rmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367914; x=1786972714;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lCRftOPaRKiExM66EvRPfBNvSrEFplSk2TDdjjmFwQc=;
        b=THdjjgl4Ltcbo+4ZjpzWYw9Gzp8U/IhHNWRn9su69nME81Cw7H4xjU/qEgEwHsKaH9
         MQN+XgTaJt1FaXMhD8tbNikOOOKteS0P57KfGAFqWC+iMDKdVM8RPrbSUKhLx6mqGOCF
         sIqpwqYWBkPEbEOr655NW0ROhRlCf/1o4/lbRWLcu64Y7OQMJ4QxuTUlwyKoVu5VmcIt
         xPUjpjxTaxVfazFB8T2q6ygbzYQq+zZEJcgZKImJM9uqKqDh0gJY0v/X4LDhmpAf8zK5
         cqmKrNWTfQLMG+MadcVHdnOsZbJ5X3DZ2Lha1FBdJZZ1aakY1msApKK23ZbonOPIzKsB
         b6Gg==
X-Gm-Message-State: AOJu0Yxi2L7CFyRShJsw1j6NwaOKquZZX12ikA43BO36YY2nkByRlLO5
	Ti63P69rHAO5falY9EyTboeXlLd23w9wOna2IkL0KPetb0D67VBuVRvD8doVw+Zzmq3Pz+554VP
	s8ZPwaMUI7vhdvzt3rMegVc22tiRuEmPyfuSCRDZJUhlD8CKaPTtE9YEAOySX1FIfqjXpXvs=
X-Gm-Gg: AR+sD13mkZjZ33dQv/7vr6I/DGSrOU22LJGoV0HrFogAICE/TG0HnBPUEX81MZ70mBh
	qmarwq/sDS2sbElFbRYJGzaEPb/2DmuVLOaFd9gkBQFM0B+brq8UUhKi0cM/aBpXIp+1LI4aff9
	DpzNgRp22lQHMU+6cwMUUNv+Ufhh2x2MvhhX6SVUtNR9Jex0cMhAL5xdpUSnr7E39LuhD38dytw
	M18L098K13g/R/+EOShYdyF0yrl2IrJ44dKK3+Jj7fyiGnRBITl9Zl2wm49pIkWLUQ9VmWHdkEA
	VorNhm/HctXSNcjmsTY9XND72Mlyo2HYBgmsFDCggs0UrfIheiLE4loSltdXN46MhdxWp++vX3P
	gDjGNxHxDLvbF4eT6gjxU1TCbhLr6pCrjzGQ40BE8QQBoTx0=
X-Received: by 2002:a17:902:e747:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d2b2d9468bmr98082365ad.1.1786367913851;
        Mon, 10 Aug 2026 06:18:33 -0700 (PDT)
X-Received: by 2002:a17:902:e747:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d2b2d9468bmr98081665ad.1.1786367913148;
        Mon, 10 Aug 2026 06:18:33 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c50cfc1sm36768825ad.82.2026.08.10.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:18:32 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 06:18:29 -0700
Subject: [PATCH] PCI: qcom: Block accesses to downstream devices on link
 down
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-ecam_blocker-v1-1-e588e07f68d4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKTPeWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0MD3dTkxNz4pJz85OzUIt00CwPDJONEA6Ok5BQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAMD7OvnAAAAA=
X-Change-ID: 20260810-ecam_blocker-f801b3a02bcd
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786367912; l=4751;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=rqLb0leokYtiOyN/1dnd6EJFd31J2CbTZT4kf3PL2IQ=;
 b=YhPsVS5OFa870b2bUwMagYVlp0GHhXIZiqrQI2Cu/wj68P9gsbnXDBpkzBKcaOWZgw7/Keh+N
 wvZqF504kUMCOI07yRDlWJxwtvVJpR8oD0IveuK8HHw7q+BggqbUl3Y
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: ZNX03TGC0L2vTEHMZKxxcDVmZCLfQ_7D
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDExNCBTYWx0ZWRfX5Y0dLVDvvSHU
 OdO9gWNSGWmos2pIwdKha4ys2st+XCNzW6wOJCsark99ulMJuOMEFRZvE3Bx6srkaq072d0QNKV
 rzB8ZZfatLAxaUaWeNXfHaRHHugzDbg=
X-Authority-Analysis: v=2.4 cv=W5EIkxWk c=1 sm=1 tr=0 ts=6a79cfab cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=GUKgOjlLqbvdKOx-lw4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDExNCBTYWx0ZWRfX6ptJgR5Ug4Ah
 L/qn+6KWgPS9c9EEodD7Mr/vSKwjW00mVLl1Pn+xxZzVRXxl1wBjXPmby3jEWnJcYaYD1v3iwos
 ZngNgzPhB0Ans1CbX8ZS3/HEFKU4N4tA8U7dxe9JRhk5og5XCFmgAu3avXXkn9N/9CjiTXdsybl
 ODcDyire/C/n6uvvE/qnasRPfmIaxZMsHvHhFWemFzCCWpRGi5n9WfqM669wGJ479RAdK/UhARh
 Bfkeh9DSzRK+CgarU7zuxQAs2OXFw4wnXWFid33Qnoulo7IsjgXl+QJA6nqGZ6o7WQ+H3GCs01g
 axzsa6mn+WD6+zWQ562HTfk2hQWmKx0iDlCZkXWUSwhrVJi3f8IhAnPIyirC9sv6fzTR7eyJovu
 hKH4ps6lzoYThARvbrTaZlrt270CuCte6Q00NAvFUAGtjtAAtPqxAPgLyQ6IHT1tdun0YWF4iBY
 nYmoBB2AFGaIOJx0koQ==
X-Proofpoint-GUID: ZNX03TGC0L2vTEHMZKxxcDVmZCLfQ_7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100114

After a PCIe link goes down, software may still access the BAR (MMIO)
space or configuration space of devices behind that link before recovery
has run. As the link is down, these accesses never complete, resulting in
a storm of Completion Timeout AERs.

Use the controller's ECAM blocker to drop these accesses to the PCIe
address space as soon as the link-down interrupt fires, so that Completion
Timeout AERs are reduced. The blocked range covers the entire address
space (base 0x0, all-ones limit), since the Root Port's own DBI/iATU
register space remains accessible regardless.

The range is programmed once in the host init path, since the range
registers are wiped by BCR reset. This leaves only the ECAM_BLOCKER_EN
bit to be flipped from the link-down IRQ handler, so the blocker can be
armed with a single fast register write for immediate effect.

The subsequent Root Port reset re-initialises the controller, which clears
the enable bit and re-programs the range for the fresh link.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..7005d989f6ff 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -73,6 +73,23 @@
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
 
+/*
+ * ECAM blocker range registers. The blocked range has a write pair
+ * (WR_BASE/WR_LIMIT) and a read pair (RD_BASE/RD_LIMIT); each address is
+ * split into a low (32-bit) and a HI (upper 32-bit) register.
+ */
+#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
+#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
+#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
+#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
+
+#define PARF_ECAM_BASE				0x380
+#define PARF_ECAM_BASE_HI			0x384
+
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
 #define ELBI_SYS_STTS				0x08
@@ -90,6 +107,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define ECAM_BLOCKER_EN				BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -1382,6 +1400,37 @@ static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
 		dw_pcie_program_t_power_on(pcie->pci, port->l1ss_t_power_on);
 }
 
+static void qcom_pcie_init_ecam_blocker(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+
+	/* ECAM base must match the DBI base address */
+	writel(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
+
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
+	writel(0, pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
+	writel(U32_MAX, pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
+}
+
+static void qcom_pcie_enable_ecam_blocker(struct qcom_pcie *pcie)
+{
+	u32 sys_ctrl;
+
+	sys_ctrl = readl(pcie->parf + PARF_SYS_CTRL);
+	sys_ctrl |= ECAM_BLOCKER_EN;
+	writel(sys_ctrl, pcie->parf + PARF_SYS_CTRL);
+
+	/* Flush the write so the blocker is enabled before this function returns */
+	readl(pcie->parf + PARF_SYS_CTRL);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1422,6 +1471,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 
 	qcom_pcie_configure_ports(pcie);
 
+	qcom_pcie_init_ecam_blocker(pcie);
+
 	qcom_pcie_perst_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {
@@ -1878,6 +1929,9 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 
 	if (test_and_clear_bit(INT_ALL_LINK_DOWN, &status)) {
 		dev_dbg(dev, "Received Link down event\n");
+
+		qcom_pcie_enable_ecam_blocker(pcie);
+
 		for_each_pci_bridge(port, pp->bridge->bus) {
 			if (pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
 				pci_host_handle_link_down(port);

---
base-commit: 3de6add8d15430cde96c615fd156216676762bf9
change-id: 20260810-ecam_blocker-f801b3a02bcd

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

