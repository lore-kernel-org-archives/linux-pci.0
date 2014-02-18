Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:62709 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaBRU7z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 15:59:55 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so19293132obc.10
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2014 12:59:54 -0800 (PST)
Subject: [PATCH v2 3/4] iommu/amd: Add include of <linux/irqreturn.h>
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
Date: Tue, 18 Feb 2014 13:59:52 -0700
Message-ID: <20140218205952.11014.27095.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140218205925.11014.14973.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We currently include <linux/irqreturn.h> in <linux/pci.h>, but I'm about to
remove that from linux/pci.h, so add explicit includes where needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/amd_iommu_types.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e400fbe411de..cff039df056e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
+#include <linux/irqreturn.h>
 
 /*
  * Maximum number of IOMMUs supported

