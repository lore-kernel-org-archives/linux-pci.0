Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:54086 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbaDJWPN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 18:15:13 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so4610202wes.30
        for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2014 15:15:12 -0700 (PDT)
Date: Thu, 10 Apr 2014 23:15:07 +0100 (BST)
From: Neil Greatorex <neil@fatboyfat.co.uk>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
cc: =?ISO-8859-15?Q?Gregory_Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
In-Reply-To: <20140410220650.GA10540@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1404102313060.25712@vroombuntu>
References: <20140410181953.50ccfcc3@skate> <20140410165733.GB23104@obsidianresearch.com> <20140410200153.46669e0c@skate> <20140410201201.GA12661@obsidianresearch.com> <alpine.DEB.2.10.1404102206090.28003@vroombuntu>
 <20140410220650.GA10540@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Jason,

On Thu, 10 Apr 2014, Jason Gunthorpe wrote:

>> I took your attached patch and extended it a bit to print out how
>> long it took. The delays also need to be much longer for me. I also
>> fixed a small typo you made where the bit wasn't being set again to
>> bring the link back up. I've attached the diff to your patch, as
>> well as the combined patch (hope that makes sense).
>
> Just to be clear you tried this alone without the above?

Yes I did.

>
> Thanks for fixing the patch, I think it also confirms the theory.
>

No problem!

> IMHO, both approaches are required.
>
> The first prevents messing up the PEX as was left by the bootloader
>
> The second allows the driver to startup a PEX that wasn't enabled by
> the bootloader, and recover from clock gating in the kernel (eg the
> modular case)
>
> Both seem valuable..
>
> Ideally I'd like to see the clk driver turn off the PEX PHY when it
> gates the clock, but I have no great idea how to accomplish that sort
> of cross register space adventure...
>
> Thomas, if we can figure out how to properly do __clk_is_enabled I
> can probably send a proper patch?

Let me know when you do and I will test it and add my Tested-by.

>
> Thanks,
> Jason
>

Cheers,
Neil

