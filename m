Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55394 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750843AbcDZTJ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 15:09:29 -0400
Date: Tue, 26 Apr 2016 21:09:26 +0200
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
Message-ID: <20160426210926.7028d15d@free-electrons.com>
In-Reply-To: <20160426170004.GA27803@localhost>
References: <1460648177-31473-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160425154611.3e7e9dc9@free-electrons.com>
	<20160425172846.GB1759@localhost>
	<20160426104208.150cbbd0@free-electrons.com>
	<20160426170004.GA27803@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 26 Apr 2016 12:00:04 -0500, Bjorn Helgaas wrote:

> > So my v3 implements what you suggested, and creates a
> > armada8k_add_pcie_port() to make it consistent with the other drivers,
> > but long term, I'm not sure this particular function is really useful.
> 
> I agree completely with everything you said.  I would be thrilled if
> somebody were to make this more sensible, as long as we did it to
> *all* the drivers, not just one.

OK. I'll see if I can come up with a few patches. Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
