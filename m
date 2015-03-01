Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:35340 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbbCACS0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Feb 2015 21:18:26 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Matt Fleming <matt.fleming@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/8] x86, boot: clean up setup_data handling
Date: Sat, 28 Feb 2015 18:17:31 -0800
Message-Id: <1425176259-30087-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now we setup_data is reserved via memblock and e820 and different
handlers have different ways, and it is confusing.
1. SETUP_E820_EXT: is consumed early and will not copy or access again.
	have memory wasted.
2. SETUP_EFI: is accessed via ioremap every time at early stage.
	have memory wasted.
3. SETUP_DTB: is copied locally.
	have memory wasted.
4. SETUP_PCI: is accessed via ioremap for every pci devices, even run-time.
5. SETUP_KASLR: is accessed early, will not copy or access again.
	have memory wasted.

Also setup_data is exported to debugfs for debug purpose.

Here will convert to let every handler to decide how to handle it.
and will not reserve the setup_data generally, so will not
waste memory and also make memblock/e820 keep page aligned.
1. not touch E820 anymore.
2. copy SETUP_EFI to __initdata variable and access it without ioremap.
3. SETUP_DTB: reserver and copy to local and free.
4. SETUP_PCI: reverve localy and convert to list, to avoid keeping ioremap.
5. SETUP_KASLR: fix accessing kaslr_enabled accessing...
6. export SETUP_PCI via sysfs.

Those patches could be applied on top of tip/x86/urgent with SETUP_KASLR
support.

Yinghai Lu (8):
  x86, kaslr: get kaslr_enabled back correctly
  x86: Kill E820_RESERVED_KERN
  x86, efi: copy SETUP_EFI data and access directly
  x86, of: let add_dtb reserve by itself
  x86, boot: Add add_pci handler for SETUP_PCI
  x86: kill not used setup_data handling code
  x86, pci: convert SETUP_PCI data to list
  x86, pci: export SETUP_PCI data via sysfs

 arch/x86/include/asm/efi.h       |   2 +-
 arch/x86/include/asm/pci.h       |   2 +
 arch/x86/include/asm/prom.h      |   9 +-
 arch/x86/include/uapi/asm/e820.h |   9 --
 arch/x86/kernel/devicetree.c     |  39 +++---
 arch/x86/kernel/e820.c           |   6 +-
 arch/x86/kernel/kdebugfs.c       | 142 --------------------
 arch/x86/kernel/setup.c          |  57 ++------
 arch/x86/kernel/tboot.c          |   3 +-
 arch/x86/mm/init_64.c            |  11 +-
 arch/x86/pci/common.c            | 281 ++++++++++++++++++++++++++++++++++++---
 arch/x86/platform/efi/efi.c      |  13 +-
 arch/x86/platform/efi/efi_64.c   |  13 +-
 arch/x86/platform/efi/quirks.c   |  23 +---
 14 files changed, 336 insertions(+), 274 deletions(-)

-- 
1.8.4.5

