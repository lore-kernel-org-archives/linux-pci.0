Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57667 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab2EEKFH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 5 May 2012 06:05:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pci@m.gmane.org>)
	id 1SQbrM-00059o-Fc
	for linux-pci@vger.kernel.org; Sat, 05 May 2012 12:05:04 +0200
Received: from 139.99.16.28 ([139.99.16.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sat, 05 May 2012 12:05:04 +0200
Received: from jlburr by 139.99.16.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pci@vger.kernel.org>; Sat, 05 May 2012 12:05:04 +0200
To: linux-pci@vger.kernel.org
From: "J.L. Burr" <jlburr@cadence.com>
Subject: [PATCH] pciutils: correct VC status display
Date: Sat, 05 May 2012 06:02:27 -0400
Message-ID: <4FA4FAB3.9060904@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: mj@ucw.cz
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I think there is a bug displaying the virtual channel status bits
"NegoPending" and "InProgress".  The wrong offset is being used.

Signed-off-by: John L. Burr <jlburr@cadence.com>
---

diff --git a/ls-ecaps.c b/ls-ecaps.c
index cd342aa..161c275 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -339,7 +339,7 @@ cap_vc(struct device *d, int where)
 	}
       rcap = get_conf_long(d, pos);
       rctrl = get_conf_long(d, pos+4);
-      rstatus = get_conf_word(d, pos+8);
+      rstatus = get_conf_word(d, pos+10);

       pat_pos = BITS(rcap, 24, 8);
       printf("Caps:\tPATOffset=%02x MaxTimeSlots=%d RejSnoopTrans%c\n",

