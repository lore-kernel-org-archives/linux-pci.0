Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:63446 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbaIDNvf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 09:51:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
Date: Thu, 04 Sep 2014 15:51:22 +0200
Message-ID: <3055252.byHHPbPjpA@wuerfel>
In-Reply-To: <2799937.bNtU9KXR6t@wuerfel>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com> <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com> <2799937.bNtU9KXR6t@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 September 2014 14:14:48 Arnd Bergmann wrote:
> 
> My impression is that you have two distinct MSI controller
> implementations, one for LS1021A and the other one for everything
> else. How about using separate pcie_host_ops for them, possibly
> also moving them into separate files?
> 

One more thing: you should really use the msi-parent property to
find the MSI controller: Sooner or later this PCI block is likely
to end up in a real product that has GICv2m or GICv3 support, so
you will have to pick which of the two MSI controllers to use.

	Arnd
