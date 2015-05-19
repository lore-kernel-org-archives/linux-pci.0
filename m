Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:53500 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbESHou (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2015 03:44:50 -0400
Message-ID: <555AE9AB.8060106@hp.com>
Date: Tue, 19 May 2015 15:43:39 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
To: Dave Young <dyoung@redhat.com>
CC: joro@8bytes.org, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, bhelgaas@google.com,
	dwmw2@infradead.org, indou.takao@jp.fujitsu.com, bhe@redhat.com,
	vgoyal@redhat.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
	ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com, "Li, ZhenHua" <zhen-hual@hp.com>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com> <5552AEE9.80408@hp.com> <5559B97B.5090805@hp.com> <20150519011322.GA7065@dhcp-128-76.nay.redhat.com>
In-Reply-To: <20150519011322.GA7065@dhcp-128-76.nay.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Dave,

Don't worry :).
Of cause I have read your comments, but most of them contains no actual
code change request, so I did not reply them one by one.
When we are sure there is no actual code change needed, I will update
the comments and other format problems if necessary.

Regards
Zhenhua

On 05/19/2015 09:13 AM, Dave Young wrote:
> Hi,
>
> On 05/18/15 at 06:05pm, Li, ZhenHua wrote:
>> Hi Joerg,
>>
>> Testing from HP: passed.
>> Testing from He Baoquan(Redhat): passed
>>
>> The problem that dmar fault came again when running v10 with latest
>> kernel is fixed.
>> And I think there is no need to update the code to a new version now.
>>
>> So please tell me if there are still any code need to be changed.
>
> Have you reviewed all my comments? Although it is only iommu driver fixes,
> The patches are sent to lkml, no? If you do not want other people's comments
> why will you send to us? I would say do not assume it is a closed circle for
> only iommu driver.
>
> It is not easy to review patches actually, frankly I feel kernel code review
> is not so strict like the early days, maybe one reason is people are getting
> tired to argue.
>
> Thanks
> Dave
>

