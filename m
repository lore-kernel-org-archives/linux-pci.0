Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32900 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932447AbcFJPoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jun 2016 11:44:18 -0400
Date: Fri, 10 Jun 2016 10:44:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
Message-ID: <20160610154414.GE19309@localhost>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 11:09:43AM +0200, Thomas Petazzoni wrote:
> This commit adds the documentation for the Device Tree binding used to
> describe the Aardvark PCIe controller, found on Marvell Armada 3700
> ARM64 SoCs.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Hi Thomas,

If you post a v2 of these, can you align the subject lines of these
binding, DT, and driver patches so it's easier to find the related
pieces, e.g., add "Armada 3700" to this one or "Aardvark" to the
others?  It looks like maybe Aardvark could be used in several
different systems, so maybe this patch should stay the same and the
drivers/pci patch should mention Aardvark instead of only "Marvell
Armada 3700"?

Bjorn
