Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E77A34EF05
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600462; cv=none; b=GbbSuyfOvtTaynCH0XiF1Xf9kdGLkAZH/lY94nwLIcBcP0UqOO77xvvgyomVrCnuh0aJtO7IPvdI0ylkRp26joUCFuS7vb0RnubObgcq0RizKbZ3eT2BNNq3GSLNXN5hTPVOexu5XoIMJkaAb2D4KzPXglOMCbvCWkPXFHRxJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600462; c=relaxed/simple;
	bh=tgb5v2thYMg2oKua2S+Z2ljwfsLGXMrEPMdeemrkAxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ecv/EQD01yMGzLUwA6DqEJB69zhdKZ8Kq7HS0ZYNGr6tjGSIzMAnthsxsbPjTynbFSYC6HrIh2xJ4zeKQDQBxh7e3HXVdkuk1UGNPS3LmIND6t8X0oxcneqTFQmT/wcChniahRbYPq2jbPwiWCCIzLYs9U9NBOVFUfmaWXCm9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DOHGwn/Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7FiNC1v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOHGwn/Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7FiNC1v"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92cem041993
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	urO8LEJ+6lWbFda5otpiYQIaXeiVcmn7HEJcXHUHVl8=; b=DOHGwn/QFPjMk8jU
	hF87pbT0p0Ex16Zw2Pj/EjDdjcHyhS88mh6mjz6Hpk/fyp/3MEyrGTSKvoYy6Rdg
	+5ezjOCItb1se5vIBbIunc0oQxPfSVluS3NP7fpofgwciBZHFp6+cRI7cbNUXFSw
	f9lYiqP/s3fbLbM892BaTnfxsE0aS7D17A7QSTM+E0wKS1yogS/xyBBaC9FsiVXp
	k1U0W173Dgrf1WLCPeiN8lmO+aJkzojt6AJnJPprS7hEWfszSDyp5qftkk3rZzu9
	JQ1pePUFBuHKQ7m7pLmkEFyLKnvSKRbvKI1Umo5998eHFo3pz5XLdl8tQ2AFw6lI
	EaxLEQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355tv9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 11:41:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a76f2d7744so65906975ad.3
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769600460; x=1770205260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urO8LEJ+6lWbFda5otpiYQIaXeiVcmn7HEJcXHUHVl8=;
        b=j7FiNC1vKTI+K+hB43UuwiY8sazbOIDv9tFz1u5csP/xTho+hNf21suEcPR8eHDdbj
         fYCIFuqpOPbbKGTaLD1Bc/NGBskKF8yQriLux5PtrJK5nR50jzylZ2rk/eYDYDeV0AXX
         aB3RgMHtdOn6Ccg4cvNymmEqh2fuh4Pmdd/cRahLNn3YiKl9pmT83vLc8OGnyfUJ07OC
         jbYpFxMGvZwn80q9RSMrGQG8KXTuUc3X8RQtGHYMSRCf9xhDRLHrZJ563yanjGNr6ulV
         UA2GVfsBo4TOEjud3lkEzbOj7zgc0+3siuzzUXpWrDB4lNH3cdvbRZmKuiEL5nLux2WF
         Aovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769600460; x=1770205260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=urO8LEJ+6lWbFda5otpiYQIaXeiVcmn7HEJcXHUHVl8=;
        b=j2yXf2K5NQjOOT+oJkvgFJi3Y4ZvblhtfQoPy5xlCPWQSW7/JG8+4gttMqeZiVMyCD
         IbCWQ2aoSw+Js6Cji4hVzxzTxP3xt4Vggb0lVyCQ6caLyLydKej6HrW+UHIqipm7nTo6
         E3yad8b1qY8Sz+1qpw6lOuWlAFVa08YQDohqitE7IC1S42vjvm03Npom2jLAv0U2Aiza
         zKyoq+b/IExXK9TUILgUI8OvKwFrIGyqwMWa2K6Fq53Wwb72VuIr94ulxlJR1MPFzZ21
         zbs3s93s3WDonRs+eHDr8fenb3KhYt2+yH2G1e1KGC99kERFlPPmeLpAQMEzFwrrztDp
         Q7MA==
X-Gm-Message-State: AOJu0Yz6tkLF/oTxlhYX+lvvtRfiaqLiG1ngk6Nu9a0CgudIOrgWVVuG
	vp0W1q58AIn/Cm5KIy4H80L82QZeNHfHtWEAsw2BvBlEgVlbpMrxV0rH76F7K6vUEP53ES6dJlw
	btBO+KAXAckTSUjYJKFqaqeUZPwo6t3Z/vQFiTZPnMsj7imOAFW7MclFr+5mJ9Eg=
