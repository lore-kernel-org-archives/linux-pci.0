Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:57555 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbCTFr2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Mar 2015 01:47:28 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 20 Mar 2015 15:47:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 582D6357804C
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 16:47:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t2K5lFbD28704910
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 16:47:23 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t2K5knS9005293
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2015 16:46:49 +1100
Date: Fri, 20 Mar 2015 16:46:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V14 10/21] PCI: Add pcibios_sriov_enable() and
 pcibios_sriov_disable()
Message-ID: <20150320054625.GB8119@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1426820797-6267-11-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426820797-6267-11-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 20, 2015 at 11:06:26AM +0800, Wei Yang wrote:
>VFs are dynamically created when a driver enables them.  On some platforms,
>like PowerNV, special resources are necessary to enable VFs.
>
>Add platform hooks for enabling and disabling VFs.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> drivers/pci/iov.c |   19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index 5643a10..64c4692 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -220,6 +220,11 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
> 	pci_dev_put(dev);
> }
> 
>+int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>+{
>+       return 0;
>+}
>+
> static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> {
> 	int rc;
>@@ -231,6 +236,7 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	struct pci_sriov *iov = dev->sriov;
> 	int bars = 0;
> 	int bus;
>+	int retval;
> 
> 	if (!nr_virtfn)
> 		return 0;
>@@ -307,6 +313,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	if (nr_virtfn < initial)
> 		initial = nr_virtfn;
> 
>+	if ((retval = pcibios_sriov_enable(dev, initial))) {
>+		dev_err(&dev->dev, "failure %d from pcibios_sriov_enable()\n",
>+			retval);
>+		return retval;
>+	}
>+
> 	for (i = 0; i < initial; i++) {
> 		rc = virtfn_add(dev, i, 0);
> 		if (rc)
>@@ -335,6 +347,11 @@ failed:
> 	return rc;
> }
> 
>+int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>+{
>+       return 0;
>+}
>+

Since you will have to v15, I would suggest to drop the return
value for this function. It seems there isn't a reason to have "int"
return value here.

Thanks,
Gavin

> static void sriov_disable(struct pci_dev *dev)
> {
> 	int i;
>@@ -346,6 +363,8 @@ static void sriov_disable(struct pci_dev *dev)
> 	for (i = 0; i < iov->num_VFs; i++)
> 		virtfn_remove(dev, i, 0);
> 
>+	pcibios_sriov_disable(dev);
>+
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>-- 
>1.7.9.5
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

