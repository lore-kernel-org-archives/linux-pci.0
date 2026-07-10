Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335B4189C0
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783689666; cv=none; b=HLD8F8oLYV7ll+UvuaMu5/mt6Oat3S1dyKOYWViw0hf7RcuZ6Nfy/QmbsCiXaXLcn7SUPYrd4N2IB0DKMYTMyIb/3hAD5IafcKnWYxBcyDRnLeunvpQJrgZICWJCrFlK9NOcAZTovkOaK+DO47AZpmQApwxQldyoheMMofbMhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783689666; c=relaxed/simple;
	bh=AmbrJkzC68B4rRpQK84/FFjOkbtbYYveaYqL5MXvDao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rlCHpybU9mStUJlYZ9NNx3I5sYAcVPXLhq2H9yicTu3YMWOhbT8tmphtICmnkxl+49KcctoklTdjvhn0/h+8ELYLgmFrMUot2jnvllWywlhMQ5SpKGLb86MXqHGloLRXyHCyoMlcvCREY+6P6t29+JiRmjC4/kfYQqAPZxxEozQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+Vrvcpi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fXovBui6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+Vrvcpi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fXovBui6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AD6quB919367
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M5bj16MZd7TUPcv+0Gm35I
	17dcBKZEcTVxrkTONYomE=; b=E+VrvcpiNo4O05NoG7Eo1rgY/g2cyCZVAvXOEj
	/eYpP9G5/+AT6xbV713qmRE444Q3DErh85tf9YPArM/J8OMI0EifNQkfotvFWkTU
	skkudu9Lm2YRJu80N1BSuCW1X9ltpITTElxIrN1uM7JN6pRN+4sFklk6sgcZCDgV
	h/wc5I9is+oDhMr8Jcr//1TOvEJiXgT3ocTet4NGJnri0Icmz9z8cHZ4rKVkS/Dp
	3OJ0ZOIzux+eQm+i5KyADw+nuEZDJBnwXodcSB1UKedfsxuLmG/s5uLj5YkSzNRY
	v/Q9/mlDyFRATmEHnx9IMjCrFf0p7tMg1j6oxG9DXVQHR8ig==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n20ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 13:21:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3811ae55313so957547a91.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783689663; x=1784294463; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M5bj16MZd7TUPcv+0Gm35I17dcBKZEcTVxrkTONYomE=;
        b=fXovBui6FCZCSDB1wyofcTZLDcfHJcV295ok7BTxm6FEVnplDk5U5vAroDCZjzaUo3
         M9XwEs/fUyA1mzBJoXyj+tqbzmruHcPcPh8qDXAmFIO0383hRJITnd//UlSq9MYULgq+
         IxSv3az5eRyQmzZJT79HRARLdnrKMS99L8Dot6sDGZrRPjH3IbcCP3y4XEppfxop0GYC
         9wdmnLz4C5X/MSjHsqvIRzuBnhMB4n7vynx+acp5YgsRuW64La28G8xWjUVUqG7vzmJh
         DMqr47UqC/gAkJRhksa0bMluAACD3sax6EC827FIwHc3CNVGqLUepp1lhfgf77M8Wqgn
         i5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783689663; x=1784294463;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M5bj16MZd7TUPcv+0Gm35I17dcBKZEcTVxrkTONYomE=;
        b=YwcRrGTPKdOC7Cpasl1oUXk78gXBxRTKz05oyStcE6WZYTVHZXlX2UFrdZrF25S4B/
         8kbvET4ZEYCGv3Z/bfm+C/gSYecI0CkaXICpT9i2aT2foontKy/eL3hga/dTb5Xz5Yki
         FFEOkzD8FIv0/TAumhuhHBm7PPEMRVG4KSRzxcycWV2PoJwXSzGRml2gx64pgKwoDLCN
         F3QS2/2ZEGTKp7Eg2a6rTG6uHDugAMpjjKsUr6C/7P4K7Fc+wxaDpbTbyIh26z90WNEm
         K/DCF34JHuYIbdWeQzbtEpA4fdRERvkVQ9UR5Rcm7pbt344EKleVq4BBfUIRYVM19Zc0
         U9bw==
X-Gm-Message-State: AOJu0YwnxLQabbjoK46le+gMnii4nYK4U5aBRdfkoI/cMMfCuCDtnEWR
	QRi78XbqAvvPoclIV3A5p/dyiWN/bZE8HDwLGezpJGRkNjK2ZKaHaBWdVvHmXDCX3ftz5CdI9ah
	20Inqymn+pV9L17oWuEwbPZ6dV78XChpVepz6DPXyNYNFmBxAeBgvnWKu+UXq8vHEKKG7M4Wysw
	==
X-Gm-Gg: AfdE7clAQfnoEJCw6XgwDsZ18L6dFnPqk4N1GKg9tkKkTo7kReunMroxjKboGJgf4yt
	sRtFELeu4X2M0VXD4Sg+JTQh3kMf4AVE5hqnPJINve1anZHqFoKG1IdCqB0FW9M/6Exk5BZA/OA
	CpqDcCl3P55Ld0UHPf5rvi6aiw943vYP7mEz5Eq51QYi4vRwWhNSFWKQY1dOg83Y92fr7CNhXaC
	M5ob611CqiG4FnElbA10ow8esSclaJpI6bFfuOJs0DSlGZRrMrnXpNhgjKOM0ax1nO8RDR6V9Kl
	VJ7kXtgl2OVpnzpVJyDNkxIKYdn1I6Eorsea4SutwTXqGhWXyyxK2p1bFaL3HsqxU+vcNRCZWiV
	ZCKm4yEotT1k3rE702WY93RTiB1Zhcwf9uYt8KBMbnSIMZ9POsOcuyVvzNw==
