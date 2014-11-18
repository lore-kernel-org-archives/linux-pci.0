Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57293 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753794AbaKRLeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 06:34:05 -0500
Date: Tue, 18 Nov 2014 12:34:02 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>
Cc: Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window
 while sizing BARs"
Message-ID: <20141118123402.7318ec94@free-electrons.com>
In-Reply-To: <20141118105843.3c1651d5@free-electrons.com>
References: <20141118105542.457d7863@free-electrons.com>
	<20141118105843.3c1651d5@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 18 Nov 2014 10:58:43 +0100, Thomas Petazzoni wrote:

> Another issue (possibly related, or not), is the following compile time
> warning:
> 
> /home/thomas/projets/linux-2.6/drivers/pci/probe.c: In function ‘pci_read_bridge_mmio_pref’:
> /home/thomas/projets/linux-2.6/drivers/pci/probe.c:430:5: warning: left shift count >= width of type
>      base |= ((dma_addr_t) mem_base_hi) << 32;
>      ^
> /home/thomas/projets/linux-2.6/drivers/pci/probe.c:431:5: warning: left shift count >= width of type
>      limit |= ((dma_addr_t) mem_limit_hi) << 32;
>      ^
> 
> This happens because dma_addr_t is 32 bits on ARM platforms, which
> isn't properly taken into account by the commit that introduces support
> for 64 bits DMA addresses.

Not sure about this one: the commit introducing the issue is in
next-20141117, but not in the current pci/next of Bjorn. Was it
reverted? Am I looking at the wrong place?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
