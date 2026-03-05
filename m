Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C683101B2
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 07:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694774; cv=none; b=qIjJHCcVUQ5/jrZIoGqF4oUOLd6CoRDxXhrhB8Sce0a8b09Gy0AG5qd/W7uBuyyj5ryvqvGtz4nVGw6dWhvcAb2+YqachiO5JTeZNgJKozgs3TrDKLSIJHUwrIRkkpBtOy3D6lGDJPIZ8MT7SajjlIsi5ALwecOHJAJSthyqi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694774; c=relaxed/simple;
	bh=yqcWMG+UFuJhqw7Kn4NxSdkkBByL8yzFPO/N6izURMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBYXg4EZtXyddJQZc4LAXGP0fzCLTm3M4jgnSs4wq1m8tz/i8RNYHKJL8oMh/j1uNMtoji4DlVM1FThxc9bWKg61fzYWBsu3BUjT8+AGjr/+JdxWOOt/Fhc+UYyXEGwg+Nj2pIW9SMkI9ERtgZBCY3Xc7rtJmVxI+bV1+yCHKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvT6XK+3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CwlOz9eC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvT6XK+3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CwlOz9eC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6254K2k91852690
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 07:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hFm1KLFglkA
	Ai97JZ8ZrNe+roA+mXMLTyIJBkUzj5oU=; b=LvT6XK+3cpH6zwUCq7ThyduDtlH
	hGns/CFidUJB+7Bao+j38FB3lVpPkm9kZeX5oN/NbWmHIeMGLkz06xamB0diJLZ/
	j7yaFm1mw2UfMN1PhnS3Y+X4i3iHPJCkd6wIt4bsjFVdCQnuGhVgVVbFr36SQx3p
	bTXNZpC+VU8Q379H5HHEsQBg4EJzEbt686HaVvimCZJsu45OSUPQcdK3/5mabZeN
	YMdvtbDzsenJrr+M579lLRHc5GQMLtFwCO8S3z1FeZjYClcPjC3Cp0HnucWHc7E9
	IAEm6l0yCuZdyQwphPQIHZGfGJ1AfqHZVQf4KMm9NwEgujLoUrkxyS4X8AQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq2q80g79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 07:12:51 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35980a994d6so24048242a91.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 23:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772694771; x=1773299571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFm1KLFglkAAi97JZ8ZrNe+roA+mXMLTyIJBkUzj5oU=;
        b=CwlOz9eCn/fHhRgBXJvZNrbFdf0AeT+P90Q8GWNokGhTm7kvRW71Kqw7SmaLR0xBta
         rUUnFGPhsxuE/ozxxGEaFC1QxXaQqMUeYJr34OzsYOW2tbypRzbnmokjV0+MJ2U/rOEj
         fs1KbLPoADyA8rWeB1dnvRmAx7l0cOfdXwfXyAdWyFLpBX/2+tPWyJyPDpuFM7RQ5VTe
         HVJMlt4VG0W2HEBBkLNHO5KGMy4OD05EgVCgNdz6/4Fie5T4VqiSexoZJZX7FpmLDtlg
         79bYhhz2nleK8BSCp/LKOvr1BL20OIPG6O4EAnxOwrk6YbEVywrKnExDb+Yrdl98s47f
         hMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772694771; x=1773299571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFm1KLFglkAAi97JZ8ZrNe+roA+mXMLTyIJBkUzj5oU=;
        b=eIEIJPDzaA/dQ6Gx6amq3q4+oIos++N9yYMerUg3N9zEQsn310Q8kCVzAjibUotzPJ
         5TpwaMChX8i3C3ZYr9wYTItOSHyaC+jExIKhMORmWFe49xb3tkTYZIC+7QVXPWCsKA4u
         aWl+zGyg8nx9H1HUf2xRyBb+wZem4BkPjriiYGnQjwnWFC7Z2Mb1CRVEcvDdOXJL0ul4
         K3cIHGf1Kss/XSc5gp5QXXsRB2UEt3d8TqMypV7snvZ6jRhXyIrkmQLbD8sEzJCKDW0Y
         lOWKnIE1DVxmTEo/QWrYyLEcZLQJhpFZp1y4fF40otwGp7/r1pWgdatmaSNzK/Rwvfb7
         1oRg==
X-Forwarded-Encrypted: i=1; AJvYcCUOQbvox1EkyGaGNPG5HbBWDR8i2FstAmfwBYDN463pm5b3/iparv2ZKPqG+FP6rv49Orih6whjLjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgxnk2ScY+1bcofPK5W5wBjwgPl0HDbAvhTQeWMp1ZZ1Xy/cOp
	QzHRarqEh+ool9gD+cgHEDLKoVQ/TkDlwjG41T/uqN5w52HXbV99pl1T1JA4opISm0FQHqz4UB0
	95EQ5ItslffZEEwAx9ucmzIwokteddkRzFRpy+t3F6qPdkh4oVJNJXzaMNkqQDOw=
