Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:51874 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbaKXXBQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 24 Nov 2014 18:01:16 -0500
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Tue, 25 Nov 2014 04:31:14 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2BECA3940053
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2014 04:31:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAON1lZl2490662
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2014 04:31:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sAON1BnQ022458
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2014 04:31:11 +0530
Date: Tue, 25 Nov 2014 10:01:08 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Refresh offset/stride after NumVFs is written
Message-ID: <20141124230108.GA8765@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1416624759-13543-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416624759-13543-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 22, 2014 at 10:52:39AM +0800, Wei Yang wrote:
>According to SR-IOV spec sec 3.3.9, 3.3.10, the NumVFs setting change will
>affect the offset and stride. Current implementation doesn't refresh the
>offset/stride cached in pci_sriov structure.
>
>This patch introduces a wrapper pci_iov_set_numvfs(), which refresh these two
>value after NumVFs is written.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> drivers/pci/iov.c |   17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 4d109c0..c7010c5 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -31,6 +31,15 @@ static inline u8 virtfn_devfn(struct pci_dev *dev, int id)
> 		dev->sriov->stride * id) & 0xff;
> }
>
>+static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
>+{
>+	struct pci_sriov *iov = dev->sriov;
>+
>+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);

I'm suspecting writing to PCI_SRIOV_NUM_VF would take some time to take
effect.

>+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
>+	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
>+}
>+
> static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
> {
> 	struct pci_bus *child;
>@@ -243,7 +252,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 			return rc;
> 	}
>
>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
>+	pci_iov_set_numvfs(dev, nr_virtfn);
> 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
> 	pci_cfg_access_lock(dev);
> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>@@ -272,7 +281,7 @@ failed:
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
>+	pci_iov_set_numvfs(dev, 0);
> 	ssleep(1);

The 1 second delay here might be for waiting VFs to be ready.

> 	pci_cfg_access_unlock(dev);
>
>@@ -303,7 +312,7 @@ static void sriov_disable(struct pci_dev *dev)
> 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>
> 	iov->num_VFs = 0;
>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
>+	pci_iov_set_numvfs(dev, 0);
> }
>
> static int sriov_init(struct pci_dev *dev, int pos)
>@@ -439,7 +448,7 @@ static void sriov_restore_state(struct pci_dev *dev)
> 		pci_update_resource(dev, i);
>
> 	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
>-	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, iov->num_VFs);
>+	pci_iov_set_numvfs(dev, iov->num_VFs);
> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> 	if (iov->ctrl & PCI_SRIOV_CTRL_VFE)
> 		msleep(100);

Here's another delay if PCI_SRIOV_CTRL_VFE isn't set previously.

Thanks,
Gavin

>-- 
>1.7.9.5
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

