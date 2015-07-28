Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59286 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427AbbG1PQG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 Jul 2015 11:16:06 -0400
Date: Tue, 28 Jul 2015 17:16:02 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 00/11] PCI: Fix ATS deadlock
Message-ID: <20150728151602.GL27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, Jul 20, 2015 at 07:13:49PM -0500, Bjorn Helgaas wrote:
> Bjorn Helgaas (11):
>       iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
>       PCI: Allocate ATS struct during enumeration
>       PCI: Embed ATS info directly into struct pci_dev
>       PCI: Reduce size of ATS structure elements
>       PCI: Rationalize pci_ats_queue_depth() error checking
>       PCI: Inline the ATS setup code into pci_ats_init()
>       PCI: Use pci_physfn() rather than looking up physfn by hand
>       PCI: Clean up ATS error handling
>       PCI: Move ATS declarations to linux/pci.h so they're all together
>       PCI: Stop caching ATS Invalidate Queue Depth
>       PCI: Remove pci_ats_enabled()

So while you are at working on ATS, could we probably also introduce a
way to globally disable ATS on a box from the kernel command line
(pci=noats?)? ATS is basically a way for a device to tunnel through the
IOMMU without access checking (because pre-translated requests are not
checked again).

For security reasons it would be good to have a way to disable ATS
completly if desired.



	Joerg

