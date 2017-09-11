Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicolai Stange <nstange@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adrian Salido <salidoa@google.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 1/3] PCI: fix race condition with driver_override
Date: Mon, 11 Sep 2017 09:45:40 +0200
Message-Id: <20170911074542.16777-2-nstange@suse.de>
In-Reply-To: <20170911074542.16777-1-nstange@suse.de>
References: <20170911074542.16777-1-nstange@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver_override implementation is susceptible to a race condition when
different threads are reading vs. storing a different driver override.
Add locking to avoid the race condition.

This is in close analogy to commit 6265539776a0 ("driver core: platform:
fix race condition with driver_override") from Adrian Salido.

Fixes: 782a985d7af2 ("PCI: Introduce new device binding path using pci_dev.driver_override")
Cc: stable@vger.kernel.org	# v3.16+
Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 drivers/pci/pci-sysfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 1eecfa301f7f..8e075ea2743e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -686,7 +686,7 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *driver_override, *old = pdev->driver_override, *cp;
+	char *driver_override, *old, *cp;
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
@@ -700,12 +700,15 @@ static ssize_t driver_override_store(struct device *dev,
 	if (cp)
 		*cp = '\0';
 
+	device_lock(dev);
+	old = pdev->driver_override;
 	if (strlen(driver_override)) {
 		pdev->driver_override = driver_override;
 	} else {
 		kfree(driver_override);
 		pdev->driver_override = NULL;
 	}
+	device_unlock(dev);
 
 	kfree(old);
 
@@ -716,8 +719,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t len;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
+	device_lock(dev);
+	len = snprintf(buf, PAGE_SIZE, "%s\n", pdev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.13.5
