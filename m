Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61764 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711AbcFBNxc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2016 09:53:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Subject: Re: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe controller
Date: Thu, 02 Jun 2016 15:53:33 +0200
Message-ID: <7070543.PV5raqmBSF@wuerfel>
In-Reply-To: <20160602144542.6bc1b421@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com> <8313817.cgODJZVrao@wuerfel> <20160602144542.6bc1b421@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 2:45:42 PM CEST Thomas Petazzoni wrote:
> 
> On Thu, 02 Jun 2016 14:34:14 +0200, Arnd Bergmann wrote:
> 
> > I think some other PCI hosts just move the interrupt-controller
> > and #interrupt-cells properties into the PCI host node itself,
> > which avoids the ambiguity here.
> 
> Do you have an example of this? I have modeled my DT binding after the
> one used by the pci-dra7xx driver, which is in the same situation as I
> am in terms of interrupt handling.
> 
> But I can indeed try to make the top-level PCIe controller node the
> interrupt controller. Let me try that quickly.
> 

Looking at the binding files, I see only this one:

Documentation/devicetree/bindings/pci/altera-pcie.txt

and a couple of others using a child node.

	Arnd

