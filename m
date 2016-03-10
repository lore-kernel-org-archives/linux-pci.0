Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41363 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbcCJSah (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Mar 2016 13:30:37 -0500
Date: Thu, 10 Mar 2016 12:30:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 00/59] PCI: Resource allocation cleanup for v4.6
Message-ID: <20160310183033.GA18456@localhost>
References: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456366370-28995-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 24, 2016 at 06:11:51PM -0800, Yinghai Lu wrote:
> Hi,
> 
> After 5b28541552ef (PCI: Restrict 64-bit prefetchable bridge windows
> to 64-bit resources), we have several reports on resource allocation
> failure, and we try to fix the problem with resource clip, and find
> more problems.
> 
> One is realloc fail with two graphics cards above 4G.
> One is from sparc that have problem with clip as we don't parse
> mem64 for it.
> 
> Other report is about pci remove/rescan does not work on some setup
> when BIOS tend to allocate small bus size.
> 
> This patchset enhance resource allocation to address those problems.
> 
> patch 1-10: parse MEM64 for sparc and other system with OF
> ...

> Yinghai Lu (59):
>   PCI: Add pci_find_root_bus_resource()
>   sparc/PCI: Use correct bus address to resource offset
>   sparc/PCI: Reserve legacy mmio after PCI mmio
>   sparc/PCI: Add IORESOURCE_MEM_64 for 64-bit resource in OF parsing
>   sparc/PCI: Keep resource idx order with bridge register number
>   PCI: Kill wrong quirk about M7101
>   PCI: Ignore BAR for ALi M1533 PCI-ISA bridge

I took a look at the above and responded on the list with several
questions.  I have the feeling that some are because I'm missing
important details about how sparc works.  If it's easier to educate me
about those via IRC, I'm usually in #linux-pci on OFTC, and I'd be
happy to chat there.

Bjorn
