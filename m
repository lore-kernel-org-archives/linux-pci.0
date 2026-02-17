Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973033033B
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327165; cv=none; b=JXMBZwKDKGMjc+ywIO5bMYduz/hImQtgVix0A5kKOsBnJYlZB3c+KED9A8Pg0QrdhVvo713Ys4PvNkX+BIV3IK7zAHXThH2xBYjGkceOlFxn4dNOGSFkIqB5xLAaIsIt2YHtAUpb5p1LmlfBW5szdwJkkp7jUWGkU5etEss1WpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327165; c=relaxed/simple;
	bh=TtbJw2QxkiBmLJKp1okcAfp6LW1NcrShntWzlulImc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCMyHk4TXRcygna8+ZiaJtVcYCMVJ0W/hrSrTpXwwiHoDFkwiLyPi1zbmNNxMmCRz3fleXPzLy1X4Rd94Om0py2qPNQRd5TuY53Op8oaLY6XQ9JZvwllzdrCnZGdvJnH/HZQoulk4+zdZO7v8u3cPI8vJJoI9klbx/DtaeUkKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OYHGcIeH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmtPOfH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYHGcIeH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmtPOfH0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBEOa01614526
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	immdT9IL2DaXPDLwrAcUsFxixoY+wZMF3PrZeo1ewh8=; b=OYHGcIeHtSftBEjf
	JAIxbkCxa2n0CVYJXJgTn7akXtjzV4q+UW0WJxImaqudghK8tDhl3NVscWsw28ul
	9V4zi0MCRnvmi5oBje9o5eTTIR/UP7e/8cVHYUMj71WPZzE/R9Rr0/9ny2aNDqoj
	R4UfvrVt3a4z7NUknitxrCDn64ab6HOdOY5RLPlfZHga2BW+vxZv0TGtiJLJL58E
	T4E75T+y7BUYxAsz/E5gqgxx+VBiqMMyM4UnoeYAlU+weKugg19LlFY0sx5gZbc3
	+9M9VIAstoxCZuhKHDOJodR31csLsAvqn/JhweNlvJdd7AlhS2TmYBy0rQSVyFYJ
	yKn4rg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc662t4uq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:19:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8245982e538so1856685b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327162; x=1771931962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=immdT9IL2DaXPDLwrAcUsFxixoY+wZMF3PrZeo1ewh8=;
        b=ZmtPOfH0u91n8YGLxpjIYSB7QeWwLMa6+azdjWNOs7KkmDV3y0ETAGkx6LrLfEKNGv
         Vdq/6pMYlzydGiVDW70GYtJBqi8mWy0KAQoxoPhVwdvxwatpw1BC8PG1Yg9T36bHp4Zf
         eFIV0wT9KIgZRhOkY/RAwbsXiuZQ954I4vQZTKrWOjk7wbZndBkzRS2QgTIg20hDE2NC
         xqrAGhdt8DJwNoDdjl2xTzmF+SGyfKRlIj2PLsRwQUKF5sJDBvc189ddGS8ceqvwiRqI
         yNSUV7R6IIRiPVYcqtYAlBJ9D/TrJVzznv/fRN5p2Xo4hOkLRoyd459HMTLIMCWQVQzN
         rEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327162; x=1771931962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=immdT9IL2DaXPDLwrAcUsFxixoY+wZMF3PrZeo1ewh8=;
        b=qgKKW/N4TC9zBtol4I6fBATiqJToaL4Md2mljf+om2KCL2ACXu/P1SqOa/CQR28koD
         qspQO6DYnzjP5SCZFXGOUznIV/u5fSshJBB1aG0191TPru61znQQCW6HOFfVUWTSKTjn
         mZFAi0vqSvcktd37DF46KVEXAlXGugKayZjXWVlOjws4zTrwNQAdcfc7A57XpvR8pkLv
         RP21YdPNY/TK/eMKy5pRByKdYcMPUjjGeR5oIJNmGtj1kcSPWULEelHPxcUoujcTB7Na
         XGlkR5SN1GtbDH3jWn7FHTGOd5n0j7H/4DrD0ouTIiYi5nhiLhqq5qbBVmSc51neHIhZ
         WP1Q==
X-Gm-Message-State: AOJu0Yw+2jhZj0NqNxS2AySqOJ4WYZGxGttjOA6xLllb7aIjAdFGw1Hm
	r7WXy4wgL09tVkrs8cYXYrCnB/NftJ1mxfJqGWaZkyKTHVGAmRw0A+hLiKEUAmP8oq5AdEEcnZN
	/2C5JlmVOb1oysYz16kzXGs8g4q2B2a3VI1bjNi7gS4z5xxLHhXdZ4fkx4tM0qr8=
