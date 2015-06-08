Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:44069 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbbFHPVt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 8 Jun 2015 11:21:49 -0400
Date: Mon, 8 Jun 2015 17:21:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Li, Zhen-Hua" <zhen-hual@hp.com>, indou.takao@jp.fujitsu.com,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	alex.williamson@redhat.com, ddutile@redhat.com,
	ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com,
	doug.hatch@hp.com, jerry.hoemann@hp.com, tom.vaden@hp.com,
	li.zhang6@hp.com, lisa.mitchell@hp.com, billsumnerlinux@gmail.com,
	rwright@hp.com
Subject: Re: [PATCH v11 04/10] iommu/vt-d: functions to copy data from old mem
Message-ID: <20150608152147.GV20384@8bytes.org>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-5-git-send-email-zhen-hual@hp.com>
 <1433772935.2952.47.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1433772935.2952.47.camel@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Mon, Jun 08, 2015 at 03:15:35PM +0100, David Woodhouse wrote:
> Surely this isn't specific to the Intel IOMMU? Shouldn't it live
> elsewhere — either in generic IOMMU code or perhaps in generic kexec
> support code?

I put a bigger rework of this on-top of Zhen-Hua's patches, you can find
the result in my x86/vt-d branch. With my patches I also removed this
pointer collecting concept and do the iomap_cache and iounmap calls
before the spin-lock is taken, so this problem is now solved
differently.

> And I think you're misusing VTD_PAGE_{SHIFT,MASK} when you should be
> using the normal PAGE_{SHIFT,MASK}.

I think VT_PAGE_* is correct, since the VT-d driver also runs on ia64.
There the system page-size is different from the VT-d page-size.

>And shouldn't physical addresses be phys_addr_t?

This is changed where appropriate, I hope.


	Joerg

