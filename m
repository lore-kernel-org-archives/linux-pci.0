Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1983B7753
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567025; cv=none; b=F8+wWAi+O1IwF2Rc+/mFTxYD9l6+iq/A/koS9iHAh6iVPpr0wOOosD/0VTu/sa3yA4Z4cqiidF7FF49qYOEWVJVKrGVcc1qQoELxqSJv0QC5TQBewSiSknhGjYpOr2zDxc8/frETLC9/U/Ol9piZTX3nDofQ+Zufth+UvMowxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567025; c=relaxed/simple;
	bh=PWGUXyr+GtnyzoUhMB9V3ekI1oFO0F8QmYYXumVt7Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBt3OagZBNOgh/9Si4J9cb4QokNkJUpL9FcX6bQ+PU2GO0e8iV8Sfv3qwd0Gaeksbrm0Eg4536NxPm0vUym9539720awyc024YKfW6aPiptm+3XBl4eAsJzoGTcyT9hCWlbjoqDZ2rNdUBrcHUoss7KptF2xDJI1On4Sw4/TkVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiIApgK/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+kDmxQz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiIApgK/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+kDmxQz"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376Ym6l494121
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 13:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7aQXCO2yyCZ+oTPzSKSvjrummEe0+JiJFnwfrGu6ciE=; b=ZiIApgK/+yc6CkXF
	zTDxjb5yYtlLxm2mIu3jnHCnxW1Wf7FV8XXSykWVv1VrOcNgsuUOvt8SRdL1PD+k
	VTlc4TwID0X4zeboZ55PX7JSygwvRMnzYL+2mo096F2JcFPsoqHF1MIkRxfCOzVQ
	U71PaiBwMVtbzgLLB/M/sGpLSnoC5/api0/wudeOCCivarkAByAFamJaX6xosVlx
	ctsl7axMgQtM/z/Jsboi4VO1/4pbnsMrSuDDbMlJR9ytKugAC8B1ytE6npAfnJyS
	lGvVEUSWUfoAG9LcgzWfxNihGPAPb3BaA1+NJjivyb14ddzK8ah5SjDGA1hcbSbs
	G8VPGQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr8trnm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 13:03:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0cac007cdso34961835ad.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775567023; x=1776171823; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aQXCO2yyCZ+oTPzSKSvjrummEe0+JiJFnwfrGu6ciE=;
        b=V+kDmxQzYNSsksM8qiAOA14erOBvDWy0d0WWD4BJkRBAcM9EuDKmv9r96+Qa6NcOlN
         KJOwX9JE1Jufa+y+vHk5O5brQ/pZGlq5RnqkPHAY3CVIE0hFlwaNxESqJuziOgLdEP+P
         0XHXGlIRXriRG2IKzQjl2PzzpiPMp2yfOUD8aBYRX+L2j0OwUEQvBdRwe5byn9Gt4oLt
         /e7rX2IinQp8WleXA0WYJLtLS7NMMpfu6AdPx1AAAwqQ+izVNtHW9GMZpZ/nWpm4K7pr
         iCqisSV7J13wrmaIBfV/FJfwUeRekNg+JpDZs8bid1UJkPYsDCx4glSXGVkNtP5SPaqv
         8oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775567023; x=1776171823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7aQXCO2yyCZ+oTPzSKSvjrummEe0+JiJFnwfrGu6ciE=;
        b=nz+Zd4kfor8xVCd1r1Q3Y1xhg++n+OqR3sHjpa6/+fhXQtIOwEqaDVzle/ULBnHUqb
         MH/XHKkkNJh9YlBpmNt0QQBgaj07rlz8O/NSYHKS45hwL7cQU2GbRhKStOpfOrGL6IfF
         YpOfDarSKMAHygDMNIXmuyzSAuCUZx5DpReaKsB60S0OdjUea16jCe2Jn9Hzlf4EkGQb
         W2dXTp4oiNTld+JOralFxnWi48XfwOWHZWQjI2IMssEsIlTGAI5DKETCAx7NN9tpOUrZ
         zJCOPRqKmm2Z1BcBnPj3x8o3qne6dTC2Uyh+0n8xC4e04iF0JZLXvWf4oBla2EgDYu0G
         TAZQ==
X-Gm-Message-State: AOJu0YzeePKhbp1gNYlfGBnUTlf6YbNbit4qcScL+fsPvmjip+P7Y3TI
	H3fQmSpDp/SHnnyxo2ztc9WkETVFQj4VGX8htNWvGqldrCgsaPCmkpn8agxBAByVXpw4QxQGBwK
	yEnn65fSCP9gzbzgXpjii/71JRX1rTuJ354bqfThNKtHmmVcy/BvEW0teNxrTZgs=
