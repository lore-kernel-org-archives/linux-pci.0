Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466214DA9D2
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550539; cv=none; b=cxAh+jeqO7Thz8IMp3spO74ohcmAp/4hsvRLPQxqItf0efX2/vC/Iub3eGzFYfqbPUshl8NWYXmY9ojCd+loN190r29hd3N138CJ0+fzsuPKYDo8Eq0Hs1FpK1nx40I4SIKvPqDq1Tzo8Sd+/tFa8Hc0myl1giccyTkIADFnkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550539; c=relaxed/simple;
	bh=J+Q5cithgOFEs2npg4+9fpSxWnB1Xl5lhIBvetZmBS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TH9DZ7LVPZtFVLZ6ELO/eC3PIfJ3c7vNSPOVMjfcS18jV8/kaW9HClQVXz/7pKwk91NH4fqein3stYqM4Nzhx2DX9TlAA/kMrxgtebh6+B1S3oTtNfxoo+8JtrDaLgD5DX6xWGcJuYsX/yptE+K6G0MiapeE7nCSGTGo0FbVRLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1qRTCl2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WnFW2wBL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1qRTCl2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnFW2wBL"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998KFaj906793
	for <linux-pci@vger.kernel.org>; Fri, 9 Oct 2026 12:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3Uqe/0VfMrfnXwJ3+sZ/qR
	MkgqFZC9GCB2T+l73h4Vk=; b=J1qRTCl2zdrJmhEiDf4laaINSafQegdwuuRZga
	tYLPptQuIhPllCVvcXHsk9YsGBYGjxhxB/8nVTOzRvLQA5w8uZzm9UYQxMf7sNLt
	W803bK95q4j+9tmq7/85A6Y3GUEiTRLfyhsMhjWgH0XkxrsglJ42TdCvIb1EFGkS
	PHdtYtxfkcauM86xaJfor17zddX8/GH1bntFSMyzLYbQEp2zM2uEeGIJvyoF4xv8
	ZLoTLXFAzyHmfhkIloyySb8DuA7DjrGUi8PoW0DOEt9j1yTgJJLs0EO4bXC5cXmg
	mU+zT7mXGZQLSB9RRFHVUV2lLEVxmlXiA14/dBubgb7KxzvQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqupt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 12:55:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so7370832a91.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791550536; x=1792155336; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Uqe/0VfMrfnXwJ3+sZ/qRMkgqFZC9GCB2T+l73h4Vk=;
        b=WnFW2wBLtrntbYqOgjQK/zN/N2BfRjUqdQs5E3Ipv2i7O3SV2ENqt9cm7H5rnN0u27
         66D+49rC1XS0LAe232XnRGANRx+rfeFq2QxrlXzTXXqOJjXbxTRT0BF9CbA6BWV4DcBk
         hpauireTNIIdgAC4O5edWkdCeSLBUHnIGs933C7qFvcbMppsz5Zd+fd+SY0viY63o+U0
         zRosEaLt68eKwuSb4cReyilqeTbIO3/HsaTrOFv/0Zj3EQCJi80V25xyQ29wxS06ZxKJ
         gsj3ja9Vp1IRGTA9Y/CQBNiIFpREKT4RmNP7gFcVOgd3fbSUw6zNQqDdZrxRpPtKejtE
         dHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791550536; x=1792155336;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3Uqe/0VfMrfnXwJ3+sZ/qRMkgqFZC9GCB2T+l73h4Vk=;
        b=hI/nZileBbyN4VY5puScomQ3VDKH1YV4Vs+mNqreMC++xOG3q8HEONjhdrriU4T2yZ
         hCwCj0ei/7DG2vwj9VVWt41ihSh4hBP+Q5RshFPvzTMOQ1C6covla/sm2izq7BWY8iep
         GACv5wQrtkZnpYO0QMQ5CuKo6exLpwuaDPVUEXMgz5Kvml40L2Ke8WAAYVmVAkggyNhz
         s/wbuaiWCfggsveV1zuEoZsvV54i4LvwYoHhYQPtwiptWE2I8sAEaFnOVXc6trFEHhhG
         RtRGYtjBAloP/+bgzeBvRRNkc9cM0mkRpAELRwZ0zK+zCwuMySmelBYmXPuPh+yuJLYj
         EumA==
