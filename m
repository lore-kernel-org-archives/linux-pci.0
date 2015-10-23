Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56803 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbbJWFip (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:38:45 -0400
Date: Fri, 23 Oct 2015 00:38:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, yinghai@kernel.org,
	bhelgaas@google.com, weiyang@linux.vnet.ibm.com, linux@iam.tj,
	wangyijing@huawei.com, khalid.aziz@oracle.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
Message-ID: <20151023053842.GB20335@localhost>
References: <CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
 <20151021023522.GJ8224@localhost>
 <CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
 <20151021.182714.551622926534141857.davem@davemloft.net>
 <1445485662.2935.17.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445485662.2935.17.camel@kernel.crashing.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 02:47:42PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2015-10-21 at 18:27 -0700, David Miller wrote:
> > From: Yinghai Lu <yinghai@kernel.org>
> > Date: Wed, 21 Oct 2015 11:16:53 -0700
> > 
> > > otherwise we need to compare res with pbm->mem_space or pbm
> > ->mem64_space
> > > to get direct parent for request_resource_conflict() calling in
> > > pci_register_legacy_regions().
> > 
> > Right, this is the issue.
> > 
> > On sparc64, the cpu physical base address used for accessing 64-bit
> > and non-64-bit memory spaces is different.
> > 
> > And that's why the resource values will be different.
> 
> This is the same on power btw, we have separate PowerBus windows to the
> PHB that get mapped respectively to 32-bit PCI MMIO and 64-bit PCI
> MMIO. The former gets "remapped" to generates 0-based PCI cycles, while
> the latter is 1:1. So the offset between CPU and PCI changes depending
> on which window you hit.

Lots of architectures do this, and the PCI core supports it by keeping
a list of all the host bridge windows.  Each entry has a struct
resource that contains the CPU address, as well as the offset from the
CPU address to the PCI address.  The arch or host bridge driver uses
pci_add_resource_offset() to tell the core about the window and the
offset.

Bjorn
