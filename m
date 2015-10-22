Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38772 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbbJVDtF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 23:49:05 -0400
Message-ID: <1445485662.2935.17.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 03/60] sparc/PCI: Unify pci_register_region()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>, yinghai@kernel.org
Cc: helgaas@kernel.org, bhelgaas@google.com,
	weiyang@linux.vnet.ibm.com, linux@iam.tj, wangyijing@huawei.com,
	khalid.aziz@oracle.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2015 14:47:42 +1100
In-Reply-To: <20151021.182714.551622926534141857.davem@davemloft.net>
References: <CAE9FiQUdKdyipTw3KSVL0Kr1FFvki5Un3NuUuXpw4TXoWi1Tpg@mail.gmail.com>
	 <20151021023522.GJ8224@localhost>
	 <CAE9FiQXXP8-5hNvKXuh5mu6Xu_9yFufmpZaXv0V95TwBBnxCpA@mail.gmail.com>
	 <20151021.182714.551622926534141857.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2015-10-21 at 18:27 -0700, David Miller wrote:
> From: Yinghai Lu <yinghai@kernel.org>
> Date: Wed, 21 Oct 2015 11:16:53 -0700
> 
> > otherwise we need to compare res with pbm->mem_space or pbm
> ->mem64_space
> > to get direct parent for request_resource_conflict() calling in
> > pci_register_legacy_regions().
> 
> Right, this is the issue.
> 
> On sparc64, the cpu physical base address used for accessing 64-bit
> and non-64-bit memory spaces is different.
> 
> And that's why the resource values will be different.

This is the same on power btw, we have separate PowerBus windows to the
PHB that get mapped respectively to 32-bit PCI MMIO and 64-bit PCI
MMIO. The former gets "remapped" to generates 0-based PCI cycles, while
the latter is 1:1. So the offset between CPU and PCI changes depending
on which window you hit.

Cheers,
Ben.

