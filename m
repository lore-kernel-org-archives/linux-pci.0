Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24538E5C0;
	Thu,  5 Feb 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291079; cv=none; b=bEl8TwzmvNIMLxEVt/JWabqbXu0E63BRapbWI8C5WgQ2Uaq3MJqfpJj4jOZS7oCwQzs2A5PL6BUo2PQqUznWmbYM+/BTwBy5er/QWPLEnLZ5U+SzcC3bRt1Ar4l2wXjiIrKYJ+fOpiuTLv08Gy8tneyX45OUZiAoNt6iKSA8H1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291079; c=relaxed/simple;
	bh=fexzGZz6Pncc1oMUxii0gGwY/bNzp9pUg+u1zaVu8/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9Y9xdZukg/E5OgrA7qCMUKuCy9LXg5nsHEpt2izV0NFGElZ2+6P95eDQGbYPVMZUBuF0H6esN2IfiS7+LwmcDDx5p7A+68FOEsYYOHswHdQWCjWMuhR43U67FozBGQLJ1ltdhMHaiWkZcenIA5KbIubZCNRlHyilYLRPYKfX2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vc8rfbBD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vc8rfbBD"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614NPFZK2146411;
	Thu, 5 Feb 2026 11:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=d9qhaWwjPfWk9yDELRkJqM5DNFZ16
	5Vo3crkEECMTxg=; b=Vc8rfbBDJafm/n85oNLItKRC+9INTOH5MPofxwK0wSznu
	OX6U4DbdwY7bgEwkogj+ilfs5n2xLc06KNMmwi3D1twDAzEbGKxuWmyNZZYpPElH
	cX9kRcP5iBSsEnM1So7BY5+i6C9oKUfy1cgUJU7QaaaHiGgMbS1WavjoZ5y+K/GN
	s8NtElyYyB8KTZrONvCICf72LeRgcCACZOEhLEOJfJ5TY89fOSu7VtuxiEGLbPwb
	RYIJWfcGIni+4IrcTk7dSE0R3O+VMMSlU7WiwEd5uCgEjVMJUSone3DmRzODjzO3
	ISeU3sxd8CTFZ5t25FT8fsN/smRgFWB8xEG+M8xWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7ukea6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:31:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615AVOvG025774;
	Thu, 5 Feb 2026 11:31:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c257bng3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 11:31:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615BVAbT025431;
	Thu, 5 Feb 2026 11:31:10 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c257bng28-1;
	Thu, 05 Feb 2026 11:31:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] pci: endpoint: pci-epf-vntb: fix num_mws in error message
Date: Thu,  5 Feb 2026 03:30:37 -0800
Message-ID: <20260205113040.240354-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-02-05_02,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602050085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA4NSBTYWx0ZWRfX1WSwR3X31y94
 LAPDdcYTiCfoR2YZsJB0bph6uj7+026BGof61Llpwulq9wQpEMQ31tocl8StBQlqqp/axrTHL70
 wMnnmhco28R1NJZVwm1IrVQ0YwAfzsfk11dMuIOZ7RYlSztOz99ESU1rtl0OZqU3Da7J0/2svU0
 r9eT5ZQN7FSQTfhZ34VBNboZGRFf0sG+kDJBfOoGBJ9glPyRsb3y/OycvO9UpZGa+dAe3foYZG1
 xST226+e+w3pcC5oKM5cHgLYZdHNkSyTSgtgxnkn010N8GdrOd/LMWva9aO1ZmfKh3OVAYFwokk
 kTteesVMUPVIwFjAHdy5FjQnIl+cOgHtJwhAyBMHEhhkk0XkueEoUxE092w4fe5bpF5a5lvZynL
 OJHhsggypolbTE7jaZJ4m2b6pjzFdFtFP4QEspQhloaRTHIxKxFsuZHbPJ8ntjM/Pl5ufnPQ4Vl
 BT2hU04OQZnRqKFwfJZt3961EhgJ6xubSu5taFwQ=
X-Proofpoint-GUID: x4houp36_6yALMQZ9s9ubmkgPVajtw6o
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=69847f80 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Ir7HKfsyF8gGHMTlXBYA:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: x4houp36_6yALMQZ9s9ubmkgPVajtw6o

Correct the error message that incorrectly prints "num_nws" instead of
"num_mws".

No functional change intended.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..c2fd31473f2e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1001,7 +1001,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 		return -EINVAL;						\
 									\
 	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		dev_err(dev, "Invalid num_mws: %d value\n", ntb->num_mws); \
 		return -EINVAL;						\
 	}								\
 									\
@@ -1027,7 +1027,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 		return -EINVAL;						\
 									\
 	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		dev_err(dev, "Invalid num_mws: %d value\n", ntb->num_mws); \
 		return -EINVAL;						\
 	}								\
 									\
-- 
2.50.1

