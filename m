Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53075 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755726AbaKASL0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 1 Nov 2014 14:11:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA1IBQ2s017851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2014 14:11:26 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Myron Stowe <mstowe@redhat.com>
Subject: [PATCH] pci, add FW_BUG warning to pci= kernel option
Date: Sat,  1 Nov 2014 14:11:19 -0400
Message-Id: <1414865479-25792-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The kernel should boot PCI without the use of kernel parameters.  Display
a FW_BUG warning when pci= is used.

Cc: Myron Stowe <mstowe@redhat.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/pci/pci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 625a4ac..5172060b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4515,6 +4515,8 @@ static int __init pci_setup(char *str)
 		}
 		str = k;
 	}
+	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
+	pr_crit(FW_BUG "The PCI configuration has been overridden thorugh the use of pci=.  Please report the issue you are attempting to resolve to your hardware vendor.\n");
 	return 0;
 }
 early_param("pci", pci_setup);
-- 
1.7.9.3

