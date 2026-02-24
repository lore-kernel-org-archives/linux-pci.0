Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EDE1A9FBD
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956885; cv=none; b=AJgxpBrRQ1vuKDDb5LAQglzIHJyICUVG4L7tvTNpU7LX3zQmyCmFoRJp+zy+oyEdrm8Bn/tT1WuXjuW5mAMKs5E9//sTSFFuNHNIRPtHdvHXKp5ZuvdqKDlH8GvTH/WT9NOT+hIrh496BsdnpwGr2muUUe6HrppHKyxFd8yCovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956885; c=relaxed/simple;
	bh=MQj2S3e1F3t5FC5SCe+RUHynrKOD8S79Ny3lhbIYBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrVh1b27xK2YSgovrPUD6ge6cilQIvov4m8qz2PHvoG5BY2cvMkMwyELS0OvOlOQp4uyrTxd+AHzG5HLZQln10QZspjp7Pw1IQyEtaad7/bgLM0tlaS3PONPESFvFUHsrrqisAFXtucrdrW0LSyKqsRytkYNapaIIp0tLqJ+/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LJ3RD3V9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJ3RD3V9"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OENJkc255766;
	Tue, 24 Feb 2026 18:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mbjb+48+gFaeU+wf7ajFGXdjQWFRi
	k6wWW4f8exMGVQ=; b=LJ3RD3V9PIFTWMQf0d4xvnInsK1O2LfQiXDDel61gFAMh
	In7wQM1eltbRP47TXscO7XGULy0bRrn5BXuMcXw+2GZMde4QqxZREL72DFBjXNE+
	BbBAb5jlazlvUnfn4QS1NV0YAJceIBFYyp4z8wtSiqKKhF7LYPLTqGNpf1n9iTX4
	hqRLgZI/LHYg8iPHONsMvoYg55MA9Yn0nE0LxHMhBDTUhqHKxq8d/qetuT2LgLcr
	iOfDmwN//X6Si7fjm8KzMMl6SJPUTSVCNWKorVo+xxENNBFz+Wjd//08ymILqHoX
	jP58oihlbmgW3yBrBe/8SqBmK6RUGwcd/GLatpMyw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf34b4sdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 18:14:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OGgqDC038593;
	Tue, 24 Feb 2026 18:14:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35m9tfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 18:14:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61OIEbZ9023188;
	Tue, 24 Feb 2026 18:14:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35m9tev-1;
	Tue, 24 Feb 2026 18:14:37 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] PCI: Fix incorrect retval type in remove_id_store()
Date: Tue, 24 Feb 2026 10:14:29 -0800
Message-ID: <20260224181434.1368066-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240155
X-Authority-Analysis: v=2.4 cv=GrlPO01C c=1 sm=1 tr=0 ts=699dea8e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=7xk7LeN0NfqzieiekaEA:9 cc=ntf
 awl=host:12261
X-Proofpoint-ORIG-GUID: nMCl0ZPUNVpmHlVGqJ5nlEl_nIxw6Zon
X-Proofpoint-GUID: nMCl0ZPUNVpmHlVGqJ5nlEl_nIxw6Zon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE1NSBTYWx0ZWRfX2Ynt+5QGW3rJ
 QqJRE+ZwmyJDpNRyHb2lRrAalqJOCU2GsmunDOFZetV5K1ih+IAzmd71lGKNWu6TG04JDJ3fx4F
 BYZE/z77Hhu++SFsjXV1GuCOLnGFhiJJaNG27ouFkjEjiHZq2AeoENIi06UwQRaJTKH94XEcD1W
 BG+T0IBUlQxTfF2dCkdHPAJYHpTNPSWdkxUxBWEyrTAdM4q3DzkisnNVeR8YYe8AeSG0YLqmXuZ
 9vIr67rBlzyvPvWHOTkctmNACGfnSTd450f/n/DqwdQTCS27n1ip4MlUWzu6mnX5ce0X6kvgLyl
 6ezCp9IyR4GbQwecEeFVkNWCyUbakuid17GcN/nz2+VatYithTlahXx9GnLAoVDigMnWhvZGdqq
 2/YGSCsz+xwYtdp7QPVRbgFKNRN1WpSzYgXK9JHFGIAftFsKABarPQLIBOwbDTH57e8IkPsH3bD
 9qW9F+MeO8WKYovWCw2psEG/AcP9ekyBnWeqGdT4=

remove_id_store() initializes retval with -ENODEV, but retval was
declared as size_t. Since size_t is unsigned, the negative value is
converted to a large positive number, breaking error handling.

Use ssize_t to match the sysfs store() return type.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index dd9075403987..b2d3dffcc4f3 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -261,7 +261,7 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
 	u32 vendor, device, subvendor = PCI_ANY_ID,
 		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
 	int fields;
-	size_t retval = -ENODEV;
+	ssize_t retval = -ENODEV;
 
 	fields = sscanf(buf, "%x %x %x %x %x %x",
 			&vendor, &device, &subvendor, &subdevice,
-- 
2.50.1