X-Gm-Gg: AZuq6aJc/9vKK52aJ8+EkD8RjTf2tV6aYKyClQlDEpkb3w+vJLTGFfGTn+N8JSfBlED
	GnjjyCdgLAPGtk6YF8Fh3fuuv5+REQKJrH895hHdRNqasPR3QapQTPVnMyJ4OTGztZJjZW027JW
	+78mNdqtHmctegZKim55jeGJBZZVfJks3qzPiYUeQa4viS06RQJImqbzzk9dw43Mslk4iT0RAJL
	K3ixF519L0eHPw0n+eJg7RDQJVprPMhA3rFNKONfmoQg7lulBWoEfRk/10jDUnoRQZnawLrS1pS
	CHjBrVhQiBtv9+1bctLS/mOqP8Q79aTH25hG+SqjvmHb28htxSrSvH+iearwN5hDVlj8E6x6qld
	UcUnnPINwCA725xcfHJi4ui+fc9YXnvSJ+NOVJVVEQ3E0
X-Received: by 2002:a05:6a21:3994:b0:366:58cc:b74b with SMTP id adf61e73a8af0-38ec62dddedmr4815194637.21.1769600460179;
        Wed, 28 Jan 2026 03:41:00 -0800 (PST)
X-Received: by 2002:a05:6a21:3994:b0:366:58cc:b74b with SMTP id adf61e73a8af0-38ec62dddedmr4815164637.21.1769600459666;
        Wed, 28 Jan 2026 03:40:59 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a9f41d0sm2010678a12.27.2026.01.28.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:40:59 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 17:10:42 +0530
Subject: [PATCH 2/3] PCI: dwc: Use common D3cold eligibility helper in
 suspend path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-d3cold-v1-2-dd8f3f0ce824@oss.qualcomm.com>
References: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
In-Reply-To: <20260128-d3cold-v1-0-dd8f3f0ce824@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathanh@nvidia.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769600446; l=2261;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=tgb5v2thYMg2oKua2S+Z2ljwfsLGXMrEPMdeemrkAxE=;
 b=vnbzCXVVkARXQGBcFxA9YhFcF0xIISi15hXTOsChmfp1rgaf88nf8kLbtDSsQsqbUBHTo201x
 MAszfW1+cyUDccRfVH8MOg3PN4VstoHYLuv5Esd/MVjjNqy2Eo6ZwoW
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=6979f5cc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=S6-w4pPrR9TiqxbCLhkA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 3EYvEfXr0hhbBj85k__EDvN8r_vGHhpb
X-Proofpoint-GUID: 3EYvEfXr0hhbBj85k__EDvN8r_vGHhpb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5NSBTYWx0ZWRfXw9cKbkkuN+U2
 gVNzKqz2+NPviG9UOSwuUXkwTrbKG6bvLrexXKqDrk4M59LGkubLX96xMNLbDOvs7/XCBJ7EhwR
 pkP+uCFFTAk35OpeNYxDO9gCsatXKFNtNev7VShZvsU/UfEBG4lVOvc9gQaF2jYsrUlSnHnPJsB
 g0V29v5QubNAJNv11BNsuuptvtuAcsRFDebSAz3UfCO5icvIkPHKnKqMnD+pdcGnXVHTOfmZRDn
 lMIdW5/GQZHvDvN6MRM8z79nWlREZSRvZVxlyifTveItUdOjyB7gltDdaV/91/0fS/ht/f3iYmR
 wEAGWvoBH7ZGJqoKddMHNxgF2xYxpbiMhP81wGTMHREdW+cT4G5TwPf2YQBHmC4XmWA16osY3pk
 rbl37xcZxPLOLZgcY5+fwq293zas1Uv1o+4LuTA4iwKFwZbV0c5XcbE9In7fwMN166acqZ2Z3ss
 ksIRiLz2rQfYD3MB4bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280095

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
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +------
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 372207c33a857b4c98572bb1e9b61fa0080bc871..2c8056761addf7febc1b0e06ddf8ba4dd4ad1684 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1157,15 +1157,10 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
-	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 	int ret;
 
-	/*
-	 * If L1SS is supported, then do not put the link into L2 as some
-	 * devices such as NVMe expect low resume latency.
-	 */
-	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
+	if (!pci_host_common_can_enter_d3cold(pci->pp.bridge))
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 31685951a080456b8834aab2bf79a36c78f46639..18d8f7d5d23088b2fa177e84a21d900c98850fcd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -26,6 +26,7 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+#include "../pci-host-common.h"
 #include "../../pci.h"
 
 /* DWC PCIe IP-core versions (native support since v4.70a) */

-- 
2.34.1

