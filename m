Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:34218 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756576AbcILEuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2016 00:50:35 -0400
From: Adit Ranadive <aditr@vmware.com>
To: <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
CC: Adit Ranadive <aditr@vmware.com>, <netdev@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <jhansen@vmware.com>,
        <asarwade@vmware.com>, <georgezhang@vmware.com>,
        <bryantan@vmware.com>
Subject: [PATCH v4 08/16] IB/pvrdma: Add device command support
Date: Sun, 11 Sep 2016 21:49:18 -0700
Message-ID: <1473655766-31628-9-git-send-email-aditr@vmware.com>
In-Reply-To: <1473655766-31628-1-git-send-email-aditr@vmware.com>
References: <1473655766-31628-1-git-send-email-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables posting Verb requests and receiving responses to/from
the backend PVRDMA emulation layer.

Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Reviewed-by: George Zhang <georgezhang@vmware.com>
Reviewed-by: Aditya Sarwade <asarwade@vmware.com>
Reviewed-by: Bryan Tan <bryantan@vmware.com>
Signed-off-by: Adit Ranadive <aditr@vmware.com>
---
Changes v3->v4:
 - Removed the min check and added a BUILD_BUG_ON check for size.

Changes v2->v3:
 - Converted pvrdma_cmd_recv to inline.
 - Added a min check in the memcpy to cmd_slot.
 - Removed the boolean from pvrdma_cmd_post.
---
 drivers/infiniband/hw/pvrdma/pvrdma_cmd.c | 108 ++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 drivers/infiniband/hw/pvrdma/pvrdma_cmd.c

diff --git a/drivers/infiniband/hw/pvrdma/pvrdma_cmd.c b/drivers/infiniband/hw/pvrdma/pvrdma_cmd.c
new file mode 100644
index 0000000..827e3ff
--- /dev/null
+++ b/drivers/infiniband/hw/pvrdma/pvrdma_cmd.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of EITHER the GNU General Public License
+ * version 2 as published by the Free Software Foundation or the BSD
+ * 2-Clause License. This program is distributed in the hope that it
+ * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
+ * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
+ * See the GNU General Public License version 2 for more details at
+ * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program available in the file COPYING in the main
+ * directory of this source tree.
+ *
+ * The BSD 2-Clause License
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
+ * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/list.h>
+
+#include "pvrdma.h"
+
+#define PVRDMA_CMD_TIMEOUT	10000 /* ms */
+
+static inline int pvrdma_cmd_recv(struct pvrdma_dev *dev,
+				  union pvrdma_cmd_resp *resp)
+{
+	dev_dbg(&dev->pdev->dev, "receive response from device\n");
+
+	spin_lock(&dev->cmd_lock);
+	memcpy(resp, dev->resp_slot, sizeof(*resp));
+	spin_unlock(&dev->cmd_lock);
+
+	return 0;
+}
+
+int
+pvrdma_cmd_post(struct pvrdma_dev *dev, union pvrdma_cmd_req *req,
+		union pvrdma_cmd_resp *resp)
+{
+	int err;
+
+	dev_dbg(&dev->pdev->dev, "post request to device\n");
+
+	/* Serializiation */
+	down(&dev->cmd_sema);
+
+	BUILD_BUG_ON(sizeof(union pvrdma_cmd_req) !=
+		     sizeof(struct pvrdma_cmd_modify_qp));
+
+	spin_lock(&dev->cmd_lock);
+	memcpy(dev->cmd_slot, req, sizeof(*req));
+	spin_unlock(&dev->cmd_lock);
+
+	init_completion(&dev->cmd_done);
+	pvrdma_write_reg(dev, PVRDMA_REG_REQUEST, 0);
+
+	/* Make sure the request is written before reading status. */
+	mb();
+	err = pvrdma_read_reg(dev, PVRDMA_REG_ERR);
+	if (err == 0) {
+		if (resp != NULL) {
+			err = wait_for_completion_interruptible_timeout(
+				&dev->cmd_done,
+				msecs_to_jiffies(PVRDMA_CMD_TIMEOUT));
+			if (err == 0 || err == -ERESTARTSYS) {
+				dev_err(&dev->pdev->dev,
+					"completion timeout or interrupted\n");
+				err = -ETIMEDOUT;
+			} else {
+				err = pvrdma_cmd_recv(dev, resp);
+			}
+		}
+	} else {
+		dev_warn(&dev->pdev->dev, "failed to write request %d\n", err);
+	}
+
+	up(&dev->cmd_sema);
+
+	return err;
+}
-- 
2.7.4

