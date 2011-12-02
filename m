Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:3857 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab1LBVsy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2011 16:48:54 -0500
Date: Fri, 2 Dec 2011 15:48:52 -0600
From: Mike Miller <mike.miller@hp.com>
To: linux-pci@vger.kernel.org
Cc: janitors@vger.kernel.org
Subject: [PATCH 1/1] Add Gen3 PCIe speed (8GT/s) to lspci
Message-ID: <20111202214852.GB6210@beardog.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Patch 1 of 1

Right now lspci shows "Speed unknown" for PCIe Gen3 links. This two liner
adds 8GT/s to fix that. I don't think the next link rate has yet been
decided. So I only go to Gen3.

Tested on PCIe Gen1, Gen2, and Gen3 systems.

From: Mike Miller <mike.miller@hp.com>
Signed-off-by: Mike Miller <mike.miller@hp.com>

---
 ls-caps.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/ls-caps.c b/ls-caps.c
index a4bf713..d8862b4 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -717,6 +717,8 @@ static char *link_speed(int speed)
 	return "2.5GT/s";
       case 2:
 	return "5GT/s";
+      case 3:
+	return "8GT/s";
       default:
 	return "unknown";
     }
