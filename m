Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4773392825
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776826475; cv=none; b=d/FdvWicoAHXm8DJE/nJNqhU83uU0juzWCk47VOdSj2X3eiMrNSbQPJ5kIfNOPnc8IPVqGbI7jOL501Ht2jepp64agjJSFisvFqYLxAmd+oezwl9GzHiBviKLP/ty9WwNOrJsSqC37mg4QMaLRa3z/WUJs8PwHRGInljkZE23Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776826475; c=relaxed/simple;
	bh=8IOkIu2e1/A67+NCy4H+cqEiZH27ZnRHfVIr1t7Se1U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ut3dsklTCjvUTSHTOQ8rbOy6tqR2cCqDCMPAdZYjMM1khYNnQ13IrlLVb83dNgM1g4y6AlVMmTs/MmidRcQuBC3RDMHmzwtNoQlQUVAQK7GuL2Ff5vzijNgXrAQMo9Fh1FqfV5m02NJJgmTeHTQXPcamm+CA6lS7iDUEveVZMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=UhXt+dov; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="UhXt+dov"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba417a8b;
	Wed, 22 Apr 2026 10:38:54 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RESEND PATCH v3 0/3] Add Devres managed IRQ vectors allocation
Date: Wed, 22 Apr 2026 10:38:39 +0800
Message-Id: <1776825522-6390-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9db30e087509cckunm3ea616f516de41
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTxlKVk9KGkoYTEJMTUhDGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=UhXt+dovoFkzUOACiwp3FA952rEzEdfhlXegVd788OJEkfHU4Z8r+rnHLHnB6EiyUNPoLAFI1+o0D7scJWa6RNGbFCvv/3YsZdPvJ14c3Z8Xz+8aE5m0Pvl1Fq9wZ+lf4zXtChCP0tN12bgZOvIXs66WT4sH6Yqn5yhraI1Jjws=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=rlAvgz3k001W3UeH9eq6jRAGmorNmIBwVYc9jN9LXJA=;
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

Historically, pcim_enable_device() not only manages standard PCI resources
(BARs) via devres but also implicitly triggers automatic IRQ vector management
when calling pci_alloc_irq_vectors[_affinity], because pcim_enable_device()
sets is_managed flag, thus pcim_msi_release() will register a cleanup action.

This creates an ambiguous ownership model. Many drivers follow a pattern of:
1. Calling pci_alloc_irq_vectors() to allocate interrupts.
2. Also calling pci_free_irq_vectors() in their error paths or remove routines.

When such a driver also uses pcim_enable_device(), the devres framework may
attempt to free the IRQ vectors a second time upon device release, leading to
a double-free. Analysis of the tree shows this hazardous pattern exists widely,
while 35 other drivers correctly rely solely on the implicit cleanup.

This series introduces new managed APIs: pcim_alloc_irq_vectors()and
pcim_alloc_irq_vectors_affinity(). Drivers that wish to have devres-managed IRQ
vectors should use these functions. They are currently the same as non-devres
managed version. In the short term, the series converts two drivers within the
PCI subsystem to use the new APIs. The long-term goal is to convert all other
drivers which wish to use these managed functions, and finally to remove the
problematic hybrid management pattern from pcim_enable_device() and
pcim_setup_msi_release() entirely.


Changes in v3:
- Rework the commit message and function doc (Philipp)
- Remove setting is_msi_managed flag from new APIs (Philipp)

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
 drivers/pci/msi/api.c          | 47 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c |  6 +++---
 include/linux/pci.h            | 22 ++++++++++++++++++++
 4 files changed, 74 insertions(+), 5 deletions(-)

-- 
2.7.4

