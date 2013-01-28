Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:59654 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab3A1W1Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:27:25 -0500
Message-ID: <5106FB47.9000508@wwwdotorg.org>
Date: Mon, 28 Jan 2013 15:27:19 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-12-git-send-email-thomas.petazzoni@free-electrons.com> <5106F6EE.4000101@wwwdotorg.org> <20130128232150.53b56e62@skate>
In-Reply-To: <20130128232150.53b56e62@skate>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2013 03:21 PM, Thomas Petazzoni wrote:
> Dear Stephen Warren,
> 
> On Mon, 28 Jan 2013 15:08:46 -0700, Stephen Warren wrote:
> 
>> I must admit, I know nothing about struct mvebu_soc_descr, but I'm
>> having a hard time seeing how that code change makes one of those clock
>> a parent of the other, since the pex0 entry doesn't reference anything
>> "pex1"-related, nor vice-versa. Is more explanation in the commit
>> message warranted here?
> 
> See the definition of mvebu_soc_descr:
> 
> struct mvebu_soc_descr {
>         const char *name;
>         const char *parent;
>         int bit_idx;
> };
> 
> It simply registers the pex0 clock with the pex0_en clock as its
> parents. Those clocks are normal gatable clocks, registered with
> clk_register_gate(). This ensures that whenever the pex0 clock is
> enabled, its parent clock pex0_en gets enabled as well.

Oh I see; I was confused by the patch description. The two clocks being
made child/parent are the two clocks for a port, and this relationship
is set up for each port; for some reason I thought there was a
requirement to make one port's clock a child of the other port's clock.
