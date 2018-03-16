Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:39558 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPMz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2018 08:55:28 -0400
Date: Fri, 16 Mar 2018 13:55:24 +0100
From: Niklas Cassel <niklas.cassel@axis.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kishon@ti.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [PATCH v4 5/5] misc: pci_endpoint_test: Handle 64-bit BARs
 properly
Message-ID: <20180316125523.GA30728@axis.com>
References: <20180308133331.19464-1-niklas.cassel@axis.com>
 <20180308133331.19464-6-niklas.cassel@axis.com>
 <20180315132213.GA8629@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315132213.GA8629@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:22:13PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 08, 2018 at 02:33:30PM +0100, Niklas Cassel wrote:
> > A 64-bit BAR consists of a BAR pair, where the second BAR has the
> > upper bits, so we cannot simply call pci_ioremap_bar() on every single
> > BAR index.
> > 
> > The second BAR in a BAR pair will not have the IORESOURCE_MEM resource
> > flag set. Only call ioremap on BARs that have the IORESOURCE_MEM
> > resource flag set.
> > 
> > pci 0000:01:00.0: BAR 4: assigned [mem 0xc0300000-0xc031ffff 64bit]
> > pci 0000:01:00.0: BAR 2: assigned [mem 0xc0320000-0xc03203ff 64bit]
> > pci 0000:01:00.0: BAR 0: assigned [mem 0xc0320400-0xc03204ff 64bit]
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 1: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR1
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 3: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR3
> > pci-endpoint-test 0000:01:00.0: can't ioremap BAR 5: [??? 0x00000000 flags 0x0]
> > pci-endpoint-test 0000:01:00.0: failed to read BAR5
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> Where are the 4 other patches in this series?  I can't just only apply
> the last one, right?

http://patchwork.ozlabs.org/project/linux-pci/list/?series=32658

I'm expecting all patches to go via Lorenzo's pci tree.

> 
> Please be careful when sending patches to properly notify everyone...

I'm using scripts from Joe Perches that run get_maintainer.pl,
these scripts are then used as --to-cmd and --cc-cmd for git send-email:
https://lkml.org/lkml/2016/9/14/482

(I did have to modify them so they handle rerolled patch series.)
BTW. Joe, do you have updated versions of your scripts?


Greg, I'm assuming that you wouldn't want to be cc'd on all patches in the
series, since all except the last one are pci related.
However, perhaps it would be nice to add all those who are cc'd in the
individual patches, as cc to the cover letter, that way it might be easier
to figure out what tree will most likely merge a certain patch series.



Kind regards,
Niklas
