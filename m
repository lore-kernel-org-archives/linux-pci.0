Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753293AbdKVWuu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 17:50:50 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 23/29] staging: rts5208: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:18 -0500
Message-Id: <1511390964-9979-24-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Remove unused rtsx_read_pci_cfg_byte() function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/staging/rts5208/rtsx.c | 17 -----------------
 drivers/staging/rts5208/rtsx.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index 89e2cfe..70e0b86 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -275,23 +275,6 @@ static int rtsx_acquire_irq(struct rtsx_dev *dev)
 	return 0;
 }
 
-int rtsx_read_pci_cfg_byte(u8 bus, u8 dev, u8 func, u8 offset, u8 *val)
-{
-	struct pci_dev *pdev;
-	u8 data;
-	u8 devfn = (dev << 3) | func;
-
-	pdev = pci_get_bus_and_slot(bus, devfn);
-	if (!pdev)
-		return -1;
-
-	pci_read_config_byte(pdev, offset, &data);
-	if (val)
-		*val = data;
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 /*
  * power management
diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
index 575e573..62e467c 100644
--- a/drivers/staging/rts5208/rtsx.h
+++ b/drivers/staging/rts5208/rtsx.h
@@ -174,8 +174,6 @@ static inline void get_current_time(u8 *timeval_buf, int buf_len)
 /* struct scsi_cmnd transfer buffer access utilities */
 enum xfer_buf_dir	{TO_XFER_BUF, FROM_XFER_BUF};
 
-int rtsx_read_pci_cfg_byte(u8 bus, u8 dev, u8 func, u8 offset, u8 *val);
-
 #define _MSG_TRACE
 
 #include "trace.h"
-- 
1.9.1
