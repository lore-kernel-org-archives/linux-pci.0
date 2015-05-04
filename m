Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55478E95.7090206@redhat.com>
Date: Mon, 04 May 2015 11:21:57 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Joerg Roedel <joro@8bytes.org>, Dave Young <dyoung@redhat.com>
CC: "Li, Zhen-Hua" <zhen-hual@hp.com>, dwmw2@infradead.org,
	indou.takao@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ishii.hironobu@jp.fujitsu.com,
	bhelgaas@google.com, doug.hatch@hp.com, jerry.hoemann@hp.com,
	tom.vaden@hp.com, li.zhang6@hp.com, lisa.mitchell@hp.com,
	billsumnerlinux@gmail.com, rwright@hp.com
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com> <20150403084031.GF22579@dhcp-128-53.nay.redhat.com> <20150504110551.GD15736@8bytes.org>
In-Reply-To: <20150504110551.GD15736@8bytes.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/04/2015 07:05 AM, Joerg Roedel wrote:
> On Fri, Apr 03, 2015 at 04:40:31PM +0800, Dave Young wrote:
>> Have not read all the patches, but I have a question, not sure this
>> has been answered before. Old memory is not reliable, what if the old
>> memory get corrupted before panic? Is it safe to continue using it in
>> 2nd kernel, I worry that it will cause problems.
>
> Yes, the old memory could be corrupted, and there are more failure cases
> left which we have no way of handling yet (if iommu data structures are
> in kdump backup areas).
>
> The question is what to do if we find some of the old data structures
> corrupted, hand how far should the tests go. Should we also check the
> page-tables, for example? I think if some of the data structures for a
> device are corrupted it probably already failed in the old kernel and
> things won't get worse in the new one.
>
> So checking is not strictly necessary in the first version of these
> patches (unless we find a valid failure scenario). Once we have some
> good plan on what to do if we find corruption, we can add checking of
> course.
>
>
> Regards,
>
> 	Joerg
>

Agreed.  This is a significant improvement over what we (don') have.

Corruption related to IOMMU must occur within the host, and it must be
a software corruption, b/c the IOMMU inherently protects itself by protecting
all of memory from errant DMAs.  Therefore, if the only IOMMU corruptor is
in the host, it's likely the entire host kernel crash dump will either be
useless, or corrupted by the security breach, at which point,
this is just another scenario of a failed crash dump that will never be taken.

The kernel can't protect the mapping tables, which are the most likely area to
be corrupted, b/c it'd (minimally) have to be per-device (to avoid locking
& coherency issues), and would require significant
overhead to keep/update a checksum-like scheme on (potentially) 4 levels of page tables.


