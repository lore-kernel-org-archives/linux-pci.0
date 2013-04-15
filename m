Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:49446 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab3DOQlB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2013 12:41:01 -0400
Date: Mon, 15 Apr 2013 18:40:57 +0200
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
Message-ID: <20130415184057.7783c272@skate>
In-Reply-To: <20130415163845.GK28693@titan.lakedaemon.net>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130415154620.GE28693@titan.lakedaemon.net>
	<20130415183623.04797912@skate>
	<20130415163845.GK28693@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jason Cooper,

On Mon, 15 Apr 2013 12:38:45 -0400, Jason Cooper wrote:

> > This ones are more recent than the v5 I originally used as a base for
> > my PCIe v8. I can resend a v9 of my PCIe patch set based on the v6 of
> > Andrew, or you can directly use PATCH 1,2,3 from Andrew series to
> > replace PATCH 1,2,3 from my series. Andrew v6 has quite a number of
> > changes compared to v5, so I really recommend using those ones.
> 
> No need to mess with v9, I'll pull AndrewM's v6.

Excellent, thanks.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
