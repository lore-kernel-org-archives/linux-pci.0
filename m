Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v3 18/18] NTB: Increase transport MTU to 64k from 16k
Date: Tue,  9 Jun 2015 05:44:45 -0400
Message-Id: <aba15cd979bc3523c0289f4766b47d3f45f32c38.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Dave Jiang <dave.jiang@intel.com>

Benchmarking showed significant performance increase going from MTU size
of 64k from 16k.  Changing the default.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index ea237aeca28c..c87bc0cbd607 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -76,7 +76,7 @@ static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
 MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
 
-static unsigned int transport_mtu = 0x401E;
+static unsigned int transport_mtu = 0x10000;
 module_param(transport_mtu, uint, 0644);
 MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
 
-- 
2.4.0.rc0.43.gcf8a8c6

