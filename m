Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60037 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab3FRInw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2013 04:43:52 -0400
Date: Tue, 18 Jun 2013 10:43:38 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
Message-ID: <20130618104338.584098e1@skate>
In-Reply-To: <20130612104207.GE30841@mithrandir>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1370536888-8871-5-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130612104207.GE30841@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Wed, 12 Jun 2013 12:42:40 +0200, Thierry Reding wrote:
> On Thu, Jun 06, 2013 at 06:41:24PM +0200, Thomas Petazzoni wrote:
> [...]
> > @@ -292,6 +454,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
> >  
> >  #endif
> >  
> > +	armada_370_xp_msi_init(node);
> > +
> 
> So I see that you don't have access to the original platform device
> here, but you could use of_find_device_by_node() to obtain it and pass
> that into armada_370_xp_msi_init() in order to set the msi_chip.dev
> field. Or you could do the lookup in armada_370_xp_msi_init() if you
> don't need it for anything else in armada_370_xp_mpic_of_init().

As I replied to Grant, of_find_device_by_node() returns NULL, I believe
because the all IRQ controller driver initialization is done pretty
early, before the of_platform_populate() call is made, so there is no
platform_device associated with the IRQ controller node at the time the
armada_370_xp_mpic_of_init() function is called.

Do you see another approach, especially in relation to your comment on
PATCH 2/8 ?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
