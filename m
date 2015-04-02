Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:50069 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbbDBLGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 07:06:10 -0400
Date: Thu, 2 Apr 2015 13:06:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v9 07/10] iommu/vt-d: enable kdump support in iommu module
Message-ID: <20150402110608.GL4441@8bytes.org>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <1426743388-26908-8-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426743388-26908-8-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 19, 2015 at 01:36:25PM +0800, Li, Zhen-Hua wrote:
> +#ifdef CONFIG_CRASH_DUMP
> +		if (is_kdump_kernel())
> +			__iommu_update_old_root_entry(iommu, bus);
> +#endif

All the is_kdump_kernel checks in this patch (and maybe in other patches
too) should really be checks whether translation on the IOMMU was
enabled or not when the kernel booted. You might also boot from a kernel
that had translation disabled into a kdump kernel that wants to enable
it. In this case these checks would break.

Speaking of booting from kernels with translation disabled, there is a
valid use of is_kdump_enabled(), to omit iommu initialization in the
kdump kernel when translation was disabled before. But the other checks
should depend on the state the iommu had when booting the kdump kernel.


	Joerg

