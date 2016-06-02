Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47699 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752116AbcFBMpp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 08:45:45 -0400
Date: Thu, 2 Jun 2016 14:45:42 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
	Lior Amsalem <alior@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
Message-ID: <20160602144542.6bc1b421@free-electrons.com>
In-Reply-To: <8313817.cgODJZVrao@wuerfel>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160602122405.GG17343@lunn.ch>
	<8313817.cgODJZVrao@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 02 Jun 2016 14:34:14 +0200, Arnd Bergmann wrote:

> I think some other PCI hosts just move the interrupt-controller
> and #interrupt-cells properties into the PCI host node itself,
> which avoids the ambiguity here.

Do you have an example of this? I have modeled my DT binding after the
one used by the pci-dra7xx driver, which is in the same situation as I
am in terms of interrupt handling.

But I can indeed try to make the top-level PCIe controller node the
interrupt controller. Let me try that quickly.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
