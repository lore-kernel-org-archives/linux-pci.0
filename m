Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0462D77F7
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785160974; cv=none; b=fbTFhKcmJxlfFxxCbyVTYCB1JkIPk8laNJmYTDI1npMK3G7hJabxPQep9d+3RuEOleJ4s3vf5borpiyK5rqlTp5dXU2O1Z6jntVPXRLvSc6O+kPpa12h12huvnsFIm0szu0DtCGjfqVbWpyN+lbZhhzU/Aepnff6DI0nSe0VLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785160974; c=relaxed/simple;
	bh=XOwW1ipJIhdcuCmys4NqO9pynADTbVV2P2Rortc3W5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVLn1P8tKEoz5uQquNffeIIR4QuM+GjIQoS/e8ivDGgjRF48MAftQkdv6jVaqbIfgBmbg18jrFotsKDWFkbSAYLvGewilI+cjkVZr6kj7WC7jN7sibu35f5qhU6i9lvdjx+s1TL4yloNDdkNvafOgEfU+t7L0hEkSirH2SQecf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHXUn/jh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFZqY67B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHXUn/jh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TFZqY67B"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDljaI3905592
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OnwIylXh9K92d0QPu2pfB366NJ6Wm2Fru1Ia7Majz00=; b=cHXUn/jh9u2dk/cX
	Mmp0Bwfqfqo2FKdPZFqbsqJgM/Kj7rJfZYItLmK0v2aAl7bhB9AatZ/huPBwjM9Y
	BIOVxVgz6Qpaw/EikS/2VrKNeuvltFoR2eoDads9/61Bv2US5X9SFX36TkxY1T5j
	EhNlEMRc3fxi03IrAi29ZZJfNkW4ZgMlYfY9R8T8GZ59OqFGfAuQ0S4/ZcKiMkgU
	4gsEfTrOmr/cOfRGZaA2uF9JVCmsLj+xrrYTCo6A4+Ku9IBzehd1EowmKAt9v9+w
	VNXSKNFEqqT/j0wSlm1nUpcBfn12LeFboLnZlDBbUHy0wR3hPT9vkgONc0HY97iN
	uyUOAQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4ukryg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:02:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb6ef846b33so2093580a12.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785160970; x=1785765770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnwIylXh9K92d0QPu2pfB366NJ6Wm2Fru1Ia7Majz00=;
        b=TFZqY67BTAEqPJrUFIe5/QBlX0rsqOK//H9sfHrY9xes38DB+QPiUPH/dLylYeeDc1
         X3QSr7VZCNSo5mlNK2mHhChP/qwdVEhNE3lfYqvNAGZ17B50JGcKBa/A3tYvGZE9YnwK
         FLDroZQqmst+qpnxGJ7Tq2BLZ3fgenWXGN2ogjxQfqlnbAE2oll/+3OBZYNmuuXT4OVY
         lUDwGWjulXV8DJQ2ZWGGO3zbKXHfFSWcabeTvXfGUcWJ3v6loGTyrCN1MpR3zrsVfKer
         g1dD30RDH4kw2xbKst9leAN+E8PasrpHH1w+0FUCIa0QqKzHYF4nNp9ADN239TaFWwqy
         nJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785160970; x=1785765770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OnwIylXh9K92d0QPu2pfB366NJ6Wm2Fru1Ia7Majz00=;
        b=keJfDY32Bhp9FaK4MLfy21zViigwCAOves8YWO0A8UBiwl5hSeaJGFpogUBd+am5Oj
         sHZjQPnPN1MsW1fv5jKpNwN5weB18vdvYWCdEi5RfxbdhVYPWZ2huILZ2EiibF1Dd1Dp
         T+fdjyt+8EMf2cMcKNkM5jzPS9OD0Ze6wF0O3fXaXzu+MgzvSxJhRL4z/ANoxL+evBh7
         GQ8+DIbwcorAVhp5Jl4JQdx1SgiH3kajFY1KOZ/6GIDz5BTxTMbT5O8SAgJ3mJhYrpg1
         QCvp5VjE9o+cdNrVbJngeyeqthoHgRfTBCZpTNjyPAF3JsurJZN/zHmO+zQOIwgB/WRn
         Di5w==
X-Gm-Message-State: AOJu0YxljbspsdbxnBrICh/Uwn/vpfVFdTc0BuW+ffOoaBV2h9+v/uGy
	OtRYL1M4TvALJ9C+CztXFHR92fyKBTVvpJbJieqrRS3GhkzMpel9c2YOr2wSMfzZJFIqNqxwkOD
	uLpSNJJjabbBCKR6nIGQmGlZWe6x34Yb/NRX84KeSScjAsw4iNCccZELLCnyqTBc=
X-Gm-Gg: AR+sD11te0uRiSNnlxxAGWUwocuM89+Oqvbap7uTzAn9+an81muBUU4uqOQSbfR2ZsX
	azDktPqP+0S/8CZb+74JNz94utbkzv99MU82IvxcZd7EjRKieJET2M1kSHwCTqia1IQ3hKztqLx
	JYcvFtC6r6vwBOib+IL4Q7EBIQGuGfJXR33sqqIgpiabafGDSeZRtiTJ+WIWCAqpBtce1ru2x7T
	WDENZ3lDt9g/d2OSlyUEonqxdI5aFwR8fNSQc4NH4CcxaSJbIjVlSEmDT39Uaf+exPhZYh5BJCX
	ariY4Bg8+0kBrvbNc0sqqh1vrz9qAVk0BSD+l6WT40GAYrl3Pg+H2WJ0j+P/qblTLrnvtuoioYU
	RKP4U70i5ch0ltk1XXD7TxbKSEzV+YeLMAxg=
