Return-Path: <thomas.petazzoni@free-electrons.com>
Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Fri, 10 Jun 2016 17:47:42 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>,
 Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>,
 Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda
 Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
Message-ID: <20160610174742.14bd4b3b@free-electrons.com>
In-Reply-To: <20160610154414.GE19309@localhost>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160610154414.GE19309@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Fri, 10 Jun 2016 10:44:14 -0500, Bjorn Helgaas wrote:

> If you post a v2 of these, can you align the subject lines of these
> binding, DT, and driver patches so it's easier to find the related
> pieces, e.g., add "Armada 3700" to this one or "Aardvark" to the
> others?  It looks like maybe Aardvark could be used in several
> different systems, so maybe this patch should stay the same and the
> drivers/pci patch should mention Aardvark instead of only "Marvell
> Armada 3700"?

Sure thing. I was about to send a v2, so I've fixed up the commit
titles so that they all include Aardvark.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