X-Gm-Gg: AeBDievPw/4g5Bf63bTPWh+Xgqx56m40toOx9vUM/SWbhqCGImkG5Qd+cKX9owwWE/j
	yIQ//mHDRzM6+d1imvpj/Rvjdyr7+uBSn/eDWkZdQSLdqBIH5Ou8vbtlZYV25LLuYohM6KHqJVu
	MRMoXdNyxfuCcu6BgSRIB2M3XITqWNlum215TWqVdKQEWFPIEk1PSL2BVVEdg3J7AUhcTOLgjN6
	HYXxh7swMkP2H9gjRHhMNOYHFtMHE/0X9nBRB5zLW/w5PQ2hUnetbqHHQ198aGMVJTAIf9aJ7Co
	90nrDpnrj8KjKJw8gITkWlNEe4DpkfFMSe4IXOKLuho/+T9Imfn7XoyZtOyDNe8XYOHNP4n7Jgr
	UJr1+BJL2Tbctv08hk0K73JrE3QlS6p9S+fyf+q0MPwu/e2fnfbZ6GfDq
X-Received: by 2002:a17:902:c410:b0:2b2:4862:78e9 with SMTP id d9443c01a7336-2b281687c7fmr191332725ad.15.1775567023092;
        Tue, 07 Apr 2026 06:03:43 -0700 (PDT)
X-Received: by 2002:a17:902:c410:b0:2b2:4862:78e9 with SMTP id d9443c01a7336-2b281687c7fmr191332045ad.15.1775567022518;
        Tue, 07 Apr 2026 06:03:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749794e8sm181564885ad.53.2026.04.07.06.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:03:38 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 18:33:11 +0530
Subject: [PATCH v4 4/5] PCI: dwc: Use common D3cold eligibility helper in
 suspend path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-d3cold-v4-4-bb171f75b465@oss.qualcomm.com>
References: <20260407-d3cold-v4-0-bb171f75b465@oss.qualcomm.com>
In-Reply-To: <20260407-d3cold-v4-0-bb171f75b465@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775566995; l=3264;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=PWGUXyr+GtnyzoUhMB9V3ekI1oFO0F8QmYYXumVt7Kw=;
 b=SYyzydNs/xfRblTu6iPrQSA4fMH41W/iB9N/GrQWpymTxH13o3VAyw2wznzKk6+5Owe6OlR3I
 qZTMEZWhJEqDsdL6LeSIjDaj91CGvrIy8scrP0kmGcdSnWG7Whu2/lL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: dKJbK4D4tlYIHNy0f-gfhMCgX_zY44Hp
X-Proofpoint-ORIG-GUID: dKJbK4D4tlYIHNy0f-gfhMCgX_zY44Hp
X-Authority-Analysis: v=2.4 cv=c9abhx9l c=1 sm=1 tr=0 ts=69d500af cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=h5qRVDGUHOPEFS6InpEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyMSBTYWx0ZWRfX8U5gBvL724fw
 KravXWcaVtpRE01mXexudEeLhUXwBUXh1GYHNHRGK2dEivR+ZbN8Aab+cXxWCViOgo3E7iw0b7l
 1S328St4g8aEcPIcVtmGtkngyeUWhQd8Ln42lPd9MrFDZf7QfxlCyEeYfxLMDfBehH/tyl0iq+2
 WE1noD2WEHVeD9w+MEvecFq277moHLBEGV55P3BnCn6Ko6JQ9NFiDVaUOgwbDqX2GrEHeKjsnRj
 H/ShwVfODOHxenDBevwiHC0aAmJ3LEwZsAzwQdTwSoAaR0sIleykYzJUcTMVnmmGLIW8tTo3a4f
 pD60JZHvDe+W0Zbia3eJScC9RarPHfwjebDh2No8PhZJ77IPUA7nbjqYGipsCFiXd6iwyJ4HAs9
 nCLmHyDOg5R9l3+iX29hXDGxTKOxLHEtwfN18tl2uWFxfymr4tL/1Wn+tZNBI+JSHiPp9Me4RwO
 n0FkaemAF0vd3DO2bTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070121

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

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++------
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a9021c99ece17504834650debd86b..ce3093cfd1608f1616001cbf5f541a4dc3eafea5 100644
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
@@ -1269,6 +1267,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	udelay(1);
 
 stop_link:
+	pci->pp.skip_pwrctrl_off = pme_capable;
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa5c27690f998d58729130ea863984..0af083018aee29c1f0f4385dacc6e878c8d040de 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -447,6 +447,7 @@ struct dw_pcie_rp {
 	bool			ecam_enabled;
 	bool			native_ecam;
 	bool                    skip_l23_ready;
+	bool			skip_pwrctrl_off;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1

