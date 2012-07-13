Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:53188 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab2GMV5l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jul 2012 17:57:41 -0400
Received: by vbnl22 with SMTP id l22so388170vbn.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:40 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (bhelgaas.mtv.corp.google.com [172.18.96.155])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 52E7E100047
	for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:40 -0700 (PDT)
Received: from bhelgaas.mtv.corp.google.com (unknown [IPv6:::1])
	by bhelgaas.mtv.corp.google.com (Postfix) with ESMTP id 06ADF18004F
	for <linux-pci@vger.kernel.org>; Fri, 13 Jul 2012 14:57:39 -0700 (PDT)
Subject: [PATCH 0/2] Infrastructure for Vendor-Specific extended capabilities
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 13 Jul 2012 15:57:39 -0600
Message-ID: <20120713215258.21756.42132.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This adds pci_find_next_ext_capability(), analogous to
pci_find_next_capability(), which allows drivers to iterate through
multiple capabilities of the same type.

Many devices include multiple Vendor-Specific extended capabilities, for
example:

00:00.0 Host bridge: Intel Corporation Sandy Bridge DMI2 (rev 06)
  Capabilities: [100 v1] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
  Capabilities: [144 v1] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
  Capabilities: [1d0 v1] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
  Capabilities: [280 v1] Vendor Specific Information: ID=0004 Rev=2 Len=018 <?>


---

Bjorn Helgaas (2):
      PCI: add pci_find_next_ext_capability()
      PCI: add Vendor-Specific Extended Capability header info


 drivers/pci/pci.c        |   40 ++++++++++++++++++++++++++++++----------
 include/linux/pci.h      |    3 +--
 include/linux/pci_regs.h |    6 ++++++
 3 files changed, 37 insertions(+), 12 deletions(-)

-- 
Bjorn
