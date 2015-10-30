Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:33452 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbbJ3FJM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 01:09:12 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 30 Oct 2015 10:39:09 +0530
Date: Fri, 30 Oct 2015 13:09:04 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, linux-pci@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] PCI: Remove VFs in reverse order if virtfn_add()
 fails
Message-ID: <20151030050904.GB5119@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222308.11908.95902.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029222308.11908.95902.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 29, 2015 at 05:23:08PM -0500, Bjorn Helgaas wrote:
>From: Alexander Duyck <aduyck@mirantis.com>
>
>If virtfn_add() fails, we call virtfn_remove() for any previously added
>devices.  Remove the devices in reverse order (first-added is
>last-removed), which is more natural and doesn't require an additional
>variable.
>
>[bhelgaas: changelog, split to separate patch for reviewability]
>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Interesting.

Reviewed-by: Wei Yang <weiyang@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c |    6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index ca400a9..c86d94c 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -233,7 +233,7 @@ int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> {
> 	int rc;
>-	int i, j;
>+	int i;
> 	int nres;
> 	u16 initial;
> 	struct resource *res;
>@@ -328,8 +328,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
> 	return 0;
>
> failed:
>-	for (j = 0; j < i; j++)
>-		virtfn_remove(dev, j, 0);
>+	while (i--)
>+		virtfn_remove(dev, i, 0);
>
> 	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
> 	pci_cfg_access_lock(dev);

-- 
Richard Yang
Help you, Help me

