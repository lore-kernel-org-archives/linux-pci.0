Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C43B0AE1
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791652; cv=none; b=FTTzDVUT23Q6rUHMMxIKgyV68ZVQ3+7mwQ9W7psr9HnfR/9igwegFKpg1aLvfmnYhjJHtUIFww0MWL2hAVzHHDDfvjguz4jee7WYnvIgqaHqs1Zsrdh+O/654b3mZtfKNs4TC8soTF4AeekIq+uMuEpQHeT2Wv67k+hR3oycGXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791652; c=relaxed/simple;
	bh=gghkv7zdXWZ6sXY7UEWVIvU/xUzxz837euFu8M0kdhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EePiopG6SYHe9yzY1jgQd8qfJ77bAk7tKANzrzfiUif8qPf7mGAvQg8SAPqGaGEu4LHtfjU5EtXPj2vmPEqRUWwMmGZzJ6UndNs8pmuFH7CNuNC/F0f7gSzbMr/kPY1y1IHf4V5xck9kOvjVR55of8Vk/wOuJJ2MnGDI80oER1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Orv3VFaN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UkTzKiZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Orv3VFaN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UkTzKiZD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DeLfC3607261
	for <linux-pci@vger.kernel.org>; Mon, 7 Sep 2026 14:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KGMEa01HAbq7RFLKvPr6n5se8AjjGKtLJcv
	8+giMlBw=; b=Orv3VFaNxRnTs+DhkZ4HlcP+q/bdDN7ErohLIi/0KUzcdgsBovY
	Ra6ziyXhyTNcOMn/BufIunBuDcPieYLBceuFBjjOkYJfWUZlGewkqxYUCsZZv8Ra
	ZUzRG0S6/EF6wfJH7W2m0wPaM+dXctrWPpCoqfQvkaixf5HxPpQWU/HjVfEEUoqL
	dSAwr+Jz+5n32FL/HsY5f67BVDirmcBITUSf4GD0Ta6RKfr0DdFwlX3Vhxb/SaLF
	wEVambbzMPEUnso3Q69azAcUcRvxRUGYWBeoXaod9s6sbHCwqtShAWZhk6GFTFB3
	UlBIgZgwo4re1U4zQAKuL98LlWa5mt/QMSg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxku441-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 14:34:02 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b1b27d7ab2so5356108eaf.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788791642; x=1789396442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KGMEa01HAbq7RFLKvPr6n5se8AjjGKtLJcv8+giMlBw=;
        b=UkTzKiZDdO5cx/b/NuSfQwgQNuhjJkUPW5VLJtYDybhvi4YB8M3A3Mk2qqSqyEGyH1
         YL/mPBHMJsf/VkZCWtDfYvfk37/L1CqemHEVSwyITJ1vjQB823UjL4i7sb9gxBA4G4Cm
         TUYuSZnzw7Ktmu8glWiXeCOpOzXf7kE80tZkd8tHbRGoTNugdQOrvV0Kn1l2B+8LcGSk
         SbkvaWUpdwiUN6KGphkDJjdDRf451sslbjOQCs0xUH2hU7Kis+6VzflB1seNk56+d5/I
         dioLakwZooTcrKr5qJxn2gCVPsr3YyGSi9/XgEpQrBbPe7nLXfWP2Chu/KgjphgTSvfI
         YOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788791642; x=1789396442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGMEa01HAbq7RFLKvPr6n5se8AjjGKtLJcv8+giMlBw=;
        b=MlBoxAroZU+HdYgJsLxkYBCgQaqxJ8aubTMo06gUN9VpDEPL49GyXd1JGNJGiZxJmF
         Aooj7Chc2d54LUnduInlQ27tfeEoYIuD34/WnuhEeBwOa1I/nM8tGTru6QAbMyX+FOEA
         WFJLOwQi5q78zC6riujkk7FYqGeGpCzXV6mKUIeA1YAUNcgAfodjb+Gfylqd0Rhkz5L5
         3P8KuPdJKt78e2Ymttz7LTcaNipkXFSgT+2BldijXNNeapb91xE4UJC4Z1u0Rood73ta
         yY8J7KUS47gQ88DX9bcWCxOQ7f9ckBrl//BWNqlKEYWhYtwg4FDuoG+S+BQCCNpZEiYT
         9iEQ==
X-Gm-Message-State: AFuF++mm65RTpqNcWJDfbO0ib83WyURhaHETvm3Vn6x/1KMjMUYvhe4T
	/cb9v22iadk41iQQaw7GJHytSqYaP9UDtlHV3xoZmQamOAS73DqLqSnx44rAIr4GyWtttQm6+SK
	homLom8mawiGRJL7hG6ZfAeRExbJ9L1HMwHk52dhLPSY2UYBLZF93/JacCoWqwzL4pRYw43S55g
	==