X-Received: by 2002:a05:6a21:3998:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3c6723703f9mr10999097637.4.1785160970019;
        Mon, 27 Jul 2026 07:02:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:3998:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3c6723703f9mr10999047637.4.1785160969464;
        Mon, 27 Jul 2026 07:02:49 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e6054598asm13789423c88.1.2026.07.27.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 07:02:49 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 19:32:37 +0530
Subject: [PATCH v6 2/3] PCI/ASPM: Disable/restore ASPM on every function
 for multi-function devices
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-aspm-v6-2-2ebb3ee7ef71@oss.qualcomm.com>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
In-Reply-To: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785160961; l=3248;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XOwW1ipJIhdcuCmys4NqO9pynADTbVV2P2Rortc3W5c=;
 b=NtCMBXTY//l3SbOp4fcoTRz5L/FehMH890GSrbHaSSm5lAAOw7EQDckvJaqpT0vmgrdQ+X/4D
 /lAhH4yAw27CSAPGHwoPMISs5RLTpFyuFJr/mbT88Xd6maqmaVkBPRu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 3d4FBzrxeF8HYLTkE9lgc3te1Pq9_8wd
X-Proofpoint-ORIG-GUID: 3d4FBzrxeF8HYLTkE9lgc3te1Pq9_8wd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfXyWCTBqaaBxvJ
 6A4VpH9lDqQFwzbL7wbiyp4S+U/uhoA7EaBuCxmYaqDsq6F9Lnfy+gk27smGQU8OsMbaQSaYF4v
 pBUx6KGjKvjc7p+XOxJIrJRLklwWoGk=
X-Authority-Analysis: v=2.4 cv=PeHPQChd c=1 sm=1 tr=0 ts=6a67650b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YW67kns_3zal6jnzbK8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNCBTYWx0ZWRfX/S+kbP3L9H/s
 ey1YDKthAW/POyn8SU4UmcMLIB4pbVBDZoypPyUDok3D/gzOrTXtcpe1UIYnvDEAU5KbYh85X8L
 YRz497Hb2tM5AMavvddWJsFM8jYop+cGqgtaiWBrsEcWfRDemdk88jcX0XsfOyAb2jKgBvTMXW0
 Zf7eEcazZ8rwmSe2mWEnzWXKWmyra/bJu3hvG8d0rNuptCqOYDG7El7o+d/pEfBjydyk0XLeigu
 xYZ3Ptv4ROpYS2iassxJnTFnx2/hj/Bg1foAcPvkq1BV0S3Fe9WXC6ErQ5A4zJppPTaKInDfAlR
 +p2ZE/5An0u3SGMiV70IjEIIroEQxnJknbxocmSKrObVZxAiE8G0kt+IKXlz2yD+/KOrpwmIrX1
 aIefOBJWlb54YouXTZ2NXiLedWAfO87okhF+Pausim1YHlc4k8Xm6K1mdY2csEK7YDsd1BCZ9Qf
 eJcAN8vNGwQiQ4yMp8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270134

pcie_aspm_cap_init() disables ASPM L0s/L1 before touching L1SS config,
then restores the pre-existing state afterward. Both steps only ever
touched link->downstream, i.e. function 0 of the downstream component,
leaving sibling functions (>0) on a multi-function device untouched.

This means the "disable" step does not actually disable ASPM link-wide
on a multi-function device: a sibling function can still have L1
enabled even after this step runs. PCIe r6.2 sec 7.5.3.7 recommends
programming the same ASPM Control value for all functions of a
multi-function device, and pcie_config_aspm_link() already loops over
every function on the bus for exactly this reason.

Loop over every function on linkbus->devices for both the disable and
restore steps, keeping the existing PCIe r6.2 sec 7.5.3.7 ordering
(disable downstream functions before upstream, restore upstream before
downstream functions). The masked pcie_capability_clear_and_set_word()
accessor from the previous commit makes this safe: it only ever
touches the ASPM Control bits, so function-specific bits elsewhere in
LNKCTL (e.g. Read Completion Boundary, CLKREQ Enable) on sibling
functions are left untouched.

Fixes: 7447990137bf ("PCI/ASPM: Disable L1 before disabling L1 PM Substates")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/aspm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 3f9c0f9a1cc7..544f35bb2555 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -861,6 +861,7 @@ static void pcie_aspm_override_default_link_state(struct pcie_link_state *link)
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *fn;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
 
@@ -894,8 +895,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	/* Disable L0s/L1 before updating L1SS config */
 	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
 	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC, 0);
+		list_for_each_entry(fn, &linkbus->devices, bus_list)
+			pcie_capability_clear_and_set_word(fn, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_ASPMC, 0);
 		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_ASPMC, 0);
 	}
@@ -930,9 +932,10 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
 						   PCI_EXP_LNKCTL_ASPMC,
 						   parent_lnkctl & PCI_EXP_LNKCTL_ASPMC);
-		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
-						   PCI_EXP_LNKCTL_ASPMC,
-						   child_lnkctl & PCI_EXP_LNKCTL_ASPMC);
+		list_for_each_entry(fn, &linkbus->devices, bus_list)
+			pcie_capability_clear_and_set_word(fn, PCI_EXP_LNKCTL,
+							   PCI_EXP_LNKCTL_ASPMC,
+							   child_lnkctl & PCI_EXP_LNKCTL_ASPMC);
 	}
 
 	/* Save default state */

-- 
2.34.1

