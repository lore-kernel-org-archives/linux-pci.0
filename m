Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:56730 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbF3BQy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 21:16:54 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 30 Jun 2015 06:46:51 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id A658CE004C
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 06:50:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5U1GmTM60424374
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 06:46:48 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5U1Gl0W022630
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 06:46:48 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2 0/4] PCI: code clean up on pci configuration space
Date: Tue, 30 Jun 2015 09:16:40 +0800
Message-Id: <1435627004-6029-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series is a clean up in the pci subsystem when accessing the pci
configuration space.

The first one is to re-use the PCI_FIND_CAP_TTL to limit the times iterating
in pci configuration space.

The next three are to use the exact type to access the pci cap and pcie ext
cap.

Tested on x86 and powerpc on top of v4.1.

The original thread could be referenced in below link:
http://comments.gmane.org/gmane.linux.kernel.pci/35931

---
v1->v2:
   * define PCI_FIND_CAP_TTL in drivers/pci/pci.h instead of
     include/linux/pci.h
   * split the change for return position check from second one, and make the
     forth patch

Wei Yang (4):
  PCI: move PCI_FIND_CAP_TTL to pci.h and use it in quirks
  PCI: use u8 to represent pci configuration space pos and cap
  PCI: use u16 to represent pci express extended capabilities pos and
    cap
  PCI: consolidate return value check for pci_find_(ext_)capability

 drivers/pci/iov.c    |    2 +-
 drivers/pci/pci.c    |   68 +++++++++++++++++++++++++-------------------------
 drivers/pci/pci.h    |    2 ++
 drivers/pci/probe.c  |   10 ++++----
 drivers/pci/quirks.c |   19 +++++++-------
 include/linux/pci.h  |   26 +++++++++----------
 6 files changed, 65 insertions(+), 62 deletions(-)

-- 
1.7.9.5