X-Gm-Gg: AYBFou2uBhzRAYtuF5LRUp+oHQv0FyMhuDbaAP89sUfptTzWbVBBn2zZ6LRu+T10qMo
	AwIsVGHZpi+Jmi6bqSoDyRPdhSsg5dRZdLQ1esWei41drpnysSSw1cKmdFITp/0N/ha0HbfzCDr
	V4+BipKSqChSp09enYg9mlS7SiCx9eeCDYIVRrl2ToI8+nvAU3bzl0N48swm/SifszPnsJm8Fi1
	IClhEfPWypugginew2ic1CeEUM+7rhAnt8WlUAKCYCJ+5tqRyX0Y1uKrN0zMk7KJKKyDoFlDxZ0
	E+AzZKVVbZLKt8rRQ+1ObOs42sb9WrHA4kVlCS42R6/vIirUWlQmaEey77c7vj09r7SQSjdgLZP
	68qm0kXmYU3IRIeyG0pY=
X-Received: by 2002:a05:6820:8108:b0:6b0:be69:d3cd with SMTP id 006d021491bc7-6b6fc9d05f6mr12790503eaf.17.1788791641735;
        Mon, 07 Sep 2026 07:34:01 -0700 (PDT)
X-Received: by 2002:a05:6820:8108:b0:6b0:be69:d3cd with SMTP id 006d021491bc7-6b6fc9d05f6mr12790482eaf.17.1788791641302;
        Mon, 07 Sep 2026 07:34:01 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.60.54.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1433171a97esm25977900c88.12.2026.09.07.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 07:34:00 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH] PCI: qcom: Honor IOMMU provider's #iommu-cells in qcom_pcie_config_sid_1_9_0()
Date: Mon,  7 Sep 2026 16:33:49 +0200
Message-ID: <20260907143349.317495-1-mani@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE2MCBTYWx0ZWRfX8CkWBvqYH7+b
 NcDezTsDNKISz8fmN+Lr0XRpBcjII3H8sFc8cFu4AtLWlYXsZkVi9vB0Ncde6jNTl8KnubWWTSU
 UF3BHTWaj4ZZpL0G4l0EZRHiHuuduv1IpusIIno8ZV9fyGm8y6nIYBzBtE6StQzJbEnBSOe6TPi
 Jp5vu4XAxxYokobg4TJ/BnTBp/vr/KDyXSnnHwQvezuLG3whmDB7vqjMxnMYSawkjMZOw+sPNKr
 lFjv9nnbqXOur5DGzgX2/cjPascRhlxowcLVDtCazYBfqJXWoUDZXIBbw3tYO5y6ni3B4aTxUO0
 TQl5Pq9UIw2rZLMnJ8F4wTwh+6IsNTrR3eFgmnAvldow+GW+UXhmmda/hmwy1skk86j5rTA2eNW
 1Mw5X5jOwObrcN2nHEap9B2XnXw3TcdHcBIie1/0QO5j1XpUZ3A9MsBiXsdnKZd/BB5M88Tm6aU
 UBGShqVxCBz6O3umQJA==
X-Proofpoint-GUID: dEgTYfMDZDLe9g0ZqwK-DO-2bYtx6FxA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE2MCBTYWx0ZWRfXyANZLJy566s5
 gJRYa326DhzydfmaL5b2QiPR6XIg9DljpZ285pIUnJayINLywxKK5JhzCUerbqIPO/A8Tmxb6oB
 JjdlH20qhfzaF3AawkQCJRNDQ8UFEsY=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9ecb5a cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=rmNCNknCB1PV+D2WvuySnA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=glRjDg6tCVJ14w43rIUA:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-ORIG-GUID: dEgTYfMDZDLe9g0ZqwK-DO-2bYtx6FxA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070160

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

qcom_pcie_config_sid_1_9_0() reads the "iommu-map" property as an array
of fixed four-word {rid-base, phandle, sid, rid-len} entries to program
the BDF to SID translation table. But that layout only holds for an
IOMMU with '#iommu-cells = <1>'. The PCIe SMMUs on these SoCs use
'#iommu-cells = <2>' (SID and mask), so per the pci-iommu binding each
entry is really five cells long.

This used to work only because the DTs were themselves broken. They
described iommu-map with four-cell entries that omitted the SID mask,
which of_map_id() tolerated via its of_check_bad_map() fallback, and the
four-word parsing coincidentally matched that malformed shape.

