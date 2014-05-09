Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:48758 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbaEIUUF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 16:20:05 -0400
Received: by mail-ig0-f176.google.com with SMTP id hl10so1590313igb.15
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2014 13:20:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9450765.GaoRYW154J@wuerfel>
References: <20140506223250.17968.27054.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <1399629530.879.21.camel@i7.infradead.org> <20140509153226.GA3571@google.com> <9450765.GaoRYW154J@wuerfel>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 9 May 2014 14:19:44 -0600
Message-ID: <CAErSpo5bPvaATcptz3wGdLWOG-1thHKCHDK5D8K=D9wy+NDomA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iommu: Use dma_addr_t for IOVA arguments
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joerg Roedel <joro@8bytes.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	James Bottomley <jbottomley@parallels.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 9, 2014 at 1:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 09 May 2014 09:32:26 Bjorn Helgaas wrote:
>> > There are people who care deeply about the performance of IOMMU API
>> > map/unmap. It isn't used *just* for virtual machines any more. See
>> > drivers/infiniband/hw/usnic/usnic_uiom.c for example.
>>
>> Of course we should care about IOMMU API performance.  We should also
>> care about interface consistency, and it seems there's a tradeoff in
>> this case.  I said "relatively" because I expect map/unmap to be less
>> frequent than read/write operations that use the mapping.  I don't
>> know anything about infiniband, so maybe that assumption is false
>> there.
>
> In most drivers using the streaming DMA API, every mapping is used
> exactly once. Think of network or block drivers: they rarely send
> the same data twice to the device, and it usually comes from or
> goes to some user space buffer.

Oh, good point.  I don't work that high up in the stack, so thanks for
reminding me of that.

Bjorn
