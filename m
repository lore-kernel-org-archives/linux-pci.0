Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42701 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967226AbcA0Vz0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jan 2016 16:55:26 -0500
Date: Wed, 27 Jan 2016 15:55:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard F <lists@keynet-technology.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
Message-ID: <20160127215522.GA4875@localhost>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost>
 <569CFB5B.7050903@keynet-technology.com>
 <20160119033839.GA3339@localhost>
 <56A8DA21.7060607@keynet-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56A8DA21.7060607@keynet-technology.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

On Wed, Jan 27, 2016 at 02:54:25PM +0000, Richard F wrote:
> Would someone be able take a quick look at my logs and give me any kind
> of steer as to where to look?  I'm happy to do some more debugging with
> a bit of guidance.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=110851

The kernel doesn't see the bt878 devices at all on your new machine,
with the exception of the boot in comment #6, where you added another
card in an adjacent slot.  That makes me think there might be a
hardware problem with the slot.  Can you try a completely different
kind of card in that slot?  Do devices in that slot work with any
other OS?

Bjorn

> On 19/01/2016 03:38, Bjorn Helgaas wrote:
> > On Mon, Jan 18, 2016 at 02:48:59PM +0000, Richard F wrote:
> >> I posted a DMESG with 4.3.3 to Bugzilla now.
> >> 4.4.0 crashed on boot, not sure why yet.
> > 
> > Thanks for all the data you collected!  I haven't had a chance to look
> > at them yet, but maybe others will take a look also.
> > 
> > Crashing on boot is a much more serious problem than failure to find a
> > card.  Any information you can collect about the v4.4.0 problem would
> > be extremely useful.  A serial console log would be ideal, but even a
> > photo or video of the boot might be helpful.  Boot with
> > "ignore_loglevel" to make sure we see all the messages.
> > 
> > Bjorn
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
