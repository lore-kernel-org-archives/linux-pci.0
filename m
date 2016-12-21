Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbcLUUQm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Dec 2016 15:16:42 -0500
Date: Wed, 21 Dec 2016 14:16:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Harry Mallon <hjmallon@gmail.com>
Cc: linux-pci@vger.kernel.org, Martin Mares <mj@ucw.cz>
Subject: Re: lspci memory behind bridge reporting
Message-ID: <20161221201635.GA31167@bhelgaas-glaptop.roam.corp.google.com>
References: <CDB45911-510C-459D-BCDC-17955FCC400D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CDB45911-510C-459D-BCDC-17955FCC400D@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Martin (lspci maintainer)]

On Wed, Dec 21, 2016 at 04:53:30PM +0000, Harry Mallon wrote:
> Hello all,
> 
> I am currently debugging a PCIE BAR assignment issue and am working on a patch to save me some time in future with lspci. Would patches like this be considered? Does anyone have any input on the proposed formats of the readouts?
> 
> 1. Currently if a bridge has no memory behind bridge it displays messages like the following, for reasons of PCI implementation detail.
> 
> I/O behind bridge: 0000f000-00000fff
> Memory behind bridge: fff00000-000fffff
> Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
> 
> I would prefer:
> I/O behind bridge: None
> Memory behind bridge: None
> Prefetchable memory behind bridge: None

Thanks for the suggestions, Harry.  I would like this, too.  Maybe
this with "-v":

  I/O behind bridge: None

and this with "-vv":

  I/O behind bridge: None (0000f000-00000fff)

There are many register values that disable the windows, and it's
conceivable that somebody would want to match the actual register
values with an analyzer trace or a piece of code.

> 2. It would be useful for me to have access to the amount of memory in these chunks (my mental hex subtraction is pretty terrible). Maybe this would be displayed something like
> 
> I/O behind bridge: 0000c000-0000dfff [8.00K]
> Memory behind bridge: f4000000-f65fffff [38.00M]
> Prefetchable memory behind bridge: 00000000e0000000-00000000f3ffffff [320.00M]

This makes sense to me, too, though I would use the same size format
lspci already uses for endpoint BARs, e.g.,

  Memory at f1000000 (64-bit, non-prefetchable) [size=8K]

Of course, BARs are always a nice power-of-two, so there's no need for
fractions, while bridge window sizes are much less constrained.  I
don't know whether it's better to use decimal places as you did, or to
use the largest unit size (K, M, G) that expresses the size as a whole
number.

Be sure to send any patches to Martin directly; I doubt he monitors
linux-pci closely.

Bjorn
