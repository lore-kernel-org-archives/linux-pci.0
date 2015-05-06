Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755944AbbEFBrJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 May 2015 21:47:09 -0400
Date: Wed, 6 May 2015 09:46:49 +0800
From: Dave Young <dyoung@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
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
Message-ID: <20150506014649.GA14065@dhcp-128-4.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <20150504110551.GD15736@8bytes.org>
 <20150505060931.GB31063@dhcp-128-4.nay.redhat.com>
 <20150505152343.GP15736@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150505152343.GP15736@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/05/15 at 05:23pm, Joerg Roedel wrote:
> On Tue, May 05, 2015 at 02:09:31PM +0800, Dave Young wrote:
> > I agree that we can do nothing with the old corrupted data, but I worry
> > about the future corruption after using the old corrupted data. I wonder
> > if we can mark all the oldmem as readonly so that we can lower the risk.
> > Is it resonable?
> 
> Do you mean marking it read-only for the devices? That will very likely
> cause DMAR faults, re-introducing the problem this patch-set tries to
> fix.

I means to block all dma write to oldmem, I believe it will cause DMA error.
But all other DMA reading requests will continue and work. This will avoid
future possible corruption. It will solve half of the problem at least?

For the original problem, the key issue is dmar faults cause kdump kernel
hang so that vmcore can not be saved. I do not know the reason why it hangs
I think it is acceptable if kdump kernel boot ok with some dma errors..

Thanks
Dave
