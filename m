Return-Path: <SRS0=ZGzV=2X=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=ZGzV=2X=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Mason' <slash.tmp@free.fr>, Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, linux-usb
	<linux-usb@vger.kernel.org>, Rob Herring <robh@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier
	<marc.zyngier@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Phuong Nguyen <phuong_nguyen@sigmadesigns.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, Robin Murphy <robin.murphy@arm.com>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>
Subject: RE: Neophyte questions about PCIe
Date: Tue, 14 Mar 2017 12:24:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFB0737@AcuExch.aculab.com>
References: <ced6a4bf-c94a-c116-1e94-52a8d675d132@free.fr>
 <20170308151724.GA20780@bhelgaas-glaptop.roam.corp.google.com>
 <f964ee05-db7f-c381-c91c-82897175da6d@free.fr>
 <9ba05c2c-57ef-b2c0-6a7c-457c392d98b5@free.fr>
 <df517167-d692-38a8-9c8f-a1112c7f578d@free.fr>
 <c0a353cb-aa1f-25db-eccd-7a1618e655b3@free.fr>
 <20170313214024.GD8232@bhelgaas-glaptop.roam.corp.google.com>
 <826d0a3f-753f-0330-5792-e11beb78d6bf@free.fr>
 <063D6719AE5E284EB5DD2968C1650D6DCFFB0422@AcuExch.aculab.com>
 <ba1c544d-e2d3-3bc5-c4a1-7072c00a108f@free.fr>
In-Reply-To: <ba1c544d-e2d3-3bc5-c4a1-7072c00a108f@free.fr>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Mason
> Sent: 14 March 2017 12:06
> On 14/03/2017 11:23, David Laight wrote:
>=20
> > Mason wrote:
> >
> >> I'd like to push support for this PCIe controller upstream.
> >>
> >> Is the code I posted on the right track?
> >> Maybe I can post a RFC patch tomorrow?
> >
> > I think you need to resolve the problem of config space (and IO) cycles
> > before the driver can be deemed usable.
>=20
> You're alluding to the (unfortunate) muxing of config and mem spaces
> on my controller, where concurrent accesses by two different threads
> would blow the system up.
>=20
> You've suggested sending IPIs in the config space accessor, in order
> to prevent other CPUs from starting a mem access. But this doesn't
> help if a mem access is already in flight, AFAIU.
>=20
> I fear there is nothing that can be done in SW, short of rewriting
> drivers such that mem space accesses are handled by a driver-specific
> call-back which could take care of all required locking.
>=20
> AFAICT, my only (reasonable) option is putting a big fat warning
> in the code, and pray that concurrent accesses never happen.
> (I'll test with a storage stress test on a USB3 drive.)

Since this is a host controller and you want to be able to use standard
PCIe cards (with their standard drivers) you need to fix the hardware
or do some kind of software workaround that is only in the config space
code.
You cannot assume than config space cycles won't happen at the same
time as other accesses.

While most driver accesses should use either the iowrite32() or writel()
families of functions I'm pretty sure they don't have inter-cpu locking.
(They might have annoying, excessive barriers.)
But it is also legal for drivers to allow pcie memory space be mmapped
directly into a processes address space.
You have no control over the bus cycles that generates.
This isn't common, but is done. We use it for bit-banging serial eeproms.

	David
