Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:50979 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbDCJCf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 05:02:35 -0400
Message-ID: <551E56F6.60503@hp.com>
Date: Fri, 03 Apr 2015 17:01:42 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Dave Young <dyoung@redhat.com>
CC: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	joro@8bytes.org, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com, "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com> <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
In-Reply-To: <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dave,

There may be some possibilities that the old iommu data is corrupted by
some other modules. Currently we do not have a better solution for the
dmar faults.

But I think when this happens, we need to fix the module that corrupted
the old iommu data. I once met a similar problem in normal kernel, the
queue used by the qi_* functions was written again by another module.
The fix was in that module, not in iommu module.


Thanks
Zhenhua

On 04/03/2015 04:40 PM, Dave Young wrote:
>> To fix this problem, we modifies the behaviors of the intel vt-d in the
>> crashdump kernel:
>>
>> For DMA Remapping:
>> 1. To accept the vt-d hardware in an active state,
>> 2. Do not disable and re-enable the translation, keep it enabled.
>> 3. Use the old root entry table, do not rewrite the RTA register.
>> 4. Malloc and use new context entry table, copy data from the old ones that
>>     used by the old kernel.
>
> Have not read all the patches, but I have a question, not sure this has been
> answered before. Old memory is not reliable, what if the old memory get corrupted
> before panic? Is it safe to continue using it in 2nd kernel, I worry that it will
> cause problems.
>
> Hope I'm wrong though.
>
> Thanks
> Dave
>
>

