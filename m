Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Jun 2012 08:20:00 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	benh@kernel.crashing.org, aik@ozlabs.ru, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH v3 0/5] PCI: Prep for VFIO and IOMMU Groups
Message-ID: <20120612062000.GA6932@8bytes.org>
References: <20120611152021.25959.71601.stgit@bling.home>
 <CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAErSpo434tDtnSOxB_REG2jFNrZL=aZERWTmmK-cdjqM4z6yWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Mon, Jun 11, 2012 at 06:59:25PM -0600, Bjorn Helgaas wrote:
> On Mon, Jun 11, 2012 at 8:26 AM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > v3:
> >  - Small change to device specific ACS check to allow quirk to
> >   support yes/no/pass type functionality. (no change to other
> >   patches and no trickle down through IOMMU series)
> >
> > Bjorn, what's needed to get these in?  Thanks,
> 
> Sorry for the delay.  I applied these to my "next" branch (headed for
> 3.6).  I didn't feel comfortable pushing them towards 3.5 since
> they're not bugfixes, and they haven't been in -next yet.

Great. Do you applied them directly to your next branch or do you have
them in a seperate branch I can pull in to merge the IOMMU Groups
patches on-top? The later would be really good :)

Regards,

	Joerg


