Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836D83EBF3F
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923929; cv=none; b=OSl8Hhk9unfDn4G3ooslm0aLmoeUajF1g7qslTWX6pBlGQ6ll4GKusBn7Ww+tyIyFB1jP2VxrJX/Spo9drbOS/DDj1cp5kNzS2g4h5h+ZsEH13KkPPgPo0MzcysSxVWhcwnWfzlXVhiXEuOnNThSOWwJs0q1YdVQQnAdl/NIrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923929; c=relaxed/simple;
	bh=Hdjf4Jqepm/ofIxsi+srbZQhc0+VYpktby6CEX3HXCs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OV2vFwfGkKGbmA8X64l08vAZMgZ289ViM0FYZY5GGGoGu+m421ukPTW1/y1LACVOzlb5N0X0JljJBDWOgrdbp4R3disQ5WXMzgfJ0gXcyl8zDAA3cvJh67vvqIBSSKyFLgekau5AV0fgTotZeKJ9CBTxZWsNf4iCe8RkQ34PaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y0EnoPNN; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y0EnoPNN"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61CHFmvv1995783;
	Thu, 12 Feb 2026 11:18:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=qLBmqD4RfSQ7N+Q4Wg
	iqyHOFEn4aGztR2U98YyUsg6M=; b=Y0EnoPNNSl+URnnuRqX8FujXyqlrD2YHOM
	x+tm44WLUO8/ivTGrZN8siFBUrSA+NClWnlq38eLhLU18495wirarR9ueF/VaphB
	tHds8moDs1wjR43fP4YbPZVZ8Iu6W209kviSrLKP++EQTnKgO0H/WWNw7EsZGHIV
	TtD791MmqznKFskJSSTb4fz3YFlVR1qW6ssyykTkMH6IZL+bbVeFQdBOBrcmPsU6
	ceTUx98hIE+XK7nGGfLWjydiMk76sMMYoT6cYuuPa/g1uAq6b7Cxwh5rBiWqJszS
	nbwDRbjmf4NmxIBBV4A8EPGcp3frdk98i8fKhL5jIPv2TcgUq5TA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4c9dty5a0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Feb 2026 11:18:40 -0800 (PST)
Received: from devvm16459.vll0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 19:18:39 +0000
From: Danielle Costantino <dcostantino@meta.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran
	<oohall@gmail.com>, <linux-pci@vger.kernel.org>,
        Danielle Costantino
	<dcostantino@meta.com>
Subject: [PATCH 0/2] PCI/DPC: Fix EDR recovery path issues
Date: Thu, 12 Feb 2026 11:18:16 -0800
Message-ID: <20260212191818.3625264-1-dcostantino@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: e0BKfwxAnPyxWxaiNFhde2hMm1vIZ_Pv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE0OSBTYWx0ZWRfX0iUXk0+Fuac5
 uoU1c7YQ+S3xmz1u+0Dr6h+9TJ23Ejs5moCbpFPZAx0kaOttag54MAeVc6FfGuaJicg+9S3uK7z
 U2DRGb9C+yovECnrRCUY8/bqaz9MHF6QeD+sfLjVJB6fsMXvMNbHpEJa1rFvDoFcnv2yceBt2lG
 irHG2y7MnwH8JDhzlcco58+OMvOrvv81cmP7cCrLBhmGXc7UMiG8efTAcsOT61JU3E+fcHqe/4r
 oNpiR1Wo8larBSMyb7cuSv+GDYVBSEw6TNN5vp5UWz2y5UABmgBHYirlMAyHyAAWT9zIyyT2xoI
 dP9Lb/RjZNkjncO6X8NSbGD4Ttc/fRTULKMyxgsoINk9hMeaxxug3F/vKH/Gn/NHRSrg6q2UMCr
 lrQdFy1F/cLPw8jsNqzulV7kjn3Dc0uh/g5ZSgNMxbM6z+hkd+Zjr2asZbPmTAhyopdpi6G4XUq
 UyZd1YuVSBPrSrq7FFg==
X-Proofpoint-ORIG-GUID: e0BKfwxAnPyxWxaiNFhde2hMm1vIZ_Pv
X-Authority-Analysis: v=2.4 cv=brNBxUai c=1 sm=1 tr=0 ts=698e2790 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=JjB_qaDjHViVyrf1wj4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

Two fixes for the firmware-first EDR path in DPC error recovery.

Both were found investigating recurring DPC events on a platform using
firmware-first EDR, where each recovery left stale state in the DPC
Status register and cleared AER diagnostic data before driver callbacks
could inspect it.

Patch 1 fixes DPC Interrupt Status (bit 3) never being cleared in the
EDR path.  In native DPC, dpc_irq() clears it in the top-half, but
EDR bypasses dpc_irq() entirely.  After this fix, dpc_reset_link()
clears both Trigger Status and Interrupt Status together.

Patch 2 moves pci_aer_raw_clear_status() from before pcie_do_recovery()
to after it in edr_handle_event(), so AER registers remain readable
throughout the driver recovery callbacks.

Tested on a firmware-first EDR platform.  A natural DPC event
confirmed:
  - DPC Status properly cleared: 0x2000 (clean) vs 0x2008 (stale, unpatched)
  - AER data available during recovery (GHES captured aer_uncor_status:
    0x00100010 throughout recovery window)
  - Full recovery successful in ~2.3s with link re-establishment

Danielle Costantino (2):
  PCI/DPC: Clear Interrupt Status in dpc_reset_link()
  PCI/EDR: Defer AER status clearing until after recovery

 drivers/pci/pcie/dpc.c | 10 +++++++++-
 drivers/pci/pcie/edr.c | 11 ++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

--
2.47.3

