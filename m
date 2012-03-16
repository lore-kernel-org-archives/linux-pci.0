Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f202.google.com ([209.85.212.202]:44885 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946153Ab2CPX4G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:56:06 -0400
Received: by wibhj13 with SMTP id hj13so60267wib.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:56:05 -0700 (PDT)
Subject: [PATCH v2 0/7] PCI core support for bus-to-resource offsets (fixes)
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Fri, 16 Mar 2012 17:47:53 -0600
Message-ID: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a set of incremental fixes related to my recent "remove device
resource fixups" series.

These apply to 63ab387ca0, the current head of Jesse's linux-next branch.
The result is the same as the updated patches I posted here:

  git://github.com/bjorn-helgaas/linux.git pci-probe_only-and-offset-v3-5eb2c1f

except that I removed the EN1K bridge I/O window rework, since it's not
necessary for the merge window.

Having these as incremental fixes means there's a stretch where bisection is
broken for powerpc and sparc platforms that use the device tree.  That's
unfortunate, but it's too late to ask Jesse to rebase his linux-next branch
and pull in the updated full patches.

Changes since v1 of these incremental fixes:
  - dropped the EN1K reimplementation; I'll repost this later
  - added changelog notes about bisection being broken on powerpc & sparc
  - powerpc: added patch to allow reallocation on PA Semi
  - sparc: there was no pci_resource_adjust() in pci_parse_of_addrs(), so
    I dropped the pcibios_bus_to_resource() I had added there
---

Bjorn Helgaas (7):
      PCI: fix bridge I/O window bus-to-resource conversion
      arm/PCI: don't export pci_flags
      powerpc/PCI: compute I/O space bus-to-resource offset consistently
      powerpc/PCI: convert devtree bus addresses to resource
      powerpc/PCI: allow reallocation on PA Semi
      sparc/PCI: convert devtree and arch-probed bus addresses to resource
      unicore32/PCI: move <asm-generic/pci-bridge.h> include to asm/pci.h


 arch/arm/kernel/bios32.c            |    1 -
 arch/powerpc/include/asm/pci.h      |    1 +
 arch/powerpc/kernel/pci-common.c    |    8 ++++-
 arch/powerpc/kernel/pci_32.c        |    6 ++--
 arch/powerpc/kernel/pci_64.c        |    2 +
 arch/powerpc/kernel/pci_of_scan.c   |   12 +++++--
 arch/powerpc/platforms/pasemi/pci.c |    3 --
 arch/sparc/kernel/pci.c             |   60 +++++++++++++++--------------------
 arch/unicore32/include/asm/pci.h    |    1 +
 arch/unicore32/kernel/pci.c         |    1 -
 drivers/pci/probe.c                 |    1 +
 11 files changed, 46 insertions(+), 50 deletions(-)

-- 
Bjorn
