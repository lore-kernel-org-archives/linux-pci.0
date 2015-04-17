Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:62483 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbbDQJjU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2015 05:39:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	CPGS <cpgs@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [query] how to use "ranges" in device tree
Date: Fri, 17 Apr 2015 11:38:45 +0200
Message-ID: <3074482.0e1L0iyh9V@wuerfel>
In-Reply-To: <20150417164546.3925eb7c@xhacker>
References: <20150416215938.347caa68@xhacker> <5862495.WQJXyp7MlL@wuerfel> <20150417164546.3925eb7c@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 17 April 2015 16:45:46 Jisheng Zhang wrote:
> > 
> > A nicer (but a little more complicated) way to do this would be to use
> > #address-cells=<2> in the parent bus and use that to enumerate the
> 
> In this way, we need to change all device nodes' "reg" in arch/arm/boot/dts/berlin2q.dtsi?

Correct

> And in arm64 case, we should use #address-cells=<3>?

It depends: if any of the address spaces within are 64-bit wide, yes, otherwise
you can make the virtual spaces just 2-cell wide.

> If above two answer is yes, setting "ranges = <..>" seems add complexity in my
> humble opinion. So is it better to use 1:1 mapping by "ranges;" in "/soc" node?
 
I agree, it gets a little awkward at that point. A better solution here would
be to take the PCI node out of /soc and move it to the root node. This has
the slight downside that you end up with registers being part of /soc and /pci,
but that's perfectly legal.

	Arnd
