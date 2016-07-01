Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33573 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751665AbcGAA3o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 20:29:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u610NuN4065122
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 20:28:59 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23w62ey8at-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 20:28:59 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 1 Jul 2016 10:28:56 +1000
Date: Fri, 1 Jul 2016 10:28:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 1/7] PCI: Ignore enforced alignment when kernel uses
 existing firmware setup
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-2-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467283993-3185-2-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <20160701002852.GA15147@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 30, 2016 at 06:53:07PM +0800, Yongji Xie wrote:
>PCI resources allocator will use firmware setup and not try to
>reassign resource when PCI_PROBE_ONLY or IORESOURCE_PCI_FIXED
>is set.
>
>The enforced alignment in pci_reassigndev_resource_alignment()
>should be ignored in this case. Otherwise, some PCI devices'
>resources would be released here and not re-allocated.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/pci/pci.c |   12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index c8b4dbd..be8f72c 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4760,6 +4760,13 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
>
> 	spin_lock(&resource_alignment_lock);
> 	p = resource_alignment_param;
>+	if (pci_has_flag(PCI_PROBE_ONLY)) {
>+		if (*p)
>+			printk_once(KERN_INFO "PCI: Ignore resource_alignment parameter: %s with PCI_PROBE_ONLY set\n",
>+						p);

We don't have to print @resource_alignment as it's ignored completely.
The content included in it doesn't mean anything:

			pr_info_once("PCI: resource_alignment ignored with PCI_PROBE_ONLY\n");

>+		spin_unlock(&resource_alignment_lock);
>+		return 0;
>+	}

A empty line is needed here.

> 	while (*p) {
> 		count = 0;
> 		if (sscanf(p, "%d%n", &align_order, &count) == 1 &&
>@@ -4837,6 +4844,11 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> 		r = &dev->resource[i];
> 		if (!(r->flags & IORESOURCE_MEM))
> 			continue;
>+		if (r->flags & IORESOURCE_PCI_FIXED) {
>+			dev_info(&dev->dev, "No alignment for fixed BAR%d: %pR\n",
>+				i, r);

The message would be like below to match PCI code style. I'm thinking it probably
uses dev_dbg() instead dev_info(), but not sure for 100%.

			dev_info(&dev->dev, "BAR %d: fixed %pR, no alignment\n", i, r);

>+			continue;
>+		}

A empty line is needed here.

> 		size = resource_size(r);
> 		if (size < align) {
> 			size = align;

Thanks,
Gavin

