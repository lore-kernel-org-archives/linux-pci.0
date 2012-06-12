Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:31399
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443Ab2FLQF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jun 2012 12:05:29 -0400
Date: Tue, 12 Jun 2012 18:04:27 +0200
From: Joerg Roedel <joerg.roedel@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Joerg Roedel <joro@8bytes.org>, <aik@ozlabs.ru>,
	<benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<dwmw2@infradead.org>, <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 0/5] PCI: Prep for VFIO and IOMMU Groups
Message-ID: <20120612160427.GE2624@amd.com>
References: <20120611152021.25959.71601.stgit@bling.home>
 <CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg@mail.gmail.com>
 <20120612062000.GA6932@8bytes.org>
 <CAErSpo6J61+XhtEeXdE-5Evhs-SJ4=3iEZDAXGuRi9moAU8KhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
In-Reply-To: <CAErSpo6J61+XhtEeXdE-5Evhs-SJ4=3iEZDAXGuRi9moAU8KhQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Jun 12, 2012 at 09:55:59AM -0600, Bjorn Helgaas wrote:
> On Tue, Jun 12, 2012 at 12:20 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > Hi Bjorn,
> >
> > On Mon, Jun 11, 2012 at 06:59:25PM -0600, Bjorn Helgaas wrote:
> >> On Mon, Jun 11, 2012 at 8:26 AM, Alex Williamson
> >> <alex.williamson@redhat.com> wrote:
> >> > v3:
> >> >  - Small change to device specific ACS check to allow quirk to
> >> >   support yes/no/pass type functionality. (no change to other
> >> >   patches and no trickle down through IOMMU series)
> >> >
> >> > Bjorn, what's needed to get these in?  Thanks,
> >>
> >> Sorry for the delay.  I applied these to my "next" branch (headed for
> >> 3.6).  I didn't feel comfortable pushing them towards 3.5 since
> >> they're not bugfixes, and they haven't been in -next yet.
> >
> > Great. Do you applied them directly to your next branch or do you have
> > them in a seperate branch I can pull in to merge the IOMMU Groups
> > patches on-top? The later would be really good :)
> 
> Hi Joerg, I have Alex's patches on a separate topic branch.  I folded
> in the pci_get_dev() fix and pushed it to here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> topic/alex-vfio-prep
> 
> This is also included in my "next" branch.


Great, thanks. I will pull in this branch and apply Alex' IOMMU group
code on-top.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

