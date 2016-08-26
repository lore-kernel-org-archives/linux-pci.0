Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/2] VMD PCIe specific LED control
Date: Fri, 26 Aug 2016 11:23:00 -0600
Message-Id: <1472232182-1448-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here is the second version for handling non-standard LED status in VMD
domains. There are significant differences this time around:

First, after discussing the original proposal, we decided that we
can't support allowing user space have direct write access to config
space. This potentially breaks the PCIe Slot Control command sequence,
so patch 1/2 provides an alternate sysfs attention setter/getter in
addition to ignoring the indicators for standard usage.

Second, I've since learned that there is no such VID/DID list I can use
in order to flag this quirk. The exact same devices with the quirk behave
differently when used outside a VMD domain. Since this quirk behavior
is specific to the VMD PCIe domain, the new approach is to set options
specific to domains as pci_dev's are being added.

Since patch 2/2 requires changes to x86 common code, I've added the
x86 maintainers in addition to PCI, and I'll re-summarize what this
feature/quirk is about:

This came from wanting a simple SGPIO-like LED management solution for
PCIe SSDs. The Intel group who made this hardware, not considering the
more broad impact on standarization, chose to reuse the hot plug serial
SMBus in the Intel CPUs (aka VPP) that already carried the Slot Control
register bits out of the CPU.

This hardware implementation therefore re-purposes the Slot Control's
Attention Indicator Control and Power Indicator Control of the PCI
Express Capabilities structure. Rather than using the PCIe standard
interpretation, this hardware uses IBPI (International Blinking Pattern
Interpretation).

One side affect is that the Attention and Power indicator presence bits
in the Slot Capabilities structures must remain enabled due to how
the hardware is wired. This would confuse the pciehp driver since it
would incorrectly (albeit understandably) assume how to control these
capabilities. So this patch series has to tell pciehp to keep away from
controlling these indicators and provide a way for the user to set
them instead.

This quirky behavior consideration is only required for the current
generation of this hardware. Future generations will use standards
compliance as being pursued within the PCI-SIG and NVMe-MI standards
bodies.

Keith Busch (2):
  pciehp: Let user control LED status
  x86/vmd: Add PCI domain specific LED option

 arch/x86/include/asm/pci.h        | 14 ++++++++++++++
 arch/x86/pci/common.c             |  7 +++++++
 arch/x86/pci/vmd.c                |  1 +
 drivers/pci/hotplug/pciehp.h      |  1 +
 drivers/pci/hotplug/pciehp_core.c | 26 ++++++++++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  |  6 +++++-
 include/linux/pci.h               |  1 +
 7 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.7.2
