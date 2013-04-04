Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:48201 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758672Ab3DDLjl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 07:39:41 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 07:39:39 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B783E38C8051
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 07:39:36 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34BdasR298348
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:36 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34BdaXJ009707
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 07:39:36 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH v2 0/5] Retrieve MSI/MSIX cap struct for once on setup
Date: Thu,  4 Apr 2013 19:39:27 +0800
Message-Id: <1365075572-20763-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While we setup MSI or MSI-X for specific PCI device, the address of
MSI or MSI-X capability structure is figured out from the config
space for multiple times. That's unnecessary and the patchset addresses
that. With the patchset applied, the latency for MSI or MSI-X setup
would be decreased hopefully.

v1 -> v2:
	* Cache the MSI/MSI-X capability offset to pci_dev directly according
	  to Bjorn's suggestion.
	* Rebase to 3.9.RC5

drivers/pci/msi.c   |  102 +++++++++++++++++++++++++--------------------------
include/linux/pci.h |    2 +
2 files changed, 52 insertions(+), 52 deletions(-)

Thanks,
Gavin

