Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336883750AC
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444962; cv=none; b=r3iE2Z4LY6+8mnjQ+foWA8hgiioZivqCbs+xDGZ6dvIuzieZrc6Fj183OtWshYC3L+A9AMAICeW2DYNrmQgqHT+xGXiZbC22JrYKDB3BJ7itXrNi1sxSpGj4H5rQM53a4jIQgiHk3OYo86SxDofajxtgMj4DaGsRQD4bbclKoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444962; c=relaxed/simple;
	bh=FM8NSfNkcJ+OAXnXrK/t/KiNoyaQ6US4QTFzM89JCZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMAdVJ8V6v0MTdJxyJecfLuJEyAOdubdhkfGfb4J0XvUGAgk1IfAa7KLj7E34VyMsKwn5kAgGvUrafwMMXFVAnjDZdHxk5q0eviFodnmMiBopXqpKZfVCm0T0Gp3dU75AqTXYmGhOljQQvWnMhjwtjv1NHvvOv3WmNGQOtwFC9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fj8FXeYM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F4WVkwT5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fj8FXeYM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F4WVkwT5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T5WL223347492
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fxC/brjZIUFI/5YPDzJNaa3TSXiJM1Iaua5y0Bx3kDA=; b=Fj8FXeYM2Cstey0K
	Z3EIT74accNvl+0ym5DPRKWQo+XgSPtmbafml8RbE12SJrdtRQV0KDvjc+XxvJuO
	TfjWMxgsZCyJ/cF8y3+FO1dmjfCkmFAFMaVYewWvX2fl/110Lo3fMa3ynJUuBmzy
	2GYDn8CsMFBLwxpc5I9n4SKpxHmZ9XtMLuV7Ti4qtqGSLmVIutxXmN0LTCLbiZ1m
	Eu2bmXb8zeUkHZuYJDqfEkiz0DLWK65MNx/XpqtkWinPclle9TUMqyIPmXjMMtm/
	S/1UX2kwBBzpfvkqx42vWfPxLQ4BVhFZU7Eq7dpeHrwCxyhFMnjQcZDuiXkjxzyy
	kUZrmQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4t07g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 06:42:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3568090851aso28892520a91.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 23:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777444959; x=1778049759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxC/brjZIUFI/5YPDzJNaa3TSXiJM1Iaua5y0Bx3kDA=;
        b=F4WVkwT5N32lJW9EAMBk1h/bcGHFYRZBDv5/sCdUugOhI5OARiuL5mdUxCcfWqTrPn
         GAB1FUH7cNj1MsCOwjAV4+Sisun32JTMEdpjp7e/NJM8sEIP9bFuhDyy5g2xB3BhU5rQ
         BwRnfinxxUSD1Cs9DHnqNMnEMYbPBvq7FYviaxeqp8SrP7vjd0G5bo68z9LUK6I+S8/Z
         bAEXoavlDSqLJ15DfbPwKC0QixcHdTZyVLe15H+wkxky9FmgI6IbNaSzjZEUdWl0nPXG
         VD0s7u0J/kIjrFbea+vbiUiP0yQvGkh/5lfj3X2IwbQKdsWhuVHPyMOra95B2D+8x0AK
         hTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777444959; x=1778049759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fxC/brjZIUFI/5YPDzJNaa3TSXiJM1Iaua5y0Bx3kDA=;
        b=KMpFJ0avaDKbiKV5VZ7Bf5VFa4vEujIUu+FWl/gnwq7h1EpzmZq3I1zyhgLDhytov0
         M87IlbtPsHWV6OVswJk1lTr3L0NiBfbuQWbVfFuo7rLWJq2oI/TG1Qm5V+z5z4Ax41E2
         t2wiDxIYOdxSDxE6E1LZ4lE8QrF9pZGM3p5+de9noBkpwbDgfWyKmFSE7VLQH2N6k9QT
         iTZMC9eshbpa0Y4nJVIh5Z7BYReEBy4c04uVoNOb1pwRY79fqsRHn8oGSIpt1zgISe/j
         x0EzgThlKw7LsLn/h9ph4dS0wveK8R/BM3Nd8nVwkE0wzqWzH645LY6dIGgtWMgWLmzx
         SPSg==
