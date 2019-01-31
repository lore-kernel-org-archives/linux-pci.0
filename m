Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5056EC169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A583218EA
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 17:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbfAaRH5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:07:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:51818 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387817AbfAaRH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Jan 2019 12:07:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 09:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="140496827"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2019 09:07:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 18AD6BF; Thu, 31 Jan 2019 19:07:47 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Revert "PCI/PME: Implement runtime PM callbacks"
Date:   Thu, 31 Jan 2019 20:07:45 +0300
Message-Id: <20190131170746.7604-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
References: <20190131170746.7604-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 0e157e52860441cb26051f131dd0b5ae3187a07b.

Heiner reported that the commit in question prevents his network adapter
from triggering PME and waking up when network cable is plugged.

The commit tried to prevent root port waking up from D3cold immediately
but looks like disabing root port PME interrupt is not the right way to
fix that issue so revert it now. The patch following proposes an
alternative solution to that issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202103
Fixes: 0e157e528604 ("PCI/PME: Implement runtime PM callbacks")
Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Tested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pcie/pme.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 0dbcf429089f..1a8b85051b1b 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -432,31 +432,6 @@ static void pcie_pme_remove(struct pcie_device *srv)
 	kfree(get_service_data(srv));
 }
 
-static int pcie_pme_runtime_suspend(struct pcie_device *srv)
-{
-	struct pcie_pme_service_data *data = get_service_data(srv);
-
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(srv->port, false);
-	pcie_clear_root_pme_status(srv->port);
-	data->noirq = true;
-	spin_unlock_irq(&data->lock);
-
-	return 0;
-}
-
-static int pcie_pme_runtime_resume(struct pcie_device *srv)
-{
-	struct pcie_pme_service_data *data = get_service_data(srv);
-
-	spin_lock_irq(&data->lock);
-	pcie_pme_interrupt_enable(srv->port, true);
-	data->noirq = false;
-	spin_unlock_irq(&data->lock);
-
-	return 0;
-}
-
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
 	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
@@ -464,8 +439,6 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 
 	.probe		= pcie_pme_probe,
 	.suspend	= pcie_pme_suspend,
-	.runtime_suspend = pcie_pme_runtime_suspend,
-	.runtime_resume	= pcie_pme_runtime_resume,
 	.resume		= pcie_pme_resume,
 	.remove		= pcie_pme_remove,
 };
-- 
2.20.1

