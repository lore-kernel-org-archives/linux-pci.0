Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 1/4] misc: mic: Add include of <linux/irqreturn.h>
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: e1000-devel@lists.sourceforge.net, Joerg Roedel <joro@8bytes.org>,
	Sudeep Dutt <sudeep.dutt@intel.com>,
	linux-kernel@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	iommu@lists.linux-foundation.org,
	Tomas Winkler <tomas.winkler@intel.com>,
	Aaron F Brown <aaron.f.brown@intel.com>,
	Arjan van de Ven <arjan@linux.intel.com>
Date: Tue, 18 Feb 2014 13:59:39 -0700
Message-ID: <20140218205939.11014.41761.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We currently include <linux/irqreturn.h> in <linux/pci.h>, but I'm about to
remove that from linux/pci.h, so add explicit includes where needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/mic/card/mic_device.h |    1 +
 drivers/misc/mic/host/mic_device.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/mic/card/mic_device.h b/drivers/misc/mic/card/mic_device.h
index 347b9b3b7916..306f502be95e 100644
--- a/drivers/misc/mic/card/mic_device.h
+++ b/drivers/misc/mic/card/mic_device.h
@@ -29,6 +29,7 @@
 
 #include <linux/workqueue.h>
 #include <linux/io.h>
+#include <linux/irqreturn.h>
 
 /**
  * struct mic_intr_info - Contains h/w specific interrupt sources info
diff --git a/drivers/misc/mic/host/mic_device.h b/drivers/misc/mic/host/mic_device.h
index 1a6edce2ecde..0398c696d257 100644
--- a/drivers/misc/mic/host/mic_device.h
+++ b/drivers/misc/mic/host/mic_device.h
@@ -24,6 +24,7 @@
 #include <linux/cdev.h>
 #include <linux/idr.h>
 #include <linux/notifier.h>
+#include <linux/irqreturn.h>
 
 #include "mic_intr.h"
 

