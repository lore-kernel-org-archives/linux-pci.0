Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:59530 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095Ab3A1Woa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:44:30 -0500
Date: Mon, 28 Jan 2013 23:44:23 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 11/27] clk: mvebu: create parent-child relation for
 PCIe clocks on Armada 370
Message-ID: <20130128234423.00bfd28e@skate>
In-Reply-To: <5106FB47.9000508@wwwdotorg.org>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-12-git-send-email-thomas.petazzoni@free-electrons.com>
	<5106F6EE.4000101@wwwdotorg.org>
	<20130128232150.53b56e62@skate>
	<5106FB47.9000508@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Stephen Warren,

On Mon, 28 Jan 2013 15:27:19 -0700, Stephen Warren wrote:

> Oh I see; I was confused by the patch description. The two clocks being
> made child/parent are the two clocks for a port, and this relationship
> is set up for each port; for some reason I thought there was a
> requirement to make one port's clock a child of the other port's clock.

Aah, ok, I understand the confusion now. Re-reading my commit log, I'm
not sure where the confusion comes from, but english is not my native
language, so maybe something that sounds clear to me is not clear in
reality. I'll rephrase the commit log to make sure this confusion is
clarified.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
