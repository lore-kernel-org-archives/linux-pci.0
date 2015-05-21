Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52402 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbbEUKLP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 May 2015 06:11:15 -0400
Date: Thu, 21 May 2015 18:11:10 +0800
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
Subject: Re: [PATCH v11 08/10] iommu/vt-d: assign new page table for dma_map
Message-ID: <20150521101110.GE3258@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-9-git-send-email-zhen-hual@hp.com>
 <20150520235242.GA2342@dhcp-17-102.nay.redhat.com>
 <555D3470.7060902@hp.com>
 <20150521065451.GA23661@dhcp-128-28.nay.redhat.com>
 <555D99EB.2030603@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555D99EB.2030603@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/21/15 at 04:40pm, Li, ZhenHua wrote:
> Hi Baoquan,
> During driver being loaded and initialized, when there is a new dma
> request, the function
>                __get_valid_domain_for_dev
> is called, and then new page is mapped.
> 
> Please check this:
> struct dma_map_ops intel_dma_ops = {
>         .alloc = intel_alloc_coherent,
>         .free = intel_free_coherent,
>         .map_sg = intel_map_sg,
>         .unmap_sg = intel_unmap_sg,
>         .map_page = intel_map_page,
>         .unmap_page = intel_unmap_page,
>         .mapping_error = intel_mapping_error,
> };
> 
> You can also add dump_stack() in __get_valid_domain_for_dev to debug.

Yeah, I saw that. At the beginning I am just wondering why you say a new
page-table, and also mention it's a empty page-table. I think here that
new page-table is an empty page-table when you said them.

No confusion any more. Thanks for explanation.

> 
> Thanks
> Zhenhua
> 
> On 05/21/2015 02:54 PM, Baoquan He wrote:
> >On 05/21/15 at 09:27am, Li, ZhenHua wrote:
> >>Hi Baoquan,
> >>
> >>In the early version of this patchset, old page tables are used by new
> >>kernel.  But as discussed, we need to make kernel use new pages when
> >>there is a new dma request , so we need to unmap the pages which were
> >>mapped in old kernel, and this is what this patch does.
> >
> >OK, just a new page table allocated in init_domain(), right? I thought a
> >specific empty page-table is allocated for these new domains in kdump
> >kernel.
> >
> >>
> >>Thanks
> >>Zhenhua
> >>
> >>On 05/21/2015 07:52 AM, Baoquan He wrote:
> >>>On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> >>>>When a device driver issues the first dma_map command for a device, we
> >>>>assign a new and empty page-table, thus removing all mappings from the
> >>>>old kernel for the device.
> >>>
> >>>Hi Zhenhua,
> >>>
> >>> From your patch I got it will remove all mappings, assign a new
> >>>page-table. But I didn't got why you stress an empty page-table. Did I
> >>>miss anything?
> >>>
> >>>Thanks
> >>>Baoquan
> >>>
> >>>>
> >>>>Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
> >>>>--
