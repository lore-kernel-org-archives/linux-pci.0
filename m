Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44473 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab3JHVgQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 17:36:16 -0400
Date: Tue, 8 Oct 2013 14:30:11 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Neil Horman <nhorman@tuxdriver.com>, stable@vger.kernel.org,
	Prarit Bhargava <prarit@redhat.com>,
	Don Zickus <dzickus@redhat.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Asit Mallick <asit.k.mallick@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Arkadiusz =?utf-8?Q?Mi=C5=9Bkiewicz?= <arekm@maven.pl>
Subject: Re: [stable PATCH] iommu/vt-d: add quirk for broken interrupt
 remapping on 55XX chipsets
Message-ID: <20131008213011.GB10765@kroah.com>
References: <20130708154111.GA27952@kroah.com>
 <1373303174-21977-1-git-send-email-nhorman@tuxdriver.com>
 <20130723170602.GA15090@kroah.com>
 <1381265132.4598.18.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1381265132.4598.18.camel@chaos.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 08, 2013 at 10:45:32PM +0200, Jean Delvare wrote:
> Hi Greg, hi Neil,
> 
> Le Tuesday 23 July 2013 à 10:06 -0700, Greg KH a écrit :
> > On Mon, Jul 08, 2013 at 01:06:14PM -0400, Neil Horman wrote:
> > > A few years back intel published a spec update:
> > > http://www.intel.com/content/dam/doc/specification-update/5520-and-5500-chipset-ioh-specification-update.pdf
> > > 
> > > For the 5520 and 5500 chipsets which contained an errata (specificially errata
> > > 53), which noted that these chipsets can't properly do interrupt remapping, and
> > > as a result the recommend that interrupt remapping be disabled in bios.  While
> > > many vendors have a bios update to do exactly that, not all do, and of course
> > > not all users update their bios to a level that corrects the problem.  As a
> > > result, occasionally interrupts can arrive at a cpu even after affinity for that
> > > interrupt has be moved, leading to lost or spurrious interrupts (usually
> > > characterized by the message:
> > > kernel: do_IRQ: 7.71 No irq handler for vector (irq -1)
> > > 
> > > There have been several incidents recently of people seeing this error, and
> > > investigation has shown that they have system for which their BIOS level is such
> > > that this feature was not properly turned off.  As such, it would be good to
> > > give them a reminder that their systems are vulnurable to this problem.  For
> > > details of those that reported the problem, please see:
> > > https://bugzilla.redhat.com/show_bug.cgi?id=887006
> > > 
> > > [ Joerg: Removed CONFIG_IRQ_REMAP ifdef from early-quirks.c ]
> > > 
> > > Notes: Modified early-quirks.c to include linux/irq.h, to fix warnings.  This
> > > isn't needed in the upstream tree
> > > 
> > > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > > CC: Prarit Bhargava <prarit@redhat.com>
> > > CC: Don Zickus <dzickus@redhat.com>
> > > CC: Don Dutile <ddutile@redhat.com>
> > > CC: Bjorn Helgaas <bhelgaas@google.com>
> > > CC: Asit Mallick <asit.k.mallick@intel.com>
> > > CC: David Woodhouse <dwmw2@infradead.org>
> > > CC: linux-pci@vger.kernel.org
> > > CC: Joerg Roedel <joro@8bytes.org>
> > > CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > CC: Arkadiusz Miśkiewicz <arekm@maven.pl>
> > > CC: Jean Delvare <jdelvare@suse.de>
> > > CC: Greg KH <gregkh@linuxfoundation.org>
> > > Signed-off-by: Joerg Roedel <joro@8bytes.org>
> > > (cherry picked from commit 03bbcb2e7e292838bb0244f5a7816d194c911d62)
> > 
> > As 3.9-stable is now dead, this one missed that window, sorry about
> > that.
> 
> Sorry for jumping in a little late, but I am looking into this again
> because one customer of ours requested this fix. I'm a bit confused now,
> by two different things:
> 
> 1* Why did Greg claim that the fix missed the 3.9-stable window while I
> can see Neil's backport of the fix made it into 3.9.9?

Greg doesn't remember what patches he applied to what stable tree, nor
if he had applied them to a previous stable release at all.  His
short-term memory is almost non-existant given the huge rate of patches
flowing through him, and he is feeling strange referring to himself in
the third person...

> 2* Why was the backport only added to 3.9-stable and not also
> 3.4-longterm and 3.0 longterm?

Probably because the patch sent to me didn't apply there?

> I need the fix for the SLE11 SP3 kernel which is based on 3.0. Neil, do
> you have a backport of the fix for this kernel? The 3.9 doesn't apply :(

Ah, yes, that's why I didn't apply it.

If someone sends me a version that does, I will add it to those trees.

thanks,

greg k-h
