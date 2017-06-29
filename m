Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:49002 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdF2D1F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2017 23:27:05 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 28 Jun 2017 21:26:34 -0600
Message-Id: <20170629032648.3073-3-logang@deltatee.com>
In-Reply-To: <20170629032648.3073-1-logang@deltatee.com>
References: <20170629032648.3073-1-logang@deltatee.com>
Subject: [PATCH 02/16] switchtec: export class symbol for use in upper layer driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We export the class pointer symbol and add an extern define in the
switchtec header file.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 drivers/pci/switch/switchtec.c | 4 +++-
 include/linux/switchtec.h      | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index a27b2bacad5a..fc139ee3fa73 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -33,9 +33,11 @@ module_param(max_devices, int, 0644);
 MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
 
 static dev_t switchtec_devt;
-static struct class *switchtec_class;
 static DEFINE_IDA(switchtec_minor_ida);
 
+struct class *switchtec_class;
+EXPORT_SYMBOL_GPL(switchtec_class);
+
 enum mrpc_state {
 	MRPC_IDLE = 0,
 	MRPC_QUEUED,
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 508cda78a430..24e598ebbcf7 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -267,4 +267,6 @@ static inline struct switchtec_dev *to_stdev(struct device *dev)
 	return container_of(dev, struct switchtec_dev, dev);
 }
 
+extern struct class *switchtec_class;
+
 #endif
-- 
2.11.0
