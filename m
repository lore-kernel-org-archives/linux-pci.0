Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:46762 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758160Ab3HBJcg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 05:32:36 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 14:55:06 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id AD5371258052
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2013 15:01:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r729WLQB5898244
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 15:02:21 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r729WM6B027336
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 19:32:24 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linuxram@us.ibm.com, shangw@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 0/4] optimization/fix/cleanup in pci_assign_unassigned_resources
Date: Fri,  2 Aug 2013 17:31:02 +0800
Message-Id: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here is some patches do the optimization/fix/cleanup for the function
pci_assign_unassigned_resources().

Wei Yang (4):
  PCI: optimize pci_bus_get_depth() by enumerating on pci bus hierachy
  PCI: add comment for pbus_size_mem() parameter
  PCI: trivial cleanup in pbus_size_io()
  PCI: fix the io resource alignment calculation in pbus_size_io()

 drivers/pci/setup-bus.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.7.5.4

