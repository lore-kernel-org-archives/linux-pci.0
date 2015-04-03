Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 3 Apr 2015 16:40:31 +0800
From: Dave Young <dyoung@redhat.com>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
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
Message-ID: <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> To fix this problem, we modifies the behaviors of the intel vt-d in the 
> crashdump kernel:
> 
> For DMA Remapping:
> 1. To accept the vt-d hardware in an active state,
> 2. Do not disable and re-enable the translation, keep it enabled.
> 3. Use the old root entry table, do not rewrite the RTA register.
> 4. Malloc and use new context entry table, copy data from the old ones that
>    used by the old kernel.

Have not read all the patches, but I have a question, not sure this has been
answered before. Old memory is not reliable, what if the old memory get corrupted
before panic? Is it safe to continue using it in 2nd kernel, I worry that it will
cause problems.

Hope I'm wrong though.

Thanks
Dave


