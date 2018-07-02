Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V5 0/6] PCI: unify slot and bus reset calls
Date: Mon,  2 Jul 2018 18:58:49 -0400
Message-Id: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_reset_slot() and pci_reset_bus() functions require user to query if a
device is behind a hotplug slot. External users are not following this
requirement.

Hide the implemetnation into PCI core and check hotplug association on
behalf of the user internally.

Changes from v4:
* return code factoring per Andy.

Sinan Kaya (6):
  PCI: Handle error return from pci_reset_bridge_secondary_bus()
  IB/hfi1: Use pci_try_reset_bus() for initiating pci secondary bus
    reset
  PCI: Hide pci_reset_bridge_secondary_bus() from drivers
  PCI: Unify try slot and bus reset API
  PCI: Deprecate pci_reset_bus() and pci_reset_slot() functions
  PCI: Rename pci_try_reset_bus() to pci_reset_bus()

 drivers/infiniband/hw/hfi1/pcie.c |  4 +-
 drivers/pci/hotplug/pciehp_hpc.c  |  5 ++-
 drivers/pci/pci.c                 | 91 +++++++++++----------------------------
 drivers/pci/pci.h                 |  1 +
 drivers/pci/pcie/aer.c            |  5 ++-
 drivers/pci/pcie/err.c            |  6 ++-
 drivers/vfio/pci/vfio_pci.c       |  6 +--
 include/linux/pci.h               |  6 +--
 8 files changed, 40 insertions(+), 84 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
