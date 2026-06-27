Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A51A9FBD
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547770; cv=none; b=UeoDCl+kIbciADcMgS+pUNe0kYWTkY0QEFRkKMa8ycRsZLLw51gyu8dD3B6ls0G4l7okuTz33SSd6Pi5W+MRcMOWN///5YiwRzFwG9MzYCBkoBRIf1cx3GHdKV6rRtjUP2lYU2L/84jkGfVsT7O10x7feHQjz2bZXxHw1Vq2Mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547770; c=relaxed/simple;
	bh=CfSp85vKwkP1utXWf1DSzwLq6pA3LJBg5WBuHJ4DkyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DF2gygOMgHXLif1HsEF753xPQJHTHGM+IQfn5LoWyk1ZEoQ2+CYFvdBIbS0QQSUnKSSlOTH9zUhVFTQN77X26nM4I3qfcvqScII0REHzL1/P1cgGO1AaEsUVMELWRdEN1wjtzZRzzSZiimZjtIAKp9m6+E4HNxjPzFr/eRrb3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3x+tIhM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKti6X+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3x+tIhM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKti6X+C"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65R4Ba0C067531
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lWShSus/rxjlfchmr2qLHcfvwE9/YJLCAZa
	fAL+0YHo=; b=J3x+tIhMSzF7DO1AMchlvEW2FHYXtVC/d1ewz+JkqDk5sCIQCJs
	HjP0oFSVfCOhNhbtsXaaWSm927+gAzHyzITNG3dVE1QmB077xkf8XtML8tmlwDsX
	DkdJi6lR8JYmF/5oP4USBA0pByli7ZTQPhbPMOJYC9G6a9S1jgSTRLH7x3LNJBoF
	HhZ+CTni8Bb6WrBult6CnnVerQutmfC5POK9H7nKNFIMqBIqrt7m4GJIOsIGDl+y
	yIML0rDrTcFlXVDseyRDLxd5RS2CR6gNBS3ih05QpJmxIfz4aw9LoZTvLzhC4KMm
	Eagj+7V99dbk7lCgMZmstp6qYk+EdaYykBg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cgbvy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 08:09:27 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139c98d7bf4so1308135c88.1
        for <linux-pci@vger.kernel.org>; Sat, 27 Jun 2026 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782547767; x=1783152567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lWShSus/rxjlfchmr2qLHcfvwE9/YJLCAZafAL+0YHo=;
        b=AKti6X+CktZ1Na2CTGRc1h8OkN2zC9FLpER1EbQMTK4GfL3GfoV7o8c3kC5Ru1LKHf
         YCnVuWARyjFRpSwEP248BxTtb0wnXtbcPgL4Z//AyPqQ2fZzKDKkRQYH1QjFFQ4Yua/g
         gcdLRKpCsujgKQ6HOpOo2VhC0W5EzuhAt3E4sPUgfvWj7tnHTCD1zfdZdUOysrBMBVrX
         xi3vUDlB+oRGI7dqlHKPU/OqMpxj1E2ETX7aUAm7Ogylq0Hu19egcMsLHghAVw6+72BT
         KhbZ0fFW7/h7liKFo4uypBiKna3WiPZ4EMQNhLvaHIzghfEXPPzjaFITP11x+oTgHyQx
         pnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782547767; x=1783152567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWShSus/rxjlfchmr2qLHcfvwE9/YJLCAZafAL+0YHo=;
        b=D1bJNQhpzPDTuSnajJ1YQ7URbwUpPTa33CmwcDVY8+/jUoAgMa+1w9gZ4Pp4U3bD0c
         30Smtg7b4b7Vl6JtkgabI4Q9dZy/GO9420GRYd2p0U8mNi5UeNebLMw9pQKezT1G5RK6
         j0lAzb4Z5eQzj0uj6hhVLheKEP3iCRe33SQictgKMZqeLPg1+j9fPrZplDKx2KX1dV+1
         WHE2YfoJbWqxFhiABfvSlCnGaUvqsgsc5/x4QNNgrZHJCfIWV+u255+vp9RlaHaPjrla
         mUCwXFLtWKL+c5r+xvQmLlp7XqS7yG4BuGkG057kfjFk6VBizYEoxDBUoi5k/VZnLns/
         kPfA==
