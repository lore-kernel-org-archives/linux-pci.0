Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:53509 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbbEOF52 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2015 01:57:28 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 15 May 2015 15:57:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3F6E22BB0040
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:57:23 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t4F5vECZ48365616
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:57:23 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t4F5unV2000817
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2015 15:56:50 +1000
Date: Fri, 15 May 2015 15:56:25 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V4 01/11] pci/iov: rename and export
 virtfn_add/virtfn_remove
Message-ID: <20150515055625.GA27029@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1431668786-30371-2-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431668786-30371-2-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 15, 2015 at 01:46:16PM +0800, Wei Yang wrote:
>During the EEH recovery, when a device's driver is not EEH aware or no
>driver is bound with a device, EEH core would do hotplug on this device.
>While it isn't feasible for a VF with usual hotplug procedure. During
>removal of a VF, virtual bus should be removed if necessary. During the
>re-creation, the pci_scan_slot() doesn't work on a VF.
>
>This patch exports two functions to handle the hotplug case for VF
>properly. They will be invoked when the EEH core does the hotplug case for
>VFs.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> drivers/pci/iov.c   |   10 +++++-----
> include/linux/pci.h |    2 ++
> 2 files changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 47daf2f..f353e6f 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -106,7 +106,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
> 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
> }
>
>-static int virtfn_add(struct pci_dev *dev, int id, int reset)
>+int pci_iov_virtfn_add(struct pci_dev *dev, int id, int reset)
> {
> 	int i;
> 	int rc = -ENOMEM;
>@@ -181,7 +181,7 @@ failed:
> 	return rc;
> }
>
>-static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>+void pci_iov_virtfn_remove(struct pci_dev *dev, int id, int reset)
> {
> 	struct pci_dev *virtfn;
>
>@@ -302,7 +302,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	}
>
> 	for (i = 0; i < initial; i++) {
>-		rc = virtfn_add(dev, i, 0);
>+		rc = pci_iov_virtfn_add(dev, i, 0);
> 		if (rc)
> 			goto failed;
> 	}
>@@ -314,7 +314,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>
> failed:
> 	for (j = 0; j < i; j++)
>-		virtfn_remove(dev, j, 0);
>+		pci_iov_virtfn_remove(dev, j, 0);
>
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
>@@ -343,7 +343,7 @@ static void sriov_disable(struct pci_dev *dev)
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

