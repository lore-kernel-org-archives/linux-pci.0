Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:40294 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLmn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 07:42:43 -0400
Date: Wed, 19 Jun 2013 13:42:40 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 2/8] PCI: Add registry of MSI chips
Message-ID: <20130619134240.3ffa8f7c@skate>
In-Reply-To: <20130618224844.GC16134@google.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1370536888-8871-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130618224844.GC16134@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Tue, 18 Jun 2013 16:48:44 -0600, Bjorn Helgaas wrote:

> I don't really understand why the msi_chip_list lives here, since
> nothing in drivers/pci/msi.c uses it.  Seems like maybe something
> that could be in the OF code somewhere?

Ok, I'll move this to drivers/of/, we'll see what Grant says about
this. Will be part of v3.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
