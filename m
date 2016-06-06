Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42326 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbcFFTVL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 6 Jun 2016 15:21:11 -0400
Date: Mon, 6 Jun 2016 14:21:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: bogus alignment messages - PCIe reset
Message-ID: <20160606192104.GB15171@localhost>
References: <CAHhAz+hSS=0sb4wv685BmynqO6TKF-i8Pr8QnsQiVjd7XYcTqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAHhAz+hSS=0sb4wv685BmynqO6TKF-i8Pr8QnsQiVjd7XYcTqw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Muni,

On Mon, Jun 06, 2016 at 03:05:17PM +0530, Muni Sekhar wrote:
> Hi,
> 
> 
> What are these “bogus alignment” debug messages? I observed these
> messages on resetting the PCIe device.
> 
> 
> 
>  [ 4703.629970] pci_bus 0000:02: Allocating resources
> 
> [ 4703.630002] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
> has bogus alignment
> 
> [ 4703.633804] pci_bus 0000:02: Allocating resources
> 
> [ 4703.633828] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
> has bogus alignment
> 
> [ 4703.635736] pci_bus 0000:02: Allocating resources
> 
> [ 4703.635755] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
> has bogus alignment
> 
> [ 4703.637074] pci_bus 0000:02: Allocating resources
> 
> [ 4703.637085] i915 0000:00:02.0: BAR 6: [??? 0x00000000 flags 0x2]
> has bogus alignment

What kernel is this on?  Can you collect the entire dmesg log?

I thought I fixed this with this change:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=63e22924f5dc

which appeared in v4.6-rc1.

Bjorn
