Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:42178 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbbEHBB6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 21:01:58 -0400
Message-ID: <554C0AC7.2080705@hp.com>
Date: Fri, 08 May 2015 09:00:55 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Joerg Roedel <joro@8bytes.org>
CC: Baoquan He <bhe@redhat.com>, alex.williamson@redhat.com,
	indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com,
	dwmw2@infradead.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, lisa.mitchell@hp.com,
	jerry.hoemann@hp.com, iommu@lists.linux-foundation.org,
	ddutile@redhat.com, doug.hatch@hp.com,
	ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org,
	bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com,
	dyoung@redhat.com, vgoyal@redhat.com,
	"Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com> <20150429112024.GB5799@dhcp-16-116.nay.redhat.com> <20150503085530.GK15033@dhcp-16-116.nay.redhat.com> <5546E240.5090403@hp.com> <20150504031749.GF5799@dhcp-16-116.nay.redhat.com> <20150507173200.GF20611@8bytes.org>
In-Reply-To: <20150507173200.GF20611@8bytes.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Joerg,
This problem is caused by the latest updates in iommu module, and we are 
trying to fix it.
When it is fixed, we will send out a new version of the patchset.

Thanks
Zhenhua

On 05/08/2015 01:32 AM, Joerg Roedel wrote:
> Hi Baoquan, ZhenHua,
>
> On Mon, May 04, 2015 at 11:17:49AM +0800, Baoquan He wrote:
>> On 05/04/15 at 11:06am, Li, ZhenHua wrote:
>>> Hi baoquan,
>>> Could you paste the kernel log of the first kernel ?
>
> Please let me know when you have worked this issue out.
>
>
> Thanks,
>
> 	Joerg
>

