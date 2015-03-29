Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 29 Mar 2015 15:38:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 12/86] x86/pci/sta2x11: use uapi/linux/pci_ids.h directly
Message-ID: <1427635734-24786-13-git-send-email-mst@redhat.com>
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
 arch/x86/pci/sta2x11-fixup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index 5ceda85..96e5e10 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -23,7 +23,7 @@
  */
 
 #include <linux/pci.h>
-#include <linux/pci_ids.h>
+#include <uapi/linux/pci_ids.h>
 #include <linux/export.h>
 #include <linux/list.h>
 
-- 
MST

