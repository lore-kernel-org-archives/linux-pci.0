Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:50696 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbcFBMeL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 08:34:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe controller
Date: Thu, 02 Jun 2016 14:34:14 +0200
Message-ID: <8313817.cgODJZVrao@wuerfel>
In-Reply-To: <20160602122405.GG17343@lunn.ch>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com> <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com> <20160602122405.GG17343@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 2:24:05 PM CEST Andrew Lunn wrote:
> 
> It is possible to list PCIe devices on the bus here as child
> nodes. I've done this when i needed a phandle to an intel ethernet
> controller on the PCIe bus, which i know is soldered onto the board.
> 
> I think your current implementation simply uses the first child
> node. It would be good to document that ordering is important. It must
> be the first child node, and any pcie devices children must come
> afterwards.

I think some other PCI hosts just move the interrupt-controller
and #interrupt-cells properties into the PCI host node itself,
which avoids the ambiguity here.

	Arnd