X-Gm-Message-State: AOJu0YwknY95cSD937RDKSIUDKpTwYLBpZmIAt9oH1g34THMIvL84Xvu
	dRJX/k63RXaukOtOWgUZYJeOpN/vg85Xw+l16CysB11W8VzXssCZ8qZk2MzNz48wbT6ceCPUknh
	WfQM5hBRup6nTlki2kbJE8hswZf4NyHruOb9MmK96he0DtDtpj4Z8VXYE2gPT8Q0=
X-Gm-Gg: AeBDietKBGZUIExTbCOrqkVsnfw3XquDzyK1CKouy9T2frwExZLLlDeX1fUdmjL6uYm
	4jvZsAMW/ZFboC94HvtXNxlJTp6NZ3ggmLEhfTLKuml6l9cOVCdYjdr/j05UgfnZMu9i6E2kGDc
	qiTqMEm/RZLqca+6f1sg2Fv9Puc4jqeSMGR1dyTYc/NHVYXMeKFq4zj8l2HDorpSpOSTKnuLRb9
	MQ3y0G4WhUgfIn2eK/kGRBDghQS8ciiS66uoK3F9CgffasNRk8cPv9/4Yz4gr7G3dHwl4X+rogj
	GB8BwJnJsLBgBg6cc6ovQWaQqRbF+I6v9mDugbzV5uNSuZztRss7Qd1yngN+LqWYvF3afCFfloz
	7JgMz0Nk72F7HcVt+dswxwWqJMhTDjv7FiGq4BKItymaMGGxaMIYLQQdXAhiZ4S5QVbw=
X-Received: by 2002:a17:90b:17ca:b0:35f:ccf6:69a5 with SMTP id 98e67ed59e1d1-3649205a55emr6831522a91.20.1777444959051;
        Tue, 28 Apr 2026 23:42:39 -0700 (PDT)
X-Received: by 2002:a17:90b:17ca:b0:35f:ccf6:69a5 with SMTP id 98e67ed59e1d1-3649205a55emr6831479a91.20.1777444958505;
        Tue, 28 Apr 2026 23:42:38 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a0303d59sm2021414a91.15.2026.04.28.23.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:42:38 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 12:12:23 +0530
Subject: [PATCH v5 1/5] PCI: host-common: Add helper to determine host
 bridge D3cold eligibility
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-d3cold-v5-1-89e9735b9df6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777444949; l=5116;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=FM8NSfNkcJ+OAXnXrK/t/KiNoyaQ6US4QTFzM89JCZ8=;
 b=K3LQ2ALmkEnry3Jpnx3w+lm/fygqHjFpyXjjyleGf6Vb/X5u5okUeTqsxaRl61VwYCNLUloXU
 eLbSzw5GJe/CPBY5JRnFaa88MzYlPV6NajQg6GWbTCoBPnJmwpMCZva
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NCBTYWx0ZWRfXxMQ1zsvwRZ4R
 Y8DRpY2KmyjAmCtmo0IL7NoxemouBGRGHhu16FZvuh7W9YK74m5SUgj0NpVZigHtkMV0u09mZly
 q9Md16Q23Pv8az/rR9Ww2p4HV1FgdmWcLl42MIrYTmqCXWcmPSB+wFfoCIpTj6bSUV89++xbNxi
 fFiWLzFjQmyxFOwE7OD0lkmg4MmY6xyQahv7reLJ0dV++gOyw2D3ygJAqbHl0OgFq+fWdow3IOe
 7jIpLiCZeGaXwSuPWdJ5E6+Xs9kqF62Q/UVZ3ZswRpIgV33vtiAjxua9ByrrxVPwuRvzqKcw+So
 XW1X8neO3iCMft9HnY7dPOxdd1TQG23Djy1e6d8c6WwX9EbtS8WTJeTVZWhndUQzt4gNuUAksBy
 2R/nPqqFyMVIIoFwUgN/we/uIY8uA+tJcKSrRUyYb7PlUFGD4HcSlJQOEUm/WjP5Kg/UnT6h7VU
 pp/hJnA8n0ksWv6rvxA==
X-Proofpoint-GUID: Ioq40EbLhS3IHcExjreeKBz677rBb_Ox
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1a860 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=w2i6tlqj-xX_7Oe5WM0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Ioq40EbLhS3IHcExjreeKBz677rBb_Ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290064

Add a common helper, pci_host_common_d3cold_possible(), to determine
whether PCIe devices under host bridge can safely transition to D3cold.

