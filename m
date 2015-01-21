Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:43148 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbbAUWyK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jan 2015 17:54:10 -0500
Received: by mail-oi0-f43.google.com with SMTP id z81so11779773oif.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2015 14:54:09 -0800 (PST)
Date: Wed, 21 Jan 2015 16:54:05 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Calculate the VF bus range on each possible
 NumVFs
Message-ID: <20150121225405.GB13072@google.com>
References: <1419227326-12083-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1419227326-12083-3-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419227326-12083-3-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 22, 2014 at 01:48:46PM +0800, Wei Yang wrote:
> Per SRIOV SPEC section 3.3.10 and 3.3.11, VF Stride and VF Offset may change
> when NumVFs changes. This will affect the bus range for VFs.
> 
> This patch iterates on each possible NumVFs and calculate the maximum bus
> range for VFs.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/iov.c |   31 +++++++++++++++++++++++++++----
>  drivers/pci/pci.h |    1 +
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index ef0ceaa..ea3a82c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -46,6 +46,30 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
>  	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
>  }
>  
> +/**
> + * Per SRIOV SPEC section 3.3.10 and 3.3.11, VF Stride and VF offset may
> + * change when NumVFs changes. Which will affect the bus range for VFs.
> + *
> + * This function iterate on all valide NumVFs and calculate the maximum bus
> + * range for VFs.
> + */
> +static inline void pci_iov_max_bus_range(struct pci_dev *dev)
> +{
> +	struct pci_sriov *iov = dev->sriov;
> +	int total = iov->total_VFs;
> +	u8 max = 0;
> +	u8 busnr;
> +
> +	for ( ; total >= 0; total--) {
> +		pci_iov_set_numvfs(dev, total);
> +		busnr = virtfn_bus(dev, iov->total_VFs - 1);

We don't need TotalVFs here, do we?  I think NumVFs should be enough.
Proposed updated patch attached below.

> +		if (busnr > max)
> +			max = busnr;
> +	}
> +
> +	iov->max_bus_range = max;
> +}


commit aecf80117ca5be299f85ead9125434f58f2ae3cb
Author: Wei Yang <weiyang@linux.vnet.ibm.com>
Date:   Mon Dec 22 13:48:46 2014 +0800

    PCI: Calculate maximum number of buses required for VFs
    
    An SR-IOV device can change its First VF OFfset and VF Stride based on the
    values of ARI Capable Hierarchy and NumVFs.  The number of buses required
    for all VFs is determined by NumVFs, First VF Offset, and VF Stride (see
    SR-IOV spec r1.1, sec 2.1.2).
    
    Previously pci_iov_bus_range() computed how many buses would be required by
    TotalVFs, but this was based on a single NumVFs value and may not have been
    the maximum for all NumVFs configurations.
    
    Iterate over all valid NumVFs and calculate the maximum number of bus
    numbers that could ever be required for VFs of this device.
    
    [bhelgaas: compute busnr of NumVFs, not TotalVFs, changelog]
    Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index dd4bc361f24a..62f9c8f6871f 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -46,6 +46,30 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
 }
 
+/**
+ * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
+ * determine how many additional bus numbers will be consumed by VFs.
+ *
+ * Iterate over all valid NumVFs and calculate the maximum number of bus
+ * numbers that could ever be required.
+ */
+static inline u8 virtfn_max_buses(struct pci_dev *dev)
+{
+	struct pci_sriov *iov = dev->sriov;
+	int nr_virtfn;
+	u8 max = 0;
+	u8 busnr;
+
+	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
+		pci_iov_set_numvfs(dev, nr_virtfn);
+		busnr = virtfn_bus(dev, nr_virtfn - 1);
+		if (busnr > max)
+			max = busnr;
+	}
+
+	return max;
+}
+
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
 {
 	struct pci_bus *child;
@@ -413,6 +437,7 @@ found:
 
 	mutex_init(&iov->lock);
 
+	iov->max_VF_buses = virtfn_max_buses(dev);
 	dev->sriov = iov;
 	dev->is_physfn = 1;
 
@@ -550,15 +575,13 @@ void pci_restore_iov_state(struct pci_dev *dev)
 int pci_iov_bus_range(struct pci_bus *bus)
 {
 	int max = 0;
-	u8 busnr;
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!dev->is_physfn)
 			continue;
-		busnr = virtfn_bus(dev, dev->sriov->total_VFs - 1);
-		if (busnr > max)
-			max = busnr;
+		if (dev->sriov->max_VF_buses > max)
+			max = dev->sriov->max_VF_buses;
 	}
 
 	return max ? max - bus->number : 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8aff29a804ff..f0a19dc7acdd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -236,6 +236,7 @@ struct pci_sriov {
 	u16 stride;		/* following VF stride */
 	u32 pgsz;		/* page size for BAR alignment */
 	u8 link;		/* Function Dependency Link */
+	u8 max_VF_buses;	/* max buses consumed by VFs */
 	u16 driver_max_VFs;	/* max num VFs driver supports */
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
