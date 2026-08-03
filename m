Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA4389104
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753132; cv=none; b=DfIxsz0t7qhurJcqJe5hFwBn3a9mcbZqH+QB/escOB8cEAoB4FBEMuw2VbAuxEhv9HNR6oY8xXE8TsYm+JTRIaTrkgkcagrHXR9Zn0TVgx4oue+wErFUnV1IQ3Cn/J0JLqDdv4J/coTcaycDb8f4c1lItxEEngNFLk+qDIbIz20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753132; c=relaxed/simple;
	bh=YQodrxLZXGti3XmvW8nwU9lpi/9j4ifCS2HxijUaHDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UDCPqBN8caLHFNnaVP1ogrKRcxwcCRAhVV1dKV6KUPJ2DumMlEXAPmVUeGXIzH+cX1SQXyZfQf/vCZPcjoFyL6vKKgq8oRlmNAgMvNS6zW9ZQsP72bez9QtRW+bQJheoitnJZ3oPFdm0xAzGe9W5jdO6VVjnW0l24jC2752RRZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vu4Jb7gB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cbIdnpCd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vu4Jb7gB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cbIdnpCd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673A8KmV4014138
	for <linux-pci@vger.kernel.org>; Mon, 3 Aug 2026 10:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhWKGvX0bNeNwHOozHVzgVNQHnYcAVFkH32Yo6rHh38=; b=Vu4Jb7gB3declPWK
	TI3ECB0a8FvuRnE+D/jzRkJmWnbzJac120CngS1IhSZayxc7b9m4tP74KA7HjzI0
	+Hr4EmydHJ/DbcOv5kOQ83iOgtoNvmG06zuFKdriQHYHbp1PSU3aENjow4ucZbmg
	DOidSr8lKRiL8ntegXqq0+5mO0vfXX6G+6pZvhhQQO/38cQ+JB8Kht/drncw1GGJ
	+kWFiQuNIvA0+o773xfVNWk3oNepwb9E151S+Ji/WULvobiHMp7evIdT5hIBn+sx
	4AjzSC2+A1KUEa0UKvSnu4sYplS7jMo07ulsrleYdoBQayosyJwfNMx8AlFfhFyo
	jHfApA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrt9285-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 10:32:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e4758ab46so3756329a91.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 03:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785753128; x=1786357928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhWKGvX0bNeNwHOozHVzgVNQHnYcAVFkH32Yo6rHh38=;
        b=cbIdnpCdJdN60W+wVZCuB0cFQzbgYAr1ZjxF7W2lJuF3RhmJWtipwTtFi5jE2HkKEK
         NNbZb4DGAKPnf0/PBRLNXi8KQ5XvDl0KlMq4J6Wo9x1dAqt6s3d5mB05e8ib3AzIE33s
         qLLoWTMOdWqDkZm7yrgwmsrWc8mj5COoP4zLQo4miVdp9Kby9147Jv7inAnYhZaiTqQ0
         iU+JJ/B7LorBsMw5W+4CU7XAvucxU4I843UlOBuzAOgMn/Z2amTX+LGTB8Lu2MtnTbOf
         MHlFYOzzsZn6xnW+itjyBt+PQkquoJtfywPbf+ALq9yueIr1DjWzWgvG2ijvZ4aNJf1K
         YmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753128; x=1786357928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hhWKGvX0bNeNwHOozHVzgVNQHnYcAVFkH32Yo6rHh38=;
        b=XZ9JO+yQTGDo9kaYUea2MHAjcoNeRTIFa+0eMu1j3wPJaeAThnIFdDzxCIYGIjgaCZ
         JqCeS523I/uainMo4ksEtYFQ17OCzviY9LksDB8GPAU2hODy39++t7ffwJYRZmxNAEW0
         t+JWDYn9C3WyJejGViVyFR6hAVKBLQRNktpHpwxlXrnBk1ruYgEJS4QcRoBy7r/dGrkM
         pQ55ofUXUo2dh4AbG0aQMJ5zl6da3CkvOhU7pHA3ie88Fung5y16kHiZysiVWpBuMtob
         lsnNMBPaZ+wFl5UK863kwAKFLKU0NJE8BezPURQaY1n7FgSd0JJFfgrEvtywmH+Rv55M
         K9GA==
X-Forwarded-Encrypted: i=1; AHgh+RoszHl8sMfbF6SvNTsjtLvJM3/TII0VO1C4bZI/9UdE4oVNLn/Z76wqcCaPJiKab4UAVXwtcRHRXSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0r3IQQFFOv1r+roouYNdYg4zk87hWmlJHH3tox08UCFRhFNGW
	si0JYPVAgKHNWZOoz/y5Ui7L0jVNd4wtBgwSlJ4ExXqDMcIIlcYtdu5yAyFi7Qltki8a7187kj8
	jYeL92zwTB0ARmG9Pg02VpsQ4u1Qq0VmzpOUMjllte5vBtHPvbwBoOIbn6yr4SNE=
