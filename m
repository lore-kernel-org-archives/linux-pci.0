Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34123 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab3GPIoB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2013 04:44:01 -0400
Date: Tue, 16 Jul 2013 10:43:47 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130716104347.045a612a@skate>
In-Reply-To: <51E4167B.4000208@wwwdotorg.org>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<51E4167B.4000208@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Stephen Warren,

On Mon, 15 Jul 2013 09:34:19 -0600, Stephen Warren wrote:

> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. This set of patches applies on top
> > of 3.11-rc1.
> 
> Thomas, who is going to merge this series?

I don't know. There are quite a few build dependencies in there:

 * PATCH 7 build depends on PATCH 1 and PATCH 5, and obviously depends
   on PATCH 6.

 * PATCH 2 to 5 really are one thing, they depend on each other.

 * PATCH 10 build depends on PATCH 5 and PATCH 8.

A quick diagram of the dependencies, best viewed with a fixed-size font
mailer.

kernel/irq/irqdomain    drivers/pci        arch/arm/kernel
     patch 1           patch 2, 3, 4           patch 8
        ||                  ||                   ||
        ||                  \/                   \/
        ||               drivers/of   ==> drivers/pci/host
        ||                patch 5           patch 10
        ||                  ||
        \\__________________//
                  ||
                  \/
            drivers/irqchip
              patch 6, 7

Patches 9 and 11 are DT patches, so they are not mentioned in this
diagram.

Normally tegra would require 1, 2, 3, 4, 5 and 8, so ideally, with
the respective maintainers ACKs, Jason Cooper could take them in a
specific topic stable branch that would not be rebased, on top of which
both the Marvell work and Tegra work could be done.

I really would like to see those patches very soon in linux-next, in
order to get some build coverage, especially for the 2, 3 and 4 patches
that touch a number of architectures.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
