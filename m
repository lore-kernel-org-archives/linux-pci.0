Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207Ab3CTWEy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Mar 2013 18:04:54 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2KM4sHo028268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2013 18:04:54 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] pci, aer_inject fix return values when device not found
Date: Wed, 20 Mar 2013 18:04:43 -0400
Message-Id: <1363817083-2807-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently the aer_inject driver returns -ENOTTY when the target PCIE device
root port is not found or if the device or root port doesn't support AER.

In the case where the root port isn't found, the driver should return -ENODEV,
and in the other cases it should return -EPERM.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 4e24cb8..8d4a5e3 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -334,13 +334,13 @@ static int aer_inject(struct aer_error_inj *einj)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev) {
-		ret = -ENOTTY;
+		ret = -ENODEV;
 		goto out_put;
 	}
 
 	pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!pos_cap_err) {
-		ret = -ENOTTY;
+		ret = -EPERM;
 		goto out_put;
 	}
 	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &sever);
@@ -350,7 +350,7 @@ static int aer_inject(struct aer_error_inj *einj)
 
 	rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
 	if (!rp_pos_cap_err) {
-		ret = -ENOTTY;
+		ret = -EPERM;
 		goto out_put;
 	}
 
-- 
1.7.9.3