Since commit ccb2fd725d41 ("of: Respect #{iommu,msi}-cells in maps") the
OF core parses such maps correctly, so the device trees were converted
to proper five-cell entries, e.g. commit c41749e9554d ("arm64: dts:
qcom: sm8250: Fix the PCIe iommu-map entries"). With five-cell entries
the fixed four-word stride slips by one cell for each entry after the
first, so qcom_pcie_config_sid_1_9_0() reads the endpoint mapping's RID
from the preceding entry's length cell and its SID from the phandle cell.
As the RID is the hash key, the endpoint's real RID is never programmed
into the BDF to SID table. Its DMA then hashes to an unprogrammed slot,
gets tagged with SID 0 and the SMMU faults like below on QCS8300:

  arm-smmu 15200000.iommu: Unhandled context fault: fsr=0x402, iova=0xffa00000, cbfrsynra=0x0, cb=1

To fix this, walk the map with a stride of 3 + '#iommu-cells' of the
referenced IOMMU and take the SID from the first specifier cell, which is
all the BDF to SID table needs. Validate the layout instead of trusting
the array size. Also, preserve the legacy behavior of the old DTs by
detecting the same pattern that of_check_bad_map() recognizes and
falling back to a stride of four.

Fixes: 4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
Reported-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 90 ++++++++++++++++++--------
 1 file changed, 64 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b58a607b713f..42cbeef083ca 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1143,50 +1143,90 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
 {
-	/* iommu map structure */
-	struct {
-		u32 bdf;
-		u32 phandle;
-		u32 smmu_sid;
-		u32 smmu_sid_len;
-	} *map;
 	void __iomem *bdf_to_sid_base = pcie->parf + PARF_BDF_TO_SID_TABLE_N;
 	struct device *dev = pcie->pci->dev;
+	struct device_node *iommu_np;
 	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
-	int i, nr_map, size = 0;
-	u32 smmu_sid_base;
+	const __be32 *map;
+	u32 iommu_cells, entry_cells, phandle, smmu_sid_base;
+	int i, nr_cells, nr_map, size = 0;
 	u32 val;
 
-	of_get_property(dev->of_node, "iommu-map", &size);
-	if (!size)
+	map = of_get_property(dev->of_node, "iommu-map", &size);
+	if (!map || !size)
 		return 0;
 
+	if (size % sizeof(*map)) {
+		dev_err(dev, "Malformed iommu-map property\n");
+		return -EINVAL;
+	}
+	nr_cells = size / sizeof(*map);
+
+	/*
+	 * Each iommu-map entry is: rid-base (1 cell), phandle (1 cell),
+	 * IOMMU specifier (#iommu-cells cells), length (1 cell). Read
+	 * #iommu-cells from the IOMMU provider referenced by the first
+	 * entry to compute the per-entry stride.
+	 */
+	phandle = be32_to_cpu(map[1]);
+	iommu_np = of_find_node_by_phandle(phandle);
+	if (!iommu_np) {
+		dev_err(dev, "Failed to find IOMMU node in iommu-map\n");
+		return -ENODEV;
+	}
+
+	if (of_property_read_u32(iommu_np, "#iommu-cells", &iommu_cells))
+		iommu_cells = 1;
+	of_node_put(iommu_np);
+
+	entry_cells = 3 + iommu_cells;
+
+	/*
+	 * Retain backward compatibility with DTs that describe iommu-map
+	 * with 4-cell entries against an IOMMU declaring #iommu-cells = 2,
+	 * matching the fallback in drivers/of/base.c::of_check_bad_map().
+	 */
+	if (iommu_cells == 2 && !(nr_cells % 4)) {
+		bool legacy = true;
+
+		for (i = 0; i < nr_cells; i += 4) {
+			if (be32_to_cpu(map[i + 1]) != phandle ||
+			    be32_to_cpu(map[i + 3]) != 1) {
+				legacy = false;
+				break;
+			}
+		}
+
+		if (legacy) {
+			dev_warn_once(dev, "iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output\n");
+			entry_cells = 4;
+		}
+	}
+
+	if (nr_cells % entry_cells) {
+		dev_err(dev, "Malformed iommu-map property\n");
+		return -EINVAL;
+	}
+	nr_map = nr_cells / entry_cells;
+
 	/* Enable BDF to SID translation by disabling bypass mode (default) */
 	val = readl(pcie->parf + PARF_BDF_TO_SID_CFG);
 	val &= ~BDF_TO_SID_BYPASS;
 	writel(val, pcie->parf + PARF_BDF_TO_SID_CFG);
 
-	map = kzalloc(size, GFP_KERNEL);
-	if (!map)
-		return -ENOMEM;
-
-	of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)map,
-				   size / sizeof(u32));
-
-	nr_map = size / (sizeof(*map));
-
 	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
 
 	/* Registers need to be zero out first */
 	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
 
 	/* Extract the SMMU SID base from the first entry of iommu-map */
-	smmu_sid_base = map[0].smmu_sid;
+	smmu_sid_base = be32_to_cpu(map[2]);
 
 	/* Look for an available entry to hold the mapping */
 	for (i = 0; i < nr_map; i++) {
-		__be16 bdf_be = cpu_to_be16(map[i].bdf);
-		u32 val;
+		u32 bdf = be32_to_cpu(map[i * entry_cells]);
+		u32 sid = be32_to_cpu(map[i * entry_cells + 2]);
+		__be16 bdf_be = cpu_to_be16(bdf);
 		u8 hash;
 
 		hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be), 0);
@@ -1208,12 +1248,10 @@ static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
 		}
 
 		/* BDF [31:16] | SID [15:8] | NEXT [7:0] */
-		val = map[i].bdf << 16 | (map[i].smmu_sid - smmu_sid_base) << 8 | 0;
+		val = bdf << 16 | (sid - smmu_sid_base) << 8 | 0;
 		writel(val, bdf_to_sid_base + hash * sizeof(u32));
 	}
 
-	kfree(map);
-
 	return 0;
 }
 
-- 
2.43.0

