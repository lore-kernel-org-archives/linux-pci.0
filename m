Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39951 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbbKDVUY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Nov 2015 16:20:24 -0500
From: ville.syrjala@linux.intel.com
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/29] pci: Decouple quirks.c from i915_reg.h
Date: Wed,  4 Nov 2015 23:19:49 +0200
Message-Id: <1446672017-24497-2-git-send-email-ville.syrjala@linux.intel.com>
In-Reply-To: <1446672017-24497-1-git-send-email-ville.syrjala@linux.intel.com>
References: <1446672017-24497-1-git-send-email-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

i915 register defines are going to become type safe, so going forward
the register defines can't be used as straight numbers. Since quirks.c
needs just a few extra register defines from i915_reg.h, decouple the
two by defining the required registers locally in quirks.c. This was
already done for a few other igpu related registers.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/pci/quirks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b03373f..78a70fb 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3404,7 +3404,9 @@ static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, int probe)
 	return 0;
 }
 
-#include "../gpu/drm/i915/i915_reg.h"
+#define SOUTH_CHICKEN2		0xc2004
+#define PCH_PP_STATUS		0xc7200
+#define PCH_PP_CONTROL		0xc7204
 #define MSG_CTL			0x45010
 #define NSDE_PWR_STATE		0xd0100
 #define IGD_OPERATION_TIMEOUT	10000     /* set timeout 10 seconds */
-- 
2.4.10

