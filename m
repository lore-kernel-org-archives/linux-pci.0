Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 May 2015 16:49:40 +0800
From: Dave Young <dyoung@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	joro@8bytes.org, vgoyal@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add functions to load and save old
 re
Message-ID: <20150513084940.GP4561@localhost.localdomain>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-6-git-send-email-zhen-hual@hp.com>
 <20150512083745.GE4561@localhost.localdomain>
 <5552AD1B.6030208@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5552AD1B.6030208@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/13/15 at 09:47am, Li, ZhenHua wrote:
> On 05/12/2015 04:37 PM, Dave Young wrote:
> >Seems the subject was truncated? Maybe "re" means root entry? Then please fix it
> >
> >On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> >>Add functions to load root entry table from old kernel, and to save updated
> >>root entry table.
> >>Add two member in struct intel_iommu, to store the RTA in old kernel, and
> >>the mapped virt address of it.
> >
> >Please explain a bit what is "RTA" in patch log, it is unclear to most of people
> >who do not know iommu details.
> >
> >>
> 
> If people want to understand this patchset, I assume they have read the vt-d
> specs. RTA is defined clearly in this spec.
> 

I think explain a bit is better, it will be easier for review, RTA is defined in spec,
right, but if you refer to it in kernel source code, describe the meaning will help
people to understand your code.

I would not stick on this 'RTA', but a descriptive subject and patch log is still
important, please check the logs, not only for this patch.

Thanks
Dave
