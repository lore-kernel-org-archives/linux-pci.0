Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:63044 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab3E3SYX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 14:24:23 -0400
Received: by mail-ie0-f175.google.com with SMTP id tp5so1390824ieb.6
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2013 11:24:23 -0700 (PDT)
Date: Thu, 30 May 2013 12:24:20 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI, IOV: fix a resource leakage on error recovery path
Message-ID: <20130530182420.GA26805@google.com>
References: <1369489718-25869-10-git-send-email-jiang.liu@huawei.com>
 <1369888293-13387-1-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369888293-13387-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 30, 2013 at 12:31:33PM +0800, Jiang Liu wrote:
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
> Hi Bjorn,
> 	Could you please help to apply this small patch onto the
> jiang-bus-lock-v3, which addresses a memory leakage issue pointed
> out by Yinghai? Or you may fold it into " PCI, IOV: simplify IOV 
> implementation".
> Thanks!
> Gerry
> ---
>  drivers/pci/iov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 5eb8165..458fb39 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -122,8 +122,9 @@ failed1:
>  	pci_dev_put(dev);
>  	mutex_lock(&iov->dev->sriov->lock);
>  	pci_stop_and_remove_bus_device(virtfn);
> -	virtfn_remove_bus(dev->bus, bus);
>  failed0:
> +	if (bus)
> +		virtfn_remove_bus(dev->bus, bus);
>  	mutex_unlock(&iov->dev->sriov->lock);
>  
>  	return rc;

I fixed this slightly differently to keep the error checking
more linear.  I think it's equivalent to what you did; let me
know if otherwise.


commit f5cfa3a1ccef2d0e9ca862c609cf185f87049177
Author: Jiang Liu <liuj97@gmail.com>
Date:   Sat May 25 21:48:37 2013 +0800

    PCI: Simplify IOV implementation and fix reference count races
    
    Trivial changes to IOV:
    
      1) use new PCI interfaces to simplify IOV implementation
      2) fix some reference count related race windows
    
    [bhelgaas: fix virtfn_add() add bus/alloc dev error paths]
    Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Donald Dutile <ddutile@redhat.com>
    Cc: Yinghai Lu <yinghai@kernel.org>
    Cc: Ram Pai <linuxram@us.ibm.com>

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 8f1e117..5fffca9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -51,24 +51,16 @@ static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 	return child;
 }
 
-static void virtfn_remove_bus(struct pci_bus *bus, int busnr)
+static void virtfn_remove_bus(struct pci_bus *physbus, struct pci_bus *virtbus)
 {
-	struct pci_bus *child;
-
-	if (bus->number == busnr)
-		return;
-
-	child = pci_find_bus(pci_domain_nr(bus), busnr);
-	BUG_ON(!child);
-
-	if (list_empty(&child->devices))
-		pci_remove_bus(child);
+	if (physbus != virtbus && list_empty(&virtbus->devices))
+		pci_remove_bus(virtbus);
 }
 
 static int virtfn_add(struct pci_dev *dev, int id, int reset)
 {
 	int i;
-	int rc;
+	int rc = -ENOMEM;
 	u64 size;
 	char buf[VIRTFN_ID_LEN];
 	struct pci_dev *virtfn;
@@ -76,18 +68,15 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
 
-	virtfn = pci_alloc_dev(NULL);
-	if (!virtfn)
-		return -ENOMEM;
-
 	mutex_lock(&iov->dev->sriov->lock);
 	bus = virtfn_add_bus(dev->bus, virtfn_bus(dev, id));
-	if (!bus) {
-		kfree(virtfn);
-		mutex_unlock(&iov->dev->sriov->lock);
-		return -ENOMEM;
-	}
-	virtfn->bus = pci_bus_get(bus);
+	if (!bus)
+		goto failed;
+
+	virtfn = pci_alloc_dev(bus);
+	if (!virtfn)
+		goto failed0;
+
 	virtfn->devfn = virtfn_devfn(dev, id);
 	virtfn->vendor = dev->vendor;
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
@@ -136,7 +125,9 @@ failed1:
 	pci_dev_put(dev);
 	mutex_lock(&iov->dev->sriov->lock);
 	pci_stop_and_remove_bus_device(virtfn);
-	virtfn_remove_bus(dev->bus, virtfn_bus(dev, id));
+failed0:
+	virtfn_remove_bus(dev->bus, bus);
+failed:
 	mutex_unlock(&iov->dev->sriov->lock);
 
 	return rc;
@@ -145,20 +136,15 @@ failed1:
 static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 {
 	char buf[VIRTFN_ID_LEN];
-	struct pci_bus *bus;
 	struct pci_dev *virtfn;
 	struct pci_sriov *iov = dev->sriov;
 
-	bus = pci_find_bus(pci_domain_nr(dev->bus), virtfn_bus(dev, id));
-	if (!bus)
-		return;
-
-	virtfn = pci_get_slot(bus, virtfn_devfn(dev, id));
+	virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
+					     virtfn_bus(dev, id),
+					     virtfn_devfn(dev, id));
 	if (!virtfn)
 		return;
 
-	pci_dev_put(virtfn);
-
 	if (reset) {
 		device_release_driver(&virtfn->dev);
 		__pci_reset_function(virtfn);
@@ -176,9 +162,11 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 
 	mutex_lock(&iov->dev->sriov->lock);
 	pci_stop_and_remove_bus_device(virtfn);
-	virtfn_remove_bus(dev->bus, virtfn_bus(dev, id));
+	virtfn_remove_bus(dev->bus, virtfn->bus);
 	mutex_unlock(&iov->dev->sriov->lock);
 
+	/* balance pci_get_domain_bus_and_slot() */
+	pci_dev_put(virtfn);
 	pci_dev_put(dev);
 }
 
@@ -335,13 +323,14 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		if (!pdev)
 			return -ENODEV;
 
-		pci_dev_put(pdev);
-
-		if (!pdev->is_physfn)
+		if (!pdev->is_physfn) {
+			pci_dev_put(pdev);
 			return -ENODEV;
+		}
 
 		rc = sysfs_create_link(&dev->dev.kobj,
 					&pdev->dev.kobj, "dep_link");
+		pci_dev_put(pdev);
 		if (rc)
 			return rc;
 	}
