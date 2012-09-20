Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58766 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab2ITHny (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2012 03:43:54 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Russell King <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] ARM: pci: Prepare for Tegra PCIe controller driver
Date: Thu, 20 Sep 2012 09:43:43 +0200
Message-Id: <1348127025-29461-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Russell,

These are two patches I've been carrying in a larger series that
converts the Tegra PCIe controller driver to a proper platform driver.
Since the complete series didn't get much feedback, I've begun to post
smaller subsets in an effort to get them merged more easily.

The first patch in this series removes the __init annotations from the
pci_common_init() function (and pcibios_init_hw(), pcibios_swizzle() as
well as pcibios_init_resources() because they end up being called from
the former) to make sure that they stay around after the init stage.
This is required because the Tegra driver depends on regulators that
become available only very late during boot and uses deferred probing to
handle this situation. It turned out that this postpones the PCI bus
initialization until after init, thus this patch.

The second patch is used to pass per-controller or per-host-bridge data
to the driver, such that it can be associated with the corresponding
bus. This is also required by the Tegra driver in order to pass a
driver-private structure to the PCI bus (or more precisely the
pci_sys_data structure associated with a bus). It is subsequently used
to obtain the root port private data given the corresponding PCI bus.

Note that v3 is pretty much the same as v2, except that it is rebased on
linux-next and contains the removal of the __init annotation from the
pcibios_init_resources() function which is only in linux-next.

Thierry

Thierry Reding (2):
  ARM: pci: Keep pci_common_init() around after init
  ARM: pci: Allow passing per-controller private data

 arch/arm/include/asm/mach/pci.h |  1 +
 arch/arm/kernel/bios32.c        | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.7.12

