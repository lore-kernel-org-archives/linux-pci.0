Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:49122 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964912AbbEMBqd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2015 21:46:33 -0400
Message-ID: <5552ACB9.5050309@hp.com>
Date: Wed, 13 May 2015 09:45:29 +0800
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
Subject: Re: [PATCH v11 02/10] iommu/vt-d: Items required for kdump
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com> <1431337974-545-3-git-send-email-zhen-hual@hp.com> <20150512081723.GC4561@localhost.localdomain>
In-Reply-To: <20150512081723.GC4561@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/12/2015 04:17 PM, Dave Young wrote:
> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>> Add context entry functions needed for kdump.
>> +/*
>> + * Fix Crashdump failure caused by leftover DMA through a hardware IOMMU
>> + *
>> + * Fixes the crashdump kernel to deal with an active iommu and legacy
>> + * DMA from the (old) panicked kernel in a manner similar to how legacy
>> + * DMA is handled when no hardware iommu was in use by the old kernel --
>> + * allow the legacy DMA to continue into its current buffers.
>> + *
>> + * In the crashdump kernel, this code:
>> + * 1. skips disabling the IOMMU's translating.
>> + * 2. Do not re-enable IOMMU's translating.
>> + * 3. In kdump kernel, use the old root entry table.
>> + * 4. Allocate pages for new context entry, copy data from old context entries
>> + *    in the old kernel to the new ones.
>> + *
>> + * In other kinds of kernel, for example, a kernel started by kexec,
>> + * do the same thing as crashdump kernel.
>> + */
>> +
>> +
>
> Above comments should come along with the code changes instead of putting it
> in this patch.
>
> BTW, there's one more blank line at the end..
Code change is in 00/10, the cover letter.
And the blank does not matter, I checked the patch with 
scripts/checkpatch.pl,  no warnings, no errors.


