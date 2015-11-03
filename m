Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:36996 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbbKCCE4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2015 21:04:56 -0500
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Tue, 3 Nov 2015 07:34:54 +0530
Date: Tue, 3 Nov 2015 10:04:48 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, linux-pci@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] PCI: Wait 1 second between disabling VFs and
 clearing NumVFs
Message-ID: <20151103020448.GB1763@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222322.11908.13738.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029222322.11908.13738.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 29, 2015 at 05:23:22PM -0500, Bjorn Helgaas wrote:
>From: Alexander Duyck <aduyck@mirantis.com>
>
>Per sec 3.3.3.1 of the SR-IOV spec, r1.1, we must allow 1.0s after clearing
>VF Enable before reading any field in the SR-IOV Extended Capability.
>
>Wait 1 second before calling pci_iov_set_numvfs(), which reads
>PCI_SRIOV_VF_OFFSET and PCI_SRIOV_VF_STRIDE after it sets PCI_SRIOV_NUM_VF.
>
>[bhelgaas: split to separate patch for reviewability, add spec reference]
>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Wei Yang <weiyang@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index fada98d..24428d5 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -339,13 +339,13 @@ failed:
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);
> 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>-	pci_iov_set_numvfs(dev, 0);
> 	ssleep(1);
> 	pci_cfg_access_unlock(dev);
>
> 	if (iov->link != dev->devfn)
> 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>
>+	pci_iov_set_numvfs(dev, 0);
> 	return rc;
> }
>

-- 
Richard Yang
Help you, Help me

