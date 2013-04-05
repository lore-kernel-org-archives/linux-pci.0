Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:50380 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161460Ab3DECym (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Apr 2013 22:54:42 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 22:54:40 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6059738C8029
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 22:54:37 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r352sbDT316552
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 22:54:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r352sanp017434
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 22:54:37 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH v3 0/5] Retrieve MSI/MSIX cap struct for once on setup
Date: Fri,  5 Apr 2013 10:54:29 +0800
Message-Id: <1365130473-7413-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While we setup MSI or MSI-X for specific PCI device, the address of
MSI or MSI-X capability structure is figured out from the config
space for multiple times. That's unnecessary and the patchset addresses
that. With the patchset applied, the latency for MSI or MSI-X setup
would be decreased hopefully.

v2 -> v3:
	* Remove checking on MSI/MSI-X capability offset in msi_set_enable()
	  and msix_set_enable(). Let the caller does the check
	* Using "u8" for MSI/MSI-X/PM capability
	* Let caller of pci_msi_check_device() checks MSI/MSI-X capability
	* Replace msi_control_reg() with "pos + PCI_MSI_FLAGS"
	* Merge [4/5] to [3/5]
v1 -> v2:
	* Cache the MSI/MSI-X capability offset to pci_dev directly according
	  to Bjorn's suggestion.
	* Rebase to 3.9.RC5

---

drivers/pci/msi.c   |  110 +++++++++++++++++++++++----------------------------
drivers/pci/msi.h   |    1 -
include/linux/pci.h |    4 +-
3 files changed, 52 insertions(+), 63 deletions(-)

Thanks,
Gavin

