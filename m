Received: from mail-m49220.qiye.163.com (mail-m49220.qiye.163.com [45.254.49.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D4335BA
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821159; cv=none; b=fEeHJVrvz1zfQYzum9cYhebT0u5AK+U7zBLJmxrshoi1Yc++KCmi2W166EDI0WI1BUvVUlgyvGLoV1I5GqrFsukLS4TZ/GF1HQ5zfkHCQaZPdnYBDoNiqp+kK89zcOxeE+bSeh2mOUXyDC0Ud5tm8Zz7/hEGEcJjfSUT1iZmrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821159; c=relaxed/simple;
	bh=FapvHKhHuHGEUhwmMlxlgK5wFbzLcR/YVtjzNQfj/y0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r5SWx8r7dwAtuhjaX2zOUL1Pvg1uCX5vzU+1FWH9G5niSSq78tapy4y946IbLtTcFmW9Q33EaMEX1AGrjcnlbUTys3fnd2ghNPaJCmx5rvyGKYRoEkCnXLLMI7ECZY/FOfg9uDM8n98kAEnBYw+e71M61zFj2LV1R2awvqhqlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=X6G52eu+; arc=none smtp.client-ip=45.254.49.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="X6G52eu+"
Received: from localhost.localdomain (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3ba07bb26;
	Wed, 22 Apr 2026 09:25:45 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/3] Add Devres managed IRQ vectors allocation
Date: Wed, 22 Apr 2026 09:25:24 +0800
Message-Id: <1776821127-234830-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9db2cb0d0109cckunm4d4f8bca15dec9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBoZVk1DHU5LGUsZHktPSVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=X6G52eu+bmZwEpHMN4wp3voEa+0qHL+/D8tcu9+vqszzDrM/7qwpIEfeMrPEXLSET6qqv7n07JIhXq71pm2/CHz538YiahhyLEUR5mVrNLT0dis3kXA4lEDSUTFPXkceciIVE9wZB6+dZqhKq+3RXSu9eBrdCRIntxrdfFjxPPc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1f90EMBDsB8nqVk5sZbeh+FS5qzfGZ/gu7kALfL7AvU=;
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
 drivers/pci/msi/api.c          | 51 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c |  6 ++---
 include/linux/pci.h            | 22 ++++++++++++++++++
 4 files changed, 78 insertions(+), 5 deletions(-)

-- 
2.7.4

