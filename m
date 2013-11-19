Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:34111 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab3KSGhI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 01:37:08 -0500
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 19 Nov 2013 12:07:06 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id AA44D125805E
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rAJ6awNU49676430
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:06:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rAJ6b1Qg008488
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2013 12:07:01 +0530
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yinghai@kernel.org
Subject: [RFC PATCH 0/3] Make 64-bit prefetchable MMIO work
Date: Tue, 19 Nov 2013 14:36:55 +0800
Message-Id: <1384843018-9479-1-git-send-email-yan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resource assignment code does not work properly after we expose 64-bit
prefetchable MMIO window in PowerNV platform.

  # ROM BAR get 4G-above address.
	This is because default value of PCIBIOS_MAX_MEM_32 is -1
	which makes it useless in 64-bit platform. After
	fixing this ...

  # ROM BAR can't get any address.
	This is because PCIBIOS_MAX_MEM_32 is actually a PCI address
	but functions as a CPU address. After fixing this ...

  # 64-bit prefetchable address is never used.
	This is because root bridge's IORESOURCE_MEM_64 is reset due to
	ROM BARs, which makes it not quilify to get 4G-above prefetchable
	address from host bridge. The 64-bit 4G-above prefetchable window
	is not used at all in the end.

Nothing is really broken currently. This is just a RFC series, preparing
for later PowerNV 64-bit MMIO work.

Guo Chao (3):
  PCI: do not compare CPU address with PCI address
  PCI: set proper default value of PCIBIOS_MAX_MEM_32
  PCI: do not reset bridge's IORESOURCE_MEM_64 flag for ROM BAR

 arch/x86/include/asm/pci.h |  1 -
 drivers/pci/bus.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/setup-bus.c    |  3 ++-
 include/linux/pci.h        |  2 +-
 4 files changed, 66 insertions(+), 5 deletions(-)

-- 
1.8.3.2

