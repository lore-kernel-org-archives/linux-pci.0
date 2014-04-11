Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:38260 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbaDKP5M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Apr 2014 11:57:12 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so5530157wgh.34
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2014 08:57:11 -0700 (PDT)
Date: Fri, 11 Apr 2014 16:57:04 +0100 (BST)
From: Neil Greatorex <neil@fatboyfat.co.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	=?ISO-8859-15?Q?Gregory_Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Fixing PCIe issues on Armada XP
In-Reply-To: <20140411163228.4214645c@skate>
Message-ID: <alpine.DEB.2.10.1404111653030.24288@vroombuntu>
References: <20140410181953.50ccfcc3@skate> <20140411163228.4214645c@skate>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Fri, 11 Apr 2014, Thomas Petazzoni wrote:

> Can everybody test these patches, and confirm that they solve all the
> outstanding problems?

PCIe now works well for me on my Mirabox / i350 combination with this 
patch set. Thanks!

Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>

Cheers,
Neil
