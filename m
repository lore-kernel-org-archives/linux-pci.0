Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51929 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425604AbcBRMus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Feb 2016 07:50:48 -0500
Date: Thu, 18 Feb 2016 13:50:45 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-pci@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@suse.de>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 1/4] PCI: aer_inject: Fix error codes
Message-ID: <20160218135045.0991a270@endymion>
In-Reply-To: <20160218130928.67dbf63b@endymion>
References: <20160218130928.67dbf63b@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

EPERM means "Operation not permitted", which doesn't reflect the lack
of support for AER. EPROTONOSUPPORT (Protocol not supported) is a
better choice or error code if the device or its root port lack
support for AER.

Likewise, EINVAL means "Invalid argument", which is not suitable for
cases where the AER error device is missing or unusable. ENODEV and
EPROTONOSUPPORT, respectively, fit better.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Prarit Bhargava <prarit@redhat.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-4.5-rc4.orig/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 11:23:03.741503472 +0100
+++ linux-4.5-rc4/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 13:18:18.999397788 +0100
@@ -340,7 +340,7 @@ static int aer_inject(struct aer_error_i
 
 	pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!pos_cap_err) {
-		ret = -EPERM;
+		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
 	pci_read_config_dword(dev, pos_cap_err + PCI_ERR_UNCOR_SEVER, &sever);
@@ -350,7 +350,7 @@ static int aer_inject(struct aer_error_i
 
 	rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
 	if (!rp_pos_cap_err) {
-		ret = -EPERM;
+		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
 
@@ -458,12 +458,12 @@ static int aer_inject(struct aer_error_i
 	if (find_aer_device(rpdev, &edev)) {
 		if (!get_service_data(edev)) {
 			printk(KERN_WARNING "AER service is not initialized\n");
-			ret = -EINVAL;
+			ret = -EPROTONOSUPPORT;
 			goto out_put;
 		}
 		aer_irq(-1, edev);
 	} else
-		ret = -EINVAL;
+		ret = -ENODEV;
 out_put:
 	kfree(err_alloc);
 	kfree(rperr_alloc);

-- 
Jean Delvare
SUSE L3 Support
