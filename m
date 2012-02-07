Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:60459 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756458Ab2BGURv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2012 15:17:51 -0500
Date: Tue, 7 Feb 2012 22:17:45 +0200
From: Felipe Balbi <balbi@ti.com>
To: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
Cc: "balbi@ti.com" <balbi@ti.com>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] usb: dwc3: second part of hibernation support
Message-ID: <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
References: <cover.1328582753.git.paulz@synopsys.com>
 <9c4ee1f156d28640bc43dee647e3470b9e1b9f37.1328582753.git.paulz@synopsys.com>
 <20120207070322.GB3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
In-Reply-To: <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 07, 2012 at 11:50:54AM -0800, Paul Zimmerman wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:balbi@ti.com]
> > Sent: Monday, February 06, 2012 11:03 PM
> >=20
> > On Mon, Feb 06, 2012 at 07:20:16PM -0800, Paul Zimmerman wrote:
> > > This patch adds the actual hibernation code, and allows it to be
> > > enabled in the Kconfig.
> >=20
> > Actually, is there any real reason someone would not use such a feature
> > if it's available in HW ?
> >=20
> > I mean, the guy chose to enable support for it on your core
> > configuration tool, right ?
>=20
> It's a dangerous feature if it's not implemented 100% correctly.
> It can cause the system to freeze solid. So I think it's best to
> make it an optional feature, at least for the time being.

Could be, on the other hand, we want those failures to appear ASAP, so
we fix them promptly. If we keep it disabled, we will most likely loose
users, I'm afraid.

Another argument is that we can keep this for testing for a loooong
period of time before merging it to mainline. That's why we have
linux-next and that's why we both have devices with DWC3 controller.
Well there are a few more companies who might pitch in soon, so we might
just get more people to help testing patches.

> < snip >
>=20
> > hmm, so this is all haps-specific ?? Isn't PCIe supposed to be
> > standardized, how come you have vendor-specific registers ??
>=20
> The HAPS implementation is non-standard, sorry. There's nothing
> I can do about that.

Can you talk more about what you're doing here ? Are you talking to
HAPS' PCIe controller ? I mean, something on the FPGA, or something on
the PCB ? I'm trying to understand whose registers are these ?

> < snip >
>=20
> > > +/*
> > > + * Platform-specific power control routine, for HAPS board
> > > + */
> > > +void dwc3_haps_power_ctl(struct dwc3 *dwc, int on)
> > > +{
> > > +	u32	reg;
> > > +	int	cnt =3D 0;
> > > +
> > > +	if (on) {
> > > +		/*
> > > +		 * Enable core well power
> > > +		 */
> > > +
> > > +		/* This is "faked" by the FPGA */
> > > +
> > > +		/*
> > > +		 * Communicate with power controller to set power state to D0
> > > +		 */
> > > +
> > > +		reg =3D dwc3_readl(dwc->regs, DWC3_HAPS_GASKET_POWER_CTL);
> > > +		dev_vdbg(dwc->dev, "R1=3D0x%08x before write\n", reg);
> > > +		reg =3D (reg & ~DWC3_HAPS_GASKET_POWER_DSTATE_MASK) |
> > > +				DWC3_HAPS_GASKET_POWER_DSTATE_D0;
> > > +		dwc3_writel(dwc->regs, DWC3_HAPS_GASKET_POWER_CTL, reg);
> > > +		reg =3D dwc3_readl(dwc->regs, DWC3_HAPS_GASKET_POWER_CTL);
> > > +		dev_vdbg(dwc->dev, "R1=3D0x%08x after write\n", reg);
> >=20
> > isn't this the same as pci_set_power_state(pci, PCI_D0); ??
>=20
> Since the HAPS has a non-standard implementation, not part of the PCI
> interface, the PCI power control functions won't work, AFAIK.

I'm not a PCI expert, but you ought to find a way to hide it under some
abstraction. Describing HAPS better would help other guys pitch in with
ideas.

I'm adding linux-pci@vger to the Cc list in order to ask for some help.

There is anyway a set of PCI pm platform_ops which you might be able to
use in order to hide this, I don't know. Like I said, I'm not very
confortable with the PCI subsystem.

> > > +		/*
> > > +		 * Wait until both PMUs confirm that they have entered D0
> > > +		 */
> > > +
> > > +		dev_vdbg(dwc->dev, "Asked for D0 state, awaiting response\n");
> > > +
> > > +		do {
> > > +			udelay(1);
> > > +			reg =3D dwc3_readl(dwc->regs, DWC3_HAPS_GASKET_DEBUG);
> > > +			if (++cnt > 10000000) {
> > > +				cnt =3D 0;
> > > +				dev_vdbg(dwc->dev, "0x%08x\n", reg);
> > > +			}
> > > +		} while ((reg & DWC3_HAPS_GASKET_DEBUG_DSTATE_MASK) !=3D
> > > +				DWC3_HAPS_GASKET_DEBUG_DSTATE_D0);
> > > +	} else {
> > > +		/*
> > > +		 * Communicate with power controller to set power state to D3
> > > +		 */
> > > +
> > > +		reg =3D dwc3_readl(dwc->regs, DWC3_HAPS_GASKET_POWER_CTL);
> > > +		dev_vdbg(dwc->dev, "R1=3D0x%08x before write\n", reg);
> > > +		reg =3D (reg & ~DWC3_HAPS_GASKET_POWER_DSTATE_MASK) |
> > > +				DWC3_HAPS_GASKET_POWER_DSTATE_D3;
> > > +		dwc3_writel(dwc->regs, DWC3_HAPS_GASKET_POWER_CTL, reg);
> > > +		reg =3D dwc3_readl(dwc->regs, DWC3_HAPS_GASKET_POWER_CTL);
> > > +		dev_vdbg(dwc->dev, "R1=3D0x%08x after write\n", reg);
> >=20
> > likewise pci_set_poer_state(pci, PCI_D3hot); or D3cold, I don't know ??
>=20
> ditto
>=20
> > > +
> > > +		/*
> > > +		 * Wait until both PMUs confirm that they have entered D3
> > > +		 */
> > > +
> > > +		dev_vdbg(dwc->dev, "Asked for D3 state, awaiting response\n");
> > > +
> > > +		do {
> > > +			udelay(1);
> > > +			reg =3D dwc3_readl(dwc->regs, DWC3_HAPS_GASKET_DEBUG);
> > > +			if (++cnt >=3D 10000000) {
> > > +				cnt =3D 0;
> > > +				dev_vdbg(dwc->dev, "0x%08x\n", reg);
> > > +			}
> > > +		} while ((reg & DWC3_HAPS_GASKET_DEBUG_DSTATE_MASK) !=3D
> > > +				DWC3_HAPS_GASKET_DEBUG_DSTATE_D3);
> > > +	}
> > > +}
> > > +
> > > +/*
> > > + * Platform-specific PME interrupt handler, for HAPS board
> > > + */
> > > +int dwc3_haps_pme_intr(struct dwc3 *dwc)
> >=20
> > if it's an IRQ handler, why aren't you requesting the IRQ and why ins't
> > this returning irqreturn_t ?
>=20
> It's not a normal interrupt handler, it's part of the non-standard HAPS
> implementation of power control. In a normal platform there would be a
> separate interrupt for this.

