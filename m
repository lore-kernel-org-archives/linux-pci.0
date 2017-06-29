Return-Path: <linux-kernel-owner@vger.kernel.org>
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
Date: Wed, 28 Jun 2017 21:26:48 -0600
Message-Id: <20170629032648.3073-17-logang@deltatee.com>
In-Reply-To: <20170629032648.3073-1-logang@deltatee.com>
References: <20170629032648.3073-1-logang@deltatee.com>
Subject: [PATCH 16/16] switchtec_ntb: update switchtec documentation with notes for ntb
Sender: linux-kernel-owner@vger.kernel.org
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
