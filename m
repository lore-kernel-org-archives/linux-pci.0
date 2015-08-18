Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e24smtp04.br.ibm.com ([32.104.18.25]:50812 "EHLO
	e24smtp04.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbHRVIG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 17:08:06 -0400
Received: from /spool/local
	by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
	Tue, 18 Aug 2015 18:08:03 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id C28D5352007C
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2015 17:06:53 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t7IL6T7112058960
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2015 18:06:30 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t7IL7wE9011327
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2015 18:07:58 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: gpiccoli@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com,
	bhelgaas@google.com
Subject: [PATCH 0/2] Disable MSI/MSI-X interrupts manually at PCI probe time in PowerPC architecture
Date: Tue, 18 Aug 2015 18:07:55 -0300
Message-Id: <1439932077-11427-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These 2 patches correct a bogus behaviour introduced by commit 1851617cd2
("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI").
The commit moved the logic responsible to disable MSI/MSI-X interrupts
at PCI probe time to a new function, named pci_msi_setup_pci_dev(), that
is not reachable in the code path of PowerPC pSeries platform.

Since then, devices aren't able to activate MSI/MSI-X capability, even
after boot. The first patch makes the function pci_msi_setup_pci_dev()
non-static. The second patch inserts a call to the function in powerpc
code, so it explicitly disables MSI/MSI-X interrupts at PCI probe time.

Guilherme G. Piccoli (2):
  PCI: Make pci_msi_setup_pci_dev() non-static for use by arch code
  powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe time in OF case

 arch/powerpc/kernel/pci_of_scan.c | 3 +++
 drivers/pci/probe.c               | 2 +-
 include/linux/pci.h               | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.1.0

