Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:43498 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbbJ3FJ5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 01:09:57 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 30 Oct 2015 10:39:55 +0530
Date: Fri, 30 Oct 2015 13:09:49 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alexander Duyck <aduyck@mirantis.com>, linux-pci@vger.kernel.org,
	Ethan Zhao <ethan.zhao@oracle.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] PCI: Reorder pcibios_sriov_disable()
Message-ID: <20151030050949.GC5119@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20151029221701.11908.82718.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20151029222315.11908.6949.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151029222315.11908.6949.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 29, 2015 at 05:23:15PM -0500, Bjorn Helgaas wrote:
>From: Alexander Duyck <aduyck@mirantis.com>
>
>Move pcibios_sriov_disable() up so it's defined before a future use.
>
>[bhelgaas: split to separate patch for reviewability]
>Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Wei Yang <weiyang@linux.vnet.ibm.com>

>---
> drivers/pci/iov.c |   12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>index c86d94c..fada98d 100644
>--- a/drivers/pci/iov.c
>+++ b/drivers/pci/iov.c
>@@ -227,7 +227,12 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
>
> int __weak pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
> {
>-       return 0;
>+	return 0;
>+}
>+
>+int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>+{
>+	return 0;
> }
>
> static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>@@ -344,11 +349,6 @@ failed:
> 	return rc;
> }
>
>-int __weak pcibios_sriov_disable(struct pci_dev *pdev)
>-{
>-       return 0;
>-}
>-
> static void sriov_disable(struct pci_dev *dev)
> {
> 	int i;

-- 
Richard Yang
Help you, Help me