X-Gm-Gg: ATEYQzzS5buhFCnFBpZAIRE02a46GnucpF/MmfBeo5hhE9EqEvOmmm8U3zay1HAh6jW
	Bu0DZIB/XaFDl6HkRVkuy1qQQHJMGSX7YPufYwljLLicreFHTdDJFexAMbY3flOp9SHiN4SMLpG
	MJn73T6E4EyN+Xfxjcqz61Aaix/9ATPKiZ9Sm/F5Z9OiQGTR8+t1BPRw8iseIhiVsn4a5JPqmZH
	3I0WzwKa9zw2wozu1H3PGGJjAhWuT0mg00eqWCI6TYpmA0eiXbBAiaRpDfRvlEp+C5EnFt+DcH0
	FaWly0R7a8i4DZUB24Jt+wXwC0Y6pg6xeDR/kfpTBBhDwWcDVAsGig9WG79ThzODtB4LnJGWvnn
	K5hzD0pd0Svg=
X-Received: by 2002:a17:90b:4e8c:b0:354:a662:47ff with SMTP id 98e67ed59e1d1-359a6a851a9mr3957559a91.35.1772694770961;
        Wed, 04 Mar 2026 23:12:50 -0800 (PST)
X-Received: by 2002:a17:90b:4e8c:b0:354:a662:47ff with SMTP id 98e67ed59e1d1-359a6a851a9mr3957531a91.35.1772694770419;
        Wed, 04 Mar 2026 23:12:50 -0800 (PST)
Received: from work ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d409b3sm870214a91.7.2026.03.04.23.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 23:12:50 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org
Cc: kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 2/2] PCI: endpoint: Improve error messages
Date: Thu,  5 Mar 2026 12:42:35 +0530
Message-ID: <20260305071236.23792-2-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305071236.23792-1-mani@kernel.org>
References: <20260305071236.23792-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: niZDwuXGytm2Bws-m67gpt16_jIlh2Zw
X-Proofpoint-ORIG-GUID: niZDwuXGytm2Bws-m67gpt16_jIlh2Zw
X-Authority-Analysis: v=2.4 cv=GecaXAXL c=1 sm=1 tr=0 ts=69a92cf3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=xB4wU2afyiWPp1UU5fEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA1NSBTYWx0ZWRfX/jZEdiC1wUU0
 EoyrW0acNjCW7OpNyFj5WaeSyOvGy98l/2rMlk18Oil3yq4gcK+ao3gvFG8hOLcaUYXA+B66Bmf
 f9NnaORC2p8zbedAe9f8Kljh93IeUxhnRHEiNWzr4W/6QDHvCVfqD7XLZbMb6kPewT4ziSaghiP
 k3WkRx3V6gFXePbvChFkJyCIOnQLAud/Gk+SQUEx/deNUFmTpYwBZmwuvNNAhqZBuqzv3gQsAAk
 1G1tIbULoVejsMAszZjfXRu1moTxHR+O6JsCwZ8szi3JYSNYow6L3Vwj7EGQvOQmsPyxL5MHTE2
 FmSLzH1iMnuVhZAhLRn4WuFtL4hdzhn6rCvllprVbltd6vjiBEs9fKvwRHK5hxN/If0ZLpopwpY
 lNuNrfH4GYj/OQUBDpd04Zinys6zT31JX50qcE282CueU1eY2OrGkQ97rjAaDr2303NgaVHp0yW
 xWnIuK61bma9H3Pk40A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050055

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Include errno in the error prints and also use dev_err() where applicable.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index a19db22b7991..2d2efd444b02 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -565,7 +565,8 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 
 	if (IS_ERR(group)) {
 		dev_err(&epf_group->epf->dev,
-			"failed to create epf type specific attributes\n");
+			"failed to create epf type specific attributes: %d\n",
+			(int)PTR_ERR(group));
 		return;
 	}
 
@@ -578,13 +579,17 @@ static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
 
 	group = pci_ep_cfs_add_primary_group(epf_group);
 	if (IS_ERR(group)) {
-		pr_err("failed to create 'primary' EPC interface\n");
+		dev_err(&epf_group->epf->dev,
+			"failed to create 'primary' EPC interface: %d\n",
+			(int)PTR_ERR(group));
 		return;
 	}
 
 	group = pci_ep_cfs_add_secondary_group(epf_group);
 	if (IS_ERR(group)) {
-		pr_err("failed to create 'secondary' EPC interface\n");
+		dev_err(&epf_group->epf->dev,
+			"failed to create 'secondary' EPC interface: %d\n",
+			(int)PTR_ERR(group));
 		return;
 	}
 
@@ -675,8 +680,8 @@ struct config_group *pci_ep_cfs_add_epf_group(const char *name)
 	group = configfs_register_default_group(functions_group, name,
 						&pci_epf_group_type);
 	if (IS_ERR(group))
-		pr_err("failed to register configfs group for %s function\n",
-		       name);
+		pr_err("failed to register configfs group for %s function: %d\n",
+		       name, (int)PTR_ERR(group));
 
 	return group;
 }
-- 
2.51.0

