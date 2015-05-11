Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:46886 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbEKCTd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 May 2015 22:19:33 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 11 May 2015 12:19:30 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6914A2CE8050
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 12:19:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4B2JK4R21692596
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 12:19:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4B2ItpQ004966
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2015 12:18:55 +1000
Date: Mon, 11 May 2015 12:13:31 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3 1/9] pci/iov: rename and export
 virtfn_add/virtfn_remove
Message-ID: <20150511021331.GC3694@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430723258-21299-2-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 04, 2015 at 03:07:30PM +0800, Wei Yang wrote:
>During the EEH procedure, when a device's driver is not EEH aware or no
            ^^^^^^^^^^^^^
            EEH recovery,

>driver is binded with a device, EEH core would do hotplug on this devices.
           ^^^^^^                                             ^^^^^^^^^^^^

>While it isn't feasible for a VF with usual hotplug procedure. During
>removal of a VF, virt_bus should be removed if necessary. During the
>re-creation, the pci_scan_slot() doesn't work on a VF.
>

Is "virt_bus" related to those functions you try to export? Even so,
you can simply have "virt_bus" in the commit log, please have "
virtual bus" or the formal things like that.

>This patch exports two functions to handle the hotplug case for VF
>properly. They will be invoked when the EEH core do the hotplug case for
                                                 ^^^^

>VFs.

Couple of typos as above.

Thanks,
Gavin

>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> drivers/pci/iov.c   |   10 +++++-----
> include/linux/pci.h |    2 ++
> 2 files changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index ee0ebff..cc941dd 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -108,7 +108,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
> 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
> }
>
>-static int virtfn_add(struct pci_dev *dev, int id, int reset)
>+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
> {
> 	int i;
> 	int rc = -ENOMEM;
>@@ -183,7 +183,7 @@ failed:
> 	return rc;
> }
>
>-static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
> {
> 	char buf[VIRTFN_ID_LEN];
> 	struct pci_dev *virtfn;
>@@ -320,7 +320,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	}
>
> 	for (i = 0; i < initial; i++) {
>-		rc = virtfn_add(dev, i, 0);
>+		rc = pci_iov_virtfn_add(dev, i, 0);
> 		if (rc)
> 			goto failed;
> 	}
>@@ -332,7 +332,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>
> failed:
> 	for (j = 0; j < i; j++)
>-		virtfn_remove(dev, j, 0);
>+		pci_iov_virtfn_remove(dev, j, 0);
>
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
>@@ -361,7 +361,7 @@ static void sriov_disable(struct pci_dev *dev)
> 		return;
>
> 	for (i = 0; i < iov->num_VFs; i++)
>-		virtfn_remove(dev, i, 0);
>+		pci_iov_virtfn_remove(dev, i, 0);
>
> 	pcibios_sriov_disable(dev);
>
>diff --git a/include/linux/pci.h b/include/linux/pci.h
>index 353db8d..94bacfa 100644
>--- a/include/linux/pci.h
>+++ b/include/linux/pci.h
>@@ -1679,6 +1679,8 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int id);
>
> int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
> void pci_disable_sriov(struct pci_dev *dev);
>+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset);
>+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset);
> int pci_num_vf(struct pci_dev *dev);
> int pci_vfs_assigned(struct pci_dev *dev);
> int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
>-- 
>1.7.9.5
>

