Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60205 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab3FRI64 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 04:58:56 -0400
Date: Tue, 18 Jun 2013 10:56:42 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/8] MSI support for Marvell EBU PCIe driver
Message-ID: <20130618105642.77c4f50d@skate>
In-Reply-To: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On Thu,  6 Jun 2013 18:41:20 +0200, Thomas Petazzoni wrote:

> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.
> 
> This version 2 follows the RFC version sent on March, 26th 2013. This
> is based on work done by Lior Amsalem <alior@marvell.com>.
> 
> The patches do the following:
> 
>  * Patch 1 comes from Thierry Redding, and adds a minimal msi_chip
>    infrastructure.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.
> 
>  * Patch 2 extends the msi_chip infrastructure with a small registry,
>    so that one driver can register an msi_chip, and another driver can
>    find the msi_chip associated to a particular Device Tree node.
> 
>    This needs to be reviewed/acked by Bjorn Helgaas.

Could you have a look at those two patches and let me know what you
think?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
