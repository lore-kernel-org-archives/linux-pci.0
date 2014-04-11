Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rs04.intra2net.com ([85.214.66.2]:37928 "EHLO
	rs04.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756AbaDKNmW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Apr 2014 09:42:22 -0400
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: Greg KH <greg@kroah.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
	stable@vger.kernel.org
Subject: Re: Re: [PATCH] PCI: Add new PCI id for Intel GPU interrupt quirk
Date: Fri, 11 Apr 2014 15:42:19 +0200
Message-ID: <4526630.rVkY1qSQns@storm>
In-Reply-To: <20140407165808.GC7119@kroah.com>
References: <3185796.STv3LRO1j8@storm> <20140407165808.GC7119@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

On Monday, 7. April 2014 09:58:08 Greg KH wrote:
> On Mon, Apr 07, 2014 at 03:10:32PM +0200, Thomas Jarosch wrote:
> > After a CPU upgrade while keeping the same mainboard,
> > we faced "spurious interrupt" problems again.
> ..

> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

sorry 'bout that :) 

I had on my mind I should CC: stable@ and then the patch will be picked up 
automatically once / if it gets applied to the normal git tree or lost
in space if it gets rejected. Guess that was wishful thinking :)

Have a nice weekend,
Thomas

