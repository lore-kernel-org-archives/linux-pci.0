Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:40363 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbbDCIbm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 3 Apr 2015 04:31:42 -0400
Message-ID: <551E4FC4.3030601@hp.com>
Date: Fri, 03 Apr 2015 16:31:00 +0800
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
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com> <20150403082816.GE22579@dhcp-128-53.nay.redhat.com>
In-Reply-To: <20150403082816.GE22579@dhcp-128-53.nay.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/03/2015 04:28 PM, Dave Young wrote:
> On 03/19/15 at 01:36pm, Li, Zhen-Hua wrote:
>> This patchset is an update of Bill Sumner's patchset, implements a fix for:
>> If a kernel boots with intel_iommu=on on a system that supports intel vt-d,
>> when a panic happens, the kdump kernel will boot with these faults:
> Zhenhua,
>
> I will review the patchset recently, sorry for jumping in late.
>
> Thanks
> Dave
>
Hi Dave,
Thanks for your review. And please also take a look at the plan I sent 
in another mail:

Change use of
      if (is_kdump_kernel()) { }

To:
     if (iommu_enabled_in_last_kernel) { }

