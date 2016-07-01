Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19857 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751845AbcGAAkJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 20:40:09 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u610cOwj098117
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 20:40:08 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23wbbb4b0v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Jun 2016 20:40:08 -0400
Received: from localhost
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 1 Jul 2016 10:40:05 +1000
Date: Fri, 1 Jul 2016 10:39:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com, aik@ozlabs.ru,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	corbet@lwn.net, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH v3 2/7] PCI: Ignore enforced alignment to VF BARs
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1467283993-3185-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467283993-3185-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Message-Id: <20160701003959.GB15147@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 30, 2016 at 06:53:08PM +0800, Yongji Xie wrote:
>VF BARs are read-only zeroes according to SRIOV spec,
>the normal way(writing BARs) of allocating resources wouldn't
>be applied to VFs. The VFs' resources would be allocated
>when we enable SR-IOV capability. So we should not try to
>reassign alignment after we enable VFs. It's meaningless
>and will release the allocated resources which leads to a bug.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/pci/pci.c |    4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index be8f72c..6ae02de 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -4822,6 +4822,10 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
> 	resource_size_t align, size;
> 	u16 command;
>
>+	/* We should never try to reassign VF's alignment */
>+	if (dev->is_virtfn)
>+		return;
>+

Yongji, I think it's correct to ignore VF's BARs. Another concern is:
it's safe to apply alignment to PF's IOV BARs? Lets have an extreme
example here: one PF has 16 VFs; each VF has only one 1KB. It means
the only PF IOV BAR is 16KB. I don't see how it works after expanding
it to 64KB which is the page size. It might be not a problem on PowerNV
platform, but potentially a issue on x86?

> 	/* check if specified PCI is target device to reassign */
> 	align = pci_specified_resource_alignment(dev);
> 	if (!align)

Thanks,
Gavin

