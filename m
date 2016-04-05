Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 18:27:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 1/4] PCI: Add Thunderbolt device IDs
Message-ID: <20160405232712.GI15353@localhost>
References: <cover.1458126755.git.lukas@wunner.de>
 <d30491f2c4c1c6d28c78c5883820f9dc28c010d9.1458126755.git.lukas@wunner.de>
 <20160317150320.GA22769@localhost>
 <20160320131135.GA29174@wunner.de>
 <20160320171246.GB16658@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160320171246.GB16658@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 20, 2016 at 10:12:46AM -0700, Greg Kroah-Hartman wrote:
> On Sun, Mar 20, 2016 at 02:11:35PM +0100, Lukas Wunner wrote:
> > Hi Bjorn,
> > 
> > On Thu, Mar 17, 2016 at 10:03:20AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Mar 16, 2016 at 03:50:35PM +0100, Lukas Wunner wrote:
> > > > Gen 1 and 2 chips use the same ID for NHI, bridges and switch.
> > > > Gen 3 chips and onward use a distinct ID for the NHI.
> > > 
> > > I assume this is strictly using #defines instead of bare numbers and
> > > hence "no functional change intended."
> > > 
> > > > Cc: Andreas Noever <andreas.noever@gmail.com>
> > > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > 
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Thanks, I've just posted a 3 patch series to support the Light Ridge
> > Thunderbolt controller and included your ack for this patch.
> > 
> > 
> > > I assume somebody else will merge this with the rest of the series.
> > 
> > The maintainer of the thunderbolt driver is Andreas Noever, however
> > I don't think Andreas sends pull requests to Linus. Everything in
> > drivers/thunderbolt/ has so far been picked up by Greg KH.
> > 
> > I have more thunderbolt stuff in the pipeline, some of which needs
> > changes to drivers/pci/. Therefore it would be ideal from my perspective
> > if my thunderbolt patches could go in via your tree, if that is possible.
> 
> I have no objection if they go through the PCI tree, especially as
> Thunderbolt really just is PCI express, it makes sense to take them that
> way.

Andreas, what's your preference?  If you want me to merge Thunderbolt
stuff via my PCI tree, I can do that.  But I don't know anything about
Thunderbolt and don't have specs or ability to test it, so I would
rely on you to ack any changes.  If you'd like to merge Thunderbolt
stuff yourself, that would be less work for me, so even better :)  But
either way is fine.

Bjorn
