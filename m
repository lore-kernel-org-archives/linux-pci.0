Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E642330B3B
	for <linux-pci@vger.kernel.org>; Thu,  5 Feb 2026 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326767; cv=none; b=UTwArOh0ir2jGa2XsRP5t4d446irADZFMN8msMOWiw+/6ZzH7LATeOy2WqLnAUr2zrMt+42HjWIgNTfRtRLzld02gbBv9nc4wCGF/6PMG7mbBoyyB4cssJ3VwYoIZELGl3LHlrZ/cVvQJizW+M27Nl/bnF8Pr8hYNz+BAsVEkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326767; c=relaxed/simple;
	bh=ntboWVGgR4eujbDEggg3GP5T/GJlDdZN1KRXS+R0b/s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=si3V5oNWDvamvZ0pvVQ96ZNlKrR7aFeBcYtdtXKBcnNof6BBCY88BzZGHAXnrm+F3aOYShWxNBHBPxK+eOgZnZq3jL8G/B5Bpw+t38se97alZYDcW0J+L2wy8JtoK/l8H4gXbKImACcwCxyxRnqyVcrMnLABA90+54C7zeozjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ujIkDZ4R; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ujIkDZ4R"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBU2O2258948
	for <linux-pci@vger.kernel.org>; Thu, 5 Feb 2026 13:26:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=9+ZTy7vZia2BgWL/KP
	HhoVHDhHgZGmoO7Rxcx5WiHps=; b=ujIkDZ4RcsP4wDDI3BN3k5TTsN5z46ST/Z
	4iTIgoB+nGNnK5rtLUw7Pf9v49uDpHZKHJYpZ93y9atZOQ2yR8j2sM/cQwo11zj7
	Ugbqhkpnc8ErLzXoOtx0zoiak/NcaIRV3gBZTylRTWmPKK5EHl8gHhJ8fvOQNWj6
	uG8Kngwyi2pAJKT/0d1qOsY1QUlDvfSKBPNBcqjukP4FD7wLr1l49I9xjyhmxPto
	USX7uIeUeEN3sX3eMRIv9Tssnuhrr67+ur4oVCXQhtVDxqg7JDpKa0+iD4xh2gWx
	pO6AcsVX69MKwAv7DvhilLXmVMPiZv+ONsXLo6Z4BGY6FlS9BLvg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c50602ks7-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Feb 2026 13:26:06 -0800 (PST)
Received: from twshared26368.04.snb1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 21:25:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 1C09A72EC9CB; Thu,  5 Feb 2026 13:25:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 0/4] pci slot reset handling fixes
Date: Thu, 5 Feb 2026 13:25:29 -0800
Message-ID: <20260205212533.1512153-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfX4Uth5nmGRLe7
 A3L5ad+BLQ2IXlR9u9+2qeDAoDfnBcs3RG1xb2xJ12Vii4JHILXFiXNi+dlsHX1Gj69E0uEwwuq
 DEAvs5vJudS+hBeQ48PjFq6EIO8CZe9yHJX2pKRawYRIiYnIJEvI2rk6YHUIlpBlFHFGIkrS/YM
 juPSQBZgS/LhqURoUQwWXHYSeHnJRzx5h0wGLd2DP7vzlBdjpUPBofPrhz4ovLufia+aIGf09wB
 UPbhfIaXHH8dE4JaQX4BcfyqsQue/YBuAVEK4oJS8iJIN6hmTyJM56w+BMqwvBjQDW+8yK5Xjqe
 taKZ/uEFB2cd7XsZrN2DbgPsO5TPtDByaN64ZGEu+yUGmaBJJegfkPgBMSiwfDN1eBZqCWZpum/
 b4P8ABKxK8HjztyPIDCl28BZMDRdWPo+gf0fhG1DrEHJI0zayBMvYw3ddS+1IrV7gwVvjH/JRRB
 FRGQsHCSwc9ZINtZbVQ==
X-Proofpoint-ORIG-GUID: BTGJUvgRf21q8abYRNOnLgrBICqKeU9g
X-Authority-Analysis: v=2.4 cv=K+Iv3iWI c=1 sm=1 tr=0 ts=69850aee cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=-2_qhUFmwe7lauJXkPsA:9
X-Proofpoint-GUID: BTGJUvgRf21q8abYRNOnLgrBICqKeU9g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Changes from previous:

Incorporating suggestions from Dan:

  There's a prep patch changing the names of the functions for clarity.

  Introduced symbolic names to the reset bridge parameters to indicate
  whether it's a masked or unmasked reset attempt.

  Renamed the new "pci_reset_bridge" to "pci_try_reset_bridge", in
  keeping with the convention this series introduced.

I've also include a new patch specifically to allow pciehp slots to
claim all bus devices. I'm almost certain this is what pciehp wanted in
the first place. If this is acceptable, patch 3/4 here becomes
unnecessary, but I'm including that patch as an option here just in case
it's preferred to remove the slot specific lock handling.

Keith Busch (4):
  pci: rename __pci_bus_reset and __pci_slot_reset
  pci: allow all bus devices to use the same slot
  pci: remove slot specific lock/unlock and save/restore
  pci: make reset_subordinate hotplug safe

 drivers/pci/hotplug/pciehp_core.c |   3 +-
 drivers/pci/pci-sysfs.c           |   3 +-
 drivers/pci/pci.c                 | 228 +++++++++---------------------
 drivers/pci/pci.h                 |   2 +-
 drivers/pci/slot.c                |  22 ++-
 include/linux/pci.h               |   8 +-
 6 files changed, 93 insertions(+), 173 deletions(-)

--=20
2.47.3

