Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001D2D876A
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444976; cv=none; b=XXsNMgsoOORClXIL9M4T01Qe4tnRBmEaEcvvfWP3IbPYKW+30l2bXxl/ltWlm2iwuLncXYLOYa4ufnL618GNnHcF987W8WLho8T+0tWZDkPLWSzI3lMdw2aEourcRfpJJBGxeqJeTt88ulSF10BreroLHX9gZUdsjj2sJ6f2904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444976; c=relaxed/simple;
	bh=5PQqOmdR5OOC75CCpY/aytMD49zycczPJnqwX7jwyag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XYCTPHNnd391YEt7DoAlh28veZJCzprn1euBbUwAvYgwIWozxNbiUOLN+7puimygqVZDTb9FG04tQ7Tn0uJaw1vq8AG95pGKaoVw0WS5R4235jb1aidd/vPAPQAmO9+wo51l1kLecgNkt71NtbvuGMcZDQptOqcKa1dpdxZYKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOIJzAjH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Uyz2fRGj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZOIJzAjH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uyz2fRGj"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T1Y2Jk3705173
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uc8OuLvzX9XXCrHmGKnrAwRgIvxvQIURsHPQUJfLOwM=; b=ZOIJzAjHV124E0r8
	vvAd0/8TOxAb3YmeRSYjmBBYHwmr1tdXxZ+6rSHSwilKkIEoZtCYY1ogZsZ3+Q+g
	rak7iJtYKV+/1AIigcUTM/mKoZ4Li8O0hHA1n6978Uz/FAFBm7I8EBvmIYSf9i5K
	s3YfaAUupwv/NSIT76p+I8o0yZKugbp3YmssvFXrntMXi3k0EIg0MCjXRWQD+UEm
	wkKcLgzalGOT9wYjBOtgJPyZ7mQdNFZ60HLkUU3GgNRdvbkJiXO8F9FBoBh/kK8D
	mgoSGkJosl1ybkhlClK20VhOr1r64GNyLEWisjKAi21ykoKRmA8RhRqX4aefH7hF
	/bzGMg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxhc1ka-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da8eb0553so580990a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777444973; x=1778049773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc8OuLvzX9XXCrHmGKnrAwRgIvxvQIURsHPQUJfLOwM=;
        b=Uyz2fRGjXhjvhImqE7mEOcugjr2v+a5XwY0+tSoR9vwJLKCO6wPEPtiox7CpHyyqey
         iAALG2HkRZW/p1s9DL1RzcvtklcUyiBTS6QhbAYPfFVh5Rj6cj6PO4lmUwlAl1yNI06j
         D6YbtCtWC4xNsg0CkkPxpf9EsWVAguuEbltz40+T780vUd9AKaNHzivSMUdkNYZQBWB/
         gUEdx1Bh7ydv0HMit3meOhIFM2SSbl725PjsHK9dbl3lVLI+aIfaixDabJyFUIbha8AS
         psMgwGpDY15du3/wKPK6ypEM9I5Zpm9PUo0kECBLlx2Jk3jizkkLpk743DLWU6K2/WGJ
         rBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444973; x=1778049773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uc8OuLvzX9XXCrHmGKnrAwRgIvxvQIURsHPQUJfLOwM=;
        b=CPT99HJsIgMWdOnovBFmARcgFoaVtrLopRfMxbdFVs3IU63Y5TpZ4iw9pIiKN5c0lh
         Hll2ljfekMw/kIWAbJLHR33SdY5BfuDn5YUOzF/JpDaB6hB5huytkVF6DglMjvKXWb5+
         gukpRDTzHj9EgaITczbp98WdsEXMyqkEzwnu3Q+pDX5uCq6LWX+cGlwLWQn6xTb7m2kh
         L2XJuWrku8GRkfQJ1xw02ixQs9tmqlFq2lqKgZ/Pg0+xwrhEs4g0clg4xZkAcYDfwAbH
         htpEP87tRiCUl629bHZuv9bdqY/vooeyebKYoVU3tFYSpHlY1t3+HZYRKHfEXnCEpfV5
         OL4Q==
X-Gm-Message-State: AOJu0YxTG0ypGw4IWX25W1NXhFVAorjx8EQKg7qc9DcidgvMcXh33Lbz
	pQTcFm2o9e7MT1As4ympZ2SrHiRfnVZ0K5MMJw9yzAjiShLna7RhxC6KAaxpBfMuoZdlJO28WVk
	zrscI9pRoi57VbofX1GazhN3IQNWZyNxleQM5hh2ufl+Kb9RJbOiv9VJmgfVxVTk=
X-Gm-Gg: AeBDieuLu15tSQM7KRb4Ty6LSrU/chG383ErNstVJ+tGVNGwRQW+ckd2C2Si15PGpie
	CNESBIMCHzW2d1xDrpPP9uvoKrVrVr01E6/SgZw19rKESn3Z2ztRw046EKR97QMD+jUrNM4J0Wd
	oYTB5mpMV0kLh5Cy7qXHjhe+LRbdFcTVsqFkjKbBUa4E2jL/gYdbOU8xSKaEg/394Ir2i4trOva
	dhHnQKWEMmAbO4cWjJMbDO+R7F0eQCrEou6lv1nR38fDTbYKhvKDh/IvJz29f17wmn4WZ7EGfcP
	rJMyZTQ8SDnDoAqnaonhrfMgDF9vpqkvqSfvjEMQO+PMr2npZM8GH8VmCM1XNK0WSsxesDZHbGS
	QWAGXz8u8I8zjOQaRlCF+v0PaMmEsIJ7frkXRzvAZY75XHeuTFDphEr+KL3V/XChCdfI=
