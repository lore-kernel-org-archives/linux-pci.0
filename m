Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52152 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425276AbcBRMwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Feb 2016 07:52:49 -0500
Date: Thu, 18 Feb 2016 13:52:46 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-pci@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@suse.de>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 3/4] PCI: aer_inject: Log actual error causes
Message-ID: <20160218135246.076beae6@endymion>
In-Reply-To: <20160218130928.67dbf63b@endymion>
References: <20160218130928.67dbf63b@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The aer_inject driver is very quiet. In most cases, it merely returns
an error code to user-space, leaving the user with little clue about
the actual reason for the failure.

So, log error messages for 4 of the most frequent causes of failure:
* Can't find the root port of the specified device.
* Device doesn't support AER.
* Root port doesn't support AER.
* AER device not found.
This gives the user a chance to understand why aer-inject failed.

Based on a preliminary patch by Thomas Renninger.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-4.5-rc4.orig/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 12:50:56.927581343 +0100
+++ linux-4.5-rc4/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 12:53:18.432587496 +0100
@@ -335,12 +335,14 @@ static int aer_inject(struct aer_error_i
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev) {
+		dev_err(&dev->dev, "aer_inject: Root port not found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
 
 	pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!pos_cap_err) {
+		dev_err(&dev->dev, "aer_inject: Device doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
@@ -351,6 +353,8 @@ static int aer_inject(struct aer_error_i
 
 	rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
 	if (!rp_pos_cap_err) {
+		dev_err(&rpdev->dev,
+			"aer_inject: Root port doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
@@ -466,8 +470,10 @@ static int aer_inject(struct aer_error_i
 			goto out_put;
 		}
 		aer_irq(-1, edev);
-	} else
+	} else {
+		dev_err(&rpdev->dev, "aer_inject: AER device not found\n");
 		ret = -ENODEV;
+	}
 out_put:
 	kfree(err_alloc);
 	kfree(rperr_alloc);

-- 
Jean Delvare
SUSE L3 Support
