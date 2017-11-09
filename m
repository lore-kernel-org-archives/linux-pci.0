Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdKIUrR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 15:47:17 -0500
From: Pawandeep Oza <poza@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH 2/4] PCI/portdrv: Add/Remove port services to the list
Date: Fri, 10 Nov 2017 02:16:37 +0530
Message-Id: <1510260399-14886-3-git-send-email-poza@codeaurora.org>
In-Reply-To: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
References: <1510260399-14886-1-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Oza Pawandeep <poza@codeaurora.org>

This patch adds and removes the port service to the service list.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index a592103..6bfe986 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -454,6 +454,8 @@ static int pcie_port_probe_service(struct device *dev)
 	if (status)
 		return status;
 
+	list_add_tail(&pciedev->slist, &pciedev->port->service_list);
+
 	get_device(dev);
 	return 0;
 }
@@ -477,6 +479,9 @@ static int pcie_port_remove_service(struct device *dev)
 
 	pciedev = to_pcie_device(dev);
 	driver = to_service_driver(dev->driver);
+
+	list_del(&pciedev->slist);
+
 	if (driver && driver->remove) {
 		driver->remove(pciedev);
 		put_device(dev);
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index b69769d..9d05621 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -31,6 +31,7 @@ struct pcie_device {
 	u32		service;    /* Port service this device represents */
 	void		*priv_data; /* Service Private Data */
 	struct device	device;     /* Generic Device Interface */
+	struct list_head slist;     /* List of services */
 };
 #define to_pcie_device(d) container_of(d, struct pcie_device, device)
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
