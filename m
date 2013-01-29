Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35104 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162Ab3A2P3A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:29:00 -0500
Date: Tue, 29 Jan 2013 16:28:53 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129162853.58dc14d7@skate>
In-Reply-To: <20130129152518.GZ23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130129161211.7bb8cada@skate>
	<20130129151501.GY23505@n2100.arm.linux.org.uk>
	<20130129162337.0121cbab@skate>
	<20130129152518.GZ23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

On Tue, 29 Jan 2013 15:25:18 +0000, Russell King - ARM Linux wrote:

> Yep, otherwise we'll have yet more code to review rather than one
> algorithm with a set of numbers...
> 
> I work on the principle that if something can be expressed numerically,
> that's always better than expressing it with code.

Having a hook allows for more flexibility (for example having special
alignment requirements depending on the device or something like that),
but I don't need this flexibility for the specific case I'm interested
in. So as you suggest, let's not over-engineer this, and use numerical
values. I'll rework my patch according to this suggestion.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
