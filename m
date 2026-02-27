Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39DD30BB84
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772161638; cv=none; b=dPzprTHf9aS4Xt6My36zdwbDqDoSZcu1ERadrFluLhsCBqeHyf3kzF6TEDc0/T0lsAuAZ6uEJOg+8devM9ypxdZVNEh+FUAl5Blw2pF8RGE+zPBPS8E2ql2nb8XRLyxFNIUzMKnB/zvKopSkgtIbWxVHccf7G7RByjdmz57MrgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772161638; c=relaxed/simple;
	bh=LwA5mnedTzlvaAUV61x5m6fTGnNuqthGFIww1JZHLpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GAmecjjlu8+rVnJzp2B5+5N4aWEjh79VfC3wSDni2frM2PzjSzf5m3zG+A2jnd3EGjy6ORN/mTtKU8+lFomqbC7Zz/YafHYYtkSqFfViqSgWeVO+65qnMLvTp8O9pT3tH20AgAVRtr9eWjHm5F/ndEXGa++4iBqSB+a/erRljEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cj1PUz8t; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cj1PUz8t"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QKZJ3C763729;
	Fri, 27 Feb 2026 03:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=lFsdDYv0E1/DXJXxa6KhxxlPE4di3
	xA6cb3oIdVLjxQ=; b=cj1PUz8t0vw5Rjz9iVKGNQcq2ZaJJQWlgpF0BZKdC9zH0
	ajmNgtXQdg6U7FvaHBcvAnFsz03iRw/MfA/dDLc1v4SbXr6FDOD2zUYkbwrCzhWt
	mcKg5BgcmvGDLKlX5JyLfs3rAZgJlUtkiNLrtbovsfsZSh4MJ6mAL4mhyNKg/kTv
	c/+17sWLcD+vMZQXbSh2UqyydN0PECLdoVpA2A+hAZGDpGCjs/urMKuTkcZudJZX
	WOGxFk7pX3PscZ97QMoX/y9xhekYpWTv8jcC7sGUjrT5uaixsULMQpkKLLe7b/3f
	T/6vNoOOITCjviaQhn46+t/ksldbvXC8GwwLct8uA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k61ffu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 03:07:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R1UOUW006331;
	Fri, 27 Feb 2026 03:07:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dj0p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 03:07:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61R373x8011351;
	Fri, 27 Feb 2026 03:07:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dj0nt-1;
	Fri, 27 Feb 2026 03:07:03 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kishon@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] PCI: endpoint: Propagate error from pci_epf_create()
Date: Thu, 26 Feb 2026 19:06:53 -0800
Message-ID: <20260227030701.40533-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-02-26_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270021
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDAyMSBTYWx0ZWRfX21/x8jOKJQWf
 KfhFs2tD9Am3lp1OZcsRgXML3Jjw2Odqid3dvvTtsxFIstisBPTSIM6Jv/LmC+UJj/OiLFC77mh
 VXIlO4wV+WJaqqetTMdMCabOgkajMmQ60wrr0D7G9NjFpq9WZgcyJz629mY3RpDrgvQY5Q6Qcpd
 lXvvzvUxG/VQTArdqwCVKMH9nj5N+a6MiBDg/r3ig18tIt6u6ON7L7f2+beoT0cFfdY7aufox/A
 Na2RtfXge/MFaBH8SiVdUvFqlTVOytEkuv48mU3Y9wamY5qfPSauiwDv+Ah+e5VM8DPizeZ/KDj
 h101PlRZDI4qRU037i3ChauUfGKHH41Ip+77j7gmJ5bp8509uhPRHEQkygH8rY/ewy4hJ9xVaXv
 +ZipRmDgHTKViaFsoedlvmxQxsHaxFxhsJPxrvSTHSrQLbL0G0HAhKDfsvpAb3oPduuOaA+EdMv
 ALC4qR+BvDrThvkA/fA==
X-Proofpoint-GUID: 3ttCBdeNSx2XV2_vrNcJ7aXkWiZek-n1
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a10a59 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=vY20Ln-xx2hFoXBo0AkA:9
 a=EBa_rOYxF3VBboPlVeQ_:22
X-Proofpoint-ORIG-GUID: 3ttCBdeNSx2XV2_vrNcJ7aXkWiZek-n1

pci_epf_make() overwrites the actual error returned by
pci_epf_create() with -EINVAL, which hides the real failure
reason. Use PTR_ERR(epf) instead and print the error code.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 0f3921f28f17..7ddf9e3c04d3 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -624,8 +624,8 @@ static struct config_group *pci_epf_make(struct config_group *group,
 
 	epf = pci_epf_create(epf_name);
 	if (IS_ERR(epf)) {
-		pr_err("failed to create endpoint function device\n");
-		err = -EINVAL;
+		err = PTR_ERR(epf);
+		pr_err("failed to create endpoint function device: %d\n", err);
 		goto free_name;
 	}
 
-- 
2.50.1

