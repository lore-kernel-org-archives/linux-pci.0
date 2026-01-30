Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4C9354AC3
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792406; cv=none; b=Kd9hfnajaC5cIjOkHpR/CqQQKDG83dN61r4lOOfpTYAJqOSfBs62Pae+QQ8eAzZQDO5WSdF+Dd07e/udFuSOristxwpvKLPsb1mICfjZUGlc1UNfdWp8d35dIfDn/CCQ0IOqKEYq/YVEXT7B+fx5OrInSPRzL1Y4mXYAiPwQ/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792406; c=relaxed/simple;
	bh=Z5At9WDsusvAU/7osf+NcfS2LVbF8cz52HFV6UpjKjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7IO7uwTG/j0nkIvEP8QF/2+c9yLuDDHlfp0WqPHwqcKbn91xENSXMKY29xTu2ptCI7gWAa5I024tFEl7iYv1axZR/b/A4AgpGRvjrbUCfU9XQ38yZBi0UzNEsgfZplnb5h3v06LvrQ4nVqE6HNBo003jZtg+6vuOsMZjPQvtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qgUZnqDd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qgUZnqDd"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UGMWWi2933440
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Do9KlFSintb9xKu983
	mnljPmXtwMPpYI7i3MTdFNwYI=; b=qgUZnqDdVtscs2GoFkXv/QTjJgql9VllC2
	1jChtIdZrFNZ7D64NCU5Fvwrwgp3umDto5xYGp4ncpHP8QZrZ84pbJWZRAMiLerx
	UUxTc+leX2ZQYH44FVUfs8hwMkuvyDLIre49fvv45/tgvuN6WZwXqc6OwJnpImS4
	kl74z1Nk8I3SWmm2rVUzL0DK0QJnPZVN2xdj18jibVpNx4E8pur1wLNxdV3NJZON
	t93wvTwtfcgKKk/ofIN+lRyldtxJbmQmcoI1WSo4KtFwjJSmzWWn7E68QjXwQPrX
	8o45a1g0HnzhKcbSrArjMdNDotuIdmvBR0QhvEJ4st1T0iGJhc/Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c0s0kv545-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 09:00:03 -0800 (PST)
Received: from twshared18212.03.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 30 Jan 2026 17:00:00 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4C1906EAF16F; Fri, 30 Jan 2026 08:59:53 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-pci@vger.kernel.org>, <helgaas@kernel.org>
CC: <alex@shazbot.org>, <lukas@wunner.de>, <dan.j.williams@intel.com>,
        <guojinhui.liam@bytedance.com>, <ilpo.jarvinen@linux.intel.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 0/4] pci: slot handling fixes
Date: Fri, 30 Jan 2026 08:59:49 -0800
Message-ID: <20260130165953.751063-1-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: 7o3SGTvzp1_cUc8P6G5PAo_YR5Jeymb6
X-Proofpoint-GUID: 7o3SGTvzp1_cUc8P6G5PAo_YR5Jeymb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEzOSBTYWx0ZWRfX6U1qUd7FbVDj
 Kl3Rxr4zoVC3tkfMnOHCNns46kkxXl77Vr9cw4E+OuWOCkCmtxaGHJTA2nK4osGCI3G9ZVngMdz
 EJkBsPkzjM1pwS4qG+LRrWdp/cbM0V6MnHloB5cozZzJCX21z8k++SEINmiXp512Hlh+R5N2xF4
 NQgaEixdtPxEX2QxDYPgJBQbyEmTMbk2Xvw+vX3b7dSik5optB5VX2uiRQTYuVr8RVZh41HvCLl
 rMijUp15bh7FmTEDUfnsSBor1LcbWafHn+FZ0uZsPQC9N1qgqk0h49AumpFDl6bHm37I1qveMWt
 A9NKozJTbfZR7uZSS+J2ZQZvhIupwt2aRpR2rh4muHOd4ASETi8LmSs4+8vkulhsdyqHQJXyBnm
 twLE7NLYVWKySFZZDH7Fdp4rINNRVrlU4Urn7mcVgmFqDsIlqHYFLwF4S+6cmxtPvTbK+yo+N39
 QQxZihBO0kzM0QzWJpQ==
X-Authority-Analysis: v=2.4 cv=TZmbdBQh c=1 sm=1 tr=0 ts=697ce393 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=bDRlUQtB0YCFKnmUvDAA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

This series fixes some older issues are the slot lock usage, with two
follow on patches to address multi-function resets in pcie hotplug
slots.

Previous discussions:

  https://lore.kernel.org/linux-pci/20260116184150.3013258-1-kbusch@meta.=
com/

  https://lore.kernel.org/linux-pci/aXvOOjZQ_EmZDgVs@kbusch-mbp/T/#t

Version change notes:

 * The first patch is unchanged from the original.

 * The second patch adds the local "bridge" to improve code clarity
   (review comments from Dan)

 * The third patch removes pci_slot_resettable in addition to all the
   other slot specific locking and state saving functions. I also
   updated a code comment explaining that all bus devices are saved and
   restored with the slot reset.

 * Included a fourth patch that fixes user suborindate bus resets when th=
e
   bridge is pcie hotplug capable; a previous version came from this
   independent patch here:

  https://lore.kernel.org/linux-pci/20260116154244.1452246-1-kbusch@meta.=
com/

   And I'm including it in this series since it is all in the same area
   with slot resets. I've made a minor change to the previous version to
   remove the code duplication with pci_bus_error_reset().

Jinhui Guo (1):
  PCI: Fix incorrect unlocking in pci_slot_trylock()

Keith Busch (3):
  pci: fix slot reset device locking
  pci: remove slot specific lock/unlock and save/restore
  pci: make reset_subordinate hotplug safe

 drivers/pci/pci-sysfs.c |   3 +-
 drivers/pci/pci.c       | 213 +++++++++++-----------------------------
 drivers/pci/pci.h       |   2 +-
 3 files changed, 61 insertions(+), 157 deletions(-)

--=20
2.47.3

