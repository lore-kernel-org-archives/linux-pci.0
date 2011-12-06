Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:10420 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab1LFTQL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2011 14:16:11 -0500
Date: Tue, 6 Dec 2011 13:16:05 -0600
From: Mike Miller <mike.miller@hp.com>
To: mj@ucw.cz
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 1/1] pciutils: add 8TB/s to link capabilities
Message-ID: <20111206191605.GA11235@beardog.cce.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Right now lspci shows "Speed unknown" for PCIe Gen3 links. This two liner
adds 8GT/s to fix that. I don't think the next link rate has yet been
decided. So I only go to Gen3.

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
