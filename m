Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 11 May 2015 12:11:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dave Young <dyoung@redhat.com>
Cc: "Li, Zhen-Hua" <zhen-hual@hp.com>, dwmw2@infradead.org,
	indou.takao@jp.fujitsu.com, bhe@redhat.com, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150511101124.GG20611@8bytes.org>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <20150504110551.GD15736@8bytes.org>
 <20150507135600.GB4559@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150507135600.GB4559@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 07, 2015 at 09:56:00PM +0800, Dave Young wrote:
> Joreg, I can not find the last reply from you, so just reply here about
> my worries here.
> 
> I said that the patchset will cause more problems, let me explain about
> it more here:
> 
> Suppose page table was corrupted, ie. original mapping iova1 -> page 1
> it was changed to iova1 -> page 2 accidently while crash happening,
> thus future dma will read/write page 2 instead page 1, right?

When the page-table is corrupted then it is a left-over from the old
kernel. When the kdump kernel boots the situation can at least not get
worse. For the page tables it is also hard to detect wrong mappings (if
this would be possible the hardware could already do it), so any checks
we could do there are of limited use anyway.


	Joerg

