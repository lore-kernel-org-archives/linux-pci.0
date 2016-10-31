Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
Cc: david.vrabel@citrix.com, boris.ostrovsky@oracle.com,
        Juergen Gross <jgross@suse.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org
Subject: [PATCH 08/12] xen: make use of xenbus_read_unsigned() in xen-pcifront
Date: Mon, 31 Oct 2016 17:48:26 +0100
Message-Id: <1477932510-28594-9-git-send-email-jgross@suse.com>
In-Reply-To: <1477932510-28594-1-git-send-email-jgross@suse.com>
References: <1477932510-28594-1-git-send-email-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use xenbus_read_unsigned() instead of xenbus_scanf() when possible.
This requires to change the type of the read from int to unsigned,
but this case has been wrong before: negative values are not allowed
for the modified case.

Cc: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/pci/xen-pcifront.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index d6ff5e8..8fc2e95 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -1038,10 +1038,8 @@ static int pcifront_detach_devices(struct pcifront_device *pdev)
 			err = -ENOMEM;
 			goto out;
 		}
-		err = xenbus_scanf(XBT_NIL, pdev->xdev->otherend, str, "%d",
-				   &state);
-		if (err != 1)
-			state = XenbusStateUnknown;
+		state = xenbus_read_unsigned(pdev->xdev->otherend, str,
+					     XenbusStateUnknown);
 
 		if (state != XenbusStateClosing)
 			continue;
-- 
2.6.6
