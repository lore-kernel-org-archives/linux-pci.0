Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <552DFB56.1070600@hp.com>
Date: Wed, 15 Apr 2015 13:47:02 +0800
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
	rwright@hp.com
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com> <20150415005731.GC19051@localhost.localdomain>
In-Reply-To: <20150415005731.GC19051@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/15/2015 08:57 AM, Dave Young wrote:
> Again, I think it is bad to use old page table, below issues need consider:
> 1) make sure old page table are reliable across crash
> 2) do not allow writing oldmem after crash
>
> Please correct me if I'm wrong, or if above is not doable I think I will vote for
> resetting pci bus.
>
> Thanks
> Dave
>
Hi Dave,

When updating the context tables, we have to write their address to root 
tables, this will cause writing to old mem.

Resetting the pci bus has been discussed, please check this:
http://lists.infradead.org/pipermail/kexec/2014-October/012752.html
https://lkml.org/lkml/2014/10/21/890

Thanks
Zhenhua



