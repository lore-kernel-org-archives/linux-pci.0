Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470794;
	b=ULmX3Fz6fXDD9EwaJeLjDtMYrRUUEs43kscRjnaV5or0Ys8YaKjr1viW3kVLDu3ie1za
	 MZxSnaR0m9kT/k5KWUp+5qXZPhisc9tiaO9rRsMWhE51xbFYqfTj8d0fDcgasGHy+JPWC
	 6fBCaRDMXT4xfKUuWT6OKeIiF9B0fzjCDuRpZN7/r5zI9cvL2xymRhwb4V+mEgjOE1OZH
	 s3d9VbXZCBkBIv2Qa2bqkHiTzu68qdiYI2lvhwVYL1WMB6kOOg7DJpxB33p9wz8YB27u6
	 6zAbTP8AX8mccegL1LCVotXwmno0W7bXbyHLpQCveDUeH+pjn7x3pnC1Qh+zo46UsJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470794;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/gJsuCKqpHJ9TJHh5ijuLyBqzufsJ/gYOMhXSp5r3a4=;
	b=hQxqwgpMdOnnOqG75Lbql1eFkwH8eDqwM/DS41bxrNMwj5y0ZwSYju2B8tBqcg3CdKE/
	 Q4U1ggh3qSJboTxQTHyPIbPYLE+t+S4oJIJDcvRA6GBG/mNYAppM5Cxz3aWp5KOR3s8z0
	 bt21yiaoa9aDN1mAZ2rkPlvwO0sU9v7hDwWy23Wryi9S6gF/EAJxnx4tI38JEKN8HPcir
	 arP0rkFLONiN0Hae2T7nUuDXO1KdlU6dDflWWqxveYkvZ8G+I9rVh2oPIpl6Hugzv8CbK
	 9VMx+rGEeh35lAEGL6YdNCpf9OQoQGu0lpysvW1xYSx48hsY+08pNeBc23nOr1i0fvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Auz2Tj6A;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58764606A31E;
	Mon, 23 Nov 2026 21:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58764606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Auz2Tj6A
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANK4UfR2945333;
	Mon, 23 Nov 2026 21:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/gJsuCKqpHJ9TJHh5ijuLyBqzufsJ/gYOMhXSp5r3
	a4=; b=Auz2Tj6Apt/DR+tBnJig4X8l0iZ3OwDj3EQApK/xXiQLgOrFT99EReiui
	s0yYMaJdAvcS4+mWmxdF+wo8Ag+nHzdQkwhsZdJCGXgVefEnEVAl9nivMSRkD6ht
	MbFj34rCh9v8EDrrhwF9jFTR05L6gxCbkiZtIbwkE80rJQHPZtXSV+OCShcs15ky
	DHBRZQleZ2jl+fDaXtV1us5ktNUBtqMeP6A3lCVuRB7ZtJJTXnopvrWm904iktsn
	adFQydKfxb7w53NBLaZt5tEmf4RBnWWvP2MuZVRYDfQKd8dmtlwz+z8rzUG8dso/
	U0uVt0g3IOfT6n07PHrHBb98zZVjg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3559h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 21:53:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANK4QgD1244336;
	Mon, 23 Nov 2026 21:53:11 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufr5vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 21:53:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANLrASx33423962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 21:53:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FEEE58053;
	Mon, 23 Nov 2026 21:53:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 151BC58043;
	Mon, 23 Nov 2026 21:53:09 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.128])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 21:53:08 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Cc: lukas@wunner.de, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
        gbayer@linux.ibm.com, schnelle@linux.ibm.com
Subject: [PATCH v1] PCI: Ignore Immediate Readiness for Samsung a826 device
Date: Mon, 23 Nov 2026 13:53:08 -0800
Message-ID: <20261123215308.1285-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b04b5c8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=xYS-XvfxY5Lkmk89MPgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA4NiBTYWx0ZWRfX3aoCSBJq0cHk
 4Z5CCY6k+EsvXF6+2lxSmvQt56efTU05aAs74LjDe4kt5qrOJUAIXTYNA8GeF/TwVDXmL/zF2Vo
 GZ2Uey1/R5Td7MdNYgJp+hgncz0bUNc=
X-Proofpoint-ORIG-GUID: WUFjfQp0ckMP72XsQpv2U0GkO6rD2cND
X-Proofpoint-GUID: UTdVSLdNaXLhQroqfcEmFC44o0araxt0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA4NiBTYWx0ZWRfX1zjZOsfjiH3M
 pR9Nqr3ERJnOfZoSiOEYz5RZd223Xkvc8b+mvAAooo8q9fh5Qz/wjxJ9lVDdZA5TUm6P3lC+FLo
 DG0YBLYGgljNuwMBh6tOQjWwy90ZJjPRrxErKMcT7fW174U5ZOPHRA9mYlOnOjK4iipUDqosPef
 PVT+XkCqwrEMKPeON09DXL5OgjS3UOp+KXB1mnDQkgYeYS99eLbnpF1REy0RX+k1cIFIVFdsJ/x
 l7NPAUHh5yr19WrvAxn5z+Pr47iTe7oNOa28e/R9qCYbFWMJX98zb4fl5pP+yxlciYPL0MTdHKG
 /jOPCXh7G5WVlTmVfmy7wuChvthOVT6ffsH57FOOPJ3nAdRKE67O7+IFiUWV6RGyfuikiIjJVgL
 gns85dDGgMVU0OGZWwtqe1yJsGP+u08zLLayjC5roIQ78j621BtWNVro5I+yHhSlhQag4KIad5z
 udwlMqtl2DI6oTfPudw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230086

The Samsung NVMe SSD Controller PM174x [144d:a826] advertises Immediate
Readiness, so pcie_flr() doesn't wait after FLR, but the device isn't ready
yet and config reads return ~0 after the reset. This happens with
firmware version SNA6SNA6 or older.

This was seen on s390x with the nvme driver bound, by resetting the device
via the sysfs reset attribute:

  # echo 1 > /sys/bus/pci/devices/200c:00:00.0/reset

  nvme 200c:00:00.0: Unable to change power state from D3cold to D0, device inaccessible
  nvme nvme0: Disabling device after reset failure: -19

Ignore Immediate Readiness on this device too, so pcie_flr() waits.

Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4a02fc80755d..11c3b45afe78 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5790,6 +5790,7 @@ static void quirk_no_imm_ready(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80c, quirk_no_imm_ready);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80d, quirk_no_imm_ready);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa80e, quirk_no_imm_ready);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SAMSUNG, 0xa826, quirk_no_imm_ready);
 
 static void quirk_no_ext_tags(struct pci_dev *pdev)
 {
-- 
2.43.0

