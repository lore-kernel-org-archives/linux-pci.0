Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 29 Mar 2015 15:43:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 77/86] linux/pci: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-78-git-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427635734-24786-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Header moved from linux/pci_ids.h to uapi/linux/pci_ids.h,
use the new header directly so we can drop
the wrapper in include/linux/pci_ids.h.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index ef15f91..67a371d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -32,7 +32,7 @@
 #include <linux/resource_ext.h>
 #include <uapi/linux/pci.h>
 
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 
 /*
  * The PCI interface treats multi-function devices as independent
-- 
MST

