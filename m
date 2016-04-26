Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35031 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752293AbcDZImM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 04:42:12 -0400
Date: Tue, 26 Apr 2016 10:42:08 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
Message-ID: <20160426104208.150cbbd0@free-electrons.com>
In-Reply-To: <20160425172846.GB1759@localhost>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160425154611.3e7e9dc9@free-electrons.com>
	<20160425172846.GB1759@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On Mon, 25 Apr 2016 12:28:46 -0500, Bjorn Helgaas wrote:

> How about if you just shuffle those bits around into
> an armada8k_add_pcie_port() and an armada8k_pcie_establish_link(), and
> we'll call that good for now?

I just sent a v3 which implements this.

However, to be honest, after looking at the other drivers, I found the
XYZ_add_pcie_port() function to not be very useful: it simply
continues the work done by the probe function, and there is really no
reason to split the remaining work of the probe() in a separate
function. The XYZ_add_pcie_port() is called only one time for each
probe() call, so having a separate function is somewhat useless. In
addition, the separation of work between probe() and
XYZ_add_pcie_port() is not very consistent accross drivers. In
pci-imx6, XYZ_add_pcie_port() only sets up the interrupt handler and
calls dw_pcie_host_init(). In pci-dra7xx, XYZ_add_pcie_port() sets up
the interrupt, maps some registers and calls dw_pcie_host_init().

So my v3 implements what you suggested, and creates a
armada8k_add_pcie_port() to make it consistent with the other drivers,
but long term, I'm not sure this particular function is really useful.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
