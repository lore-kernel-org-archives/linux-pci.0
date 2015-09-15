Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0076.outbound.protection.outlook.com ([157.56.110.76]:31552
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751573AbbIOSHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 14:07:08 -0400
Message-ID: <55F85E43.5070207@caviumnetworks.com>
Date: Tue, 15 Sep 2015 11:06:59 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: David Daney <ddaney.cavm@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/6] PCI: generic: Misc. bug fixes and enhanced support
 for MSI.
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/11/2015 04:21 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> While using the pci-host-generic driver to add PCI support for the
> Cavium ThunderX processors, several bugs were discovered.  We also
> need the ability to specify a per-bus MSI controller, so support for
> that was added.
>
> David Daney (6):
>    PCI: Make global and export pdev_fixup_irq().
>    PCI: generic: Only fixup irqs for bus we are creating.
>    PCI: generic: Quit clobbering our pci_ops.
>    PCI: generic: Correct, and avoid overflow, in bus_max calculation.
>    PCI: generic: Pass proper starting bus number to pci_scan_root_bus().
>    PCI: generic: Allow bus default MSI controller to be specified.
>

Based on feedback on this first revision of the patches, I plan on 
sending an updated patch set in a few days.  In the mean time, keep 
sending feedback...

David Daney



>   .../devicetree/bindings/pci/host-generic-pci.txt   |  5 ++
>   drivers/pci/host/pci-host-generic.c                | 55 +++++++++++++++-------
>   drivers/pci/setup-irq.c                            |  7 +--
>   include/linux/pci.h                                |  3 ++
>   4 files changed, 50 insertions(+), 20 deletions(-)
>