X-Gm-Message-State: AOJu0YzyxeNNUzuPikxB9beSXngcuqzIQ/+1aG20ZUkHTg0Wnjr5AqMp
	iQaSnTuUCOlVx4P2CW1m6OgEKVvREQmZsHKDYe+NiRbHSHuNkeNtDE7HISPBnTTIkIiOg7QAhvk
	b9pwXBesS6OJGN259jZsvgPiMWgyZzwAPg+q+1Pq6OJe29fEo1yBaGrFgg15sypM=
X-Gm-Gg: AfdE7cnBEu+f+2ECCwSod5+R/DRQtXB294kci0LOtA6ZqBlaFkT6/5X0qP8MedMA8aF
	NzoaoobFXj+9Ls8RmhLlhpp6rRgVJov9yQi9gTTc1sVNXBJsaimqmGCrzdrRuUdqHGa0xwV1cFh
	4IMmNSha6euyy5EoQJq3v5whHEl1212EdSFbh1vvGH0JR6BRY3hf//k5WQxrhl8noLLRbkAY6Dw
	ouo0mabYSOpshRhIW7bph38dIDsIxn9ErFpzTwY/lSR4A/9qrQb833Zg3xgIQN481cBXEjloJyu
	d1THMmdIERChyq10ePdT0kscyxELibt0VmcjINF0KYtiIBWq4uQyCzxlZ6vuDfTqMNM4e9kEMlS
	Z9rJg8lVp2GTSloWSsncuOylTn19PYHdSTJ8q
X-Received: by 2002:a05:7022:45a6:b0:139:c712:3303 with SMTP id a92af1059eb24-139db890b4fmr6882036c88.0.1782547767161;
        Sat, 27 Jun 2026 01:09:27 -0700 (PDT)
X-Received: by 2002:a05:7022:45a6:b0:139:c712:3303 with SMTP id a92af1059eb24-139db890b4fmr6882024c88.0.1782547766589;
        Sat, 27 Jun 2026 01:09:26 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:2040:16b0:8991:15a9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139e78317f3sm11047564c88.9.2026.06.27.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 01:09:26 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Paul Guder <paul.guder@example.com>
Subject: [PATCH 6.12.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 13:39:13 +0530
Message-ID: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a3f8538 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=A1X0JdhQAAAA:8
 a=EUspDBNiAAAA:8 a=VmgAbFiIFK11awy29BgA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDA2OSBTYWx0ZWRfX1GC02B18veLt
 9dFzR0827SgWBwcSRhv8TjybQQCayMrv6s7vven98mbFD/VOk2W0mxhGTahD7/0F5rv33shnQ+z
 pMnb62e0nNp56kByu7X+3JV+3yPyxAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDA2OSBTYWx0ZWRfX8hdmXIyF4FIf
 X20X/+brdqdttPjH7w4+bBcjvGfTXBl3MU0dZznLLiWcOOhvLtTpEInJrnGwmCov+tFro7u2R5q
 D+izGtkBhWS64LxeNamzR7L95+i49OpDzYL0zr1Bs6/ZeWYeQ5ppPrQw/sz8GAZJB0kmx6VcUe4
 ljNvaK2GTFoRZYRrRpz6k2CRGRZQZL2rJnJDAFkw5K72byRRTmq0tvHzQLoWX1Kc3dGP2px3j01
 DFCoKTbnBo6P0ZNPhvqUU6uSeH/VeYMjyD5zEvQNyaETobRidn6Jif0cHvK3Ug6oF6XPmfOy4Y9
 GCIhK07tN8X/0DaWe+2BWGBvo+1+4GzA4Xsh5jOxMnvQZckGKA95B5RrXCPM8UPeidDA8WzNpiP
 WEIcBcNGHWrXUj0QP4a0UPFArdkmQubJSE652RHaiWpGHeXs7QZclVM9EwTFynUM+fpPRHlq7SE
 jS2YZ1zuFUNCdPKzWxg==
X-Proofpoint-GUID: 0ViJu3VAXLDgzcRE4RKqYDCRxclnqW3i
X-Proofpoint-ORIG-GUID: 0ViJu3VAXLDgzcRE4RKqYDCRxclnqW3i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270069

This reverts commit 480c94d3affbc11b9e98ca223a9fa19d90b84fbb.

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
index ae0f36e270ba..5d27cd149f51 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -329,20 +329,15 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
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
@@ -537,7 +532,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -617,7 +612,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -710,7 +705,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -1014,7 +1009,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
-- 
2.51.0

