Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51384 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbaLVXi2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Dec 2014 18:38:28 -0500
Message-ID: <1419291504.30005.5.camel@bling.home>
Subject: Re: [PATCH] vfio-pci: Fix the check on pci device type in
 vfio_pci_probe()
From: Alex Williamson <alex.williamson@redhat.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Date: Mon, 22 Dec 2014 16:38:24 -0700
In-Reply-To: <20141222061226.GA12537@richard>
References: <1418001738-7010-1-git-send-email-weiyang@linux.vnet.ibm.com>
	 <20141222061226.GA12537@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2014-12-22 at 14:12 +0800, Wei Yang wrote:
> Alex,
> 
> Does it look good to you?

Well, mixing changes to a subsystem and a driver in a single patch is
surely going to slow down acceptance because neither Bjorn or I know who
is going to grab it.  I'd probably want to mark the vfio-pci change for
stable, which would be a lot easier to do if it was just a 4-line
correction to the existing code rather than extending the pci-core
interface for a single, trivial user.  Thanks,

Alex

On Mon, Dec 08, 2014 at 09:22:18AM +0800, Wei Yang wrote:
> >Current vfio-pci just supports normal pci device, so vfio_pci_probe() will
> >return if the pci device is not a normal device. While current code makes a
> >mistake. PCI_HEADER_TYPE is the offset in configuration space of the device
> >type, but we use this value to mask the type value.
> >
> >This patch adds a function to check whether the pci device is a normal type
> >and use it in vfio_pci_probe().
> >
> >Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> >---
> > drivers/vfio/pci/vfio_pci.c |    4 +---
> > include/linux/pci.h         |   11 +++++++++++
> > 2 files changed, 12 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >index 9558da3..f82bf62 100644
> >--- a/drivers/vfio/pci/vfio_pci.c
> >+++ b/drivers/vfio/pci/vfio_pci.c
> >@@ -839,13 +839,11 @@ static const struct vfio_device_ops vfio_pci_ops = {
> >
> > static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > {
> >-	u8 type;
> > 	struct vfio_pci_device *vdev;
> > 	struct iommu_group *group;
> > 	int ret;
> >
> >-	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &type);
> >-	if ((type & PCI_HEADER_TYPE) != PCI_HEADER_TYPE_NORMAL)
> >+	if (!pci_is_normal(pdev))
> > 		return -EINVAL;
> >
> > 	group = iommu_group_get(&pdev->dev);
> >diff --git a/include/linux/pci.h b/include/linux/pci.h
> >index 48d1f98..2027f66 100644
> >--- a/include/linux/pci.h
> >+++ b/include/linux/pci.h
> >@@ -519,6 +519,17 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
> > 		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
> > }
> >
> >+/**
> >+ * pci_is_normal - check if the PCI device is a normal device
> >+ * @dev: PCI device
> >+ *
> >+ * Return true if the PCI device is a normal device
> >+ */
> >+static inline bool pci_is_normal(struct pci_dev *dev)
> >+{
> >+	return dev->hdr_type == PCI_HEADER_TYPE_NORMAL;
> >+}
> >+
> > static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
> > {
> > 	dev = pci_physfn(dev);
> >-- 
> >1.7.9.5
> 



