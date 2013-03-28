Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36025 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab3C1HYm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2013 03:24:42 -0400
Date: Thu, 28 Mar 2013 08:24:36 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Neil Greatorex <neil@fatboyfat.co.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
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
Subject: Re: [PATCHv7 04/17] pci: infrastructure to add drivers in
 drivers/pci/host
Message-ID: <20130328082436.317d698a@skate>
In-Reply-To: <CAAfodu2t4j4ZASzdaKV0QarffXRwMgkMESGy=dDq1oMfTANEeg@mail.gmail.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364395234-11195-5-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAAfodu2t4j4ZASzdaKV0QarffXRwMgkMESGy=dDq1oMfTANEeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Neil Greatorex,

On Thu, 28 Mar 2013 00:28:02 +0000, Neil Greatorex wrote:

> Surely this patch should include the drivers/pci/host/Makefile or it will
> not build?

Ah, correct. I'll fix that up in the v8. Thank you for noticing!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
