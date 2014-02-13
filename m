Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:34117 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666AbaBMS1F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 13 Feb 2014 13:27:05 -0500
Date: Thu, 13 Feb 2014 11:26:55 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2 0/3] ARM: PCI: implement generic PCI host controller
Message-ID: <20140213182655.GE17248@obsidianresearch.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 12, 2014 at 08:16:08PM +0000, Will Deacon wrote:

> Like v1, I continue to support only a single controller and therefore a
> single I/O space. I'm not sure how to represent multiple controllers in the
> device-tree without inventing some horrible hacks, so any ideas in this area
> would be much appreciated.

The DT representation is very straightforward, just have more copies
of what you already have. Each DT stanza should be represented in
Linux a distinct PCI domain.

In Linux you run into two small problems
 1) PCI Domain numbers needs to be allocated dynamically
    * I think there should be a core thing to allocate a domain
      object w/ a struct device, and assign a unique domain number.
      We are already seeing drivers do things like keep track
      of their own domain numbers via a counter (pcie-designware.c)
      The host bridge object is similar to this but it isn't focused
      on a domain.
 2) The space in the IO fixed mapping needs to be allocated to PCI
    host drivers dynamically
    * pci_ioremap_io_dynamic that takes a bus address + cpu_physical
      address and returns a Linux virtual address.
      The first caller can get a nice traslation where bus address ==
      Linux virtual address, everyone after can get best efforts.

You will have overlapping physical IO bus addresses - each domain will
have a 0 IO BAR - but those will have distinct CPU physical addresses
and can then be uniquely mapped into the IO mapping. So at the struct
resource level the two domains have disjoint IO addresses, but each
domain uses a different IO offset..

Jason
