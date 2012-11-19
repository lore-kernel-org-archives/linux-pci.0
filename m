Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41487 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab2KSSet (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Nov 2012 13:34:49 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 385/493] pci: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:34 -0500
Message-Id: <1353349642-3677-385-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-pci@vger.kernel.org 
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34862da..ea9533b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -589,7 +589,7 @@ struct pci_driver {
  * in a generic manner.
  */
 #define DEFINE_PCI_DEVICE_TABLE(_table) \
-	const struct pci_device_id _table[] __devinitconst
+	const struct pci_device_id _table[]
 
 /**
  * PCI_DEVICE - macro used to describe a specific pci device
-- 
1.8.0

