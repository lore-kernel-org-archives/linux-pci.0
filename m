Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:38255 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaLVGMc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 01:12:32 -0500
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 22 Dec 2014 16:12:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9BCA02CE8069
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 17:12:29 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBM6CSW328049520
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 17:12:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBM6CSxA016747
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2014 17:12:28 +1100
Date: Mon, 22 Dec 2014 14:12:26 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: alex.williamson@redhat.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] vfio-pci: Fix the check on pci device type in
 vfio_pci_probe()
Message-ID: <20141222061226.GA12537@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1418001738-7010-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418001738-7010-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex,

Does it look good to you?

On Mon, Dec 08, 2014 at 09:22:18AM +0800, Wei Yang wrote:
>Current vfio-pci just supports normal pci device, so vfio_pci_probe() will
>return if the pci device is not a normal device. While current code makes a
>mistake. PCI_HEADER_TYPE is the offset in configuration space of the device
>type, but we use this value to mask the type value.
>
>This patch adds a function to check whether the pci device is a normal type
>and use it in vfio_pci_probe().
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> drivers/vfio/pci/vfio_pci.c |    4 +---
> include/linux/pci.h         |   11 +++++++++++
> 2 files changed, 12 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>index 9558da3..f82bf62 100644
>--- a/drivers/vfio/pci/vfio_pci.c
>+++ b/drivers/vfio/pci/vfio_pci.c
>@@ -839,13 +839,11 @@ static const struct vfio_device_ops vfio_pci_ops = {
>
> static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> {
>-	u8 type;
> 	struct vfio_pci_device *vdev;
> 	struct iommu_group *group;
> 	int ret;
>
>-	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &type);
>-	if ((type & PCI_HEADER_TYPE) != PCI_HEADER_TYPE_NORMAL)
>+	if (!pci_is_normal(pdev))
> 		return -EINVAL;
>
> 	group = iommu_group_get(&pdev->dev);
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index 48d1f98..2027f66 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -519,6 +519,17 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
> 		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
> }
>
>+/**
>+ * pci_is_normal - check if the PCI device is a normal device
>+ * @dev: PCI device
>+ *
>+ * Return true if the PCI device is a normal device
>+ */
>+static inline bool pci_is_normal(struct pci_dev *dev)
>+{
>+	return dev->hdr_type == PCI_HEADER_TYPE_NORMAL;
>+}
>+
> static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
> {
> 	dev = pci_physfn(dev);
>-- 
>1.7.9.5

-- 
Richard Yang
Help you, Help me

