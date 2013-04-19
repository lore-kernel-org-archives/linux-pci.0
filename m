Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34873 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030552Ab3DSOeG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Apr 2013 10:34:06 -0400
Date: Fri, 19 Apr 2013 15:33:31 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCHv8 07/19] arm: pci: add a align_resource hook
Message-ID: <20130419143331.GV14496@n2100.arm.linux.org.uk>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com> <1365541601-14095-8-git-send-email-thomas.petazzoni@free-electrons.com> <20130415163609.GJ28693@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130415163609.GJ28693@titan.lakedaemon.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 15, 2013 at 12:36:09PM -0400, Jason Cooper wrote:
> Russell,
> 
> Thanks for applying this patch (7683/1) to your tree.  I see it's in
> your for-next, which I understand *isn't* stable.

That is correct.

>   029baf1 ARM: 7683/1: pci: add a align_resource hook
> 
> Is there a stable branch I could depend on for the rest of this series
> (particularly, patch 10)?  It looks like you applied it to your misc
> branch, but that's not currently available.

I will have to look at that; as I'm still catching up with mail three
days after having returned and there's still quite an amount outstanding,
it's going to be a while before I can look at this.  Given that we're at
-rc7 and the amount of outstanding mail, it's likely that may happen
after the merge window has opened.

