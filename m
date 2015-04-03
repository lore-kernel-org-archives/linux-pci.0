Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:44955 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbDCHyu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 03:54:50 -0400
Message-ID: <551E471F.7090504@hp.com>
Date: Fri, 03 Apr 2015 15:54:07 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Joerg Roedel <joro@8bytes.org>
CC: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com> <20150402111133.GM4441@8bytes.org>
In-Reply-To: <20150402111133.GM4441@8bytes.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,
This is quite strange. I checked the patches from patch 01 to 10 using 
./scripts/checkpatch.pl under the kernel source directory, but got 0 
errors and 0 warning.  Only some white spaces in the cover letter 00, 
but is could not be checked by this script.

But I checked the intel-iommu.c using "checkpatch.pl -f", found too many 
warnings and errors. Maybe we need a new patch to fix them.

Thanks
Zhenhua

On 04/02/2015 07:11 PM, Joerg Roedel wrote:
> Hi Zhen-Hua,
>
> On Thu, Mar 19, 2015 at 01:36:18PM +0800, Li, Zhen-Hua wrote:
>> This patchset is an update of Bill Sumner's patchset, implements a fix for:
>> If a kernel boots with intel_iommu=on on a system that supports intel vt-d,
>> when a panic happens, the kdump kernel will boot with these faults:
>
> I reviewed this patch-set and it is getting closer to a point where it
> could be merged. I found a few white-space errors in the review, please
> do a check_patch run on the next round and fix these. Besides that and
> given some third-party testing and reviews I think we can look forward
> to merge it early after the merge-window for v4.1, to give it enough
> testing in -next too.
>
>
> 	Joerg
>

