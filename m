Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43993 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbbEMJLl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 13 May 2015 05:11:41 -0400
Date: Wed, 13 May 2015 17:10:59 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 06/10] iommu/vt-d: datatypes and functions used for
 kdump
Message-ID: <20150513091059.GF3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-7-git-send-email-zhen-hual@hp.com>
 <20150513085609.GD3736@dhcp-128-28.nay.redhat.com>
 <55531231.6040506@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55531231.6040506@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/13/15 at 04:58pm, Li, ZhenHua wrote:
> Hi Dave,
> 
> iommu->root_entry_old_virt is used to store the mapped old rta.
> iommu->root_entry_old_phys is used to store the physical address
> stored in registers.
> So we must not free/unmap iommu->root_entry_old_phys .

Oh, yes. I was mistaken on this. Thanks for telling.

> 
> Zhenhua
> On 05/13/2015 04:56 PM, Baoquan He wrote:
> >>+
> >>+	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
> >>+	if (!iommu->root_entry_old_phys) {
> >>+		pr_err("Could not read old root entry address.");
> >>+		return -1;
> >>+	}
> >>+
> >
> >I didn't find where you call iounmap to free mapping of
> >iommu->root_entry_old_phys. Am I missing anything?
> >
> >>+	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
> >>+						VTD_PAGE_SIZE);
> >>+	if (!iommu->root_entry_old_virt) {
> >>+		pr_err("Could not map the old root entry.");
> >>+		return -ENOMEM;
> >>+	}
> 
