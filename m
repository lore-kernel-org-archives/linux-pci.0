Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:17444 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab2AUKYZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 21 Jan 2012 05:24:25 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [RFC PATCH 0/3] PCI: allocate pci bus num range for bridge scan
Date: Sat, 21 Jan 2012 02:24:05 -0800
Message-Id: <1327141448-15281-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2632ed3: PCI: kill pci_fixup_parent_subordinate_busnr()
5b951ec: PCI: Allocate bus range instead of use max blindly
b9459d8: PCI: Add iobusn_resource and insert root bus range to that tree.

set up iobusn_resource tree, and register bus number range it.
later when need to find bus range, will try to allocate from the tree

need to test on arches other than x86, to verify if root bus end finding
is right.

could be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-busn-alloc

Thanks

Yinghai

 arch/ia64/pci/pci.c              |    9 +
 arch/powerpc/kernel/pci-common.c |   12 ++-
 arch/x86/include/asm/topology.h  |    3 +-
 arch/x86/pci/acpi.c              |   15 ++-
 arch/x86/pci/bus_numa.c          |    8 +-
 arch/x86/pci/common.c            |   11 +-
 drivers/parisc/dino.c            |    9 +
 drivers/parisc/lba_pci.c         |    8 +
 drivers/pci/probe.c              |  298 +++++++++++++++++++++++++++++---------
 drivers/pci/remove.c             |    1 +
 include/linux/ioport.h           |    1 +
 include/linux/pci.h              |    5 +
 kernel/resource.c                |    8 +
 13 files changed, 310 insertions(+), 78 deletions(-)


