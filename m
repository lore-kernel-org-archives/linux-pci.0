Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:58418 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758247Ab3HBJdo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 05:33:44 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 2 Aug 2013 14:58:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4156DE0055
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2013 15:03:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r729XYpD45219970
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 15:03:34 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r729XYa3030961
	for <linux-pci@vger.kernel.org>; Fri, 2 Aug 2013 19:33:36 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: linuxram@us.ibm.com, shangw@linux.vnet.ibm.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 2/4] PCI: add comment for pbus_size_mem() parameter
Date: Fri,  2 Aug 2013 17:31:04 +0800
Message-Id: <1375435866-16332-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1375435866-16332-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the comment of pbus_size_mem(), the comment of two parameters are missed.

This patch fills in the missing description for two parameters of
pbus_size_mem().

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6dbe562..939ca1b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -838,6 +838,8 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
  * pbus_size_mem() - size the memory window of a given bus
  *
  * @bus : the bus
+ * @mask: mask the resource flag, then compare it with type
+ * @type: the type of free resource from bridge
  * @min_size : the minimum memory window that must to be allocated
  * @add_size : additional optional memory window
  * @realloc_head : track the additional memory window on this list
-- 
1.7.5.4

