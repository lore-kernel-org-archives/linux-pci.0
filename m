Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664035;
	b=Paf+wjgB/J7FT3kZDEZZhyAE16efUWvjxfoz1Fap3ul6JynVnm83IYYj3JcGesKxgVmg
	 ZYMkG9s6Hk/UM0O8wCVIC0LSOqnKSk1mHwh8R0yFL4vF1/BLnuVqNNpJHWMQzhDA+S9Wk
	 mO2nT6zbIhN0MDRZwx5FZBSmPSUwUjMVyFfZOx9IFjVahezp64uMjUPgLK869fIWqL77d
	 pUpzwnSanwORzIeMKvMlGY/zbB2sRB/MS5bfzBXlg5yj5l5+eD6Ha0stel4AekJ7GYHKu
	 3EXm+Kkn/YN5ARyfgRK5j5EH29acWVxMKl2Yr4HffGNgpBqNAgyjzmgpXan6EZJzvXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664035;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Yc3Lk1SMDUy5lRE1e9UFOoEJ3aUlGfsMjGNgwYeic5Q=;
	b=V/OPeGi9yQSm2F0/yAiB3RI1+JLeJi55IePtsvibL2C+Dwszet1dTR3tdAriD0kk9gKC
	 KpPvXX0u575SkC/aDZtwNvI2qQhnCNCjEgN6Us+dOaLtlCmOXSBuCdWYU1HsGACABmT9s
	 4eP9mpIG0yRRFCRYVMTmqRVl+AZuHnBI5sQ+1X7NYWsQat14kMqYoxcKBYaHUXxz3ZWD+
	 jsv8Bd0t4kjGeapOc4WnMvLsMuRNCiphTNDQ6EyrlaHSC8LMprOiTGwTt7z/BxiFegobF
	 AEPJvcu5kQ+psc9FNm4yrKq71XRZHoskpd1hQ7Wm+zTY7YMnngYd7C50D69+Cb13G4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKEmlj5n;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6236606A32E
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 10:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6236606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OKEmlj5n
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M7EOip3457375;
	Thu, 22 Oct 2026 10:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Yc3Lk1SMDUy5lRE1e9UFOoEJ3aUlGfsMjGNgwYeic
	5Q=; b=OKEmlj5nptwXzVbGaN3+N0LSpFJERpwDmRRXMG4JxUYyS+FutEvhwaUyf
	gSLyGFzVRWV5mxyYXMN5GobKX+ZQuHakI9rRZavhAazw/aueLZwzqQ7f4+/tmTT7
	GbSiF8oePxFP6yMcG7p/x0ZRTb8B8w+tcv0jhObUNFu4fH0Pl2SWs1Spb/Kc6p60
	ZqpVJhcW48qXyKelt62txqDVCARFeERkT3V6XojsNgAVVIjDxe5p98tZz7uOWCju
	27RFLV6Fqtw8qZv+ENdpKJJ7KQvIZpFd6kyOKv1enqmUUch9o1yH0N7MdF7t8GR0
	ZlN0RSoUwVWa7B6SIzhI4V/atpQhw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a60d0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:13:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4sBg337793;
	Thu, 22 Oct 2026 10:13:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he6gqhppk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:13:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MADi2M39321952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 10:13:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AB3C2004F;
	Thu, 22 Oct 2026 10:13:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C0D12004E;
	Thu, 22 Oct 2026 10:13:43 +0000 (GMT)
Received: from jupiter.bl1-in.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 10:13:43 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update EEH maintainer details
Date: Thu, 22 Oct 2026 15:43:42 +0530
Message-ID: <20261022101342.2962384-1-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzOCBTYWx0ZWRfX01xUOc4yusG9
 58BVi38jJMs6cqtZsGd24xUJ3pXAePDbiurhkB+3nmdWdaCv0j5KBdraZPzTUTIagWZU+OLNE/D
 UMuWuxf/MGGMWnNKPVtsZhUNBBrzGClJEpJaQKZfXQsrvT+TagTO+7AX6MYRqz3b5j993L+nnNV
 s/vKhyvuMFfyT1upAIRV1ruHENRcn3E1Zv4NaoJB9/0ASkI1TKjzGxqydMVhdRe/goEaX8k0BzQ
 YZZvHxeQJ4O0LFtFHKXFlHHXjUurena2Dv/6PHqiVtot3QSP7A99ki2IVkDANTlxsSFH2lHva6m
 z59ocTJ1zxJy65nXFAYJGy0YijUgJzPTmRvu4mgVj8R99DAh7M1UJ+oFyR1QFY3fIn/C+U+K5Ky
 WRAS+82smKgRwwYOIcpDoRsLnbuM8b4ktSs5NoMmpD6EFoyxY6gZsnGWbZ4QDANpTSXQQtENFhv
 iAsQn3bsYoAMvfH+NhQ==
X-Proofpoint-ORIG-GUID: lMyKY-k35uyVJ9UW91JMsKH9GmciRAdo
X-Proofpoint-GUID: lMyKY-k35uyVJ9UW91JMsKH9GmciRAdo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzOCBTYWx0ZWRfX0EDo88Ly3Pmo
 ekutgiUXRYdi1av7fBudiAScLxFdpRkB3rWRFcSIWgLtFurPdUY8nhVILrnYLdI2OyTZy/32JPH
 fUGkuhLrzLW/PKhAhzRehExtvTU6Nz0=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad9e1dd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8
 a=l8-7-_HzwCMQ2enNK-oA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220038

I no longer have the bandwidth to maintain EEH. Sourabh Jain has
graciously agreed to take over as the new maintainer.

- Add Sourabh Jain as EEH maintainer
- Remove myself from the EEH maintainer role

Thank you Sourabh for stepping up and ensuring continued support for
EEH.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9fe9c2a39b..e7bc0bb7353d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21092,7 +21092,7 @@ F:	drivers/pci/endpoint/
 F:	tools/testing/selftests/pci_endpoint/
 
 PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
-M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
+M:	Sourabh Jain <sourabhjain@linux.ibm.com>
 R:	Oliver O'Halloran <oohall@gmail.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
-- 
2.56.0

