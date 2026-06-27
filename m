Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AC1A9FBD
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547635; cv=none; b=iWnCkETn2BU+Q/b5ArRF70R3Xl8plGaXOt2sEsJQD7kEWFkRzTXzxWfBdRDGyTfb9D6AKvfKNVuRBw2c/QauX6VFiB8NarMc/wAQCTduGQ6WxmL6Whu15WfRp1MYrKKTlSRs+sx/Vi+ZLsi83J6lpQDBZQ9ov0D/71NXzyAXnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547635; c=relaxed/simple;
	bh=zXW1XafnasxL3ImW4DzgnyYlWRPzxh82e7LFGdDr9VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zlk85IbFh1h+5mMfhu59/OM+kwrpZWO2Rz+yUAcn78Ucv/TNVteTxgg25gPYdg2ARvfElvtcLYE/dCdmCmESqxGjrFTmsToBbJHk64eGCw0Rikt4hz4+NHEFWD3sXiYT5YB7GkecGR541yxHxjshdHv6Z3DrL/RbbC0CBgg8hzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nTIwn2MN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLeQoSTR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nTIwn2MN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLeQoSTR"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65R3ewLZ006436
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=a2v9cSxlzqYTsoche+QEUyXPjVQP/dlUcd7
	xJmpAwLg=; b=nTIwn2MNeXouSw5NBjb/GBLYho1Vy2yoHCdNe7XFGLAuNlx2CYw
	sy3cBr6jlSfQwvm0LYHUtz8OxvI3E+bC0gEnu57yY7EgxJqFgClddjQXHuCszx/L
	nW0re2ecKFPP2WkbDPfM4+aSYOlIQI3PKazAaBKxFyC6wshJzZb+fvYadakPuyV6
	fabV2FfKqXN4zN+pOQ64ukBHWFLMnOF3jgUKsURiMMBBA5uMmt+s/F8ji+vLwIv5
	7McnAkIL1QFss0nZQXgfNwCT9JFZQQlXou7ccMT8fv+U40VfyAJU2biWgKGykifx
	vxv5dBzxYXuly+mwRc73Rph9LcGjmg6sLSw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tugd7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:07:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bccca5620so2467916eec.1
        for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782547633; x=1783152433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2v9cSxlzqYTsoche+QEUyXPjVQP/dlUcd7xJmpAwLg=;
        b=XLeQoSTRnXG8BEHCfQ+G+KdchfkyiEYhtyKfzRfCCwsBeNdRyY5I0uwHsgAIBjvwVR
         Y844h8BbH4oxD92RpOflozxulWD03N57pcOYae41NxOqCVaDNkUAMWrcrM/62x0aiMGl
         QOUjBkGjddpoah8YYQYSLtb9GNpadI42VKy3xwQyuFA19kdBM+rqmhmFOZYWJH51mLJQ
         u1Kj+ZiAYvVvBTtult5dfGycpccCqYEugV2KSk+b4hmdSZsv52fALMIVm7Z/qYyBBYCZ
         wb1Jr72qobA/kOa/6gLn9hNptEOinXehMF4LZ2rIIwqC61ShZQnFz1jS+99NV1GbP6po
         3iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782547633; x=1783152433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2v9cSxlzqYTsoche+QEUyXPjVQP/dlUcd7xJmpAwLg=;
        b=oaxEnGK7Ex4WFcRyxOZxOGbCkU4V1BO0bOq1xmfUCmpoL9uToO8oM4m7MY37uQPkGD
         vXy+WBaKBSHLSiapih/RWeszJ2gY6qWhwLPwEZ2b0jYYIMYvhNkGWmR9SZyRyjsGBqsI
         UHI51qFJ+pEMr2PG9bMZ6MIEXmxZGt8Pebcl82jAdumeCZTu8EqmbMolezxVklLHNqXR
         c78f/BmuoYFUsiBi1tmF3XMnEsvnhgiEKFa9MBwV83aTqpBuZ4azcb1YK0dAGhOD6Ko8
         QU0daLJdCOVMPZwx+E7kcnaQnla8wG0FWtNZudYXne4ZYV63mxQ76tnCeIx6I4rv/8oq
         tdOA==
X-Gm-Message-State: AOJu0Yxd37QN81ArXlH1Gt6xfmNNRz5If2z1u3Bj8alaqvghDbj8Jyjz
	i0QVCmEFDUfQzrlASmVySnYMZJkDiKh9zgC/IZT/CPbthPYuaZyRy7RtJmKhRJTSmBYjHsSCj/k
	lwSRyqH8kv9IpbekMsPXhf/9JooebfY1MCjLdfdpI7xMLAwNDaB1Bvhv3W+kq70A=
