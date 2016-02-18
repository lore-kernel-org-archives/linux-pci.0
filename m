Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52440 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425294AbcBRMyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 18 Feb 2016 07:54:05 -0500
Date: Thu, 18 Feb 2016 13:54:02 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-pci@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Borislav Petkov <bp@suse.de>,
	Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 4/4]  PCI: aer_inject: Log error injections
Message-ID: <20160218135402.61061d5a@endymion>
In-Reply-To: <20160218130928.67dbf63b@endymion>
References: <20160218130928.67dbf63b@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Log successful error injections so that injected errors can be
differentiated from real errors.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
Note: none of my systems support AER injection so this is untested.

 drivers/pci/pcie/aer/aer_inject.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-4.5-rc4.orig/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 13:20:02.063933626 +0100
+++ linux-4.5-rc4/drivers/pci/pcie/aer/aer_inject.c	2016-02-18 13:20:02.515936151 +0100
@@ -469,6 +469,9 @@ static int aer_inject(struct aer_error_i
 			ret = -EPROTONOSUPPORT;
 			goto out_put;
 		}
+		dev_info(&edev->device,
+			 "aer_inject: Injecting errors %08x/%08x into device %s\n",
+			 einj->cor_status, einj->uncor_status, pci_name(dev));
 		aer_irq(-1, edev);
 	} else {
 		dev_err(&rpdev->dev, "aer_inject: AER device not found\n");

-- 
Jean Delvare
SUSE L3 Support
