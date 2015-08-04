Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33236 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbHDX7U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2015 19:59:20 -0400
Received: by igbpg9 with SMTP id pg9so104140804igb.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2015 16:59:19 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id b1sm768714iob.18.2015.08.04.16.59.17
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 04 Aug 2015 16:59:18 -0700 (PDT)
Subject: [PATCH 1/2] PCI: pciehp: Remove unused interrupt events
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 04 Aug 2015 18:59:17 -0500
Message-ID: <20150804235917.15421.15816.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804235823.15421.71342.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The list of interrupt events (INT_BUTTON_IGNORE, INT_PRESENCE_ON, etc.) was
copied from other hotplug drivers, but pciehp doesn't use them all.

Remove the interrupt events that aren't used by pciehp.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp.h |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 57cd132..aca84e1 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -101,18 +101,14 @@ struct controller {
 	unsigned int power_fault_detected;
 };
 
-#define INT_BUTTON_IGNORE		0
 #define INT_PRESENCE_ON			1
 #define INT_PRESENCE_OFF		2
 #define INT_SWITCH_CLOSE		3
 #define INT_SWITCH_OPEN			4
 #define INT_POWER_FAULT			5
-#define INT_POWER_FAULT_CLEAR		6
-#define INT_BUTTON_PRESS		7
-#define INT_BUTTON_RELEASE		8
-#define INT_BUTTON_CANCEL		9
-#define INT_LINK_UP			10
-#define INT_LINK_DOWN			11
+#define INT_BUTTON_PRESS		6
+#define INT_LINK_UP			7
+#define INT_LINK_DOWN			8
 
 #define STATIC_STATE			0
 #define BLINKINGON_STATE		1