X-Gm-Gg: AfdE7cnyeBfas62qEiXhGJfshIaHiM4L9v0sKwZw9Bethw0EbvhU++XGll4RvwmOKIj
	UzNDUhGStEZdJTDcM6AE2MpK826My8bYWcTvU5PKxswxuRoWq89ak1sMAQOFgRFMzGNLlpQIShp
	pmPK8rKAPbUpu9k1TYOWZadwdgpcjqmJrzY6xH/82zpeAyQS7IKetzPwbmgB4SAR8oL3KrbT6fZ
	tXGxltOKlkOCtKwjV1WPwYeUUULweVOkBSOE8DmXPLrtvuBkUvaQ8xpUUh9afx3kS+xRgfYZ1zA
	5slHVcqx87hXk9Hd/7S6B04Qitp5C/XbdTpVZIwnk9I/Ryzl1v6M/bRiYZMyc1FuK+UEr/g60PQ
	b2knKLTOLsT30+Knh5ppSgvUQBMv5l5hDh4yY
X-Received: by 2002:a05:7300:578f:b0:30c:7dcb:c8fb with SMTP id 5a478bee46e88-30c84d51fc8mr10062455eec.11.1782547633043;
        Sat, 27 Jun 2026 01:07:13 -0700 (PDT)
X-Received: by 2002:a05:7300:578f:b0:30c:7dcb:c8fb with SMTP id 5a478bee46e88-30c84d51fc8mr10062408eec.11.1782547632263;
        Sat, 27 Jun 2026 01:07:12 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:2040:16b0:8991:15a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30d3af0d2e4sm3915711eec.22.2026.06.27.01.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 01:07:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Paul Guder <paul.guder@example.com>
Subject: [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 13:37:02 +0530
Message-ID: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: e6S13980D41ar2dI4x_5F22PMd7yExNM
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a3f84b1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=A1X0JdhQAAAA:8
 a=EUspDBNiAAAA:8 a=VmgAbFiIFK11awy29BgA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: e6S13980D41ar2dI4x_5F22PMd7yExNM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDA2OCBTYWx0ZWRfX6xoMpMsoUwAS
 kpdEvTNdNK3kTEtDWwST5OEx18kPXb0NpPYncCcpOsPNWjTdYuCGCtU7tRNK+9OCS9fbe4VdNqo
 VPxQo0EZeBNS5ZfxTqC0W/52LJ2qL/NYnXSk7fbus+P9HFDNdYfzm/yy8xnh9jN5ppCd9tgXWrg
 onP9ytysP/71CD6IyEEQ3Z4GqwDIN2Dk+7VPOTWe6cEZob3vFX82K+UF/eeEn2M7TNjy/YvYrpN
 BC4o2/i7Glc/2xyckuVPOajU/G+8SVjV/UTMLHyIIjUgEuGZP6UnZ+bJt2AMw3kpYoWwJKFCz6o
 dLf7TYP66FCn2cBstND5Tq36ph6iOx/79/4QDrJzJu1JgISa87+95/9mwfK0WfKfU3heN8z2MYi
 UfvSLskY0jp68EDaNzvQdDQDG94/S8g2YlzRyD/mgNUYivnTu2oN49Kkwezm0i4soorMYgbMOHx
 pNgeyP6wiE9JJCIIQ6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDA2OCBTYWx0ZWRfX3acshnSEH8sf
 hDY1pDxt+b5/o2+NTns0Hy/BLS2Knp4NZaGds7ta8NB7yW0WTrFQr1GgIm7XVamCMzzJf8qYPfb
 c/8Tscu9QHH/W9LZpcUxGZTrpQgnpLM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270068

This reverts commit f176c47683bf6365e2f6d580d557fae49169a703.

When the Qcom PCIe Root Port advertises itself as hotplug capable, the
PCI core pre-allocates a conservative 2MB non-prefetchable bridge window
with 1MB alignment during the initial bus scan. However, the WLAN device
(17cb:1103) on the ThinkPad X13s requires a 2MB BAR with 2MB alignment,
which cannot be satisfied from within the pre-allocated bridge window.
This causes the device to fail enumeration:

  ath11k_pci 0006:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
  ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags 0x20000000]: can't assign; bogus alignment
  ath11k_pci 0006:01:00.0: failed to assign pci resource: -22
  ath11k_pci 0006:01:00.0: failed to claim device: -22
  ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22

Before this commit, the bridge was not marked hotplug capable, so the PCI
core deferred resource allocation until the device appeared on the bus
during rescan, at which point the BAR was correctly sized and aligned.

On mainline kernel and recent stable kernels, (v7.0+), this regression is
masked by a set of changes in the pwrctrl core that defers PCIe controller
probe until the endpoint driver is ready, ensuring the endpoint is visible
on the bus when bridge resources are first allocated. But those changes
cannot be backported as they are not bug fixes.

So simply revert the offending commit to restore the wireless functionality
on the Qcom platforms.

Reported-by: Paul Guder <paul.guder@example.com>
Closes: https://lore.kernel.org/linux-pci/CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 43555ad9e5dc..789cc0e3c10d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -341,20 +341,15 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
+static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	/*
-	 * Qcom PCIe Root Ports do not support generating command completion
-	 * notifications for the Hot-Plug commands. So set the NCCS field to
-	 * avoid waiting for the completions.
-	 */
 	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
-	val |= PCI_EXP_SLTCAP_NCCS;
+	val &= ~PCI_EXP_SLTCAP_HPC;
 	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
@@ -554,7 +549,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -634,7 +629,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -727,7 +722,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -1033,7 +1028,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
-- 
2.51.0

