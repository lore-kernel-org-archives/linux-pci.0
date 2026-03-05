Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A674274B44
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694770; cv=none; b=mHMtk7wH3siFFqScOtQqRGWFSUjeEE0Y6WLFZYNE7FQnD9cRaFpcohx0qNZo8BoajrlSwEeCTwi6ALTR+frn7vWmfZow6itmAmwfvOPx/f/krFfhDc+miJsysID13rGIB/KCw+ChQspbsjJnfkvKab9CdY1Ft1f0clMT1EQoakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694770; c=relaxed/simple;
	bh=UhCMOjU2MR5qJ9pTZZsqwLKidDzcZH+9PxfTbs8/brE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4e5nKLxjhsgavzHUcmLa3Y1y8HyM8ufDP+WoPNn8XldjVot4JU5AGoG1LAVXNOpezNuiv+T9Kc8XAVi4A64FT4dtI9pl2m8czKwVvqi1dL66Uix1oXaG4twT2u0/KY97zNEvlK/QrXYFZfTckIORkxJJlwezyvHA49FEa6okTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LwOhxojW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SCdhQAz3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LwOhxojW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SCdhQAz3"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6251BgZR021019
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 07:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=pWcrS8fIIrR7yp4sNtvHPjJd+NFee2mfuv9
	O16NTxl8=; b=LwOhxojW/3vfTYm2B2jBbVKzru0NBFSux/cHi6bQxrP/84inzuq
	ILASbHI4PDalGNNe277t3Bov5qqcbCil/lCAmst3bAgHnYF955wO91EHOZL8XyI7
	4qc7haDML0DqBjDvRf4bUGfvMCSorQBytIodzqFp3t2bukq4c9eL/9T0pBGTpv93
	Xl6hWEfuG8PD0oR7CyOsJ6LsA1zyENEC2itcNgQ/r+ZBaDEWEFPJxz3u+roztg9O
	W8xU66gn9ssc4V7//G+UxuxJQB5sLWiMne1qeeyX6RwJSsFtwWjpBzWIdSu8WidV
	9ZA6HtQLxm51EPWYp8jad4Xik5xSAN/633w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpupthmst-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 07:12:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3595485abbbso6341785a91.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772694768; x=1773299568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWcrS8fIIrR7yp4sNtvHPjJd+NFee2mfuv9O16NTxl8=;
        b=SCdhQAz3oxLhr1UYrjCBGIdJ9N9DGDEuZFz8Axsl93AHvgelzT0xRT007XtHAalAKS
         FupoiF14EIdZgGtDuGeRUuMrITkdmkE6emIGjoPhv+3bP/vuLCdKPrLCHJB+LkoWVkEZ
         0eKQ9r1JlaLMXF2K2+w/2mPIe3QwRjgyKSBxl45a+gSxt2ASSThWV58eiXT/aP6uX79K
         ZDH0eS8n9W0vkM7ZNTOjZwre4fbh4CKOzRNx9vu+5GiV09vHXlu2dc4q9RLRJ/RUrZzn
         xiLabTKjXtt1MLsBfcGmCK0xnmwMTT9czVuuFzN300gAL5bDth+2MPqWQ4duhz4IRR/J
         +m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772694768; x=1773299568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWcrS8fIIrR7yp4sNtvHPjJd+NFee2mfuv9O16NTxl8=;
        b=c5HH3lrcdKzuzwgZ2rD+HwaePK3LYO8A8SDI7tFzrNxkm8YmSQQfoDYo1ax+czqbPS
         K8x9Hp3k5bAiWMfA/TOX1xdp38rkVJ8PnADgm9Exm4n1zxvR7wICAuK+DR2ckxq//472
         N/caWNHSXlhctZ/+JLdsQCIb6ShIlG6eEUkOM9fSzsVN8kUQvFRh1Qpvv/y42LwYk7js
         yw+Z17qUiBkAPR08PMcEQLrTh0oAVCbKNBxJCxh1g9PtH+bxG5EU8cS7eITo5LwQsIqP
         mcqwSynGn7qiEZ45W9YNt2UeQL0XoG3kfu/dtxa1ZKppLSxbwEq/o0QpFP7kHWdDX5kM
         l7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVrbNa9Cq0ncIs8exhL0eT00xep1iSxjuFEQXTSZWeeK5RkT/r0o73+Org8l07bL9GrfNikKQVbTn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnE8Vg7pn03+wymO05n1ecaPquY4jbUI44cMOKm6C2jymQCHM
	zKmbefdqiWLMxkcLy+lkoT5d9al+eKrWyZTKvv40rcDtPdM8EYvO/MOf6niE3Z14TytzYT5X2jy
	SRfF5UrTS4sMhAaQ089Pqy83zbGNzNxp8ibRcya4zSWuzz65uhsd6Wftq96xHzTU=