I see. Another of HAPS' details. It would be very nice to uncover all of
this platform-specific details and find proper places for those.

> < snip >
>=20
> > this is unnecessary. You should be using pm_runtime APIs for this ;-)
> > Please don't duplicate effort, we have our pm runtime layer for this
> > sort of situation.
> >=20
> > If you use pm_runtime, you will enter hibernation whenever your pm usage
> > counter reaches zero, and we can be as aggressive as we want.
>=20
> Can you point me to an existing kernel driver that uses the pm_runtime
> calls to perform what we need here? It must guarantee that after some

git grep -e "pm_runtime_" drivers/ will have show you many examples.
There's also lots of information under
Documentation/power/runtime_pm.txt

> function (pm_runtime_get?) is called, nothing will attempt to touch any

pm_runtime_get() will, well, do a get. In short, it will enable the
platform for access. In case of e.g. OMAP, we will be enabling the
correct clock nodes in order to be able to use the correct interconnect
to access device's register.

> of the controller registers except the ones that are guaranteed to be
> alive, namely the two HAPS-specific functions above. In particular, it
> must prevent calls from the upper layers into the gadget API from
> touching the controller registers.

that's something which is very driver specific ;-) So we must guarantee
in the driver that this will not happen. It's not very complex to
achieve that, though.

Actually, what most people do, is that they call pm_runtime_get_sync()
before an access to the device is needed, and pm_runtime_put() when the
device isn't needed anymore.

There's no way a generic pm layer can achieve that without help from the
driver. See that with your ad-hoc PM implementation, you have a bunch of
busy loops waiting for the device to come out of hibernation, those
loops will be handled by the generic PM layer, but the driver has to
help ;-)

--=20
balbi

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMYbmAAoJEIaOsuA1yqRETzMP/R7qlcO2py+O8q9VBdM2+pI2
NajfIinCHwAisHNcQxkqu+2Al0FSzThkt8LkUXFnG4amWHd2/9sQTgz5Pc61e0K4
6hpq/yAKEyXu/Qa1rKsFOdIH3Shte37r3ayj8JnLhIpQ5P1fMisLhtCPj9CBqznh
+UVMxkXprzGIg2UUy9BCZoetaiFKlGypLQdKb71J0A+crcCwKmZeFkquKz9XDpn6
WFzTvBaNtvpn9seTSIevBLOjkX1pTp9At5FtZfWlnuf30ZFW/GvxMVWX0gvvRsAZ
YedT3j38DHRFIvJzDH/VdCrtO9KJ0A9Y43GqOPeasxlBh2ccyKg7fhS7ER+F3/Lp
r6OH0EJJtmpQ7obWtdEgFO8GjMdPqEq9QIkOsCYLxq4/zlQQgomIfAYciMJz/vkO
+/S8e6ioHliKWFqCVxiqJfrYddGMKWJm50oUyh/gS34eh+B/kckwe6AQRXffV4M8
/QtWB9DT5OQ9cInCtZem33miMbdnqetDd1H6bR2R6v7Ee3wrbQj9Sqa5F2zcjwd2
HUGV7OtlJOoU9qWnXPOFehul8Z+vruPt6AdyQNYoEwpMwBeUJ+JyoQ3+xySBLTCt
XsdX0ubhwTb4d7Y25imUOSSIWuGsGxk2ShRo0pj9kBh8YIE/FmiGBQugXdpRSvZ7
MVFYvJxYx/S2xXioy8xo
=U3sl
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
