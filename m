Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4510BC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFC220656
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 08:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfDOIlq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:41:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:54137 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfDOIlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 04:41:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 01:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="149499538"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 01:41:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 088D82FA; Mon, 15 Apr 2019 11:41:42 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Imre Deak <imre.deak@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/LINK: Disable bandwidth notification interrupt during suspend
Date:   Mon, 15 Apr 2019 11:41:42 +0300
Message-Id: <20190415084142.30897-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the bandwidth notification interrupt is left unmasked when entering
suspend to idle it triggers immediately bringing the system back to
working state.

To keep that from happening, disable the interrupt when entering system
sleep and enable it again during resume.

Reported-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/bw_notification.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index 4fa9e3523ee1..77e685771487 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -107,11 +107,25 @@ static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
 	free_irq(srv->irq, srv);
 }
 
+static int pcie_bandwidth_notification_suspend(struct pcie_device *srv)
+{
+	pcie_disable_link_bandwidth_notification(srv->port);
+	return 0;
+}
+
+static int pcie_bandwidth_notification_resume(struct pcie_device *srv)
+{
+	pcie_enable_link_bandwidth_notification(srv->port);
+	return 0;
+}
+
 static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
 	.name		= "pcie_bw_notification",
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_BWNOTIF,
 	.probe		= pcie_bandwidth_notification_probe,
+	.suspend	= pcie_bandwidth_notification_suspend,
+	.resume		= pcie_bandwidth_notification_resume,
 	.remove		= pcie_bandwidth_notification_remove,
 };
 
-- 
2.20.1

