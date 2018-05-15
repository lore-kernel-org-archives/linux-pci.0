Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:43138 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752427AbeEOJI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 May 2018 05:08:27 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v4 0/8] PCI: leak fixes, removable generic PCI host, assorted stuff
Date: Tue, 15 May 2018 11:06:59 +0200
Message-Id: <cover.1526375226.git.jan.kiszka@siemens.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes in v4:
 - restore pci_free_resource_list() in error path of
   of_pci_get_host_bridge_resources()

Changes in v3:
 - refactor series to be both bisectable and simpler while reworking
   of_pci_get_host_bridge_resources()
 - include of_pci_get_host_bridge_resources() removal
 - include devm_of_pci_get_host_bridge_resources() error path fixes
 - effectively, no functional changes to v2

Changes in v2:
 - patch 1: commit message reworking as suggested by Lorenzo
 - patch 3-6: split-up as suggested by Bjorn
 - patch 8: new
 - patch 10: select PCI_DOMAINS from PCI_HOST_GENERIC, rather than
   allowing manual choice, as suggested by Lorenzo

This primarily enables to unbind the generic PCI host controller without
leaving lots of memory leaks behind. A previous proposal patch 5 was
rejected because of those issues [1].

The fixes have been validated in the Jailhouse setup, where we add and
remove a virtual PCI host controller on hypervisor activation/
deactivation, with the help of kmemleak.

Besides that, there is tiny PCI API cleanup at the beginning and
support for manually enabled PCI domains at the end that enables the
Jailhouse scenario.

Jan

[1] http://lkml.iu.edu/hypermail/linux/kernel/1606.3/00072.html


CC: Jingoo Han <jingoohan1@gmail.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>

Jan Kiszka (8):
  PCI: Make pci_get_new_domain_nr() static
  PCI: Fix memory leak of devm_pci_alloc_host_bridge()
  PCI: Rename device node parameter of
    of_pci_get_host_bridge_resources()
  PCI: Replace dev_node parameter of of_pci_get_host_bridge_resources
    with device
  PCI: Replace pr_*() with dev_*() in of_pci_get_host_bridge_resources()
  PCI: Rework of_pci_get_host_bridge_resources() to
    devm_of_pci_get_host_bridge_resources()
  PCI: Add support for unbinding the generic PCI host controller
  PCI: Enable PCI_DOMAINS along with generic PCI host controller

 drivers/pci/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/host/Kconfig               |  1 +
 drivers/pci/host/pci-aardvark.c        |  5 ++-
 drivers/pci/host/pci-ftpci100.c        |  4 +--
 drivers/pci/host/pci-host-common.c     | 13 +++++++
 drivers/pci/host/pci-host-generic.c    |  1 +
 drivers/pci/host/pci-v3-semi.c         |  3 +-
 drivers/pci/host/pci-versatile.c       |  3 +-
 drivers/pci/host/pci-xgene.c           |  3 +-
 drivers/pci/host/pcie-altera.c         |  5 ++-
 drivers/pci/host/pcie-iproc-platform.c |  4 +--
 drivers/pci/host/pcie-rcar.c           |  5 ++-
 drivers/pci/host/pcie-rockchip.c       |  4 +--
 drivers/pci/host/pcie-xilinx-nwl.c     |  4 +--
 drivers/pci/host/pcie-xilinx.c         |  4 +--
 drivers/pci/of.c                       | 65 ++++++++++++++++------------------
 drivers/pci/pci.c                      |  6 ++--
 drivers/pci/probe.c                    |  4 ++-
 include/linux/of_pci.h                 |  4 +--
 include/linux/pci-ecam.h               |  1 +
 include/linux/pci.h                    |  3 --
 21 files changed, 76 insertions(+), 68 deletions(-)

-- 
2.13.6
