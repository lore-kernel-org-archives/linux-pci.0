Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, Sinan Kaya <okaya@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 23/29] staging: rts5208: remove rtsx_read_pci_cfg_byte()
Date: Mon, 27 Nov 2017 11:58:00 -0500
Message-Id: <1511801886-6753-24-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
References: <1511801886-6753-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
