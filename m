Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:42438 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3EWGfP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 02:35:15 -0400
Date: Thu, 23 May 2013 08:35:09 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH 0/4] Marvell PCIe driver improvements
Message-ID: <20130523083509.79297513@skate>
In-Reply-To: <20130523001353.GH31625@1wt.eu>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130523001353.GH31625@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Willy Tarreau,

On Thu, 23 May 2013 02:13:53 +0200, Willy Tarreau wrote:

> > You'll find in this patch series 4 small patches that make various
> > improvements to the Marvell PCIe driver.
> (...)
> 
> FWIW, these patches applied on top of your pcie-v10 tree have made
> my mini-pcie dual-nic appear for the first time on the mirabox. Till
> now I never knew if it was a hardware or software issue since the NIC
> does not appear in u-boot nor lspci, whatever the kernel versions,
> including the original Marvell one's. The NIC has two functions (one
> per controller) and no bridge, so it may be a side effect of your
> improvements (or maybe you fixed a bug).

Hum, interesting. Can you show the output of lspci -v and lspci -t
(which a pciutils version of lspci, not Busybox one) ? I'm interested
in seeing the layout of the PCIe bus with such a device, to get a
better understanding.

> Anyway for me it's a great improvement !
> 
> I've not tried it on the OpenBlocks AX3 yet (it was not detected
> there previously). But I have good hopes.
> 
> For reference, the NIC is Jetway's ADMPEIDLA (intel i350-AM2).

Should I be taking this as a formal Tested-by from you? :-)

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
