Received: from mail-m1973199.qiye.163.com (mail-m1973199.qiye.163.com [220.197.31.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C741C695
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394936; cv=none; b=L/w18Hr46khvyD9mL7xim4pB+6EypICabCF0IBo7neCqJ8ZtbR09DRfAI+0rpHMdxyTBXlYy0cOwsCfFSIHjBVc+bE7Gt1oYM4D6O9VKCyymxlt38Cq6xsj6cCPFgkrVF/2byMad3N0YpfXxYq6h8HGK3KeLQA0HvxY1D0G3k5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394936; c=relaxed/simple;
	bh=5I8iwT0tu4NPwlaMTrabKRKsi5KYVx5J+lotCNGb1Q0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X4gygDv6qcx2DrumQG7f6UMKufc5aujV6ED768gVK9WrCCLQB0lXLoIpZ5NMHGatPGCaNhx0vvPnaLmbDfpGS9gzF36UgXowgTupAWqEukM9Zz0YErDboCj9nYvYiaBlUCnKQCMyiPw6O1958qIX2bUAs5r7fwWZOIOxxPehxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=iNJX3MJg; arc=none smtp.client-ip=220.197.31.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="iNJX3MJg"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3b1199afc;
	Fri, 17 Apr 2026 10:26:34 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/3] Add Devres managed IRQ vectors allocation
Date: Fri, 17 Apr 2026 10:26:04 +0800
Message-Id: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d9942f11a09cckunm63489ccb2f73b5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh1PTlZJHhpOTRpOSUpOT0hWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=iNJX3MJgqqpUUcTTx+H1H3YwHpWkK0S/GDO1HEjCc4GJVa2Gx64EOwar8TNGtIvHrXpfoMvaNWdVERRXncnNVC1DM7AO22FUXPfgEpYfaaSxsMxmSN1k9SvnB0gFmRXZzkryVvyj9JRwjtH+wAeD/a3DWl2AcEGNQUvs0sHy00U=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Q2FK+BWAcl4wrxF1/z88dYL9ZcSlGl63S2mjyM2zLGs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

There is a long-standing design issue in the PCI/MSI subsystem where the
implicit, automatic management of IRQ vectors by the devres framework
conflicts with explicit driver cleanup, creating ambiguity and potential
resource management bugs.

Historically, `pcim_enable_device()` not only manages standard PCI resources
(BARs) via devres but also implicitly triggers automatic IRQ vector management
by setting a flag that registers `pcim_msi_release()` as a cleanup action.

This creates an ambiguous ownership model. Many drivers follow a pattern of:
1. Calling `pci_alloc_irq_vectors()` to allocate interrupts.
2. Also calling `pci_free_irq_vectors()` in their error paths or remove routines.

When such a driver also uses `pcim_enable_device()`, the devres framework may
attempt to free the IRQ vectors a second time upon device release, leading to
a double-free. Analysis of the tree shows this hazardous pattern exists widely,
while 35 other drivers correctly rely solely on the implicit cleanup.

This series introduces new managed APIs: pcim_alloc_irq_vectors()and
pcim_alloc_irq_vectors_affinity(). Drivers that wish to have devres-managed IRQ
vectors should use these functions. They appropriately set the is_msi_managed
flag and ensure proper automatic cleanup.

In the short term, the series converts two drivers within the PCI subsystem to
use the new APIs. The long-term goal is to convert all other drivers to use these
managed functions, and finally to remove the problematic hybrid management pattern
from pcim_enable_device() entirely.


Changes in v2:
- Rebase
- Introduce patches only for PCI subsystem to convert the API

Shawn Lin (3):
  PCI/MSI: Add Devres managed IRQ vectors allocation
  PCI: switchtec: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()
  PCI: vmd: Replace pci_alloc_irq_vectors() with
    pcim_alloc_irq_vectors()

 drivers/pci/controller/vmd.c   |  4 ++--
 drivers/pci/msi/api.c          | 26 ++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c |  6 +++---
 include/linux/pci.h            | 22 ++++++++++++++++++++++
 4 files changed, 53 insertions(+), 5 deletions(-)

-- 
2.7.4

