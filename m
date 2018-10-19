Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECA4C67863
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B143321477
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zBGqww0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B143321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeJSKPd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJSKPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:33 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD4620C0E;
        Fri, 19 Oct 2018 02:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539915097;
        bh=7Bw9BAD3dnrJ4c/qQu2mn0qi3to8fMTZjzgajDSHZKE=;
        h=From:To:Cc:Subject:Date:From;
        b=zBGqww0HRQWSsvhSe6VHVtzRDYM8gR9ufcoVq/im0uevcB/pO8wJ8qRFfJcMSyfra
         YSXmSZpWLfIXFNPGUdjpM9oZYOw7fuvQRZN3cw0wAt9WKhPTICjViGU0NJMpmejR1h
         75ac3kFZrL6d2KnTn/aTbuOkrg1H9De09f0xlcqk=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v6 1/7] PCI: Expose reset_type to users of __pci_reset_function_locked()
Date:   Fri, 19 Oct 2018 02:11:21 +0000
Message-Id: <20181019021132.14743-1-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need a contract between the reset API users and the PCI core about the
types of reset that a user needs vs. what PCI core can do internally.
If a platform supports hotplug, we need to do hotplug reset as an example.

Expose the reset types to the drivers and try different reset types based
on the new reset_type parameter.

Most users are expected to use PCI_RESET_ANY, PCI_RESET_FUNC or
PCI_RESET_LINK parameters.

Link: https://www.spinics.net/lists/linux-pci/msg75828.html
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   |  2 +-
 drivers/pci/pci.c                             | 59 ++++++++++++-------
 drivers/xen/xen-pciback/pci_stub.c            |  6 +-
 include/linux/pci.h                           | 58 +++++++++++++++++-
 4 files changed, 100 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 6fb13fa73b27..0ff76722734d 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -989,7 +989,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	rc = __pci_reset_function_locked(oct->pci_dev);
+	rc = __pci_reset_function_locked(oct->pci_dev, PCI_RESET_ANY);
 
 	if (rc != 0)
 		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1835f3a7aa8d..e292ea589d3e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4673,6 +4673,7 @@ static void pci_dev_restore(struct pci_dev *dev)
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
  * @dev: PCI device to reset
+ * @reset_type: reset mask to try
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -4688,9 +4689,9 @@ static void pci_dev_restore(struct pci_dev *dev)
  * Returns 0 if the device function was successfully reset or negative if the
  * device doesn't support resetting a single function.
  */
