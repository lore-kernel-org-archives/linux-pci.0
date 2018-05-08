Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEHVtx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2018 17:49:53 -0400
From: Colin King <colin.king@canonical.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: hv: fix spelling mistake: "reqquest" -> "request"
Date: Tue,  8 May 2018 22:49:46 +0100
Message-Id: <20180508214946.19772-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 50cdefe3f6d3..7e93b4ffb162 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -2071,7 +2071,7 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev)
 				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 		if (ret) {
 			dev_err(&hdev->device,
-				"PCI Pass-through VSP failed sending version reqquest: %#x",
+				"PCI Pass-through VSP failed sending version request: %#x",
 				ret);
 			goto exit;
 		}
-- 
2.17.0