X-Gm-Gg: ATEYQzyDiDQ+sczjdKFGy2gX++7HDAyCd23AMJb1XMBZ3McytqUsfeA9r4u857UwoRA
	wtoHmiqRr0ZVozxHpuJsRNWM2TT5ElFxkHT9Vd49JK9oQJrDWRaFtS7ciRp4QsD+fSFvUyausTw
	8dqVhTtI0AFWNUPMIprej/AhF8VeqjG3Gv0vktFkCWrqg/bb76CTquS/RdPpE3yT/j822KPzi8W
	W7LXiRBepVsj6aoX+hE9X8SqKiAfG8pc+1gix0pz6osph+oE+WFuTdfHLHlJxvf7yiShddRv2jj
	Ban4WuDuPvgbcOeVJxznx3d5b3sXlADQWXdiu8l6JhOCdOjQxLt57J5ie3UR18RvXFMG/UMx6mh
	ru1BCcHGWvcI=
X-Received: by 2002:a17:90a:d00b:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-359a6a7a0a3mr3686302a91.27.1772694767667;
        Wed, 04 Mar 2026 23:12:47 -0800 (PST)
X-Received: by 2002:a17:90a:d00b:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-359a6a7a0a3mr3686276a91.27.1772694767145;
        Wed, 04 Mar 2026 23:12:47 -0800 (PST)
Received: from work ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d409b3sm870214a91.7.2026.03.04.23.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:12:46 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org
Cc: kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 1/2] PCI: endpoint: Print the EPF name in the error log of pci_epf_make()
Date: Thu,  5 Mar 2026 12:42:34 +0530
Message-ID: <20260305071236.23792-1-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA1NSBTYWx0ZWRfXxIJ4744Wg9RR
 VVaRSf3J7GZ84zokYzeR/yL11HeOAWKqsOx5jSpdMwjS0TaISJ65YtuzPZS1vY3ei15A8E7R+Dg
 iYg9P0v/+CjHkvRc2SyGEW/XRRAYUsKpuKqDWWiw+6hV+miN7EhvUOekgTev1vRPNsboPkRYibA
 JrtGTc8LXEaMd+H3xKexpLHU2OqbxDishtxbpSgYHkhFbeG1ygUGwiQpVmh2B9EMWBaDv9Yhskz
 9EAPbsrRx2BB6O376ZbuIGH8+3DcjQPrUtCjJhPnxkE5Bv2cG+v+TV6lbLTO5DoDvq2nXIY8m4I
 peHQVwvrJbrhqETUxxhuKtWqmJnLRyQLQN6ZGj2kn+2aA/EOi2qtT3i47oVh5StJSaQUivoPJ+H
 KJT2fthe2/Ray+tJ59BKRMt8bxo9uoGPqcwdxy3gv0z764bpWhqkR0aLTPBmMVjvHxDa6bALvoi
 G/z6BBYXtLTXqxPv+6A==
X-Proofpoint-ORIG-GUID: K3BJvsxL659wVM2zjdYSbDtQ4Ads9ELE
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a92cf0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=3DCxOJRDFJXil6P1jVoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: K3BJvsxL659wVM2zjdYSbDtQ4Ads9ELE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050055

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Merely printing the error log without the actual EPF name will not give
much clue to the users about the failure. Hence, print the EPF name also.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 076d115db02b..a19db22b7991 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -625,7 +625,8 @@ static struct config_group *pci_epf_make(struct config_group *group,
 	epf = pci_epf_create(epf_name);
 	if (IS_ERR(epf)) {
 		err = PTR_ERR(epf);
-		pr_err("failed to create endpoint function device: %d\n", err);
+		pr_err("failed to create endpoint function device (%s): %d\n",
+			epf_name, err);
 		goto free_name;
 	}
 
-- 
2.51.0

