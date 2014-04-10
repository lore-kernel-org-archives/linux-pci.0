Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46164 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964944AbaDJSUl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 14:20:41 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so11184116wib.5
        for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2014 11:20:39 -0700 (PDT)
Date: Thu, 10 Apr 2014 19:20:37 +0100 (BST)
From: Neil Greatorex <neil@fatboyfat.co.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	=?ISO-8859-15?Q?Gregory_Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410181953.50ccfcc3@skate>
Message-ID: <alpine.DEB.2.10.1404101849270.1578@vroombuntu>
References: <20140410181953.50ccfcc3@skate>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Thu, 10 Apr 2014, Thomas Petazzoni wrote:

> Can you test this stack of patches on your system and configuration, and
> let me know if that works for you? Of course, please do not include any
> other PCI related fix: the goal is to be aware of *all* the issues, and
> fix them in mainline.

I have tested this branch on my Mirabox. I still get the link up problem 
but if I work around that (see below) the igb driver works flawlessly.

Tested-by: Neil Greatorex <neil@fatboyfat.co.uk>

> Remaining issues:
>
> * The link up problem. Unfortunately, I tried to reproduce it today,
>   and didn't manage to. It's weird, because I'm sure I was able to
>   produce it in the past, but I'm no longer able to, I don't know.
>   Therefore, it's not easy for me to work on this topic. Neil, Jason,
>   do you think this is a topic you could potentially handle?

Do you have earlyprintk enabled? I've found that if I have earlyprintk in 
my bootargs / command line then I don't get the issue. I assume that is 
because of timing, but it could be something else?

Cheers,
Neil
