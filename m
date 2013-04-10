Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.196]:50832 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965128Ab3DJQrT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Apr 2013 12:47:19 -0400
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 10 Apr 2013 11:39:06 -0500
Subject: Question: ioremap of PCI resources
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020980427838@AUSP01VMBX24.collaborationhost.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

Question, when doing an ioremap() of a PCI resource which is more correct?

	iobase = pci_resource_start(pcidev, bar);
	len = pci_resource_len(pcidev, bar);
	mmio = ioremap(iobase, len);

or

	mmio = pci_ioremap_bar(pcidev, bar);

pci_ioremap_bar() does some extra sanity checking to make sure the bar
is actually a memory resource and then does an ioremap_nocache().

If the ioremap() is in order to talk to the registers on the PCI device wouldn't
the pci_ioremap_bar() be more correct?

Thanks for any replies,
Hartley
