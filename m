Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Alex Deucher <alexdeucher@gmail.com>,
	Christian Knig <christian.koenig@amd.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-iommu@vger.kernel.org, linux-acpi@vger.kernel.org,
	x86@kernel.org
Subject: [Bugfix v4 0/2] Prevent binding PCI drivers to PCI devices used by non-pci drivers
Date: Fri,  9 Oct 2015 22:07:30 +0800
Message-Id: <1444399652-25920-1-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1444386214-26319-1-git-send-email-joro@8bytes.org>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,
	I prepared this patchset yesterday but forgot to send them out.
I think it still worth sending out for review, so here we go:)

---
Commit 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()") breaks suspend/resume on some AMD platforms.
The root cause is:
1) AMD IOMMU drivers enables MSI on IOMMU PCI devices at early boot stage
2) PCI driver binding code tries to allocate/free PCI legacy IRQ when
   binding other PCI drivers to IOMMU PCI devices at later boot stage,
   and breaks PCI MSI allocation information.
3) System resume breaks when restoring PCI MSI state using the damaged
   data.

We have tried on solution to detect that a PCI is in use by IOMMU driver
by checking pci_msi_enabled(). But that's too specific, actually we should
prevent binding PCI drivers to PCI devices used by non-PCI drivers.

Fortunately, we could prevent binding PCI drivers to PCI devices by setting
pci_dev->match_driver to false. If needed, we could implement a helper
function to manipulate pci_dev->match_driver.

Jiang Liu (2):
  iommu/amd: Prevent binding other PCI drivers to IOMMU PCI devices
  ACPI, PCI: Prevent binding other PCI drivers to IOAPIC PCI devices

 drivers/acpi/ioapic.c          |    7 +++++--
 drivers/iommu/amd_iommu_init.c |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.7.10.4

