Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933060AbcE3OSH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 May 2016 10:18:07 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH 2/2] PCI: hv: handle all pending messages in hv_pci_onchannelcallback()
Date: Mon, 30 May 2016 16:17:59 +0200
Message-Id: <1464617879-19581-3-git-send-email-vkuznets@redhat.com>
In-Reply-To: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
References: <1464617879-19581-1-git-send-email-vkuznets@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When we have an interrupt from host we have a bit set in event page
indicating there are messages for the particular channel. We need to read
them all as we won't get signaled for what was on the queue before we
cleared the bit in vmbus_on_event(). This applies to all Hyper-V drivers
and the pass-through driver should do the same.
I did non meet any bugs, the issue was found by code inspection. We don't
have many events going through hv_pci_onchannelcallback(), this explains
why nobody reported the issue before.

While on it, fix handling non-zero vmbus_recvpacket_raw() return values by
dropping out. If the return value is not zero it is wrong to inspect
buffer or bytes_recvd as these may contain invalid data.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/pci/host/pci-hyperv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index a68ec49..7de341d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1657,12 +1657,16 @@ static void hv_pci_onchannelcallback(void *context)
 			continue;
 		}
 
+		/* Zero length indicates there are no more packets. */
+		if (ret || !bytes_recvd)
+			break;
+
 		/*
 		 * All incoming packets must be at least as large as a
 		 * response.
 		 */
 		if (bytes_recvd <= sizeof(struct pci_response))
-			break;
+			continue;
 		desc = (struct vmpacket_descriptor *)buffer;
 
 		switch (desc->type) {
@@ -1724,7 +1728,6 @@ static void hv_pci_onchannelcallback(void *context)
 				desc->type, req_id, bytes_recvd);
 			break;
 		}
-		break;
 	}
 
 	kfree(buffer);
-- 
2.5.5

