Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:54168 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbbBME4C (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Feb 2015 23:56:02 -0500
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 13 Feb 2015 14:56:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E5BC3578048
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2015 15:55:58 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t1D4tohd40108254
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2015 15:55:58 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t1D4tOjE013548
	for <linux-pci@vger.kernel.org>; Fri, 13 Feb 2015 15:55:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	cascardo@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Support registering specific reset handler
Date: Fri, 13 Feb 2015 15:54:55 +1100
Message-Id: <1423803299-22356-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

VFIO PCI infrastructure depends on pci_reset_function() to do reset on
PCI devices so that they would be in clean state when host or guest grabs
them. Unfortunately, the function doesn't work (or not well) on some PCI
devices that require EEH PE reset.

The patchset extends the quirk for PCI device speicific reset methods to
allow dynamically registration. With it, we can translate reset requests
for those special PCI devcies to EEH PE reset, which is only avaialble on
64-bits PowerPC platforms.

Gavin Shan (4):
  PCI: Rename struct pci_dev_reset_methods
  PCI: Introduce list for device reset methods
  PCI: Allow registering reset method
  powerpc/powernv: Register PCI dev specific reset handlers

 arch/powerpc/platforms/powernv/pci.c |  61 +++++++++++++++
 drivers/pci/pci.h                    |   3 +-
 drivers/pci/quirks.c                 | 139 ++++++++++++++++++++++++++++++-----
 include/linux/pci.h                  |   9 +++
 4 files changed, 192 insertions(+), 20 deletions(-)

-- 
1.8.3.2