This helper is intended to be used by PCI host controller drivers to
decide whether they may safely put the host bridge into D3cold based on
the power state and wakeup capabilities of downstream endpoints.

The helper walks all devices on the all bridge buses and only allows
the devices to enter D3cold if all PCIe endpoints are already in
PCI_D3hot. This ensures that we do not power off the host bridge while
any active endpoint still requires the link to remain powered.

For devices that may wake the system, the helper additionally requires
that the device supports PME wake from D3cold (via WAKE#). Devices that
do not have wakeup enabled are not restricted by this check and do not
block the devices under host bridge from entering D3cold.

Devices without a bound driver and with PCI not enabled via sysfs are
treated as inactive and therefore do not prevent the devices under host
bridge from entering D3cold. This allows controllers to power down more
aggressively when there are no actively managed endpoints.

Some devices (e.g. M.2 without auxiliary power) lose PME detection when
main power is removed. Even if such devices advertise PME-from-D3cold
capability, entering D3cold may break wakeup. So, return PME-from-D3cold
capability via an output parameter so PCIe controller drivers can apply
platform-specific handling to preserve wakeup functionality.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 71 ++++++++++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 +
 2 files changed, 73 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d6258c1cffe5..09432d69175c 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -17,6 +17,9 @@
 
 #include "pci-host-common.h"
 
+#define PCI_HOST_D3COLD_ALLOWED        BIT(0)
+#define PCI_HOST_PME_D3COLD_CAPABLE    BIT(1)
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
@@ -106,5 +109,73 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+static int __pci_host_common_d3cold_possible(struct pci_dev *pdev, void *userdata)
+{
+	u32 *flags = userdata;
+	int type;
+
+	/* Ignore conventional PCI devices */
+	if (!pci_is_pcie(pdev))
+		return 0;
+
+	type = pci_pcie_type(pdev);
+	if (type != PCI_EXP_TYPE_ENDPOINT &&
+	    type != PCI_EXP_TYPE_LEG_END &&
+	    type != PCI_EXP_TYPE_RC_END)
+		return 0;
+
+	if (!pdev->dev.driver && !pci_is_enabled(pdev))
+		return 0;
+
+	if (pdev->current_state != PCI_D3hot)
+		goto exit;
+
+	if (device_may_wakeup(&pdev->dev)) {
+		if (!pci_pme_capable(pdev, PCI_D3cold))
+			goto exit;
+		else
+			*flags |= PCI_HOST_PME_D3COLD_CAPABLE;
+	}
+
+	return 0;
+
+exit:
+	*flags &= ~PCI_HOST_D3COLD_ALLOWED;
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * pci_host_common_d3cold_possible - Determine whether the host bridge can transition the
+ *				     devices into D3Cold.
+ *
+ * @bridge: PCI host bridge to check
+ * @pme_capable: Pointer to update if there is any device which is capable of generating
+ *		 PME from D3cold.
+ *
+ * Walk downstream PCIe endpoint devices and determine whether the host bridge
+ * is permitted to transition the devices into D3cold.
+ *
+ * Devices under host bridge can enter D3cold only if all active PCIe endpoints are in
+ * PCI_D3hot and any wakeup-enabled endpoint is capable of generating PME from D3cold.
+ * Inactive endpoints are ignored.
+ *
+ * The @pme_capable output allows PCIe controller drivers to apply
+ * platform-specific handling to preserve wakeup functionality.
+ *
+ * Return: %true if the host bridge may enter D3cold, otherwise %false.
+ */
+bool pci_host_common_d3cold_possible(struct pci_host_bridge *bridge, bool *pme_capable)
+{
+	u32 flags = PCI_HOST_D3COLD_ALLOWED;
+
+	pci_walk_bus(bridge->bus, __pci_host_common_d3cold_possible, &flags);
+
+	*pme_capable = !!(flags & PCI_HOST_PME_D3COLD_CAPABLE);
+
+	return !!(flags & PCI_HOST_D3COLD_ALLOWED);
+}
+EXPORT_SYMBOL_GPL(pci_host_common_d3cold_possible);
+
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index b5075d4bd7eb..7eb5599b9ce4 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_host_common_d3cold_possible(struct pci_host_bridge *bridge, bool *pme_capable);
 #endif

-- 
2.34.1

