Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: [PATCH v3 0/7] PCI: Add support for enforcing all MMIO BARs not to share PAGE_SIZE
Date: Thu, 30 Jun 2016 18:53:06 +0800
Message-Id: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series aims to add an option for PCI resource allocator to  
force BARs not to share PAGE_SIZE. This would make sense to VFIO 
driver. Because current VFIO implementation disallows to mmap 
sub-page(size < PAGE_SIZE) MMIO BARs which may share the same page 
with other BARs for security reasons. Thus, we have to handle mmio 
access to these BARs in QEMU emulation rather than in guest which 
will cause some performance loss.

To achieve that, we would like to make use of the existing 
resource_alignment kernel parameter and force a minimum alignment 
of PAGE_SIZE. It's flexible. And we can enable it by default on
some archs which may easily hit the performance issue because of  
their 64K page.

In this series, patch 1,2,3 fixed bugs of using resource_alignment;
patch 4,5 tried to add a new option for resource_alignment to use 
IORESOURCE_STARTALIGN to specify the alignment of PCI BARs; patch 6
modified resource_alignment to support syntax which can be used to
enforce the alignment of all MMIO BARs to be at least PAGE_SIZE;
patch 7 enabled this feature by default on PowerNV platform.

Changelog v3:
- Ignore enforced alignment to fixed BARs
- Fix issue that disabling memory decoding when reassigning the alignment
- Only enable default alignment on PowerNV platform

Changelog v2:
- Ignore enforced alignment to VF BARs on pci_reassigndev_resource_alignment()

Yongji Xie (7):
  PCI: Ignore enforced alignment when kernel uses existing firmware setup
  PCI: Ignore enforced alignment to VF BARs
  PCI: Do not disable memory decoding in pci_reassigndev_resource_alignment()
  PCI: Add a new option for resource_alignment to reassign alignment
  PCI: Do not use IORESOURCE_STARTALIGN to identify bridge resources
  PCI: Add support for enforcing all MMIO BARs to be page aligned
  PCI: Add a macro to set default alignment for all PCI devices

 Documentation/kernel-parameters.txt |    7 +-
 arch/powerpc/include/asm/pci.h      |    4 ++
 drivers/pci/pci.c                   |  123 +++++++++++++++++++++++++++--------
 drivers/pci/setup-bus.c             |    9 ++-
 4 files changed, 111 insertions(+), 32 deletions(-)

-- 
1.7.9.5
