Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbeIMIjW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Sep 2018 04:39:22 -0400
Date: Wed, 12 Sep 2018 22:31:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [GIT PULL] PCI fixes for v4.19
Message-ID: <20180913033147.GA73412@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI fixes:

  - Add Tyrel Datwyler as maintainer for PPC64 RPA hotplug (Tyrel Datwyler)

  - Add Gustavo Pimentel as DesignWare PCI maintainer (Joao Pinto)

  - Fix a Switchtec Spectre v1 vulnerability (Gustavo A. R. Silva)

  - Revert an unnecessary Intel 300 ACS quirk (Mika Westerberg)

  - Fix pciehp hot-add/powerfault detection that left indicators in wrong
    state (Keith Busch)

  - Fix pci_reset_bus() logic error (Dennis Dalessandro)

  - Revert IB/hfi1 PCI reset change that caused a deadlock (Dennis
    Dalessandro)

  - Allow enabling PASID on Root Complex Integrated Endpoints (Felix
    Kuehling)


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.19-fixes-1

for you to fetch changes up to 9d27e39d309c93025ae6aa97236af15bef2a5f1f:

  PCI: Fix enabling of PASID on RC integrated endpoints (2018-09-11 21:46:49 -0500)

----------------------------------------------------------------
pci-v4.19-fixes-1

----------------------------------------------------------------
Dennis Dalessandro (2):
      PCI: Fix faulty logic in pci_reset_bus()
      IB/hfi1,PCI: Allow bus reset while probing

Felix Kuehling (1):
      PCI: Fix enabling of PASID on RC integrated endpoints

Gustavo A. R. Silva (1):
      switchtec: Fix Spectre v1 vulnerability

Joao Pinto (1):
      MAINTAINERS: Add Gustavo Pimentel as DesignWare PCI maintainer

Keith Busch (1):
      PCI: pciehp: Fix hot-add vs powerfault detection order

Mika Westerberg (1):
      Revert "PCI: Add ACS quirk for Intel 300 series"

Tyrel Datwyler (1):
      MAINTAINERS: Add entries for PPC64 RPA PCI hotplug drivers

 MAINTAINERS                       | 16 +++++++++++++++-
 drivers/infiniband/hw/hfi1/pcie.c | 11 ++++-------
 drivers/pci/hotplug/pciehp_hpc.c  | 18 +++++++++---------
 drivers/pci/pci.c                 |  3 ++-
 drivers/pci/probe.c               |  5 ++++-
 drivers/pci/quirks.c              |  6 ------
 drivers/pci/switch/switchtec.c    |  4 ++++
 include/linux/pci.h               |  3 +++
 8 files changed, 41 insertions(+), 25 deletions(-)
