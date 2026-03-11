Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB63B6370
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224827; cv=none; b=ccVWcB2v/9ETSik5eiq8hnbi4fSRYZjYxdxp49fmpq4dQJwU+QnDAjF1IljY9U87gnqDw2pQhz6PjvraIEayywDLXVEH8ei+dl/b9Im+15fsMezP9BUlgp0XM3y7rzMRPnkT1gdONkS3Boq7Ds2NZzNTIfA/ga1y/IQkc66OnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224827; c=relaxed/simple;
	bh=fy3UTBHOugmoB20oZcj6up7VhBsfAepWi8HvjyVSVZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tv15mgRGSEQc+R3AGBhiczqZ+yZBSzkKe/BOC2VtMeJgq0J9jmJaPes7ZC9xJWEcH1nkG6nl00ppd8LrpZJZ5nvHvESnOe2bRcJFP9wO6AyeZG5t6mDiKAYmwKR1vRDRix6pw9HmnZ8L/sOADPXUBUE1C8++0Symh0kxeASGn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWpqu4qp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YO4jYbJl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWpqu4qp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YO4jYbJl"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9Eq02614148
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3HW+aNY3GxegGpMcu6PaLCejcYO8z8KGXcALkhoF/nA=; b=NWpqu4qpYeNdEAU2
	Zw3gI9JLNRKEHETOmCIBhcuoVhKMbGKAWXNtnSWM0OxhA88q3ej//Uh4Ta5BTV4/
	bUy4E6SFuSoX9839JDh4zR/WIN4gEgGhML3vvEZowhHQpncaGfcBByAZG7tUvbr4
	WGJmCnImw+ufB38vvsHNde9b3AVFOwwzu5/ML6N68HBmWfOooBt1z324dsLOMe2t
	sM7yioQTjr9B9dINgnlOLlp3AtdvjDx53wU/TyPiWyoMIU48pbtg/UkyfynHP6rB
	ANJKJ+VmF48zI+EwqfzTYb5xzyrzKaFNDJCysN2Ya1n6wl/EVv2hPQhnLLLomag1
	H0rR3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf1fbm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 10:27:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae65d5cc57so442793775ad.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773224824; x=1773829624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HW+aNY3GxegGpMcu6PaLCejcYO8z8KGXcALkhoF/nA=;
        b=YO4jYbJlgRScY+II7qkZ9IiTJcACzFK3zQrXN7zS5EFSGD87c3q2Cq6GOL7EVNGz4G
         hqZXiVs2T95cTZa0Xhj4wSwED2Yqtj9AEi3joKU2GHO9nG50LOflWmDKl01V7lPtFo7c
         2nkQJbPb2q0RuSebu9f3PIDabPFSIMUZrLQWIBPL/FObOY7+B5wLYRKZrAiJQRBpUBMw
         3FDCmL0zo17BJya4UJ0kalJW1Vef3DwSWNfz7rDSO3J6n0/v2uVnSJ4SHI62WuCSSqrF
         yGpuiNogEFZ8UsQb7yFS00I2MorDWzT9wvKu6gRrwim1VA3kZWuAfKcBsTrIjDtvXxj+
         0C1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773224824; x=1773829624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3HW+aNY3GxegGpMcu6PaLCejcYO8z8KGXcALkhoF/nA=;
        b=bdlIM48HL3sLI7HVViIJVv134KgEgDRj3TrRGL9NDXEc63VK9nCgar5sgxDJ0D/VIQ
         D8nBOihZmV9LXkRxRL+0nLEld2lNwZx53xqPNwWsrX78ziqzBauA7Fu+pLLrMPSdohmm
         BIeKqN2hLEFnZAKQPsJC5exPgZsNmIZ6jBwrAu8jnyVC2YQYq7zowwYPG81ANIQjv8OZ
         Q6RxHGGZpDiPVyoWSPkO/17RLdbG6F/tcYxcCRqNhXjxjXIgYZA/AdRqm0uuxGy7QKGd
         dBONdXtVWVPG4WNctZ0gFAGMN1H5BCEakZrpWD3n7Np1J+qbkc2C2QW3pleFjURBwDFf
         tsxQ==
X-Gm-Message-State: AOJu0YzJ+IdGbBy47uQMkVTyZVNno1Ce3+56OxKgj7sFYNQY54yQBybP
	wFmuKUu4jNPBoMzAO3F3rbmvqTY2/MgfoD51i+OnArRatVzeIQIYWF1GueoDOmGB0c5lkaGZfxt
	UEjDKwppTeaU726BGPlkwdNA5DBvZ56cG7UsBYPWKFG3Vr4J1fI4OREdssjjU9uY=
