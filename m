Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:50160 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753086AbbDBLLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 07:11:35 -0400
Date: Thu, 2 Apr 2015 13:11:33 +0200
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
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150402111133.GM4441@8bytes.org>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Zhen-Hua,

On Thu, Mar 19, 2015 at 01:36:18PM +0800, Li, Zhen-Hua wrote:
> This patchset is an update of Bill Sumner's patchset, implements a fix for:
> If a kernel boots with intel_iommu=on on a system that supports intel vt-d, 
> when a panic happens, the kdump kernel will boot with these faults:

I reviewed this patch-set and it is getting closer to a point where it
could be merged. I found a few white-space errors in the review, please
do a check_patch run on the next round and fix these. Besides that and
given some third-party testing and reviews I think we can look forward
to merge it early after the merge-window for v4.1, to give it enough
testing in -next too.


	Joerg

