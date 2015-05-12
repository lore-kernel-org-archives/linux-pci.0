Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 May 2015 14:18:52 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump
 kernel
Message-ID: <20150512061852.GA10229@dhcp-16-116.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> This patchset is an update of Bill Sumner's patchset, implements a fix for:
> If a kernel boots with intel_iommu=on on a system that supports intel vt-d, 
> when a panic happens, the kdump kernel will boot with these faults:

Test passed on my local workstation. Thanks, Zhenhua.

> 
>     dmar: DRHD: handling fault status reg 102
>     dmar: DMAR:[DMA Read] Request device [01:00.0] fault addr fff80000
>     DMAR:[fault reason 01] Present bit in root entry is clear
> 
>     dmar: DRHD: handling fault status reg 2
>     dmar: INTR-REMAP: Request device [[61:00.0] fault index 42
>     INTR-REMAP:[fault reason 34] Present field in the IRTE entry is clear