X-Received: by 2002:a17:90b:2d0e:b0:35c:10e8:1a72 with SMTP id 98e67ed59e1d1-364a1e91ad1mr2070797a91.7.1777444973107;
        Tue, 28 Apr 2026 23:42:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0e:b0:35c:10e8:1a72 with SMTP id 98e67ed59e1d1-364a1e91ad1mr2070761a91.7.1777444972599;
        Tue, 28 Apr 2026 23:42:52 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303d59sm2021414a91.15.2026.04.28.23.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:42:52 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:12:26 +0530
Subject: [PATCH v5 4/5] PCI: dwc: Use common D3cold eligibility helper in
 suspend path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-d3cold-v5-4-89e9735b9df6@oss.qualcomm.com>
References: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
In-Reply-To: <20260429-d3cold-v5-0-89e9735b9df6@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777444949; l=3749;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5PQqOmdR5OOC75CCpY/aytMD49zycczPJnqwX7jwyag=;
 b=w+R58IbthfJ5zUxuVUnEnIOCN/KuwhYjhFN9dhYCENxXhUC/7WxDiftz3Zj1nuozc4k/w19wj
 NaeGrMJzDtkC/fvBKOymfM2HEcyFt57ItD5WSujJebuWSV9kTuvBwYA
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfX1Ylg2jPfFSD0
 c0dodqN8QlrQdGnoBvy05aou/fIcA/v2i4McicPYIY/nGb/0Y8cirhXRbmRN8BLSEEX9yOly96S
 CmFGM4BJY8BUktQW4AYitXNbgeD8pTiXi5KH0ebDnkw73ObyIF52aBv6J4HRM1oNMn384drnQk6
 hHAests8c0Ma0nF+9/USHBHS6xjrMPrvFnv01KkcMMUnfeF8utibVhC7o035ThQLRULACTKTgPQ
 5KvRMG0kqE2wEgkl3EcOxgxdCDvs9R3I9MizFQ8Q7hDla2K8KS0H97aInzRDkyk7UMwnMlM0aNV
 8vwBxB6mTv72GZFEUidB1md+c59q8UlYR0OCZn2jRqXY/irZaRvNpUimdpk2QInq6M1shZDpwWm
 gXAMvuICshTB6Ol8RWhYzBWo83wtt7jJkY+Kg8gQz7OTQjVg0jsJ/tZfnPz8O6Gc3EKV56WlyoC
 /ugYW3NksZfw10CxzlA==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f1a86e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=h5qRVDGUHOPEFS6InpEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: gUsLK1OMtgILVaDqhvGSlU0z5OL3meDz
X-Proofpoint-GUID: gUsLK1OMtgILVaDqhvGSlU0z5OL3meDz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290064

Previously, the driver skipped putting the link into L2/device state in
D3cold whenever L1 ASPM was enabled, since some devices (e.g. NVMe) expect
low resume latency and may not tolerate deeper power states. However, such
devices typically remain in D0 and are already covered by the new helper's
requirement that all endpoints be in D3hot before the devices under host
bridge may enter D3cold.

So, replace the local L1/L1SS-based check in dw_pcie_suspend_noirq() with
the shared pci_host_common_d3cold_possible() helper to decide whether the
devices under host bridge can safely transition to D3cold.

In addition, propagate PME-from-D3cold capability information from the
helper and record it in skip_pwrctrl_off. Some devices (e.g. M.2 cards
without auxiliary power) may lose PME detection when main power is
removed, even if they advertise PME-from-D3cold support. This allows
controller power-off to be skipped when required to preserve wakeup
functionality.

Update the suspended flag in dw_pcie_resume_noirq() only after the PCIe
link resumes successfully, to avoid marking the controller active when
link resume fails.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++--------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index c9517a348836..9e409a1909e6 100644
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
 
@@ -1218,18 +1220,14 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	bool pme_capable = false;
 	int ret = 0;
 	u32 val;
 
 	if (!dw_pcie_link_up(pci))
 		goto stop_link;
 
-	/*
-	 * If L1SS is supported, then do not put the link into L2 as some
-	 * devices such as NVMe expect low resume latency.
-	 */
-	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
@@ -1273,6 +1271,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	udelay(1);
 
 stop_link:
+	pci->pp.skip_pwrctrl_off = pme_capable;
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
@@ -1290,8 +1289,6 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (!pci->suspended)
 		return 0;
 
-	pci->suspended = false;
-
 	if (pci->pp.ops->init) {
 		ret = pci->pp.ops->init(&pci->pp);
 		if (ret) {
@@ -1313,6 +1310,8 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (pci->pp.ops->post_init)
 		pci->pp.ops->post_init(&pci->pp);
 
+	pci->suspended = false;
+
 	return 0;
 
 err_stop_link:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 3e69ef60165b..e759c5c7257e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -450,6 +450,7 @@ struct dw_pcie_rp {
 	bool			ecam_enabled;
 	bool			native_ecam;
 	bool                    skip_l23_ready;
+	bool			skip_pwrctrl_off;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1

