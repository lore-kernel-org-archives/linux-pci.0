Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:35430 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbaEMBff (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 May 2014 21:35:35 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 13 May 2014 11:35:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/4] drivers/vfio: Rework offsetofend()
Date: Tue, 13 May 2014 11:35:22 +1000
Message-Id: <1399944924-1200-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399944924-1200-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399944924-1200-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The macro offsetofend() introduces unnecessary temporary variable
"tmp". The patch avoids that and saves a bit memory in stack.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 include/linux/vfio.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 81022a52..8ec980b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -86,9 +86,8 @@ extern void vfio_unregister_iommu_driver(
  * from user space.  This allows us to easily determine if the provided
  * structure is sized to include various fields.
  */
-#define offsetofend(TYPE, MEMBER) ({				\
-	TYPE tmp;						\
-	offsetof(TYPE, MEMBER) + sizeof(tmp.MEMBER); })		\
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
 
 /*
  * External user API
-- 
1.8.3.2

