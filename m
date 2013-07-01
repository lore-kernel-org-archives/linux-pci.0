Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:58488 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab3GAPLj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 11:11:39 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 1 Jul 2013 20:35:25 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5D15EE004F
	for <linux-pci@vger.kernel.org>; Mon,  1 Jul 2013 20:41:12 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r61FBUX320840562
	for <linux-pci@vger.kernel.org>; Mon, 1 Jul 2013 20:41:30 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r61FBVsZ024917
	for <linux-pci@vger.kernel.org>; Tue, 2 Jul 2013 01:11:33 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com,
	shangw@linux.vnet.ibm.com
Subject: [PATCH 2/4] PCI: add comment for pbus_size_mem() parameter
Date: Mon,  1 Jul 2013 23:10:30 +0800
Message-Id: <1372691432-6440-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1372691432-6440-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the comment of pbus_size_mem(), the comment of two parameters are missed.

This patch fills in the missing description for two parameters of
pbus_size_mem().

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
---
 drivers/pci/setup-bus.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b333f73..43dbe0a 100644
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

