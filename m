Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:49111 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756562AbaIWRyb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 13:54:31 -0400
Received: by mail-ig0-f173.google.com with SMTP id l13so5061640iga.6
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2014 10:54:30 -0700 (PDT)
Date: Tue, 23 Sep 2014 11:54:28 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/9] PCI/MSI: Change msi_bus attribute to support
 enable/disable MSI for EP
Message-ID: <20140923175428.GA6776@google.com>
References: <1411450050-1510-1-git-send-email-wangyijing@huawei.com>
 <1411450050-1510-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411450050-1510-4-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 23, 2014 at 01:27:24PM +0800, Yijing Wang wrote:
> Msi_bus attribute is only valid for bridge device.
> We can enable or disable MSI capability for a bus,
> if we echo 1/0 > /sys/bus/pci/devices/$EP/msi_bus,
> the action will be ignored. Sometime we need to
> only enable/disable a EP device MSI capability,
> not all devices share the same bus.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |    9 +++++++++
>  drivers/pci/pci-sysfs.c                 |   12 ++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 6615fda..edc4e8d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -65,6 +65,15 @@ Description:
>  		force a rescan of all PCI buses in the system, and
>  		re-discover previously removed devices.
>  
> +What:		/sys/bus/pci/devices/.../msi_bus
> +Date:		September 2014
> +Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
> +Description:
> +		Writing a zero value to this attribute will turn off
> +		MSI capability for device. If device is a bridge, all
> +		child devices under the bridge will be set to no MSI.
> +		Drivers need to be reloaded to valid the new setting.
> +
>  What:		/sys/bus/pci/devices/.../msi_irqs/
>  Date:		September, 2011
>  Contact:	Neil Horman <nhorman@tuxdriver.com>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 9ff0a90..b199ad9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -251,11 +251,9 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	if (!pdev->subordinate)
> -		return 0;
> -
> -	return sprintf(buf, "%u\n",
> -		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI));
> +	return sprintf(buf, "%u\n", pdev->subordinate ?
> +		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
> +			   : !pdev->no_msi);
>  }
>  
>  static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
> @@ -278,8 +276,10 @@ static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
>  	 * Maybe devices without subordinate buses shouldn't have this
>  	 * attribute in the first place?
>  	 */
> -	if (!pdev->subordinate)
> +	if (!pdev->subordinate) {
> +		pdev->no_msi = !val;
>  		return count;
> +	}
>  
>  	/* Is the flag going to change, or keep the value it already had? */
>  	if (!(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI) ^
> -- 
> 1.7.1
> 

I propose the following, which rewords the changelog, documentation, and
comments.  It also adds a printk for the endpoint case and makes the bridge
printk unconditional.  And it simplifies the code to set the bus flag.

Let me know if you object to anything.

Bjorn


commit 8ca0ecc79e6b154d3e16f443c1dd520f4c8af4ac
Author: Yijing Wang <wangyijing@huawei.com>
Date:   Tue Sep 23 13:27:24 2014 +0800

    PCI/MSI: Add "msi_bus" sysfs MSI/MSI-X control for endpoints
    
    The "msi_bus" sysfs file for bridges sets a bus flag to allow or disallow
    future driver requests for MSI or MSI-X.  Previously, the sysfs file
    existed for endpoints but did nothing.
    
    Add "msi_bus" support for endpoints, so an administrator can prevent the
    use of MSI and MSI-X for individual devices.
    
    Note that as for bridges, these changes only affect future driver requests
    for MSI or MSI-X, so drivers may need to be reloaded.
    
    Add documentation for the "msi_bus" sysfs file.
    
    [bhelgaas: changelog, comments, add "subordinate", add endpoint printk,
    rework bus_flags setting, make bus_flags printk unconditional]
    Signed-off-by: Yijing Wang <wangyijing@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6615fda0abfb..ee6c04036492 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -65,6 +65,16 @@ Description:
 		force a rescan of all PCI buses in the system, and
 		re-discover previously removed devices.
 
+What:		/sys/bus/pci/devices/.../msi_bus
+Date:		September 2014
+Contact:	Linux PCI developers <linux-pci@vger.kernel.org>
+Description:
+		Writing a zero value to this attribute disallows MSI and
+		MSI-X for any future drivers of the device.  If the device
+		is a bridge, MSI and MSI-X will be disallowed for future
+		drivers of all child devices under the bridge.  Drivers
+		must be reloaded for the new setting to take effect.
+
 What:		/sys/bus/pci/devices/.../msi_irqs/
 Date:		September, 2011
 Contact:	Neil Horman <nhorman@tuxdriver.com>
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ff0a901ecf7..dbf63e23988d 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -250,46 +250,45 @@ static ssize_t msi_bus_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *subordinate = pdev->subordinate;
 
-	if (!pdev->subordinate)
-		return 0;
-
-	return sprintf(buf, "%u\n",
-		       !(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI));
+	return sprintf(buf, "%u\n", subordinate ?
+		       !(subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI)
+			   : !pdev->no_msi);
 }
 
 static ssize_t msi_bus_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *subordinate = pdev->subordinate;
 	unsigned long val;
 
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	/*
-	 * Bad things may happen if the no_msi flag is changed
-	 * while drivers are loaded.
-	 */
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
-	 * Maybe devices without subordinate buses shouldn't have this
-	 * attribute in the first place?
+	 * "no_msi" and "bus_flags" only affect what happens when a driver
+	 * requests MSI or MSI-X.  They don't affect any drivers that have
+	 * already requested MSI or MSI-X.
 	 */
-	if (!pdev->subordinate)
+	if (!subordinate) {
+		pdev->no_msi = !val;
+		dev_info(&pdev->dev, "MSI/MSI-X %s for future drivers\n",
+			 val ? "allowed" : "disallowed");
 		return count;
-
-	/* Is the flag going to change, or keep the value it already had? */
-	if (!(pdev->subordinate->bus_flags & PCI_BUS_FLAGS_NO_MSI) ^
-	    !!val) {
-		pdev->subordinate->bus_flags ^= PCI_BUS_FLAGS_NO_MSI;
-
-		dev_warn(&pdev->dev, "forced subordinate bus to%s support MSI, bad things could happen\n",
-			 val ? "" : " not");
 	}
 
+	if (val)
+		subordinate->bus_flags &= ~PCI_BUS_FLAGS_NO_MSI;
+	else
+		subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
+
+	dev_info(&subordinate->dev, "MSI/MSI-X %s for future drivers of devices on this bus\n",
+		 val ? "allowed" : "disallowed");
 	return count;
 }
 static DEVICE_ATTR_RW(msi_bus);
