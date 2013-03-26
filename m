Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:34358 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755214Ab3CZWvs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Mar 2013 18:51:48 -0400
Date: Tue, 26 Mar 2013 16:51:39 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Lior Amsalem <alior@marvell.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Olof Johansson <olof@lixom.net>,
	Maen Suleiman <maen@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCHv6 10/17] arm: mvebu: add PCIe Device Tree informations
 for Armada 370
Message-ID: <20130326225139.GB10124@obsidianresearch.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364314719-1049-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326163421.GA30255@obsidianresearch.com>
 <20130326201654.GA7109@avionic-0098.mockup.avionic-design.de>
 <20130326222744.54e9fc82@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130326222744.54e9fc82@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 26, 2013 at 10:27:44PM +0100, Thomas Petazzoni wrote:

> Is this correct? Thierry, Jason, if you could confirm my understanding,
> that would be great. I could then rework and resend the patch set.

It looked to me the same as what Thierry was doing, and Thierry's
looked like it included everything from the big discussion on that
subject. Seems good to go to me.

Jason