X-Received: by 2002:a17:90a:c2cb:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-389420ac578mr12741984a91.34.1783689662993;
        Fri, 10 Jul 2026 06:21:02 -0700 (PDT)
X-Received: by 2002:a17:90a:c2cb:b0:387:e0db:bc2c with SMTP id 98e67ed59e1d1-389420ac578mr12741936a91.34.1783689662405;
        Fri, 10 Jul 2026 06:21:02 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311838c9235sm36496290eec.21.2026.07.10.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 06:21:02 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 06:20:57 -0700
Subject: [PATCH] PCI: qcom: Clear Attention Button Present in Slot
 Capabilities
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-clear_abp_0710-v1-1-efd63ebdaa09@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALjxUGoC/yXMTQqAIBBA4avErAtUor+rRIjaWBNRoRVBePesl
 t/ivRs8OkIPTXKDw5M8rUsETxMwo1oGzKiPBsFEwUrOMjOjclLpTX4UtuJYC133KocYbQ4tXd+
 w7X77Q09o9vcCITyncNhGcgAAAA==
X-Change-ID: 20260710-clear_abp_0710-2f81e92b9da4
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783689661; l=2992;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=AmbrJkzC68B4rRpQK84/FFjOkbtbYYveaYqL5MXvDao=;
 b=E4pzDzd8NMsd8khB8GflJNpFbnVr4eGdKgjnZj7qBSStgpXXw4uWnq0wcOThRntFfr5TYBW8Q
 aFeYwv8n9s5BDLRRnyiCMjhFPdT1Qm7cnEUTAm/vo47djVgZgZePNCW
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfX2KSuaTPgdVlO
 FBn9WC8Ip1l7ngEj40MgOYQ+VIA6YlvL+gny/vCSygEkJp/yOq82tyCN7Re9fqDlVMUeFn9U4i2
 g1Z/7HVf+cBGAaE29ZzWuhxZ5gcwpb4=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50f1c0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=864Vm389qZSSETCWT5kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: SBDbsASTc7kUTcPyoOgnRjKS0w3Xsv5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzMSBTYWx0ZWRfX30pacqrbw218
 MPz4rl6eB3NLM2Uo3zCpx/aBX5XDsLrXkiuQyZ7G+eayUnrLbyv1Da0KI/SS25+rt2n+bTZWJM0
 VGuJM7YEniescgKWT2i9lqbUis3vmIVOmj/KqIu0vEDrY7QQtxoxXb/eYfMAoqtm+64AalZAcIR
 ZiJdXcUQKo7Laf/J5KCRjOfXk3GDRRV4SkTxi0QRfCIh2q4qa6A8FdZMXCqskqACdxxKbb1C3TJ
 NrTWAq2OcC5OafDhBKTr5vhP6ZyDGgoJWCcj5gEEfiMw5RxxV7YOjsWQB1T1PUN96nsc/+zcddS
 nY3PO4Qtaezn37b6fx6XvXWgwViIUNLcOcXJwFbWU7ggoR5/Ku8Upk1/gy2x1eKBPYDGtevDb+l
 UDHeqLZLxgW/ZqXxPT1INoA93tSBMLqcu82DfJQRCnlTlqUval0hLEVlzIG3eXYijHkS8J1aice
 XPTJngbtJB/vLgEMJZw==
X-Proofpoint-GUID: SBDbsASTc7kUTcPyoOgnRjKS0w3Xsv5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100131

Qcom PCIe Root Ports advertise the Attention Button Present (ABP) bit in
the Slot Capabilities register, but the slots have no attention button.

When ABP is set, pcie_enable_notification() in the pciehp driver enables
the Attention Button Pressed interrupt (ABPE) and leaves the Presence
Detect Changed interrupt (PDCE) disabled. As a result, presence detect
changes are never reported and surprise hot-plug detection that relies on
Presence Detect Changed events does not work.

While at it, rename qcom_pcie_set_slot_nccs() to qcom_pcie_set_slot_cap()
since it now programs more than just the NCCS field.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index b193c989b2b8..89c2d4cb1fbe 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -358,7 +358,7 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
+static void qcom_pcie_set_slot_cap(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
@@ -372,6 +372,11 @@ static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
 	 */
 	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
 	val |= PCI_EXP_SLTCAP_NCCS;
+	/*
+	 * Qcom PCIe Root Ports do not support Attention Button, so clear
+	 * Attention Button Present in Slot Capabilities.
+	 */
+	val &= ~PCI_EXP_SLTCAP_ABP;
 	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
@@ -580,7 +585,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }
@@ -660,7 +665,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }
@@ -759,7 +764,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }
@@ -1078,7 +1083,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_set_slot_cap(pcie->pci);
 
 	return 0;
 }

---
base-commit: 3edb3a038d423480efeb204dbc6ddc9a292f8ecb
change-id: 20260710-clear_abp_0710-2f81e92b9da4

Best regards,
--  
Qiang Yu <qiang.yu@oss.qualcomm.com>

