Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5552AD1B.6030208@hp.com>
Date: Wed, 13 May 2015 09:47:07 +0800
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
Subject: Re: [PATCH v11 05/10] iommu/vt-d: Add functions to load and save
 old re
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com> <1431337974-545-6-git-send-email-zhen-hual@hp.com> <20150512083745.GE4561@localhost.localdomain>
In-Reply-To: <20150512083745.GE4561@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/12/2015 04:37 PM, Dave Young wrote:
> Seems the subject was truncated? Maybe "re" means root entry? Then please fix it
>
> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>> Add functions to load root entry table from old kernel, and to save updated
>> root entry table.
>> Add two member in struct intel_iommu, to store the RTA in old kernel, and
>> the mapped virt address of it.
>
> Please explain a bit what is "RTA" in patch log, it is unclear to most of people
> who do not know iommu details.
>
>>

If people want to understand this patchset, I assume they have read the 
vt-d specs. RTA is defined clearly in this spec.

