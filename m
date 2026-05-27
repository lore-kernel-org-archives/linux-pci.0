Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0E27F01E;
	Wed, 27 May 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905326; cv=none; b=hWozP/AIITLy79tQeV8eGCFqnKN/BRTg26z65bWacPYamMrj/OtuF5dVmZEjtkvjVudiGV1nUr7GLEwi9LOm7gxeWr8ZaDyOHIfNzZlgMIhN6zKYgBf1k9ET8wktPPRyWOgjKywMKfOSuJRNsv3F8KBVXfQaReY2gv7yvfRpWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905326; c=relaxed/simple;
	bh=SIbsty7I/iEDvFL2HuKtJHm5SB7eRMcwWkXlx+E8IXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDj7jGsSwa/2PwWeE3DTRbtpWJXHNVvvmfwg/m7syydZbnDf4Kah9rQa12VlwgM1nJTIpR/MPTrol9RvGqFBhjUIkkdVYcB3EcJ/7F8PvZypNXMg3YwgpqujmtkbDj9CqPZN+By4NRqPhrre5TuWKu8l1GQIfDa1QsG08V9BX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z3uT0DTu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z3uT0DTu"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCB3Nn3594524;
	Wed, 27 May 2026 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KBhArppnVBBM6M4CD8pwBApItJWNjiw5adP314oYd
	w4=; b=Z3uT0DTu+ki3LEq5EMotRXZ01goq9hXOiO6xz5nlxRctx1bsqvfSsCjog
	C7xb5A9uUyU/iCHbFZUrSWJVaharwjmmTBBtE64Qb3QGxq662VCIPJ3KPPZBy7Lc
	ymKJexdhv0NB7Bj14JrVdlk/ixW01M0eDqUIGz9kkNzci4cEKuyZmeRRRUdojCwX
	wZji8zRw0cQFjdVwncphdFz3F+53zKdU8KmbmHBSw01KLwnxyv+Pq6fCeCZrQQSf
	ZTzxiOtqk6JQY09oICj76FXIDQGoVSB1vOglDR9+5Qioil/juISZL58lsBEEIbWZ
	zujG9QgrAGn0AcbdjA3x1WM/sjJIA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2jsp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs53Z010671;
	Wed, 27 May 2026 18:08:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb4avw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI8MQl45285874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:08:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C14BA20040;
	Wed, 27 May 2026 18:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D13482004B;
	Wed, 27 May 2026 18:08:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.220.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 18:08:18 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2 0/3] ppc/pnv: Fix panics and refactor pnv_php.c
Date: Wed, 27 May 2026 23:38:13 +0530
Message-ID: <20260527180816.2749186-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZahQOOm8zkH4eWS-r5JH1W7QD0QFF9rc
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a17331b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=19T7HI5kWQHWw3tJfkgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MiBTYWx0ZWRfX1pCvED0rGHRZ
 M4oSgjofiwDOuTw4tWitjmN9aLcKYJOmLF7abWijjHrM7iwu8FQMqdvFvzny25FxxLCJ2v/SffD
 XPktyDlBcpX4ckyUpuYjSfmR78h7iaax9iDyb/kK2F78e2F2j6ng6lyZX1TXe5cUzqKLdBqCvzS
 ZqpePIJaKqPuV8k7oIQ1/ROBhZgPl3VRD3I0ZPSFvOvsjWgHShoY7ZBzSYcPq/qvTKCDf8UPNDn
 BG5TQzIHHJQwATNZ+DoFzWcwBXsNogSG4YHNSXt5tkZ5bz2cgL6ya8eQiMHovuChb0JpCuJz2SA
 SBEVTiDlihCBdmfTA62Vz4yPtXKsg/22J34DsTC9xwFTijuO+VTaRsGvGeApxdcMbzj7ySd9DvS
 uTzNCQ2lpYGjaxXzF5H0b0a6xLNENPzNz/h7nAu5haNwUHWDzGtuFF84dRmj6e9uCwNuqF2FwKM
 59j64KEZAcmgTApyDDg==
X-Proofpoint-ORIG-GUID: Fo607T0LaHRznho-UTTfhKIGl523Cfnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270182

Overview
========

Since below upstream commit, powernv systems get a panic during boot when an
OpenCAPI hotplug slot is detected:

  commit 80f9fc2362797538ebd4fd70a1dfa838cc2c2cdb
  Date:   Tue Jul 15 16:36:55 2025 -0500
  
      PCI: pnv_php: Work around switches with broken presence detection

The panic log is present in patch #1

Patch #1: Adds null checks around null pointer dereferences
Patch #2: Rework the driver code to separate PCIe-specific and common code
Patch #3 (optional): Group PCIe functionality together, only code movements

Note: Patch 1 is important and independent of the other patches

Note2: Patch 2 & 3 can be squashed into 1 commit. Intentionally kept patch #2 as
small as possible for ease of review.

Changelog
=========
v1 -> v2:
* Sashiko pointed out various null pointer dereferences including a kernel panic triggered by userspace, fixed them
* Add rework patches, so that PCIe-specific and common code can be separated
  cleanly

Aditya Gupta (3):
  ppc/pnv: Add null checks for OpenCapi PHBs
  ppc/pnv: Refactor PNV PCI hotplug driver
  ppc/pnv: Refactor PNV PCI Hotplug to group PCIe functions

 arch/powerpc/include/asm/pnv-pci.h |  16 +
 drivers/pci/hotplug/pnv_php.c      | 554 ++++++++++++++++-------------
 2 files changed, 328 insertions(+), 242 deletions(-)

-- 
2.54.0

