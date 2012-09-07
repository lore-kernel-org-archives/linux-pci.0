Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36688 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646Ab2IGFAu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 7 Sep 2012 01:00:50 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Fri, 7 Sep 2012 01:00:49 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id CF779C9003E
	for <linux-pci@vger.kernel.org>; Fri,  7 Sep 2012 01:00:46 -0400 (EDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q8750kkH174738
	for <linux-pci@vger.kernel.org>; Fri, 7 Sep 2012 01:00:46 -0400
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q8750f0b016678
	for <linux-pci@vger.kernel.org>; Thu, 6 Sep 2012 23:00:43 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH V9 0/5] Minimal alignment for p2p bars
Date: Fri,  7 Sep 2012 13:00:30 +0800
Message-Id: <1346994035-16218-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

v1 -> v2:
	* Shorten the varaible names so that they looks more short.
        * Changelog adjustment so that they looks more meaningful.
v2 -> v3:
        * Rebase to 3.5.RC4
v3 -> v4:
        * Merge Yinghai's patches.
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
v8 -> v9:
	* Rebase to 3.6.RC4
	* Remove the original first 3 patches since they're irrevelant to the
	  intention.
	* Platform can override p2p I/O alignment even the p2p bridge explicitly
	  requires 1KiB I/O alignment according to Bjorn's comments.
	* In function pbus_size_io(), the maximal allowed I/O alignment was changed
	  from 4KiB to 1KiB for those p2p bridges that require 1KiB alignment, which
	  is traced by variable "io_align". I'm not sure that's correct for 100% since
	  the original implementation had 1KiB for "io_align" for the case.
	* Adjustment for pnv_pci_window_alignment() so that we can use the default
	  alignments (4KiB for I/O, 1MiB for memory) if the PCI bus isn't the top
	  level bus in the associated EEH segment.

Gavin Shan(5)
  pci: weak function returns alignment
  pci: resource assignment based on p2p alignment
  pci: refactor function pbus_size_mem
  ppc/pci: override pcibios_window_alignment
  ppc/pnv: I/O and memory alignment for p2p bridges

-----

arch/powerpc/include/asm/machdep.h        |    3 +
arch/powerpc/kernel/pci-common.c          |   20 +++++++
arch/powerpc/platforms/powernv/pci-ioda.c |   39 ++++++++++++++
drivers/pci/setup-bus.c                   |   81 +++++++++++++++++++++--------
include/linux/pci.h                       |    2 +
5 files changed, 124 insertions(+), 21 deletions(-)

Thanks,
Gavin

