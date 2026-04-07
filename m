Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3811E3B3C18
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565888; cv=none; b=FMBPz4giN4IQIW1iZBpo1ecsubEwekf8Dry8uNqgr2rFmruphwDW+5rGQdw08y699KbNy6nc1FCk5BdM+8i/i5m0ufoctGCil3KcVnU1vHGwsXj3D4swAnAaohPdCaeIyyPAxIJL9KsvvRz2IHBD3GltPWYR4vISTyDaW4CuATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565888; c=relaxed/simple;
	bh=D0TB0jvRuzPNWEFrFeMfVdBNym4lEMVlSbrtCDCSGSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP4IC0N0V9fgG8dvvu/iEyTUJ+iFvO2bhnmzxxf1kIOIkmk7cT5sBuqwlmGgV53M25dRkfoHDPaIGNUymqnJSLQyLBxIYm2HgsSVZM8IaCUdV9g8pjw+sC2oRA79+KT/TmUnITDwz3PAU+CZ9Y+FvimHUL3gpGgYNPvSEaHd2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9TzzWs7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9OWOMKv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9TzzWs7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9OWOMKv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376tmoJ2009900
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 12:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KcSF6GhUxpn
	hWCwDbVDLTRbgA+EkufOMYvemBFzcsX4=; b=K9TzzWs7MGakwir+T4NmySrzIWT
	uwZ9V6LGYz9nbTgLNtfK9EZk/2KFDlacwc8hngf63x9a2eZhxbpG95W+2ngwLdmB
	sM0sSkXuw3C7tHEq3J2aCv0b7IZuPNepdD8w2eCBZ8UOZJ0RY0bcXDO1ULJNFYwy
	ZpR+fuEqMFkQm2kM0qPqH6QxU7zZsnIT+bQdKd57PElvx5xlov+46AzAzhsPtZ/I
	MIByhIxtk39OB1fA3TAgNeT3lijgakYMs7Sv27DaqUCb74GwgrZXQsIfjt1sfq2N
	oSUzmzhNVyrFkDdd9wV6qPvsMNN0rxXt7tepc68T7K4dz8uo4pEjTpp9Bkw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrtrbh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 12:44:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so2276486a12.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775565885; x=1776170685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcSF6GhUxpnhWCwDbVDLTRbgA+EkufOMYvemBFzcsX4=;
        b=D9OWOMKvyYMKypWuqUlPnfjRB6/+WPixwulRn/C9LFA5LSrH9LxefQkcNMtC135ncH
         1zX9QUNMZ9DaB80M20O+ysHFFOx6m15ZVrwDJz67nSS/bxjlIxtjWNkNgHRAw/rE/g9B
         OT6OlRybRM3eDI+G3C4e5wQlRgz2DC5kKWkoUtbaZN4cMWz78AGBRgTv5As+tebGrRP9
         a+q4Ur/gt8CmitRISe3xXvilyibYw+DzZS2lcTxEmRZ+MhfZ+I9uAOmqQHRlgLCxQI7o
         nHYSUsU7r6jfSS/r0QrfV2z/GgqikEBIgYhBObODYFSYBurQAQaxIhIysdPGQVfPWFHU
         m48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565885; x=1776170685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcSF6GhUxpnhWCwDbVDLTRbgA+EkufOMYvemBFzcsX4=;
        b=YmdC/OTjtfXzqRUUuNPEm49AyqEH0IJiAXnrz2hTIOWYgPWo0GySAp/qjxfHcFoF2C
         EsdnRsa6w5TtrEZsdittb9fJHXFxAugMSjHepnSpJGQj72FwygIfQHpEQmXhCUkk+nzj
         JL+4cD0ofgZlaUsmGbSMyxaxI6aztWuMWXuZfowWDPTkDjsq2aZ0N+Sr/pCKgjGWqKaY
         iYD9rzLULBH19+OFHxLV4N0Yc3PB41e1/ReVYYJubG7ChF5+8pqV6cyHdxt5dE/ZaY4p
         cdrUpJ+rU6snkt4QysKFoQoM0zmFWdepfe8yFMKFhErjG9D6OZf4V786RA5to3nBQSAA
         oCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUjDV1vDEEUMVB4BNWWT9Ts13ITSA8MRDFu1eSe8KnZ6BZZ1Sd3S3z0KzqUWV9CHxyCrbU7YBfLILg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjMXDqN57g4PPVT6w6UijrzxnaXx3dXERfdb6SqRUVAzPtzDx
	sUyPd9hh0fR4T8CruX78rLwSEeSo+fBROl/fkLEWeXWoRXPqPaUFoO7CISnxaaKB2mJJXpJkaB5
	vwH5wWqFIUhyOqJClmPB+fbIYDyQrNmEl7RBlo0Eu3zZb7sUp3OQzIBSSQ+PXgSI=
