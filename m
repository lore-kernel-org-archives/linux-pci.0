Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42052 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932532AbbC2Nly (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Mar 2015 09:41:54 -0400
Date: Sun, 29 Mar 2015 15:41:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 58/86] pci-label: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-59-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci-label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 2ab1b47..cf250c1 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -23,7 +23,7 @@
 #include <linux/dmi.h>
 #include <linux/sysfs.h>
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/nls.h>
-- 
MST

