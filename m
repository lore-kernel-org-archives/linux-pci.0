Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37486 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbbH0R2B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Aug 2015 13:28:01 -0400
Received: by igui7 with SMTP id i7so41568613igu.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2015 10:28:00 -0700 (PDT)
Date: Thu, 27 Aug 2015 12:27:53 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Don't update VF's BAR
Message-ID: <20150827172753.GA27056@google.com>
References: <20150714221511.GM24416@google.com>
 <1438159978-32285-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438159978-32285-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Alex]

On Wed, Jul 29, 2015 at 04:52:58PM +0800, Wei Yang wrote:
> VF BARs are RO zero, so updating VF BARs will not take any effect.
> See the SR-IOV spec r1.1, sec 3.4.1.11.
> 
> Also this patch adds a warning in pci_update_resource() in case someone
> really tries to update it.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

I applied this with some whitespace and changelog fixes to
pci-4.4/virtualization for v4.4, thanks!  I will rebase this branch
v4.3-rc1 or later.

You mentioned the justification (avoids "error updating" messages) on the
mailing list.  It helps me out if you include that in the changelog, but I
added it for you.

Bjorn

commit fa47e4466c567b43bcf8e152a4425277b6d033d9
Author: Wei Yang <weiyang@linux.vnet.ibm.com>
Date:   Wed Jul 29 16:52:58 2015 +0800

    PCI: Don't try to restore VF BARs
    
    VF BARs are read-only zero, so updating VF BARs will not have any effect.
    See the SR-IOV spec r1.1, sec 3.4.1.11.
    
    Don't update VF BARs in pci_restore_bars().
    
    This avoids spurious "BAR %d: error updating" messages that we see when
    doing vfio pass-through after 6eb7018705de ("vfio-pci: Move idle devices to
    D3hot power state").
    
    [bhelgaas: changelog, fix whitespace]
    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0008c95..1a682f8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -473,7 +473,7 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
 }
 
 /**
- * pci_restore_bars - restore a devices BAR values (e.g. after wake-up)
+ * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
  * @dev: PCI device to have its BARs restored
  *
  * Restore the BAR values for a given device, so as to make it
@@ -483,6 +483,10 @@ static void pci_restore_bars(struct pci_dev *dev)
 {
 	int i;
 
+	/* Per SR-IOV spec 3.4.1.11, VF BARs are RO zero */
+	if (dev->is_virtfn)
+		return;
+
 	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
 		pci_update_resource(dev, i);
 }
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 232f925..152de5c 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -36,6 +36,11 @@ void pci_update_resource(struct pci_dev *dev, int resno)
 	enum pci_bar_type type;
 	struct resource *res = dev->resource + resno;
 
+	if (dev->is_virtfn) {
+		dev_warn(&dev->dev, "can't update VF BAR%d\n", resno);
+		return;
+	}
+
 	/*
 	 * Ignore resources for unimplemented BARs and unused resource slots
 	 * for 64 bit BARs.
