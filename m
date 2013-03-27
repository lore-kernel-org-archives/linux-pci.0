Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:54708 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451Ab3C0I4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Mar 2013 04:56:12 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Wed, 27 Mar 2013 04:56:11 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 755D238C801A
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:09 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r2R8u972335098
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 04:56:09 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r2R8u8kT002184
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2013 05:56:09 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Retrieve MSI/MSIX cap struct for once on setup
Date: Wed, 27 Mar 2013 16:56:00 +0800
Message-Id: <1364374564-19096-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While we setup MSI or MSI-X for specific PCI device, the address of
MSI or MSI-X capability structure is figured out from the config
space for multiple times. That's unnecessary and the patchset addresses
that. With the patchset applied, the latency for MSI or MSI-X setup
would be decreased hopefully.

drivers/pci/msi.c               |   51 ++++++++++++++++++++------------------
drivers/pci/pcie/portdrv_core.c |    2 +-
include/linux/pci.h             |    4 +-
3 files changed, 30 insertions(+), 27 deletions(-)

Thanks,
Gavin

