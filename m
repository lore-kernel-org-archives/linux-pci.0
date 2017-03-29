Return-Path: <SRS0=US7a=3G=amd.com=Kelly.Zytaruk@kernel.org>
Return-Path: <SRS0=US7a=3G=amd.com=Kelly.Zytaruk@kernel.org>
From: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Alex Williamson
	<alex.williamson@redhat.com>
Subject: RE: Having problems resetting a PCI device
Date: Wed, 29 Mar 2017 21:41:48 +0000
Message-ID: <DM2PR12MB00789662208FE959FCBD7AD6FE350@DM2PR12MB0078.namprd12.prod.outlook.com>
References: <DM2PR12MB00780139E84F5B961AD4AB6CFE350@DM2PR12MB0078.namprd12.prod.outlook.com>
 <20170329205446.GB31007@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170329205446.GB31007@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, March 29, 2017 4:55 PM
> To: Zytaruk, Kelly
> Cc: linux-pci@vger.kernel.org; Alex Williamson
> Subject: Re: Having problems resetting a PCI device
>=20
> Hi Kelly,
>=20
> On Wed, Mar 29, 2017 at 08:03:33PM +0000, Zytaruk, Kelly wrote:
> > I have a PCI device that is sitting behind a bridge.
> >
> > Under certain reproducible circumstances the PCI device will become
> > inactive. Reading the PCI config space returns all 0xFFFFFFFF.
> >
> > The bridge appears to still be functional. Reading the status from the
> > bridge I see a Fatal Error due to a Surprise Down event.
>=20
> Just to be specific, is this the "Surprise Down Error" in the AER uncorre=
ctable
> error status register?  "lspci -vv" probably decodes all that for you.
>=20
> > I am trying to figure out how to bring the device back online.
> >
> > I tried toggling the secondary bus reset bit of the Bridge Control
> > Register but it doesn't appear to make any difference. I still see
> > 0xFFFFFFFF in the device config space.
>=20
> Are you calling pci_reset_function() or doing this by hand?
> pci_reset_function() tries several different strategies, one of which is =
toggling
> the secondary bus reset bit.

I just read the documentation for the call and this could be a problem
"The PCI device must be responsive  to PCI config space in order to use thi=
s function."

In my case reading PCI config space returns all 0xFFFFFFFF

>=20
> > I provided a pci_error_handler but the error_detected() function is
> > not getting called.
>=20
> Do you have CONFIG_PCIEAER turned on?  I would naively expect AER to log
> something and call your error_detected() function if this error occurs (b=
ut I
> haven't looked at the code for a long time).
>=20
> > Given that these two methods are not helping me out what other choices
> > do I have to either reset the PCI device or hot-plug the device from a
> > kernel driver. Or some other method of bring the device back to life.
> >
> > Note that I am running Linux 4.8 in dom0 on Xen (if that makes a
> > difference).
> >
> > Thanks, Kelly
