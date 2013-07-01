Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:42712 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3GAPLG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 11:11:06 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 2 Jul 2013 00:59:19 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 270842CE804A
	for <linux-pci@vger.kernel.org>; Tue,  2 Jul 2013 01:11:01 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r61Eu41I6553880
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 00:56:04 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r61FB0p4029020
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 01:11:00 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	shangw@linux.vnet.ibm.com
Subject: [PATCH 0/4] optimization/fix/cleanup in pci_assign_unassigned_resources
Date: Mon,  1 Jul 2013 23:10:28 +0800
Message-Id: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here is some patches do the optimization/fix/cleanup for the function
pci_assign_unassigned_resources().

Wei Yang (4):
  PCI: optimize pci_bus_get_depth() by enumerating on pci bus hierachy
  PCI: add comment for pbus_size_mem() parameter
  PCI: trivial cleanup in pbus_size_io()
  PCI: fix the io resource alignment calculation in pbus_size_io()

 drivers/pci/setup-bus.c |   56 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 42 insertions(+), 14 deletions(-)

-- 
1.7.5.4