X-Gm-Gg: AZuq6aIQ5t8njWIdvR6eoJpNwtv7eOMl668FIjzXYQEyDQ69AORsK8nuXqSsrgZBHPt
	cJcbkTR06mSIvoBv43sx+Jbt9cWpS/03cTHG8MO38zR2De5gt39KyF6s57nlk4HHGlT21rwnFYx
	nHDyGwqzn5IWurIJ7sZhpt+LM1RLZr+jUCpK0KLTmGiP/I1jrLd5stWA854rUsHrpFUNfGcLi+G
	GaT6FZLTP4hW0jB2gWP07l9jF3hzFtRjXJQXVP34IWdVFE9Tvj1kkG25kRjm1eZDwnGeh2DKUf6
	Q+ZocEe3vi9XDMqHRy4LBYcycVmr0qbroOCDuafUg2GkvQa2QIZB8axWpJnLgopFEMpIXkjFmvy
	kHm1Jp8ZgmgY4rjlzOSbySOBq4eJZT6kT5FRhfCWsN+XJQLMgHRbeNclt
X-Received: by 2002:a05:6a00:2444:b0:823:ec5:430c with SMTP id d2e1a72fcca58-824d5eb79a4mr9451781b3a.29.1771327162389;
        Tue, 17 Feb 2026 03:19:22 -0800 (PST)
X-Received: by 2002:a05:6a00:2444:b0:823:ec5:430c with SMTP id d2e1a72fcca58-824d5eb79a4mr9451756b3a.29.1771327161858;
        Tue, 17 Feb 2026 03:19:21 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm13181914b3a.50.2026.02.17.03.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 03:19:21 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 16:49:07 +0530
Subject: [PATCH v2 2/5] PCI: dwc: Use common D3cold eligibility helper in
 suspend path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-d3cold-v2-2-89b322864043@oss.qualcomm.com>
References: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
In-Reply-To: <20260217-d3cold-v2-0-89b322864043@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771327148; l=2041;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=TtbJw2QxkiBmLJKp1okcAfp6LW1NcrShntWzlulImc8=;
 b=YWmGKKIDBl3wYoKkpN/uTl2ahJVwSeE+5nhAt6wtBrGX2sN86iG3g8H4fNwHYNFYCQvszbMOM
 qBFuDArb0YoDjIliFHrt0hfLTqnbaWrwXLZ4WkXsz6TBpW+1rxpcmoZ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfX6MbUc8IxCSg5
 cDPpmJe/RCF5Mq0lBUKgc+4VsVuvPzCSXfJkWVHzm+/G0/fnVTMvA4cVqSKTLXyWoZTfqmSwLyT
 UKjR02Hldhrc5sTWrOmfCOPj4hV1On51WrIyRm4Vux+HeghphlzogeemTDnXIJm8esRbY2mHg1k
 VyrJUr6FWIi4/rZa3y0BZYwHn7INnBW47UDz2nrYeMfs8m+2TS6JbH1semLzjZj0bfRPnFquU3w
 wRfvqWD0xw0gKTXCD/onYQDC2J0+OHvmzkcY2M9pbvCoG9lW8sY4cP02tHf3wyIetCIDq9HyvGT
 9owocQOOIheSTjRfAPFbnSgF0SspW9a32d2kamBS+5yXhUFpbv1ljMm1irAYAHNxdCF4vgGbDLG
 LcGy6ea1rLT6lVhrWz8z/957Q/dL0E+Pi3bnnHa5GtzCkiZZlwUl1g1MTQa+MtqYgz5njjyFs2N
 mrbG+xKm6YE1o0dE5UA==
X-Authority-Analysis: v=2.4 cv=Y6b1cxeN c=1 sm=1 tr=0 ts=69944ebb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=ir7Wv4stjHWE4dv3774A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: l6HLFB39zrIF3CWqBD-kecKY-iLcHvor
X-Proofpoint-ORIG-GUID: l6HLFB39zrIF3CWqBD-kecKY-iLcHvor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094

Previously, the driver skipped putting the link into L2/device state in
D3cold whenever L1 ASPM was enabled, since some devices (e.g. NVMe) expect
low resume latency and may not tolerate deeper power states. However, such
devices typically remain in D0 and are already covered by the new helper's
requirement that all endpoints be in D3hot before the host bridge may
enter D3cold.

So, replace the local L1/L1SS-based check in dw_pcie_suspend_noirq() with
the shared pci_host_common_can_enter_d3cold() helper to decide whether the
DesignWare host bridge can safely transition to D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a9021c99ece17504834650debd86b..713aa64553bfc988717cab2936935bb43aabd72c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -16,9 +16,11 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
 
+#include "../pci-host-common.h"
 #include "../../pci.h"
 #include "pcie-designware.h"
 
@@ -1218,18 +1220,13 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	/*
-	 * If L1SS is supported, then do not put the link into L2 as some
-	 * devices such as NVMe expect low resume latency.
-	 */
-	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+	if (!pci_host_common_can_enter_d3cold(pci->pp.bridge))
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {

-- 
2.34.1

