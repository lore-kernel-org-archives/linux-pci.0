Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54743 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab3CZRVN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 13:21:13 -0400
Date: Tue, 26 Mar 2013 18:21:09 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
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
Subject: Re: [RFCv1 00/11] MSI support for Marvell EBU PCIe driver
Message-ID: <20130326182109.05da7690@skate>
In-Reply-To: <201303261718.09160.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130326180514.2f7790d3@skate>
	<201303261718.09160.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 17:18:08 +0000, Arnd Bergmann wrote:

> The mailing list rejects patches that have an in-reply-to header with
> pointing to a different subject as the new email.
> It also has an exception for emails that have the work PATCH in
> brackets, but not [RFC] or [GIT PULL]. You can work around by using
> [RFC PATCH 1/11] or [RFC][PATCH 1/11].

Aah, thanks for the tip. Do you think there's a place where we could
write this down for future reference? Maybe
Documentation/arm/mailing-list or whatever?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
