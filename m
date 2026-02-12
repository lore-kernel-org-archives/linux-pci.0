Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18E2C0F83
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 22:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936093; cv=none; b=RrsgwqKZbMpFbY8b9a2canA80iWmDiyqzD8e96vtrREFAgiI+KL1vM9flZHa7vxBHMpN5fY3zGvwPp6cKO0Ij12F0vqtAibVUFtKcG/90GJdDXNe7rVJexJPyQIV2EWKycYEAmnvBfk/V/ESyMQHjbsKnKpQCrJz0VJcLO2F5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936093; c=relaxed/simple;
	bh=pwoOuk/Dn+CycSat9l/wIR+DJqKbF4NokFe4jspvtso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3CwJUnYOdSCTCM/p80FnrTYg88dEi1JyJwBq8gEA9CFo/71TVENKzHCeMcPMRf5DOqx0DkdLe+k+5/ReZZgg0fM8Gke1WCAVofYOqQh0sXmrCRX+p9UDPS6tcWjjpPcZyQ91b4P2KGii9quqlBxhaITPJkeIUtyLVRMlheFvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=o2UQmsaE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="o2UQmsaE"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CJlqJi2149970
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=0tyqnANZaXWsGb0wm1
	Hmr1L9nqcYABJD1YZPaH7CQ1E=; b=o2UQmsaEKYnnvWRWxppmPD7torxJBxYPrV
	mjMYq4vh092XZVNPoa031/uhIkc3fQdxuOWq0SbHjYDccjQ4FZA+nZONJM1kMgEN
	HqdRbwqWKRd3mgWaHmsGODxri2Dmdj6E5Qc9HT8FTYou2rQ4JEroCiw2rf00iEM2
	SXJTV/xJkoFAnHewFNEnf7/dAFuGWww8Yw8Z/inAx18IVNkvwW4Uh7/aWj5yEW4f
	4bYgR1eo2jlx/XrzIGd0ij7N7j+jjXXdl9QDna8HroF7zgz4g9KGvhqDLXTplwHh
	DabZt8bHTN5+IoZNDYBFi1rm0uNH4ygUNDEv24i0cYk8ZzGG0SBg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9hynn1r7-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Feb 2026 14:41:31 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c085:208::7cb7)
 by mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 22:41:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AAF0C7AD50D9; Thu, 12 Feb 2026 14:41:13 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>, <alex@shazbot.org>,
        <dan.j.williams@intel.com>
CC: <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/3] pci slot reset handling fixes
Date: Thu, 12 Feb 2026 14:41:09 -0800
Message-ID: <20260212224112.1913980-1-kbusch@meta.com>
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
X-Proofpoint-GUID: G6sMUisZmsP788DrYo8LRet7rFO17C0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE3NSBTYWx0ZWRfX27aO2tyMfdO2
 YE6uIxYKxMfCzpzYpu/iQzwVRPgsvJ0CH00ILMKexwuefQHwB6igad7uJTPfKo+17wUYQT8C72C
 XZSm3Xsg1LNGdKHXW8NAv3o8dm/sIRJbtQ7Tvp3KmMPRf1PBDAuXkQvR/zy1ONCXmSWPMvkTavR
 SxUuXAdyC8K2JcwihSEb+QOVpHJQiZS8BDdnLdJl1psFz2RMYsN0RKkR4ncIdiezeuxapLRNad3
 1XGHfBi+6aazF0jqk6q2ZOZvirMhnQAa+9ojir3p6mWcynYqDlBbbJxMBDUU8z5OHRIUrZImqsO
 eBCn89VJFy6Q6TvMUYlzah5AotzxeiuHIEYCDsXi9JBRnPVinkEN0mt3FPTB43/EHOYi1xCEWQy
 r9s9Mu+buv4KWXFVWf8B0cx1IPn/6QZsNytxZdLCrqLXFkn6E8IeTDHR7HqNIKiRhm9PhCz1SCx
 /omlm+sj9LoLSm8Q/iw==
X-Proofpoint-ORIG-GUID: G6sMUisZmsP788DrYo8LRet7rFO17C0Z
X-Authority-Analysis: v=2.4 cv=DfMaa/tW c=1 sm=1 tr=0 ts=698e571b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=iT43ZOlSGHBV6OOi7xoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Changes from previous version:

 * Dropped the patch that unifies bus and slot reset device locking and
   config space restoration. There were good intentions for proposing
   it, but it's not necessary anymore for the pciehp case at hand and
   it introduces risks by conflating what is actually affected when you
   request a slot reset.

 * Fixed up some typos, added requested code comments

 * Fixed up the compilation linking mistake in patch 1

 * I changed a parameter name in the last patch for the common bridge
   reset method. Previously called "masked", but it's really the case
   that both methods want to mask hotplug events. The real difference
   between thw two options is whether we save+restore the affected
   devices. The error handling path doesn't want that because the error
   handler is responsible for it. But everyone else wants the reset
   handler to take care of it automatically.

 * Added reviews

Keith Busch (3):
  pci: rename __pci_bus_reset and __pci_slot_reset
  pci: allow all bus devices to use the same slot
  pci: make reset_subordinate hotplug safe

 drivers/pci/hotplug/pciehp_core.c |  3 +-
 drivers/pci/pci-sysfs.c           |  3 +-
 drivers/pci/pci.c                 | 94 ++++++++++++++++++++-----------
 drivers/pci/pci.h                 |  2 +-
 drivers/pci/slot.c                | 27 +++++++--
 include/linux/pci.h               |  8 ++-
 6 files changed, 96 insertions(+), 41 deletions(-)

--=20
2.47.3

