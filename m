Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: [RFC/RFT PATCH v2 0/3] PCI: generic device NUMA node detection
Date: Mon, 15 May 2017 14:22:02 +0100
Message-Id: <20170515132205.19622-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch series is v2 of a previous posting:

v1 -> v2:

- Added missing call to acpi_pci_bus_find_numa_node()
- Rebased against v4.12-rc1

v1: https://lkml.org/lkml/2017/4/26/211

On the ARM64 architecture, the arch specific PCI pcibus_to_node() callback
can be triggered on struct pci_bus.sysdata structures that carry host
bridge specific data through different structures layout (ie sysdata
pointer points at different structs for different host bridges), therefore
it is not possible to have a unified pcibus_to_node() implementation.

Given that the device NUMA node is a property of the struct pci_bus (and
its associated struct device), move the struct pci_bus node assignment to
generic PCI code, where according to the platform firmware the NUMA node
for the device backing the struct pci_bus is retrieved and propagated
through the PCI bus hierarchy.

Lorenzo Pieralisi (3):
  PCI: Introduce pci_bus_find_numa_node()
  PCI: Add call to set-up NUMA node for struct pci_bus devices
  PCI/ACPI: Add ACPI pci_bus_find_numa_node() implementation

 drivers/pci/pci-acpi.c | 20 ++++++++++++++++++++
 drivers/pci/pci.c      |  6 ++++++
 drivers/pci/probe.c    |  3 ++-
 include/linux/pci.h    |  7 +++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.10.0

