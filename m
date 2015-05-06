Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:59717 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbbEFIQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 May 2015 04:16:19 -0400
Date: Wed, 6 May 2015 10:16:17 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dave Young <dyoung@redhat.com>
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
Message-ID: <20150506081617.GB20611@8bytes.org>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <20150504110551.GD15736@8bytes.org>
 <20150505060931.GB31063@dhcp-128-4.nay.redhat.com>
 <20150505152343.GP15736@8bytes.org>
 <20150506014649.GA14065@dhcp-128-4.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150506014649.GA14065@dhcp-128-4.nay.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 06, 2015 at 09:46:49AM +0800, Dave Young wrote:
> For the original problem, the key issue is dmar faults cause kdump kernel
> hang so that vmcore can not be saved. I do not know the reason why it hangs
> I think it is acceptable if kdump kernel boot ok with some dma errors..

It hangs because some devices can't handle the DMAR faults and the kdump
kernel can't initialize them and will hang itself. For that it doesn't
matter whether the fault was caused by a read or write request.


	Joerg

