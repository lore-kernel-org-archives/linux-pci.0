Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54703 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442AbbC2NnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Mar 2015 09:43:10 -0400
Date: Sun, 29 Mar 2015 15:43:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 78/86] linux/pci: drop include/linux/pci_ids.h
Message-ID: <1427635734-24786-79-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that everyone uses uapi/linux/pci_ids.h
directly, drop the wrapper from include/linux/.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/pci_ids.h | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 include/linux/pci_ids.h

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
deleted file mode 100644
index fd13521..0000000
--- a/include/linux/pci_ids.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <uapi/linux/pci_ids.h>
-- 
MST