X-Gm-Gg: ATEYQzwxKrnoX/Gv4ZWChBdYSGCc3j/8EKqbqTqbNqjVejy0I93+92LNyWHG7JPkpSf
	Ru+LoU7/TEluX/syHxLt9Yb6rKHWL9PSfVzeGkwNUHHaxc7YqPKdsTWKkW/mczAYy6fufwONdN8
	519mFbpyd/0Ey168kG2NR8th7Z7zOkYqAOCU8jeTm/aeqH4WZibxKDUPdZlGXALNcqD0KU+SOi8
	j4IjSMw1SXDvaDzEad8xk7WF7zJi1CKejyfhzrJAup3UqL/wubapoGy0Pnarnb7vRNhi5oYcrCb
	RtRLtNWfgl30cF34duBUXd6+jJHA1eaQ6wJDkgGMne8phVjwHzyqk7BtrXPVUfmBXWMhS2XfbIC
	i5PjhR+pY8flCEddTvnWd+p/MO71e5D0VI8cbBaHB0xhrxWyblCvzelv9
X-Received: by 2002:a17:903:1a44:b0:2ae:5c3d:b07d with SMTP id d9443c01a7336-2aeae92201emr21189735ad.57.1773224824341;
        Wed, 11 Mar 2026 03:27:04 -0700 (PDT)
X-Received: by 2002:a17:903:1a44:b0:2ae:5c3d:b07d with SMTP id d9443c01a7336-2aeae92201emr21189435ad.57.1773224823861;
        Wed, 11 Mar 2026 03:27:03 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222872sm19575245ad.18.2026.03.11.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:27:03 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 15:56:47 +0530
Subject: [PATCH v3 2/5] PCI: dwc: Use common D3cold eligibility helper in
 suspend path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-d3cold-v3-2-4d85dc7c2695@oss.qualcomm.com>
References: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
In-Reply-To: <20260311-d3cold-v3-0-4d85dc7c2695@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224811; l=2039;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=fy3UTBHOugmoB20oZcj6up7VhBsfAepWi8HvjyVSVZA=;
 b=X9FyPw8OeaPRkbA/4PgAqOrpJ3qLGGhtZbOFwSw2LAoBmZPgdHkRAjhXRnMO5NP+6NqQGzOj8
 tWPIdnBqR/FBxj4CKR+EFFQiJMwA06TT1HHCWG4Qqad+24waSRSQhTl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: RD_-jHse6PZTSHOB7cVkCPZL9OC8spnR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX39ZY29ftu4LE
 M7VnLbRrYil4MI35B+FUVBSsvjkpBbM5fU0mlo6p9ECYUpg6mN0TNl0tX/vtMSJyQ6fEh+bzmfu
 mcUMCtE3zKcG9A3mTB9JzUYKjjTQ+fP+OQxLT7VZgrmC9ky1q+2LPYn88tX15IsA8wi8utcDJ2E
 BxevFF77Oy7kc8NTIZNRBXLvbTfh2EinjZcw5hD0vhMWWFrG+5+4G0BQviB7ql31FRPUC5RzKFa
 X6Z2qprxNlU4JMuu/wXiQiZhigkp7VfcoxlniW1rl3GjbQmf0oswZkLQJlT6SQjcsyeH3dkrw6c
 gnOOyfx7aDCCkvay4sOoCg7d6Azh8DzkQwkIXkdqe/vH/ZmWQ95xeY5UjCG8ZDyBD1dxntQWIXn
 npxG/qCIDgBxubr66xlSDaaspJbCWK2Bbj0jLOxUgSnM8OwlI6cnRdGP5WJhNKvmQ6lXYhRBNBW
 IubpSrrz+uHhIZGqZqw==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b14379 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ir7Wv4stjHWE4dv3774A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: RD_-jHse6PZTSHOB7cVkCPZL9OC8spnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110087

Previously, the driver skipped putting the link into L2/device state in
D3cold whenever L1 ASPM was enabled, since some devices (e.g. NVMe) expect
low resume latency and may not tolerate deeper power states. However, such
devices typically remain in D0 and are already covered by the new helper's
requirement that all endpoints be in D3hot before the host bridge may
enter D3cold.

So, replace the local L1/L1SS-based check in dw_pcie_suspend_noirq() with
the shared pci_host_common_d3cold_possible() helper to decide whether the
DesignWare host bridge can safely transition to D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a9021c99ece17504834650debd86b..8e81f0208c76fb22aa908de4e1ff379ec0cae2ff 100644
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
+	if (!pci_host_common_d3cold_possible(pci->pp.bridge))
 		return 0;
 
 	if (pci->pp.ops->pme_turn_off) {

-- 
2.34.1