X-Gm-Gg: AR+sD11BHAfQ0PV0JY7QkoZJB6JZpg947I6v1un7YsFHFgUEkpVm+JLNGEYzr15olPr
	orGin0BFaIchqWuotryJ6/RWkGO9Umhe5q1SV/3DZw2CMUfvw78ie0SaLdRl8RXrney8fdHNjhQ
	qhr65xvRAiIPc0QJR954Fi9T3gZqhNA5XKIFHduucCT3ctO/rzJodTKqCWEUWmfwXuE1QGhuS8F
	IkEHie8HXWwkHYKtxXQxOcXHe4dDewD9Iqf/Q/K5No0KhnAnEPuPM7wEwBveMTzUj68h3w6CMi2
	2Hrys8zu3EpeNCrK78bHXTNZmNf2PanKIUFrsbjkwkcICOuKTDbWdEMYgoZ2QaVl1INaDdtuJaa
	kJT+keQYtD6HwvanI47iHsaTo3w==
X-Received: by 2002:a17:90b:58c3:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38fbc4bc3cbmr8623163a91.24.1785753128254;
        Mon, 03 Aug 2026 03:32:08 -0700 (PDT)
X-Received: by 2002:a17:90b:58c3:b0:389:8f6c:4d59 with SMTP id 98e67ed59e1d1-38fbc4bc3cbmr8623122a91.24.1785753127669;
        Mon, 03 Aug 2026 03:32:07 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b1244bsm3693427a91.0.2026.08.03.03.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:32:07 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:01:45 +0530
Subject: [PATCH v2 3/5] PCI: epf-mhi: Use a define for the DMA transfer
 timeout
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-dma_multi_sg-v2-3-c12bb05e42d6@oss.qualcomm.com>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
In-Reply-To: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753106; l=1737;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=YQodrxLZXGti3XmvW8nwU9lpi/9j4ifCS2HxijUaHDk=;
 b=rcBxb1zUyIP4s50AcsJ6tkSwDs7jalf+WtVec3AVWiM+5ZsHiNUzXBYpOlzh8jiw2Jacuj4Ec
 tl6wkE1qXPxBIdwVaF+mpN3ZJYM4JlQEETY7EYgWiO8hxuAAq1WXNMf
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5NCBTYWx0ZWRfX8PYq/MF2zPxu
 6WJX7lMh5fxVEbBrPsbZGVzw1zeooeczMjoT41HFlRQHV5bmHJI0lmXYB7CE2hKygLd3LRqqj95
 Y/1yxUcU06Ajn47aghz7GJehHeQDXnwfLv/LhXVesWlFr+ov3JKWH8qz/j6CG22rAVar/96nbRz
 yYDSJKH9YTM6Iwk1oGOnWJDoVjgvag3qrLqKFy9BjcsoUFXFEAp3rX76FD9ACxmQO2JDpxZgEoO
 nRXJ/NsCd8padcsHqwHgHfrLj0qaCsfIWoLA4cszdTscjKFGyCcFQk+4Vm/OMA8Fp3+MTSbRoG1
 rhoeKmDDZbvY1v+ebhJVB0WO9ZKTdv/ul1E1l3CaXIUTZHBoW3OSsY6yoddCSwRN1oesA0DFYHq
 Y/PKj9ziYuz/GUQhBCTeuG504jplEUb0Ug6P5nv5/tVkIbiWBLt0e1J7JbJjgywXjX0g2ChQPOl
 JmNL6d4v3oMMNidzKew==
X-Proofpoint-GUID: FG4LYDKGZVstTFpAHJkJ62hBeByNIUUL
X-Proofpoint-ORIG-GUID: FG4LYDKGZVstTFpAHJkJ62hBeByNIUUL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5NCBTYWx0ZWRfX7YgG0mPc+Z74
 5pWvARE+0WuTubtlhuk0stNa0XveGi1e5XWbrKOIc1lF9smKKtfnocLhLmN9AZDTwyOzpmYWE18
 j/CAzuIwYWe8X40sdHg1+pPVyZUcqow=
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=6a706e29 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=K2uzCxK3BSS_9ZXfCP0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030094

The eDMA read and write paths open-code a 1000 ms completion timeout as a
msecs_to_jiffies(1000) literal. Replace both with a
PCI_EPF_MHI_DMA_TIMEOUT_MS define so the value is named and shared. No
functional change.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index c3e3b58fb86cd75e175b69ca45530610c500b99e..6bac69fc84b472c5f1abbeede2b441b5db73c784 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -21,6 +21,8 @@
 /* Platform specific flags */
 #define MHI_EPF_USE_DMA BIT(0)
 
+#define PCI_EPF_MHI_DMA_TIMEOUT_MS 1000
+
 struct pci_epf_mhi_dma_transfer {
 	struct pci_epf_mhi *epf_mhi;
 	struct mhi_ep_buf_info buf_info;
@@ -357,7 +359,7 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 	dma_async_issue_pending(chan);
-	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(PCI_EPF_MHI_DMA_TIMEOUT_MS));
 	if (!ret) {
 		dev_err(dev, "DMA transfer timeout\n");
 		dmaengine_terminate_sync(chan);
@@ -425,7 +427,7 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 	}
 
 	dma_async_issue_pending(chan);
-	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(1000));
+	ret = wait_for_completion_timeout(&complete, msecs_to_jiffies(PCI_EPF_MHI_DMA_TIMEOUT_MS));
 	if (!ret) {
 		dev_err(dev, "DMA transfer timeout\n");
 		dmaengine_terminate_sync(chan);

-- 
2.34.1

