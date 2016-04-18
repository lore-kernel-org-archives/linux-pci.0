Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46786 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560AbcDRB1v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 17 Apr 2016 21:27:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 580AE20333
	for <linux-pci@vger.kernel.org>; Sun, 17 Apr 2016 21:27:45 -0400 (EDT)
Date: Mon, 18 Apr 2016 10:27:41 +0900
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org,
	=?utf-8?B?0J7Qu9C10LPQnNC+0YDQvtC3?= <oleg.moroz@mcc.vniiem.ru>,
	Joerg Roedel <jroedel@suse.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 0/3] v4.4: Revert "PCI: Implement pcibios_alloc_irq() and
Message-ID: <20160418012741.GB8223@kroah.com>
References: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 13, 2016 at 12:56:59AM -0500, Bjorn Helgaas wrote:
> pcibios_free_irq()"
> 
> Please apply these reverts to the v4.4 stable kernel.
> 
> We reverted the following changes from v4.5 to fix a regression:
> 
>   8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
>   811a4e6fce09 ("PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed")
>   991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")
> 
> but I forgot to mark those reverts for stable.  This series contains the
> backports for v4.4.
> 
> For reference, the v4.5 reverts are:
> 
>   fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"")
>   67b4eab91caf ("Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed"")
>   6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()"")

All now applied, thanks for these.

greg k-h
