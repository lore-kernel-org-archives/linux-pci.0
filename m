Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5883AECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C58E21522
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C58E21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeITWKn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:21034 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbeITWKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 09:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="258918162"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.44])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2018 09:26:25 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv4 01/12] PCI: portdrv: Initialize service drivers directly
Date:   Thu, 20 Sep 2018 10:27:06 -0600
Message-Id: <20180920162717.31066-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180920162717.31066-1-keith.busch@intel.com>
References: <20180920162717.31066-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI port driver saves the PCI state after initializing the device
with the applicable service devices. This was, however, before the
service drivers were even registered because pci probe happens before
the device_initcall initialized those service drivers. The config space
state that the services set up were not being saved. The end result
would cause pci devices to not react to events that the drivers think
they did if the pci state ever needed to be restored.

This patch fixes this by changing the service drivers from using the
init calls to having the portdrv driver calling the services directly.
This will get the state saved as desired, while making the relationship
between the port driver and the services under it more explicit in the
code.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/hotplug/pciehp_core.c |  3 +--
 drivers/pci/pcie/aer.c            |  3 +--
 drivers/pci/pcie/dpc.c            |  3 +--
 drivers/pci/pcie/pme.c            |  3 +--
 drivers/pci/pcie/portdrv.h        | 24 ++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_pci.c    |  9 +++++++++
 6 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 68b20e667764..944047976569 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -287,7 +287,7 @@ static struct pcie_port_service_driver hpdriver_portdrv = {
 #endif	/* PM */
 };
 
-static int __init pcied_init(void)
+int __init pcie_hp_init(void)
 {
 	int retval = 0;
 
@@ -298,4 +298,3 @@ static int __init pcied_init(void)
 
 	return retval;
 }
-device_initcall(pcied_init);
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 83180edd6ed4..637d638f73da 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1569,10 +1569,9 @@ static struct pcie_port_service_driver aerdriver = {
  *
  * Invoked when AER root service driver is loaded.
  */
-static int __init aer_service_init(void)
+int __init pcie_aer_init(void)
 {
 	if (!pci_aer_available() || aer_acpi_firmware_first())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
-device_initcall(aer_service_init);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f03279fc87cd..a1fd16bf1cab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -282,8 +282,7 @@ static struct pcie_port_service_driver dpcdriver = {
 	.reset_link	= dpc_reset_link,
 };
 
-static int __init dpc_service_init(void)
+int __init pcie_dpc_init(void)
 {
 	return pcie_port_service_register(&dpcdriver);
 }
-device_initcall(dpc_service_init);
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 3ed67676ea2a..1a8b85051b1b 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -446,8 +446,7 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 /**
  * pcie_pme_service_init - Register the PCIe PME service driver.
  */
-static int __init pcie_pme_service_init(void)
+int __init pcie_pme_init(void)
 {
 	return pcie_port_service_register(&pcie_pme_driver);
 }
-device_initcall(pcie_pme_service_init);
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d59afa42fc14..2498b2d34009 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -23,6 +23,30 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   4
 
+#ifdef CONFIG_PCIEAER
+int pcie_aer_init(void);
+#else
+static inline int pcie_aer_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_HOTPLUG_PCI_PCIE
+int pcie_hp_init(void);
+#else
+static inline int pcie_hp_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_PCIE_PME
+int pcie_pme_init(void);
+#else
+static inline int pcie_pme_init(void) { return 0; }
+#endif
+
+#ifdef CONFIG_PCIE_DPC
+int pcie_dpc_init(void);
+#else
+static inline int pcie_dpc_init(void) { return 0; }
+#endif
+
 /* Port Type */
 #define PCIE_ANY_PORT			(~0)
 
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index eef22dc29140..23a5a0c2c3fe 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -226,11 +226,20 @@ static const struct dmi_system_id pcie_portdrv_dmi_table[] __initconst = {
 	 {}
 };
 
+static void __init pcie_init_services(void)
+{
+	pcie_aer_init();
+	pcie_pme_init();
+	pcie_dpc_init();
+	pcie_hp_init();
+}
+
 static int __init pcie_portdrv_init(void)
 {
 	if (pcie_ports_disabled)
 		return -EACCES;
 
+	pcie_init_services();
 	dmi_check_system(pcie_portdrv_dmi_table);
 
 	return pci_register_driver(&pcie_portdriver);
-- 
2.14.4