-int __pci_reset_function_locked(struct pci_dev *dev)
+int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type)
 {
-	int rc;
+	int rc = -EINVAL;
 
 	might_sleep();
 
@@ -4702,24 +4703,42 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * other error, we're also finished: this indicates that further
 	 * reset mechanisms might be broken on the device.
 	 */
-	rc = pci_dev_specific_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	if (pcie_has_flr(dev)) {
-		rc = pcie_flr(dev);
+	if (reset_type & PCI_RESET_DEV_SPECIFIC) {
+		rc = pci_dev_specific_reset(dev, 0);
 		if (rc != -ENOTTY)
 			return rc;
 	}
-	rc = pci_af_flr(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
-	if (rc != -ENOTTY)
-		return rc;
-	return pci_parent_bus_reset(dev, 0);
+
+	if (reset_type & PCI_RESET_FLR) {
+		if (pcie_has_flr(dev)) {
+			rc = pcie_flr(dev);
+			if (rc != -ENOTTY)
+				return rc;
+		}
+		rc = pci_af_flr(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_PM) {
+		rc = pci_pm_reset(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_SLOT) {
+		rc = pci_dev_reset_slot_function(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	if (reset_type & PCI_RESET_BUS) {
+		rc = pci_parent_bus_reset(dev, 0);
+		if (rc != -ENOTTY)
+			return rc;
+	}
+
+	return rc;
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
@@ -4784,7 +4803,7 @@ int pci_reset_function(struct pci_dev *dev)
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_reset_function_locked(dev);
+	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
 
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
@@ -4819,7 +4838,7 @@ int pci_reset_function_locked(struct pci_dev *dev)
 
 	pci_dev_save_and_disable(dev);
 
-	rc = __pci_reset_function_locked(dev);
+	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
 
 	pci_dev_restore(dev);
 
@@ -4844,7 +4863,7 @@ int pci_try_reset_function(struct pci_dev *dev)
 		return -EAGAIN;
 
 	pci_dev_save_and_disable(dev);
-	rc = __pci_reset_function_locked(dev);
+	rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 59661db144e5..6dfb805bcb19 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -105,7 +105,7 @@ static void pcistub_device_release(struct kref *kref)
 	/* Call the reset function which does not take lock as this
 	 * is called from "unbind" which takes a device_lock mutex.
 	 */
-	__pci_reset_function_locked(dev);
+	__pci_reset_function_locked(dev, PCI_RESET_ANY);
 	if (pci_load_and_free_saved_state(dev, &dev_data->pci_saved_state))
 		dev_info(&dev->dev, "Could not reload PCI state\n");
 	else
@@ -283,7 +283,7 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	 * (so it's ready for the next domain)
 	 */
 	device_lock_assert(&dev->dev);
-	__pci_reset_function_locked(dev);
+	__pci_reset_function_locked(dev, PCI_RESET_ANY);
 
 	dev_data = pci_get_drvdata(dev);
 	ret = pci_load_saved_state(dev, dev_data->pci_saved_state);
@@ -417,7 +417,7 @@ static int pcistub_init_device(struct pci_dev *dev)
 		dev_err(&dev->dev, "Could not store PCI conf saved state!\n");
 	else {
 		dev_dbg(&dev->dev, "resetting (FLR, D3, etc) the device\n");
-		__pci_reset_function_locked(dev);
+		__pci_reset_function_locked(dev, PCI_RESET_ANY);
 		pci_restore_state(dev);
 	}
 	/* Now disable the device (this also ensures some private device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6925828f9f25..7ace46b3e479 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -849,6 +849,62 @@ enum {
 	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
 };
 
+/*
+ * A common theme here is that the driver wants some degree of
+ * control of the type of reset used, vfio specifically wants to specify a
+ * bus or slot reset while hfi1 just wants to specify that the link is
+ * reset and doesn't care if it's a bus or slot reset that accomplishes
+ * that.  The right "unified" interface is one that takes a parameter
+ * allowing the caller to specify the scope or type of reset
+ * with aliases so drivers can ignore the hotplug interface if they wish
+ * for special cases.
+ *
+ * PCI_RESET_ANY tries all reset type one by one until device is successfully
+ * reset. Under normal circumstances, most drivers are expected to use
+ * PCI_RESET_ANY as they don't usually care about the type of reset as long
+ * as device is reset.
+ *
+ * PCI_RESET_FUNC is useful when you want to reset one particular PCI device
+ * but you don't want to impact other devices or cause a temporary service
+ * outage.
+ *
+ * PCI_RESET_LINK can be used to cause a link retraining. This operation will
+ * cause service outage for the PCI bus if there are other devices on the same
+ * bus. PCI_RESET_LINK determines if a platform supports hotplug or not and
+ * suppresses hotplug interrupts during secondary bus reset.
+ *
+ * PCI_RESET_DEV_SPECIFIC can be used to reset a device by help from the
+ * device driver. Not all device drivers support this option.
+ *
+ * PCI_RESET_FLR can be used to issue a Function Level Reset to a device. This
+ * option will fail if FLR is not supported.
+ *
+ * PCI_RESET_PM can be used to reset the device via D3->D0 and D0->D3 sleep
+ * transition. This assumes that device supports PM based reset.
+ *
+ * PCI_RESET_SLOT forces a slot/hotplug reset. This will not work on platforms
+ * without hotplug capability. This option should only be used for advanced
+ * use-cases where driver developer absolutely knows that the device will never
+ * be used on non-hotplug environments.
+ * Not recommended for scalability. Please refer to PCI_RESET_LINK and let the
+ * PCI core do the hotplug detection.
+ *
+ * PCI_RESET_BUS performs a secondary bus reset on the link and causes a link
+ * recovery. Using this option directly and bypassing hotplug driver may
+ * cause a deadlock if platform supports hotplug. Please refer to
+ * PCI_RESET_LINK and let the PCI core do the hotplug detection.
+ */
+#define PCI_RESET_DEV_SPECIFIC	(1 << 0)
+#define PCI_RESET_FLR		(1 << 1)
+#define PCI_RESET_PM		(1 << 2)
+#define PCI_RESET_SLOT		(1 << 3)
+#define PCI_RESET_BUS		(1 << 4)
+
+#define PCI_RESET_ANY		(~0)
+#define PCI_RESET_FUNC		(PCI_RESET_DEV_SPECIFIC | \
+				 PCI_RESET_FLR | PCI_RESET_PM)
+#define PCI_RESET_LINK		(PCI_RESET_SLOT | PCI_RESET_BUS)
+
 /* These external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -1111,7 +1167,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 void pcie_print_link_status(struct pci_dev *dev);
 bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
-int __pci_reset_function_locked(struct pci_dev *dev);
+int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
-- 
2.19.0

