Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56047 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab3DCLF5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2013 07:05:57 -0400
Date: Wed, 3 Apr 2013 13:05:52 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFC PATCHv1 2/5] bus: mvebu: fix mistake in PCIe window target
 attribute for Kirkwood
Message-ID: <20130403130552.0c28ea34@skate>
In-Reply-To: <20130403105757.GV13280@titan.lakedaemon.net>
References: <1364407504-13524-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364407504-13524-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130403125247.5914a862@skate>
	<20130403105757.GV13280@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Wed, 3 Apr 2013 06:57:57 -0400, Jason Cooper wrote:

> Thanks for pointing this out.  I'll put it in mvebu/drivers as you
> suggested.  I'll need to rebase mvebu/soc on it.  But I haven't done the
> PR yet, so not a big deal.

Ok, thanks. I'll finalize the cleanup of the kirkwood PCIe branch in
order to be able to submit a version that hopefully should be
acceptable.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
