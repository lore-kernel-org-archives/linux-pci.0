Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534ED4457A4;
	Tue,  1 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247375; cv=none; b=JpQh2yTufZxX1+ir8FJqKRvi+NqFCwTUTmdgsjgGlAIYJVu3iF0rl8vwsjlkaAmbyZ2Dpmaagpu2rfj+g0jJD/kh2W66YDcIfWK0xPU0IrsyLEZWPFAA8jc173oXimJ6ApCAW14phXoxTM1ZuBx7x74fY947BKTmh5oYjaCgSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247375; c=relaxed/simple;
	bh=bCtyfejhhPx3cWwYvOXW7KFgYGIdEWPjNvooqG+w8UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfcaIsRv5/WyaJldQ4cO4QFi3X+xyITMvH2zLSnmw9djzDwEDTYQFmeJ+JrnAxOhwB7WLCKM+ybzHWrrydWX+j2ycgt5kLu7IqfaJp/0006XS7aTsCYnAJ3mz4/ZOXbOgEOe1ipI/+uZVokmLLHX0Y7t2KLX+0tN6IGRGIbuMrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07548455|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0251362-0.000825801-0.974038;FP=7035564555927897295|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.j2BhRtJ_1788247039;
Received: from localhost.localdomain(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j2BhRtJ_1788247039 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 01 Sep 2026 15:17:27 +0800
From: Lin Wang <wanglin@open-hieco.net>
To: Borislav Petkov <bp@alien8.de>,
	yazen.ghannam@amd.com,
	mario.limonciello@amd.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	"H. Peter Anvin" <hpa@zytor.com>,
	bhelgaas@google.com,
	x86@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] x86/hygon: Add Family 0x18 DF node enumeration and SMN access
Date: Tue,  1 Sep 2026 15:16:55 +0800
Message-ID: <20260901071700.3255382-1-wanglin@open-hieco.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision addresses the Sashiko comments on v3.

Sashiko noted that v3 disabled AMD NB and SMN initialization on Hygon
while amd64_edac, ATL and k10temp could still call those interfaces. V4
restores the pre-v3 AMD NB behavior and leaves those drivers unchanged.
The broad SMN exclusion is replaced by a model-specific handoff to the
Hygon SMN setup.

However, restoring AMD NB initialization does not make the AMD paths
usable for the Family 0x18 topology covered here. AMD NB maps nodes 0
through 7 to fixed PCI slots. Hygon discovers F3 devices by PCI ID, may
expose more than eight DF nodes, reports sparse CPU NodeIds, and groups
SMN roots by socket.

This series adds the Hygon node and SMN interfaces first so the Hygon
paths in those drivers can be converted separately.

The AMD-side changes check smn_exclusive before accessing amd_roots.
On these models, amd_smn_init() does not reserve the roots needed by
Hygon SMN setup. AMD SMN calls return -ENODEV until their callers use
the Hygon interfaces. The remaining Hygon handling in amd_nb.c and
amd_node.c can then be removed separately.

Sashiko also found that v3 retained pci_get_class() iterator devices
without owning references. The Hygon setup now holds a reference for
every reserved root and releases all references and config regions on
failure.

The corresponding reference and roots_per_node issues in
amd_smn_init() predate this series. Yazen confirmed them and is handling
the AMD fixes separately.

The node and SMN implementation has been tested on a Family 0x18 Model
0x07 system with 2 sockets, 12 CDDs and 4 IODs.

Changes in v4:

  - Drop the v3 AMD NB vendor restriction. (Sashiko)
  - Replace the vendor-wide AMD SMN exclusion with a model-scoped
    handoff. (Sashiko)
  - Hold references for reserved Hygon SMN roots and release all
    resources on setup failure. (Sashiko)
  - Drop the SMN debugfs interface.

Links:

  Sashiko v3 review:
    https://sashiko.dev/#/patchset/20260709075549.626095-1-wanglin%40open-hieco.net

  RFC v1:
    https://lore.kernel.org/all/20260402111515.1155505-1-wanglin@open-hieco.net/

  RFC v2:
    https://lore.kernel.org/all/20260423060420.1785357-1-wanglin@open-hieco.net/

  v3:
    https://lore.kernel.org/all/20260709075549.626095-1-wanglin@open-hieco.net/


Lin Wang (5):
  pci_ids: Add Hygon Family 0x18 DF F3/F4 device IDs
  x86/hygon: Add Family 0x18 DF node enumeration
  x86/hygon: Map CPU NodeIds to DF nodes
  x86/amd_node: Skip SMN setup on Hygon Fam18h models 0x04-0x08
  x86/hygon: Add Family 0x18 SMN access

 MAINTAINERS                       |    3 +
 arch/x86/Kconfig                  |    4 +
 arch/x86/include/asm/hygon/node.h |  207 ++++++
 arch/x86/kernel/Makefile          |    1 +
 arch/x86/kernel/amd_node.c        |   18 +-
 arch/x86/kernel/hygon_node.c      | 1011 +++++++++++++++++++++++++++++
 include/linux/pci_ids.h           |    6 +
 7 files changed, 1247 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/hygon/node.h
 create mode 100644 arch/x86/kernel/hygon_node.c


base-commit: abdf623ddb75b24659018d3952d8f61937306ae5
-- 
2.43.0

