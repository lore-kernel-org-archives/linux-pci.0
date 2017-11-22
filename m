Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbdKVWul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 17:50:41 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 20/29] xen: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:15 -0500
Message-Id: <1511390964-9979-21-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/xen-pcifront.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index 8fc2e95..94b25b5 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -595,6 +595,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 	struct pci_driver *pdrv;
 	int bus = pdev->sh_info->aer_op.bus;
 	int devfn = pdev->sh_info->aer_op.devfn;
+	int domain = pdev->sh_info->aer_op.domain;
 	struct pci_dev *pcidev;
 	int flag = 0;
 
@@ -603,7 +604,7 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		cmd, bus, devfn);
 	result = PCI_ERS_RESULT_NONE;
 
-	pcidev = pci_get_bus_and_slot(bus, devfn);
+	pcidev = pci_get_domain_bus_and_slot(domain, bus, devfn);
 	if (!pcidev || !pcidev->driver) {
 		dev_err(&pdev->xdev->dev, "device or AER driver is NULL\n");
 		pci_dev_put(pcidev);
-- 
1.9.1
