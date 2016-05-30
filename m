Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933116AbcE3OSF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 May 2016 10:18:05 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 1/2] PCI: hv: don't leak buffer in hv_pci_onchannelcallback()
Date: Mon, 30 May 2016 16:17:58 +0200
Message-Id: <1464617879-19581-2-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
References: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We don't free buffer on several code paths in hv_pci_onchannelcallback(),
put kfree() to the end of the function to fix the issue. Direct { kfree();
return; } can now be replaced with a simple 'break';

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/pci/host/pci-hyperv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 7e9b2de..a68ec49 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1661,10 +1661,8 @@ static void hv_pci_onchannelcallback(void *context)
 		 * All incoming packets must be at least as large as a
 		 * response.
 		 */
-		if (bytes_recvd <= sizeof(struct pci_response)) {
-			kfree(buffer);
-			return;
-		}
+		if (bytes_recvd <= sizeof(struct pci_response))
+			break;
 		desc = (struct vmpacket_descriptor *)buffer;
 
 		switch (desc->type) {
@@ -1679,8 +1677,7 @@ static void hv_pci_onchannelcallback(void *context)
 			comp_packet->completion_func(comp_packet->compl_ctxt,
 						     response,
 						     bytes_recvd);
-			kfree(buffer);
-			return;
+			break;
 
 		case VM_PKT_DATA_INBAND:
 
@@ -1729,6 +1726,8 @@ static void hv_pci_onchannelcallback(void *context)
 		}
 		break;
 	}
+
+	kfree(buffer);
 }
 
 /**
-- 
2.5.5

