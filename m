Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 13 May 2015 10:36:46 +0800
From: Baoquan He <bhe@redhat.com>
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: dwmw2@infradead.org, indou.takao@jp.fujitsu.com, joro@8bytes.org,
	vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 07/10] iommu/vt-d: enable kdump support in iommu
 module
Message-ID: <20150513023646.GB3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-8-git-send-email-zhen-hual@hp.com>
 <20150513021027.GA3736@dhcp-128-28.nay.redhat.com>
 <5552B6B4.5080206@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5552B6B4.5080206@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/13/15 at 10:28am, Li, ZhenHua wrote:
> >>+static u8 g_translation_pre_enabled;
> >Hi Zhenhua,
> >
> >I haven't checked patch one by one, am going through the code flow.
> >
> >About g_translation_pre_enabled, I don't think it's necessary to define
> >it as a global variable. Both its assignment and judgement are in
> >init_dmars(). In this situation a local variable translation_pre_enabled
> >in init_dmars() is enough.
> >
> >You can assign value to it here:
> >
> >		iommu_check_pre_te_status(iommu);
> >		if (iommu->pre_enabled_trans) {
> >			translation_pre_enabled = 1;
> >			...
> >		}
> >
> >Thanks
> >Baoquan
> >
> Hi Baoquan,
> This variable is only be used in this file, for it is defined as static.
> Till now, I think both global and local variable are fine, got the same
> thing.
> But I believe global is better, because if other functions want to
> know whether translation is enabled, this global variable is a good
> choice.

OK, I don't insist on this. But I think we don't have obligation to
consider the future usage for a function or variable. We can often see a
static function is redefined as non-static since it need be used in
other file or the similar thing for variable. It's also good to change
it when it's really needed.

Anyway, I am fine with this. Just for now it's a little uncomfortable to
me.

Thanks
Baoquan