X-Gm-Gg: AeBDietM1gvD2y9SLaaQry4b/0DAoH8sET6AixjteFxnRvqY3NZbUI5qNc3lMl8HQqE
	kNdRJy9mra4axkJVmLeD3bhJiQl0AbT2DdIbi2PfrRgqbTXGY8c60t85CGp9IpV4PbI6SGA3Rm4
	mbSClP22mLjJ+qvSE3kDVQ/2zhhIIHHyQpvaMx7jXlJZXiKR0TUXhmhvgaeFAJTzmpaMlXYhqec
	V3VNbTYbaRhAtWPA+BHORDrt72p+lWZoMyQCthDhI8xwlSBHS8ViB0olS+D+vQy8pdKNBT4GImb
	/q5gesbD/f1d+pUo42zCF3quxjMWxDVjmynyNWG842CUIxf9m+9H5g+cnzwSKN8owdwCgJKyR+v
	eLB0VMw==
X-Received: by 2002:a05:6a00:a0f:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-82d0da33e8fmr15483564b3a.8.1775565885130;
        Tue, 07 Apr 2026 05:44:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0f:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-82d0da33e8fmr15483524b3a.8.1775565884435;
        Tue, 07 Apr 2026 05:44:44 -0700 (PDT)
Received: from work ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm18262551b3a.38.2026.04.07.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:44:43 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
        bhelgaas@google.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 1/2] PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
Date: Tue,  7 Apr 2026 18:14:20 +0530
Message-ID: <20260407124421.282766-2-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>
References: <20260407124421.282766-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOSBTYWx0ZWRfXwFypcZNOQGSK
 6yTjW6RCTsQ4IVQ4q4zkzJP2RAohWIwDuX+iQ8ZbK1fB/kKMrdYDxEu3LcrB0nLdkSyVbajcN7N
 +Ile5X4/zwuyFrtOMTOPd8wpsbtqf3urLbcurkjmiCl9EpXpyUTUageDpyEGJaPywav4VKipzvN
 Iwxwlgk1zxnbIx8FPqHwFDgkJJrxHpQ5KeOTsoGWgmQOVJH5KSAbs5LlI//3t7ZoPZjAK/73TnE
 c+I0lh8kem7XY0rY5mmL7sYJgR4ph5K1E7IBMvIb0aCx4M9C0n2fPxG6wBLAg5C6gaQqzWVH4L9
 dXXe1iH9RjIaZUpwmM4UiisQbGTrxDgOHWbxoqS97asfmWWd8LjXi8bxkmRjBkJxKYkSTEthQkB
 gJTkGdnILFNgslPmlJXmAU9QLLo5mLyrfQFYwEAExQ5416YQ9AJzPxBXA8cmnwH3yaxdT01h/AW
 x+5dNqlMem/NTQAzzjg==
X-Proofpoint-GUID: ql3heDl3LxYvV8klx5KQ9WADbjt7gZVI
X-Proofpoint-ORIG-GUID: ql3heDl3LxYvV8klx5KQ9WADbjt7gZVI
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d4fc3e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=PxpW6Q19wR3HJFGb5M4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070119

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

epf_ntb::db_count value should be within 1 to MAX_DB_COUNT. Current code
only checks for the upper bound, while the lower bound is unchecked. This
can cause a lot of issues in the driver if the user passes 'db_count' as 0.

So add a check for 0 also. While at it, remove the redundant 'db_count'
assignment.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 2256c3062b1a..3d30aa4dbb84 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -483,7 +483,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
 	struct device *dev;
-	u32 db_count;
 	int ret;
 
 	dev = &ntb->epf->dev;
@@ -495,14 +494,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 		return -EINVAL;
 	}
 
-	db_count = ntb->db_count;
-	if (db_count > MAX_DB_COUNT) {
-		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
+	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count %d out of range (1 - %d)\n",
+			ntb->db_count, MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
-	ntb->db_count = db_count;
-
 	if (epc_features->msi_capable) {
 		ret = pci_epc_set_msi(ntb->epf->epc,
 				      ntb->epf->func_no,
-- 
2.51.0

