Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:34332 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751773Ab3EWGxi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 May 2013 02:53:38 -0400
Date: Thu, 23 May 2013 08:52:59 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] Marvell PCIe driver improvements
Message-ID: <20130523065259.GK31625@1wt.eu>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130523001353.GH31625@1wt.eu> <20130523083509.79297513@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130523083509.79297513@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 23, 2013 at 08:35:09AM +0200, Thomas Petazzoni wrote:
> > FWIW, these patches applied on top of your pcie-v10 tree have made
> > my mini-pcie dual-nic appear for the first time on the mirabox. Till
> > now I never knew if it was a hardware or software issue since the NIC
> > does not appear in u-boot nor lspci, whatever the kernel versions,
> > including the original Marvell one's. The NIC has two functions (one
> > per controller) and no bridge, so it may be a side effect of your
> > improvements (or maybe you fixed a bug).
> 
> Hum, interesting. Can you show the output of lspci -v and lspci -t
> (which a pciutils version of lspci, not Busybox one) ? I'm interested
> in seeing the layout of the PCIe bus with such a device, to get a
> better understanding.

(send privately in another thread).

> > Anyway for me it's a great improvement !
> > 
> > I've not tried it on the OpenBlocks AX3 yet (it was not detected
> > there previously). But I have good hopes.
> > 
> > For reference, the NIC is Jetway's ADMPEIDLA (intel i350-AM2).
> 
> Should I be taking this as a formal Tested-by from you? :-)

Yes, obviously, feel free to add this one :

  Tested-by: Willy Tarreau <w@1wt.eu>

Willy

