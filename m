Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49387 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933039Ab3DOQgb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 12:36:31 -0400
Date: Mon, 15 Apr 2013 18:36:23 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
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
Subject: Re: [PATCHv8 00/19] PCIe support for the Armada 370 and Armada XP
 SoCs
Message-ID: <20130415183623.04797912@skate>
In-Reply-To: <20130415154620.GE28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130415154620.GE28693@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Mon, 15 Apr 2013 11:46:20 -0400, Jason Cooper wrote:

> >  * Patches 1-5 are awaiting a formal Acked-by from the Device Tree
> >    maintainers. Patches 1-3 are the new version of the OF PCI range
> >    parsing functions from Andrew Murray, which he worked on after the
> >    comments from Rob Herring. Patches 4 and 5 are much more trivial
> >    and have been around since many versions of this series.
> 
> Applied to mvebu/drivers

Patches 1-3 have a newer version that has been posted by Andrew Murray
recently, see:

Subject: [PATCH v6 0/3] of/pci: Provide common support for PCI DT
parsing Date: Thu, 11 Apr 2013 16:26:06 +0100
Message-Id: <1365693969-23907-1-git-send-email-Andrew.Murray@arm.com>

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162558.html

This ones are more recent than the v5 I originally used as a base for
my PCIe v8. I can resend a v9 of my PCIe patch set based on the v6 of
Andrew, or you can directly use PATCH 1,2,3 from Andrew series to
replace PATCH 1,2,3 from my series. Andrew v6 has quite a number of
changes compared to v5, so I really recommend using those ones.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
