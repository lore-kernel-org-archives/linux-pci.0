Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01901E9B37
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067935; cv=none; b=BJna9Nuca4KKLPJfQCRmdY+WswUQ9PfMuwln+JZZCIc+Ues+QHuXPK1iW0K3PM9nUJ353vRlh+LvutEyDXMjm8L0FL7gvrJnKgW+xMlITy1Qj1DFoOae0u1oWgP9oMwhSzlmbTEzlwfJpMmNm1jYS/8xP/RUYQJm3UbePT7MCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067935; c=relaxed/simple;
	bh=OnfAu/AW9rFZ1vLKruBd8Y9wj7Qrr1ILxPEU3yiKVY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4Ifr8c9vkAg+pTqJYTXlTcbI5z8MzZeoBKSEZFWQJBgvKBb5dJEA5cWJZG+Ceu1pCKPQeallVnuL6Q3eL97aWRu/SOLnYScuF/8UILbxmr5jxdrIDlbJkf86exeNHuYn8RSGnYUyt4VZySDVQN0UNW8plnGShFyJbaHlpMrnCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuIpSdqj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D4U2opxr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuIpSdqj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D4U2opxr"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7QdBw107243
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 07:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ARswkDbA8yhSD/2cJfqadeY4khX9O1yiyy3zywvZkvE=; b=DuIpSdqjVU2byTXs
	5r0IZFXss3DXWyVz/9fBDkGrXL1paD7SCX55031gumeSIPA4CtxQejve1Yx2s4gR
	k1r//MClzRZqmdBtIT7/DNRG4KyW69nYGgIU00o2O2plRlJUUgqMXtN6IALhbEva
	d8LeC6odoWF9Gk7c99gVMj7r8goWMhKNAxw9eVl/fXwtcmRrXyiNoPTmnkaI61nz
	LlV1MSuTjLgYQ3ONx9uUacd8zIiitu2QSSbHcJRg1c56E/h/JFkCSb8OdYGAIbTE
	as/LOJBKMIC2dSfT+SuJeBTKsD2WpfA7kS9bwn00xYCCn/pE2rOuT4zRSE+95Np7
	htFCCQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6pgshg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 07:45:27 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso1309006eec.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 23:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769067927; x=1769672727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARswkDbA8yhSD/2cJfqadeY4khX9O1yiyy3zywvZkvE=;
        b=D4U2opxrIeuotygx7wh/5RYm4G/aQbdyxCPsSoBbF/lklGTCEHhMJE77X+UkyIRaE4
         5++7Sndu4uisi1GPkqOqWYeLiVoBwuUa5RRp77EzP7SERrpccjiaOo4aUN/Ht6tATRsb
         CeqWVgVEAjX5PJHbFVmM63Tu4oIbS/tymQR4804IlBmzNuFYJrflyVZdiHQGgfZr4CPK
         Cojl6ShUy8Y6Q0I0egOPDy1zzH7HEyQ5L+s+nbnZb/6TOdhzpHU8CfXN4S/Nibt6S+ld
         ppffkbcsa1pEcHGJ8zUmTWHGhm865b55y/DhfeQHLT2VEG+MqG2Mv0Or2IB8OTdsxuXA
         xbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769067927; x=1769672727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARswkDbA8yhSD/2cJfqadeY4khX9O1yiyy3zywvZkvE=;
        b=goicD81F6Aqku9UhZmUsRLCsPSM5Am/NW+I/icEVZWWJrP58tEazOxIB63d8uUHfk6
         Ghia89s7Y5A0ElPcSx5nxZOF2+UMkIugWP6egu65q+Sri1aIS0SiJGB31gix/N0TtKFX
         2d3qfRGbQYQmCKtF1TcIjrofEG1FDnQfmS2Hk4psnzrEzUi8Y+tlmGm/1NHndsuTBAii
         +CM/bUcyHxE8gQ7meOacqdeUFxeH9loteRHOFJB+5MzuVMW9XoSSLlSbYBI3mYMzr0DY
         vBbQuY0UtQp4OC8WK4qr/MUnet5vRCd+1B09Z+1PBv/0Nyq6KbKRA8aFK1llwDb7XSSW
         OLug==
X-Gm-Message-State: AOJu0YzxOZyGfOpgPfBlOfMA7OcMpWU4NJikMp2HhZtuq/AiGSwMZWH4
	jJUGBnXBNid3Gx9OXCMTnxur+CopO0PNNCbtA/rFkYok2BRn+UgswcCGpBBqaf3JpjZpUQeN1BV
	v/LIoV3AZrf9Pj4vjIssazO9zvBdOjy50DMc8bCfTJQeFLYjHQGRrdOIVtx4fBWwiwyIDHvA=