X-Gm-Message-State: AFq9FYJxevMqkmoIz1Mgf0ISZ7Y3Hg/JNIUDf2AL+tfg6BMjd62TRlTG
	NjbXLsUAVqDVHbQmJPMupIQibgHv6LfG9LaXxHzHqMxOaIP8is8j9+h0rzRQmbybkksbhB/W1YW
	sfvDynfPPJWzPBKKREtFIMWLcvGZWtC6xe3XUOZSy5Jujp03jsVjMlxZ8nPLhx/aRbi7YV8c=
X-Gm-Gg: AYBFou2Yx6HeRcJwo5r6r9QU5zFEOBh+JM8MBjlDBmbXlv21Jsm8hg7IOWFPlsXK7Cq
	WN7LeXngHxY4y7AhmWPeMlGCKGPT+4As3gqqdeV/zuoefVVaK5OBHCxMj0osqPluvYXShMDCZix
	JoGOc9M5efOgUvOvh70NzJ5aSLYRRC9SKbHeMHo1H6Oj4D8oywStaWGggtpBgfOuvuekbenNZ1w
	qkwD0ZJ9B18e6nrloHfSUDAyBRZCA/zD2pUuMj60UC2Rg4EMsQcHNn1CCyHmARrq3F6alnICuqS
	KZJSu3Q0+N/Fz2kV5KgfYKtOgsh91ec5hgffHtgz4Qx+MP15SHb1lSyUTtefZkQRsUN/5ROWAls
	rkp8I6N3Qf9Ih8G+e6aAE4NFewnUuidRQqw==
X-Received: by 2002:a17:90a:ec8c:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3ab3a2902admr1884407a91.3.1791550535898;
        Fri, 09 Oct 2026 05:55:35 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8c:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-3ab3a2902admr1884378a91.3.1791550535324;
        Fri, 09 Oct 2026 05:55:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36fdc75esm3571153a91.12.2026.10.09.05.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:55:34 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 18:25:27 +0530
Subject: [PATCH] PCI: qcom: Disable halting feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-halt-v1-1-4a2d7899d91f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD7kyGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNL3YzEnBLdpDRzS0PDNAPzlJQ0JaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAI+4lT5oAAAA
X-Change-ID: 20261009-halt-bf7911f07ddf
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791550531; l=4919;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=J+Q5cithgOFEs2npg4+9fpSxWnB1Xl5lhIBvetZmBS0=;
 b=XICb5l7eu3tq2RSc345oeJQ24YwNk5tk6gMVyHwWtJJMwd7juMvCPEmz4J0r0aTzDE6bBZSMs
 eqyK2PV30KaDtgY6W3XwDd0xcfklLCKxO+Dy3wEQsfXIrJbBxGYL93b
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MSBTYWx0ZWRfX7hCm+JhO8gR3
 7/D7FRJh2QhftMsk5xhyWPh7kDmjuMQ8Ez5fwo1HlnejKifedN2XowDLKqCTwayP6uSUSAHK3eM
 vprJKe6psPIzmD1Cj9Z50LsG5MU4o6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MSBTYWx0ZWRfX1LkAKeRL54NZ
 EjVgWJZZi6RGDcuPH8NE+LRre3gM8okdKgM9b7G+iu8ilnM1NCubl55ePQyt115x0Pmb+OHQ1WG
 Ykzx5id5/tSO8sp6wIAzqAwKggup0jzdGJi04tC8RDSWiEX7EJxHCkiZG5eQD4Gl06/K/F/Cxxw
 sl7HT1LMcBf7oS0fQ25T4fI36bMsF/xO1wjVggHskuiiuYe3bwQQLGNsIAZwTNQmz9ChdvnA0Ip
 RF4WuYFaZBN8KRVnYRrkH7myt3NEJHndL6sZb49V0zXWG+kmm8V/UhY4KptMoS/DDZB71APt6Jz
 v56yu5yQQOrBfAPXxyNHg3SlvVDPEP455rmDqXOpFYA3FfrMzk1kI9Igl0bVxi6TQjjf7ukZVF1
 FKIZRZ/yKBgPxyuO+zVegyK0m6EzwITmQvTN5xR/9ppIKqNXq+Wmwk+U4P6Rbly7JEG/J7zzc9S
 JyhBb9IXQUzp+fA5T8w==
X-Proofpoint-GUID: SQM0DvQf_L1Ew1MqPnLE5oVWU3LeXJLf
X-Proofpoint-ORIG-GUID: SQM0DvQf_L1Ew1MqPnLE5oVWU3LeXJLf
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8e449 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=c_kIYljxz58IW9DPLlcA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090051

