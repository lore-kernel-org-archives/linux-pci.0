Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:43441 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3FZRkE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2013 13:40:04 -0400
Date: Wed, 26 Jun 2013 13:39:53 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Don Zickus <dzickus@redhat.com>,
	Don Dutile <ddutile@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Asit Mallick <asit.k.mallick@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: Re: [3.9 stable PATCH] iommu/vt-d: add quirk for broken interrupt
 remapping on 55XX chipsets
Message-ID: <20130626173953.GA8168@hmsreliant.think-freely.org>
References: <1372253195-17053-1-git-send-email-nhorman@tuxdriver.com>
 <20130626172610.GA6842@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130626172610.GA6842@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 26, 2013 at 10:26:10AM -0700, Greg KH wrote:
> On Wed, Jun 26, 2013 at 09:26:35AM -0400, Neil Horman wrote:
> > A few years back intel published a spec update:
> > http://www.intel.com/content/dam/doc/specification-update/5520-and-5500-chipset-ioh-specification-update.pdf
> > 
> > For the 5520 and 5500 chipsets which contained an errata (specificially errata
> > 53), which noted that these chipsets can't properly do interrupt remapping, and
> > as a result the recommend that interrupt remapping be disabled in bios.  While
> > many vendors have a bios update to do exactly that, not all do, and of course
> > not all users update their bios to a level that corrects the problem.  As a
> > result, occasionally interrupts can arrive at a cpu even after affinity for that
> > interrupt has be moved, leading to lost or spurrious interrupts (usually
> > characterized by the message:
> > kernel: do_IRQ: 7.71 No irq handler for vector (irq -1)
> > 
> > There have been several incidents recently of people seeing this error, and
> > investigation has shown that they have system for which their BIOS level is such
> > that this feature was not properly turned off.  As such, it would be good to
> > give them a reminder that their systems are vulnurable to this problem.  For
> > details of those that reported the problem, please see:
> > https://bugzilla.redhat.com/show_bug.cgi?id=887006
> > 
> > [ Joerg: Removed CONFIG_IRQ_REMAP ifdef from early-quirks.c ]
> > 
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > CC: Prarit Bhargava <prarit@redhat.com>
> > CC: Don Zickus <dzickus@redhat.com>
> > CC: Don Dutile <ddutile@redhat.com>
> > CC: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Asit Mallick <asit.k.mallick@intel.com>
> > CC: David Woodhouse <dwmw2@infradead.org>
> > CC: linux-pci@vger.kernel.org
> > CC: Joerg Roedel <joro@8bytes.org>
> > CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > CC: Arkadiusz Miskiewicz <arekm@maven.pl>
> > CC: Greg KH <gregkh@linuxfoundation.org>
> > Signed-off-by: Joerg Roedel <joro@8bytes.org>
> > ---
> >  arch/x86/include/asm/irq_remapping.h |  3 +++
> >  arch/x86/kernel/early-quirks.c       | 20 ++++++++++++++++++++
> >  drivers/iommu/intel_irq_remapping.c  | 10 ++++++++++
> >  drivers/iommu/irq_remapping.c        |  6 ++++++
> >  drivers/iommu/irq_remapping.h        |  2 ++
> >  5 files changed, 41 insertions(+)
> 
> Please let me know what the git commit id of the patch you are asking to
> be applied is, in Linus's tree.  Otherwise I'll just assume you are
> trying to get a patch into a stable branch that isn't in Linus's tree,
> which isn't allowed, and I know you know better than to try to do that
> :)
> 
Sorry, I normally do a cherry-pick -x, fat fingered it in my rush :).  As was
previously noted, its from commit 03bbcb2e7e292838bb0244f5a7816d194c911d62
Neil

> thanks,
> 
> greg k-h
> 
