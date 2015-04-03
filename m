Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbbDCJV6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 3 Apr 2015 05:21:58 -0400
Date: Fri, 3 Apr 2015 17:21:11 +0800
From: Dave Young <dyoung@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	joro@8bytes.org, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <551E56F6.60503@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <551E56F6.60503@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/03/15 at 05:01pm, Li, ZhenHua wrote:
> Hi Dave,
> 
> There may be some possibilities that the old iommu data is corrupted by
> some other modules. Currently we do not have a better solution for the
> dmar faults.
> 
> But I think when this happens, we need to fix the module that corrupted
> the old iommu data. I once met a similar problem in normal kernel, the
> queue used by the qi_* functions was written again by another module.
> The fix was in that module, not in iommu module.

It is too late, there will be no chance to save vmcore then.

Also if it is possible to continue corrupt other area of oldmem because
of using old iommu tables then it will cause more problems.

So I think the tables at least need some verifycation before being used.

> 
> 
> Thanks
> Zhenhua
> 
> On 04/03/2015 04:40 PM, Dave Young wrote:
> >>To fix this problem, we modifies the behaviors of the intel vt-d in the
> >>crashdump kernel:
> >>
> >>For DMA Remapping:
> >>1. To accept the vt-d hardware in an active state,
> >>2. Do not disable and re-enable the translation, keep it enabled.
> >>3. Use the old root entry table, do not rewrite the RTA register.
> >>4. Malloc and use new context entry table, copy data from the old ones that
> >>    used by the old kernel.
> >
> >Have not read all the patches, but I have a question, not sure this has been
> >answered before. Old memory is not reliable, what if the old memory get corrupted
> >before panic? Is it safe to continue using it in 2nd kernel, I worry that it will
> >cause problems.
> >
> >Hope I'm wrong though.
> >
> >Thanks
> >Dave
> >
> >
> 
