Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:49950 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbaJNGrv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Oct 2014 02:47:51 -0400
Received: from /spool/local
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 14 Oct 2014 16:47:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 92C462CE8047
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:47:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id s9E6NDiW2883772
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:23:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s9E6lism018038
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2014 17:47:45 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 0/3] PCI: code clean up on pci configuration space
Date: Tue, 14 Oct 2014 14:47:29 +0800
Message-Id: <1413269253-8990-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series is a clean up in the pci subsystem when accessing the pci
configuration space.

The first one is to re-use the PCI_FIND_CAP_TTL to limit the times iterating
in pci configuration space.

The next two is to use the exact type to access the pci cap and pcie ext cap.

Tested on x86 and powerpc.

Wei Yang (3):
  PCI: move PCI_FIND_CAP_TTL to pci.h and use it in quirks
  PCI: use u8 instead of int for pci configuration space pos and cap
  PCI: use u16 instead of int for pci express extended capabilities pos
    and cap

 drivers/pci/iov.c    |    2 +-
 drivers/pci/pci.c    |   68 +++++++++++++++++++++++++-------------------------
 drivers/pci/probe.c  |   10 ++++----
 drivers/pci/quirks.c |   19 +++++++-------
 include/linux/pci.h  |   28 +++++++++++----------
 5 files changed, 65 insertions(+), 62 deletions(-)

-- 
1.7.9.5