The PARF write, read and BDF halt features make the controller wait
for earlier AXI transactions to complete before issuing new ones. This
is needed on SoCs whose NoC cannot preserve the ordering of inbound
transactions from the controller.

On newer SoCs, the NoC preserves this ordering on its own. Halting at
the controller adds no correctness benefit and reduces inbound DMA
bandwidth.

Add a noc_ensures_ordering flag to struct qcom_pcie_cfg. Clear all
three halt features on SoCs that set it. Other SoCs keep enabling
write halt as before.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
On shikra we should not disable this feature, when respining the shikra
we need to make sure this is not getting disabled.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 37 +++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..73eb303919c1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -53,6 +53,7 @@
 #define PARF_SLV_ADDR_SPACE_SIZE		0x16c
 #define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
+#define PARF_AXI_MSTR_RD_HALT_NO_WRITES		0x1a4
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
@@ -67,6 +68,7 @@
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
 #define PARF_NO_SNOOP_OVERRIDE			0x3d4
+#define PARF_AXI_MSTR_WR_NS_BDF_HALT		0x4a0
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_DEVICE_TYPE			0x1000
@@ -134,6 +136,9 @@
 /* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
 #define EN					BIT(31)
 
+/* PARF_AXI_MSTR_RD_HALT_NO_WRITES */
+#define RD_HALT_NO_WRITES_EN			BIT(0)
+
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 #define PARF_LTSSM_STATE_MASK			GENMASK(5, 0)
@@ -149,6 +154,9 @@
 #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
 #define RD_NO_SNOOP_OVERRIDE_EN			BIT(3)
 
+/* PARF_AXI_MSTR_WR_NS_BDF_HALT */
+#define BDF_CHANGE_HALT_EN			BIT(0)
+
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
@@ -275,12 +283,16 @@ struct qcom_pcie_ops {
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
   * @firmware_managed: Set if the Root Complex is firmware managed
+  * @no_l0s: Set if the Root Complex does not support L0s
+  * @noc_ensures_ordering: Set if the NoC preserves the ordering of inbound
+  * transactions from the controller.
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
 	bool override_no_snoop;
 	bool firmware_managed;
 	bool no_l0s;
+	bool noc_ensures_ordering;
 };
 
 struct qcom_pcie_perst {
@@ -1081,9 +1093,23 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 	pci->l1ss_support = true;
 
-	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
-	val |= EN;
-	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	if (pcie->cfg->noc_ensures_ordering) {
+		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+		val &= ~EN;
+		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+
+		val = readl(pcie->parf + PARF_AXI_MSTR_RD_HALT_NO_WRITES);
+		val &= ~RD_HALT_NO_WRITES_EN;
+		writel(val, pcie->parf + PARF_AXI_MSTR_RD_HALT_NO_WRITES);
+
+		val = readl(pcie->parf + PARF_AXI_MSTR_WR_NS_BDF_HALT);
+		val &= ~BDF_CHANGE_HALT_EN;
+		writel(val, pcie->parf + PARF_AXI_MSTR_WR_NS_BDF_HALT);
+	} else {
+		val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+		val |= EN;
+		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
+	}
 
 	return 0;
 err_disable_clocks:
@@ -1597,12 +1623,14 @@ static const struct qcom_pcie_cfg cfg_1_0_0 = {
 
 static const struct qcom_pcie_cfg cfg_1_9_0 = {
 	.ops = &ops_1_9_0,
+	.noc_ensures_ordering = true,
 };
 
 static const struct qcom_pcie_cfg cfg_1_34_0 = {
 	.ops = &ops_1_9_0,
 	.override_no_snoop = true,
 	.no_l0s = true,
+	.noc_ensures_ordering = true,
 };
 
 static const struct qcom_pcie_cfg cfg_2_1_0 = {
@@ -1624,15 +1652,18 @@ static const struct qcom_pcie_cfg cfg_2_4_0 = {
 
 static const struct qcom_pcie_cfg cfg_2_7_0 = {
 	.ops = &ops_2_7_0,
+	.noc_ensures_ordering = true,
 };
 
 static const struct qcom_pcie_cfg cfg_2_9_0 = {
 	.ops = &ops_2_9_0,
+	.noc_ensures_ordering = true,
 };
 
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
 	.ops = &ops_1_21_0,
 	.no_l0s = true,
+	.noc_ensures_ordering = true,
 };
 
 static const struct qcom_pcie_cfg cfg_fw_managed = {

---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: 20261009-halt-bf7911f07ddf

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

