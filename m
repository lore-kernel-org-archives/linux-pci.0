Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51556 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbcCAOl5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 1 Mar 2016 09:41:57 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Russell King <linux@arm.linux.org.uk>
Subject: [PATCH v2 0/3] arm/arm64: pci: PCI_PROBE_ONLY clean-up
Date: Tue,  1 Mar 2016 14:44:06 +0000
Message-Id: <1456843449-19393-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
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

Therefore, to clean up the arm/arm64 resources enablement on PCI_PROBE_ONLY
systems this patchset implements three patches:

PATCH 1: Create PCI core code infrastructure to claim bus resources
PATCH 2: Leverage the infrastructure in PATCH 1 to claim resources in
         the PCI generic host controller on PCI_PROBE_ONLY systems
PATCH 3: Remove PCI_PROBE_ONLY kludges from arm/arm64 PCI back-ends to
         complete the clean-up and leverage the PCI generic
         pcibios_enable_device() implementation

Tested on arm/arm64 systems with kvmtool and PCI host generic.

v1 -> v2

- Rewrote patch 1 to recursively claim resources for the whole PCI bus
  hierarchy
- Updated commits logs/tags
- Rebased against v4.5-rc6

v1: https://patchwork.ozlabs.org/patch/545669/

Lorenzo Pieralisi (3):
  drivers: pci: add generic code to claim bus resources
  drivers: pci: host-generic: claim bus resources on PCI_PROBE_ONLY
    set-ups
  arm/arm64: pci: remove arch specific pcibios_enable_device()

 arch/arm/kernel/bios32.c            | 12 -------
 arch/arm64/kernel/pci.c             | 13 -------
 drivers/pci/host/pci-host-generic.c |  5 ++-
 drivers/pci/setup-bus.c             | 68 +++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                 |  1 +
 5 files changed, 73 insertions(+), 26 deletions(-)

-- 
2.5.1

