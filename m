Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60257 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740AbcASDim (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Jan 2016 22:38:42 -0500
Date: Mon, 18 Jan 2016 21:38:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard F <lists@keynet-technology.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: Hint HB6 - kernel doesn't see chips behind it.
Message-ID: <20160119033839.GA3339@localhost>
References: <5698191B.1070904@keynet-technology.com>
 <20160115172640.GC28453@localhost>
 <569CFB5B.7050903@keynet-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <569CFB5B.7050903@keynet-technology.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 18, 2016 at 02:48:59PM +0000, Richard F wrote:
> I posted a DMESG with 4.3.3 to Bugzilla now.
> 4.4.0 crashed on boot, not sure why yet.

Thanks for all the data you collected!  I haven't had a chance to look
at them yet, but maybe others will take a look also.

Crashing on boot is a much more serious problem than failure to find a
card.  Any information you can collect about the v4.4.0 problem would
be extremely useful.  A serial console log would be ideal, but even a
photo or video of the boot might be helpful.  Boot with
"ignore_loglevel" to make sure we see all the messages.

Bjorn

> On 15/01/2016 17:26, Bjorn Helgaas wrote:
> > Hi Richard,
> > 
> > On Thu, Jan 14, 2016 at 09:54:35PM +0000, Richard F wrote:
> >> I moved a Kodicom card (http://linuxtv.org/wiki/index.php/Kodicom_4400R)
> >> from an older machine to a new with a PCIe bridge.  Bttv modprobe can no
> >> longer find the BT878 chips behind the PCI bridge, though the bridge is
> >> found.
> >>
> >> The bridge is a PCI6140 AKA "Hint HB6".
> >> I noticed a PCI quirk for it, tried manually adding the IO/memory spaces
> >> that were originally logged, but doesn't help.
> >>
> >> This machine runs kernel 3.12.52 (x64), but it also fails on 3.0.76.
> >> The BT878 chips were recognised on the older machine also running 3.0.76
> >> but with a vanilla PCI bus.
> > 
> > Thanks for your report.  I opened this bug report:
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=110851
> > 
> > Can you please attach the complete dmesg logs from the old machine
> > running 3.0.76 and the new machine running 3.0.76 to that bugzilla?
> > Also please attach the complete "lspci -vvv" output for all the
> > devices in the new machine.
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
