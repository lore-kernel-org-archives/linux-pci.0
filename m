Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:47925 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaLWBQb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 20:16:31 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 23 Dec 2014 11:16:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 827612CE805A
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2014 12:16:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBN1GOKS30605338
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2014 12:16:25 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBN1GNJb018001
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2014 12:16:24 +1100
Date: Tue, 23 Dec 2014 09:16:22 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] vfio-pci: Fix the check on pci device type in
 vfio_pci_probe()
Message-ID: <20141223011622.GA6035@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1418001738-7010-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141222061226.GA12537@richard>
 <1419291504.30005.5.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419291504.30005.5.camel@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 22, 2014 at 04:38:24PM -0700, Alex Williamson wrote:
>On Mon, 2014-12-22 at 14:12 +0800, Wei Yang wrote:
>> Alex,
>> 
>> Does it look good to you?
>
>Well, mixing changes to a subsystem and a driver in a single patch is
>surely going to slow down acceptance because neither Bjorn or I know who
>is going to grab it.  I'd probably want to mark the vfio-pci change for
>stable, which would be a lot easier to do if it was just a 4-line
>correction to the existing code rather than extending the pci-core
>interface for a single, trivial user.  Thanks,
>
>Alex

Hi,

I got your concern.

The reason I introduce a helper to check the pci device type is in my mind we
will try our best to hide those pci detailed information from outside. The
easiest way to fix it is to check the pci_dev->hdr_type field, but this will
export some internal information from pci core to vfio-pci.

I will first make a 4-line change to fix this error. If Bjorn like the idea of
the helper, I will make up another one.

>
>On Mon, Dec 08, 2014 at 09:22:18AM +0800, Wei Yang wrote:
>> >Current vfio-pci just supports normal pci device, so vfio_pci_probe() will
>> >return if the pci device is not a normal device. While current code makes a
>> >mistake. PCI_HEADER_TYPE is the offset in configuration space of the device
>> >type, but we use this value to mask the type value.
>> >
>> >This patch adds a function to check whether the pci device is a normal type
>> >and use it in vfio_pci_probe().
>> >
>> >Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> >---
>> > drivers/vfio/pci/vfio_pci.c |    4 +---
>> > include/linux/pci.h         |   11 +++++++++++
>> > 2 files changed, 12 insertions(+), 3 deletions(-)
>> >
>> >diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> >index 9558da3..f82bf62 100644
>> >--- a/drivers/vfio/pci/vfio_pci.c
>> >+++ b/drivers/vfio/pci/vfio_pci.c
>> >@@ -839,13 +839,11 @@ static const struct vfio_device_ops vfio_pci_ops = {
>> >
>> > static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> > {
>> >-	u8 type;
>> > 	struct vfio_pci_device *vdev;
>> > 	struct iommu_group *group;
>> > 	int ret;
>> >
>> >-	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &type);
>> >-	if ((type & PCI_HEADER_TYPE) != PCI_HEADER_TYPE_NORMAL)
>> >+	if (!pci_is_normal(pdev))
>> > 		return -EINVAL;
>> >
>> > 	group = iommu_group_get(&pdev->dev);
>> >diff --git a/include/linux/pci.h b/include/linux/pci.h
>> >index 48d1f98..2027f66 100644
>> >--- a/include/linux/pci.h
>> >+++ b/include/linux/pci.h
>> >@@ -519,6 +519,17 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
>> > 		dev->hdr_type == PCI_HEADER_TYPE_CARDBUS;
>> > }
>> >
>> >+/**
>> >+ * pci_is_normal - check if the PCI device is a normal device
>> >+ * @dev: PCI device
>> >+ *
>> >+ * Return true if the PCI device is a normal device
>> >+ */
>> >+static inline bool pci_is_normal(struct pci_dev *dev)
>> >+{
>> >+	return dev->hdr_type == PCI_HEADER_TYPE_NORMAL;
>> >+}
>> >+
>> > static inline struct pci_dev *pci_upstream_bridge(struct pci_dev *dev)
>> > {
>> > 	dev = pci_physfn(dev);
>> >-- 
>> >1.7.9.5
>> 
>
>

-- 
Richard Yang
Help you, Help me

