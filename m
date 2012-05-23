Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:39724 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2EWWg4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 18:36:56 -0400
Received: by vcbfl13 with SMTP id fl13so240925vcb.1
        for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 15:36:56 -0700 (PDT)
Subject: [PATCH v3 0/2] archdata init in device_add() notifier
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michal Simek <monstr@monstr.eu>, benh@kernel.crashing.org,
	microblaze-uclinux@itee.uq.edu.au, linux-pci@vger.kernel.org,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	jbarnes@virtuousgeek.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linuxppc-dev@lists.ozlabs.org
Date: Wed, 23 May 2012 16:36:55 -0600
Message-ID: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's what I put in my "for-3.6" branch for now.  We can still change
it, so let me know if you see any problems.

I reworked the changelogs, changed the notification function name per
Jesse, folded the one-line pcibios_setup_bus_notifier() into the only
caller (on microblaze), and changed it from __devinit to __init (on
powerpc) since it now has nothing to do with hotplug.

Thank you very much for doing this work, Matsumoto-san.  I hope to
eventually get rid of pcibios_fixup_bus() altogether, and this is a
significant step in that direction.

Bjorn
---

Hiroo Matsumoto (2):
      powerpc/PCI: move DMA & IRQ init to device_add() notification path
      microblaze/PCI: move DMA & IRQ init to device_add() notification path


 arch/microblaze/include/asm/pci.h          |    1 
 arch/microblaze/pci/pci-common.c           |   62 +++++++++++---------
 arch/powerpc/include/asm/pci.h             |    2 -
 arch/powerpc/kernel/pci-common.c           |   87 ++++++++++++++--------------
 arch/powerpc/kernel/pci_32.c               |    2 +
 arch/powerpc/kernel/pci_64.c               |    2 +
 arch/powerpc/kernel/pci_of_scan.c          |    1 
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 
 drivers/pci/pci.c                          |    5 --
 drivers/pcmcia/cardbus.c                   |    3 -
 include/linux/pci.h                        |    3 -
 11 files changed, 83 insertions(+), 86 deletions(-)
