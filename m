Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4E3AA1A6
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958379; cv=none; b=SmoS+eUAzf5Yk6vWbCDq90TMxoAA0TDjQMWD6pxBGc/n3rwqUgAvKyfOg5LB/AwRTciG2AzbzvxbgZO+jvrt183+vDMdNa6eMldftQ/bZakhkKvyz5ucDikClAz6OvQFXktYuVmw/QAG/oZumzFAk/X9WBpADtUm17TGrSNaUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958379; c=relaxed/simple;
	bh=HN+ij10L5m/h+Y21F8Dl3PX41gzfd0MEK7lBgnpNJ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dl+n1yaZOuXAcYHAzQJtFdwCinuWfO1VDqlYXCwxwPXJRWoMUEb7C8/tTOMenqqeBhAe12biMKeWvgLaMsBCuElXTYfAVsU3CpUTbzU5PwPmpYl6I5CGczzhjOOaKAsgiQu4GnZLLVa9nGATK0X5ktkwAfujaZq341SHGBHd7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4ENpaRs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4ENpaRs"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OEMoP64097381;
	Tue, 24 Feb 2026 18:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=U98XZG3PE+W4uBPJHSC0P4OHu1pCc
	1uuHcI2j7IpHik=; b=l4ENpaRs6rD4/4NyWv6ALF4izMVNcGwLEHdB7vePHnLrS
	T4SlobXj2WuCerdTBXZOFuKBgS7gH5vJ2LXXXv2+mV969BZUUU4hKJPCoPFm3eAU
	Er8AmV4rU97a7ustVEIby621xIHFIjOlDEVssK1yFpIicVmJ188p0GyZFrK1m/QI
	ReMMPdi9jV4pb35dSOnxA0GyWhDoABQJwwKFwiF+BwjMI7B1ZPmlMovV8OUDPVKR
	1Mr3sL5M6NdVfptuV3Dua9ybpP0i980NmdwNWAaMye3yRTLZIMQaGkFr9CNEhaBc
	y3YilxgC8bukM9cGHBeIophvGnu+71cn4L/1jxrSg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5vre6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 18:39:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OI0gBZ028500;
	Tue, 24 Feb 2026 18:39:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35a2hq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 18:39:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61OIdTOF033075;
	Tue, 24 Feb 2026 18:39:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35a2hpr-1;
	Tue, 24 Feb 2026 18:39:29 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kishon@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] PCI: endpoint: Fix typo in pci_epf_add_vepf() comment
Date: Tue, 24 Feb 2026 10:39:19 -0800
Message-ID: <20260224183927.1369124-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE1OSBTYWx0ZWRfX1ul9uNZDGzU9
 UYNuct63sskCni43NU+6KJWCSYzdbRroTbFP0TPArABe89XQ6iA4dwq9l9cZp2XKpkMo0I4AY3l
 w/cSdGftWc0xEDi/TTQzfLI/j9XaP+oJn8qoPVaMpxwR3dyBBn9VUkGnXyHRXmYEN63FwzChNRQ
 A4xUsLuQRQ4fCzxs4GU5T5V9EbkKueOFyefGhSZbETTNmNpewwxS2QukX92a6XpIr7rWjHpC30Z
 jXP6F0YKtx4eqOQdUbMnmF1LlxAypYkB4np8feWqM2CdMklSmBGf2VVi7id3r1p71glONoMHQ33
 aijcmF47Y+QK+59Z3NxR/0KdyKm9Cm0lMQNNMfAeg6XSn8AaFVdDtgf91mNNMY8k0oN9VQpuLbw
 Lqu8dES714lkFHk/e7GFUbNSf9iD5nB1p2W4h6IqJ6OOMhIIHByO3QaG6wsmFegfZ+YgmIhcfeI
 SA7yUL2xSP3JAjUvacQ==
X-Proofpoint-GUID: 9zuObMnZENsjbTO_FM3ox3tYiCaxWPAX
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699df063 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=IVrYRDEivXVJGjHDVmUA:9
X-Proofpoint-ORIG-GUID: 9zuObMnZENsjbTO_FM3ox3tYiCaxWPAX

The comment refers to pci_epf_add_epf(), but the correct function name
is pci_epf_add_vepf(). Update the comment to match the implementation.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 83fd20c11238..6987343c9e61 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(pci_epf_bind);
  * @epf_vf: the virtual EP function to be added
  *
  * A physical endpoint function can be associated with multiple virtual
- * endpoint functions. Invoke pci_epf_add_epf() to add a virtual PCI endpoint
+ * endpoint functions. Invoke pci_epf_add_vepf() to add a virtual PCI endpoint
  * function to a physical PCI endpoint function.
  */
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
-- 
2.50.1

