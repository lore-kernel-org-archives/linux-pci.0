Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932757AbeCITAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:00:39 -0500
Subject: [PATCH v2 09/13] PCI/portdrv: Remove unnecessary include of
 <linux/pci-aspm.h>
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:00:38 -0600
Message-ID: <152062203834.77693.14346655067368975701.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

portdrv_pci.c doesn't use anything from <linux/pci-aspm.h>.  Remove the
include of it.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/portdrv_pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 127321e17184..1997d9f2743e 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -17,7 +17,6 @@
 #include <linux/init.h>
 #include <linux/aer.h>
 #include <linux/dmi.h>
-#include <linux/pci-aspm.h>
 
 #include "../pci.h"
 #include "portdrv.h"