X-Gm-Gg: AZuq6aIbivOyYD2WObqy2iZh95tgDbe01qFsse3PjD/fe2Vqou43Zkv+mXuAHji6urM
	SHGlgLhCBUhO+i90Ug1Lt31jbsaDxbhMxvn9WHBDRfM9p414knVPpUAf5B3gO4NGY2NEtphmKkk
	+rG8EOchKaqytPD5+MoWTUxnr/uIdQyzAfadXA4nBlhLcWMbKM5dRjAx2xKBVpX1NaPTIanQjcg
	fwLvOvIng1A5japboUG0vmQPXTQFKaz+/a2TijGt5eVQeOAXqvTmOo0oSzMk98lF5TbKFDMxO7A
	HNdqlFcYp7Z1Y3z7e/hmhEzVCGpX/i7O9Hq5o6bUOC4mVhgIzzWYNY4b5IxnZGEr55xClUkePpI
	XHfNPCQRLm5mC03vESN66F79SDw864ByPWuvl16jYzpVDCyuDdFh43jxS
X-Received: by 2002:a05:7300:8c14:b0:2a4:3593:c7d9 with SMTP id 5a478bee46e88-2b6b4e8b390mr16756456eec.25.1769067926831;
        Wed, 21 Jan 2026 23:45:26 -0800 (PST)
X-Received: by 2002:a05:7300:8c14:b0:2a4:3593:c7d9 with SMTP id 5a478bee46e88-2b6b4e8b390mr16756440eec.25.1769067926309;
        Wed, 21 Jan 2026 23:45:26 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b36550dfsm24875278eec.25.2026.01.21.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 23:45:25 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 23:45:18 -0800
Subject: [PATCH 1/2] PCI: dwc: Fix grammar and formatting in
 dw_pcie_remove_ext_capability()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-remove_cap_clean_up-v1-1-e78115e5d467@oss.qualcomm.com>
References: <20260121-remove_cap_clean_up-v1-0-e78115e5d467@oss.qualcomm.com>
In-Reply-To: <20260121-remove_cap_clean_up-v1-0-e78115e5d467@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769067924; l=1054;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=OnfAu/AW9rFZ1vLKruBd8Y9wj7Qrr1ILxPEU3yiKVY4=;
 b=0nnXFTMwwb1y/kpr9YhIAJCE29sACTdjKWTFgqjAFquvlCS39T2fxlPSl30koTv/vmjenIIPL
 AYK+cFs+eRpApnkgviugDQJ1dpL84lPlutCWGk2lGQbMyMbPRF2IOeA
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA0OSBTYWx0ZWRfX86MTqfjI2Ky2
 RHR69eM5qJtTfvEir6424Au97S9OBLTnBIBwxrKHkBPGeu38uGY5hANgOAlwQlQUkVPNjqeLeAG
 jIFh/1spqVYjQ4FQHSZ3F6lL96yNHKcWVw3mz0DyWhqw8UChbRjiKiGtzouAV7KF06JezcTUYRd
 BiUjF1sAbs3mvlUU0xbBugj2899mgmbTNqB3BLTpES/lQv9nmFk+I7Zuz0yak5fi8qA1Q7iQkBo
 30wyKg4BnFlSZBQ5T9NLUpeMXgIPP6W/xeQhBHQ5gf2grf6Ey5sc8yINyPma7vFqLS4KLSUT8tM
 iWGlcq7rxr9ZZupaYZRQAgzU6qHwR5DkQuU3L8MzKfBQn5Tzvnrxos3DQE6hgT79e27Iss0mDgA
 rdixQBBq80zD2OdgKCMXD35usPrPS7uxMf54KV8pDeBVU2EiAUZfnWOeR5mddjcKyk7sM5ECUU2
 au/9CO7xboB4xd6tTQQ==
X-Authority-Analysis: v=2.4 cv=OZGVzxTY c=1 sm=1 tr=0 ts=6971d598 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=m7LhmkQuZJo2DZ2u2bkA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: ruZ85cTN_Cn6r172mrYm8paKaJQ8vwNg
X-Proofpoint-GUID: ruZ85cTN_Cn6r172mrYm8paKaJQ8vwNg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220049

Fix a grammatical error in the comment by changing "it's" to "its". Also
add a blank line after the variable declaration for better code
formatting.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 2fa9f6ee149ed76ee84e8129a47f4bde2fa4d513..18331d9e85be30462277532afa71b5850438f32e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -268,9 +268,10 @@ void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap)
 		return;
 
 	header = dw_pcie_readl_dbi(pci, cap_pos);
+
 	/*
 	 * If the first cap at offset PCI_CFG_SPACE_SIZE is removed,
-	 * only set it's capid to zero as it cannot be skipped.
+	 * only set its capid to zero as it cannot be skipped.
 	 */
 	if (cap_pos == PCI_CFG_SPACE_SIZE) {
 		dw_pcie_dbi_ro_wr_en(pci);

-- 
2.34.1

