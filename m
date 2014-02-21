Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37707 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754806AbaBUPLW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 10:11:22 -0500
Date: Fri, 21 Feb 2014 16:11:08 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221161108.50a4c932@skate>
In-Reply-To: <2193926.ls2teBqnfK@wuerfel>
References: <53039894.10905@keymile.com>
	<53074584.5010202@keymile.com>
	<20140221144708.48559045@skate>
	<2193926.ls2teBqnfK@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Fri, 21 Feb 2014 16:05:16 +0100, Arnd Bergmann wrote:

> >  *) I don't know if the algorithm to split the BAR into multiple
> >     windows is going to be trivial.
> 
> The easiest solution would be to special case 'size is between
> 128MB+1 and 192MB' if that turns out to be the most interesting
> case. It's easy enough to make the second window smaller than 64MB
> if we want.
> 
> If we want things to be a little fancier, we could use:
> 
> 	switch (size) {
> 		case (SZ_32M+1) ... (SZ_32M+SZ_16M):
> 			size2 = size - SZ_32M;
> 			size -= SZ_32M;
> 			break;
> 		case (SZ_64M+1) ... (SZ_64M+SZ_32M):
> 			size2 = size - SZ_64M;
> 			size -= SZ_64M;
> 			break;
> 		case (SZ_128M+1) ... (SZ_128M+SZ_64M):
> 			size2 = size - SZ_128M;
> 			size -= SZ_128M;
> 			break;
> 	};

What if the size of your BAR is 128 MB + 64 MB + 32 MB ? Then you need
three windows, and your algorithm doesn't work :-)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
