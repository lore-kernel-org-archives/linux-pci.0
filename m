Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:9764 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbDCHqE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 03:46:04 -0400
Message-ID: <551E450F.4030903@hp.com>
Date: Fri, 03 Apr 2015 15:45:19 +0800
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
	rwright@hp.com, "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH v9 07/10] iommu/vt-d: enable kdump support in iommu module
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com> <1426743388-26908-8-git-send-email-zhen-hual@hp.com> <20150402110608.GL4441@8bytes.org>
In-Reply-To: <20150402110608.GL4441@8bytes.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,
Thinking about it carefully, I think you suggestions are very helpful, 
and the checks should be:
* All these things should be done in the second kernel, not only the 
kdump kernel. Sometimes user may use kexec manually start a new kernel.
* Copying those tables should only happen in the second kernel, only in 
this situation: iommu is enabled in both first and second kernel.

So, I think we can do this:
1. Use a new variable iommu_enabled_in_last_kernel;
2. When iommu module is loaded, it means the iommu is enabled in current 
kernel.  Then we check DMA_GSTS_TES:
    * if DMA_GSTS_TES is set, then it should be the second kernel(kexec 
starts this kernel manually, or it is kdump kernel), and the first 
kernel used iommu tables.  Here we need to copy these tables; then set 
iommu_enabled_in_last_kernel to 1.
    * if DMA_GSTS_TES is NOT set, then we do not need to care about 
these tables.

3. Replace all
#ifdef CONFIG_CRASH_DUMP
	if (is_kdump_kernel()) {
             // Do some thing
         }
#endif

To:
if (iommu_enabled_in_last_kernel) {
      // Do some thing
}

Do you agree with these?

Thanks
Zhenhua

On 04/02/2015 07:06 PM, Joerg Roedel wrote:
> On Thu, Mar 19, 2015 at 01:36:25PM +0800, Li, Zhen-Hua wrote:
>> +#ifdef CONFIG_CRASH_DUMP
>> +		if (is_kdump_kernel())
>> +			__iommu_update_old_root_entry(iommu, bus);
>> +#endif
>
> All the is_kdump_kernel checks in this patch (and maybe in other patches
> too) should really be checks whether translation on the IOMMU was
> enabled or not when the kernel booted. You might also boot from a kernel
> that had translation disabled into a kdump kernel that wants to enable
> it. In this case these checks would break.
>
> Speaking of booting from kernels with translation disabled, there is a
> valid use of is_kdump_enabled(), to omit iommu initialization in the
> kdump kernel when translation was disabled before. But the other checks
> should depend on the state the iommu had when booting the kdump kernel.
>
>
> 	Joerg
>

