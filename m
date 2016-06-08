Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] ARM/ARM64: PCI: PCI_PROBE_ONLY clean-up
Date: Wed,  8 Jun 2016 12:04:46 +0100
Message-Id: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 David Daney <david.daney@cavium.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Current arm/arm64 code prevents enabling resources in the respective
pcibios_enable_device() callbacks if the PCI_PROBE_ONLY flag is set,
in that on those platforms the resources tree was not validated properly
since PCI resources are not currently claimed on arm/arm64 PCI_PROBE_ONLY
systems.

This is a temporary kludge, in that PCI_PROBE_ONLY flag is used to
describe systems with fixed resources, that can nonetheless be enabled
through the standard pci_enable_resources() call present in PCI core code,
(ie via the generic pcibios_enable_device() call).

To remove the PCI_PROBE_ONLY flag in arm/arm64 pcibios_enable_device()
callbacks, the PCI host controllers that can be used with
PCI_PROBE_ONLY configurations must make sure that devices resources are
validated and inserted in the kernel resource tree even on PCI_PROBE_ONLY
systems so that the generic pcibios_enable_device() generic code, while
enabling resources (pci_enable_resources()), does not find dangling
resources pointers (ie missing parent pointers) that are omens of
an incomplete resource tree, causing failures in resources enablement.

PCI core code provides interfaces to assign/reassign/reallocate PCI
bus resources but it is currently lacking an interface to claim
resources for a specific bus. Arches implement resources claiming through
ad-hoc code built on top of pci_claim_resource() API, but that code
cannot be leveraged on architectures like arm/arm64 that rely on the
generic PCI infrastructure to carry out resources claiming/assignment.

Therefore, to clean up the arm/arm64 resources enablement on
PCI_PROBE_ONLY systems this patchset implements four patches:

PATCH 1: Create PCI core code infrastructure to claim bus resources
PATCH 2: Leverage the infrastructure in PATCH 1 to claim resources in
         the PCI generic host controller on PCI_PROBE_ONLY systems

PATCH 3: Remove the PCI_PROBE_ONLY kludge from the arm64 PCI back-end to
         complete the clean-up and leverage the PCI generic
         pcibios_enable_device() implementation

PATCH 4: Remove the PCI_PROBE_ONLY kludge from the arm PCI back-end to
         complete the clean-up and leverage the PCI generic
         pcibios_enable_device() implementation

Tested on arm/arm64 systems with kvmtool and PCI host generic.

v2 -> v3

- Split patch 3 in two patches so that arm and arm64 are handled
  in different patches
- Improved commits logs, clarified resource parent assignment
- Rebased against v4.7-rc2

v2: https://patchwork.ozlabs.org/patch/590556/

v1 -> v2

- Rewrote patch 1 to recursively claim resources for the whole PCI bus
  hierarchy
- Updated commits logs/tags
- Rebased against v4.5-rc6

v1: https://patchwork.ozlabs.org/patch/545669/

Lorenzo Pieralisi (4):
  PCI: add generic code to claim bus resources
  PCI: host-generic: claim bus resources on PCI_PROBE_ONLY set-ups
  ARM64/PCI: remove arch specific pcibios_enable_device()
  ARM/PCI: remove arch specific pcibios_enable_device()

 arch/arm/kernel/bios32.c           | 12 -------
 arch/arm64/kernel/pci.c            | 13 --------
 drivers/pci/host/pci-host-common.c | 27 +++++++++++++--
 drivers/pci/setup-bus.c            | 68 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                |  1 +
 5 files changed, 94 insertions(+), 27 deletions(-)

-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
