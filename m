Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:36113 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbdGRQE0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jul 2017 12:04:26 -0400
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
Date: Tue, 18 Jul 2017 10:04:09 -0600
Message-Id: <20170718160409.6493-17-logang@deltatee.com>
In-Reply-To: <20170718160409.6493-1-logang@deltatee.com>
References: <20170718160409.6493-1-logang@deltatee.com>
Subject: [PATCH v2 16/16] switchtec_ntb: update switchtec documentation with notes for NTB
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The switchtec_ntb driver has a couple requirements on the switchec's
hardware configuration so we add these notes to the documentation.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
---
 Documentation/switchtec.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
index a0a9c7b3d4d5..978a346e1fb3 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -78,3 +78,15 @@ The following IOCTLs are also supported by the device:
   between PCI Function Framework number (used by the event system)
   and Switchtec Logic Port ID and Partition number (which is more
   user friendly).
+
+
+Non-Transparent Bridge (NTB) Driver
+===================================
+
+An NTB driver is provided for the switchtec hardware in switchec_ntb.
+Currently, it only supports switches configured with exactly 2
+partitions. It also requires the following configuration settings:
+
+* Both partitions must be able to access each other's GAS spaces.
+  Thus, the bits in the GAS Access Vector under Management Settings
+  must be set to support this.
-- 
2.11.0
