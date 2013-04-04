Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:48270 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760606Ab3DDV6V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2013 17:58:21 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
	Thu, 4 Apr 2013 15:58:20 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A0BC719D8045
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2013 15:58:11 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r34LwF8E308050
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 15:58:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r34LwEeg010547
	for <linux-pci@vger.kernel.org>; Thu, 4 Apr 2013 15:58:14 -0600
Message-Id: <201304042158.r34LwDHx010466@d03av02.boulder.ibm.com>
Subject: [PATCH 1/3] pci: Export pci_dev_type
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org, lucaskt@linux.vnet.ibm.com,
	klebers@linux.vnet.ibm.com, brking@linux.vnet.ibm.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 04 Apr 2013 16:58:13 -0500
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Export pci_dev_type so that arch specific PCI probing code can
initialize a new PCI device struct.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/pci/pci.h   |    1 -
 include/linux/pci.h |    1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/pci/pci.h~pci_export_pci_dev_type drivers/pci/pci.h
--- linux/drivers/pci/pci.h~pci_export_pci_dev_type	2013-04-02 17:01:25.000000000 -0500
+++ linux-bjking1/drivers/pci/pci.h	2013-04-02 17:02:31.000000000 -0500
@@ -153,7 +153,6 @@ static inline int pci_no_d1d2(struct pci
 }
 extern struct device_attribute pci_dev_attrs[];
 extern struct device_attribute pcibus_dev_attrs[];
-extern struct device_type pci_dev_type;
 extern struct bus_attribute pci_bus_attrs[];
 
 
diff -puN include/linux/pci.h~pci_export_pci_dev_type include/linux/pci.h
--- linux/include/linux/pci.h~pci_export_pci_dev_type	2013-04-02 17:01:59.000000000 -0500
+++ linux-bjking1/include/linux/pci.h	2013-04-02 17:02:29.000000000 -0500
@@ -670,6 +670,7 @@ enum pcie_bus_config_types {
 extern enum pcie_bus_config_types pcie_bus_config;
 
 extern struct bus_type pci_bus_type;
+extern struct device_type pci_dev_type;
 
 /* Do NOT directly access these two variables, unless you are arch specific pci
  * code, or pci core code. */
_

