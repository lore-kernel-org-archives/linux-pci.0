Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51246 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab2HTNqx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Aug 2012 09:46:53 -0400
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Mon, 20 Aug 2012 09:46:52 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CF861C9005C
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:49 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q7KDkeeF2818092
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 09:46:43 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q7KDkdSC009769
	for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 10:46:40 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	yinghai@kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH V8 0/8] Minimal alignment for p2p bars
Date: Mon, 20 Aug 2012 21:46:27 +0800
Message-Id: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v1 -> v2:
	* Shorten the varaible names so that they looks more short.
        * Changelog adjustment so that they looks more meaningful.

v2 -> v3:
        * Rebase to 3.5.RC4

v3 -> v4:
        * Merge Yinghai's patches.

v3 -> v4:
        * Split patch for easy review.
        * Add function to retrieve the minimal alignment of p2p bridge.

v4 -> v5:
        * Rebase to 3.5.RC7
        * Introduce weak function pcibios_window_alignment() to retrieve
          I/O and memory alignment for P2P bridges.
        * Introduce pcibios_window_alignment() for ppc to override the
          PCI function.
        * Add ppc_md.pcibios_window_alignment() for specific platform like
          powernv can override ppc's pcibios_window_alignment().

v5 -> v6:
        * Refactor pcibios_window_alignment() so the platform-specific
          implementation needn't return the default alignment according
          to Bjorn's suggestion.
        * Simplify pbus_size_mem() according to Bjorn's suggestion: Just
          check the platform required alignment at very end and adjust
          the "min_align" if necessary.

v6 -> v7:
        * Change "type" to "b_res->flags & mask" while retrieving the
          minimal alignment for memory window according to Ram's suggestion.
        * Refactor pbus_size_mem() according to Ram's suggestion.
        * ppc_md.pcibios_window_alignment returns 1 for those PCI bridges
          behind PCI bridges so that PCI core will use default alignment
          values.

v7 -> v8:
	* Rebase to 3.6.RC2, which starts to use "struct resource" to represent
	  the range of PCI bus numbers that specific p2p bridge covers.
	* Define macros for the default alignment of P2P bars according to
	  Richard's comments.

Lu Yinghai(3):
  pci: change variable name for find_pci_host_bridge
  pci: argument pci_bus for find_pci_host_bridge
  pci: fiddle with conversion of pci and CPU address

Gavin Shan(5)
  pci: weak function returns alignment
  pci: resource assignment based on p2p alignment
  pci: refactor function pbus_size_mem
  ppc/pci: override pcibios_window_alignment
  ppc/pnv: I/O and memory alignment for p2p bridges

-----

arch/powerpc/include/asm/machdep.h        |    3 +
arch/powerpc/kernel/pci-common.c          |   20 ++++++++
arch/powerpc/platforms/powernv/pci-ioda.c |   38 +++++++++++++++
drivers/pci/host-bridge.c                 |   35 +++++++++-----
drivers/pci/setup-bus.c                   |   74 ++++++++++++++++++++++------
include/linux/pci.h                       |    7 ++-
6 files changed, 148 insertions(+), 29 deletions(-)

Thanks,
Gavin

