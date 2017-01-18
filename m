Return-Path: <SRS0=A/eM=ZA=intel.com=vaibhav.shankar@kernel.org>
Return-Path: <SRS0=A/eM=ZA=intel.com=vaibhav.shankar@kernel.org>
From: "Shankar, Vaibhav" <vaibhav.shankar@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "Patel, Mayurkumar"
	<mayurkumar.patel@intel.com>, "Busch, Keith" <keith.busch@intel.com>,
	"lukas@wunner.de" <lukas@wunner.de>, "yinghai@kernel.org"
	<yinghai@kernel.org>, "yhlu.kernel@gmail.com" <yhlu.kernel@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vinjamuri,
 Venkateswarlu V" <venkateswarlu.v.vinjamuri@intel.com>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH v2] PCI: pciehp: Optimize PCIe root resume time
Date: Wed, 18 Jan 2017 01:32:13 +0000
Message-ID: <98A68070CD83F8438B54ECF5FBADF9360132B14A@ORSMSX107.amr.corp.intel.com>
References: <20161211011908.GA10954@linux-siqj.site>
 <1481589145-22109-1-git-send-email-vaibhav.shankar@intel.com>
 <20170111183726.GE14532@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170111183726.GE14532@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, January 11, 2017 10:37 AM
> To: Shankar, Vaibhav <vaibhav.shankar@intel.com>
> Cc: bhelgaas@google.com; Patel, Mayurkumar
> <mayurkumar.patel@intel.com>; Busch, Keith <keith.busch@intel.com>;
> lukas@wunner.de; yinghai@kernel.org; yhlu.kernel@gmail.com; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] PCI: pciehp: Optimize PCIe root resume time
>=20
> Hi Vaibhav,
>=20
> On Mon, Dec 12, 2016 at 04:32:25PM -0800, Vaibhav Shankar wrote:
> > On Apollolake platforms, PCIe rootport takes a long time to resume
> > from S3. With 100ms delay before read pci conf, rootport takes ~200ms
> > during resume.
> >
> > commit 2f5d8e4ff947 ("PCI: pciehp: replace unconditional sleep with
> > config space access check") is the one that added the 100ms delay
> > before reading pci conf.
> >
> > This patch includes a condition check for 100ms dealy before reading
> > PCIe conf. This delay in included only when PCIe max_bus_speed > 5.0
> > GT/s. Root port takes ~16ms during resume.
>=20
> This patch reduces the delay by 100ms for devices that don't support
> 5.0 GT/s.  Please include references to the specs about the necessary del=
ays
> and explain why we don't need this 100ms delay.
>=20
> Presumably there's something in the spec about needing extra delay when
> supporting 5.0 GT/s.
>=20
> This is generic code, so we can't make changes based on specific devices =
like
> Apollolake.  We have to make the code follow the spec so it works for
> everybody.
>=20
> > With 100ms delay:
> > [  155.102713] calling  0000:00:14.0+ @ 70, parent: pci0000:00, cb:
> > pci_pm_resume_noirq [  155.119337] call 0000:00:14.0+ returned 0 after
> > 16231 usecs [  155.119467] calling  0000:01:00.0+ @ 5845, parent:
> > 0000:00:14.0, cb: pci_pm_resume_noirq [  155.321670] call
> > 0000:00:14.0+ returned 0 after 185327 usecs [  155.321743] calling
> > 0000:01:00.0+ @ 5849, parent: 0000:00:14.0, cb: pci_pm_resume
> >
> > With Condition check:
> > [   36.624709] calling 0000:00:14.0+ @ 4434, parent: pci0000:00, cb:
> pci_pm_resume_noirq
> > [   36.641367] call 0000:00:14.0+ returned 0 after 16263 usecs
> > [   36.652458] calling 0000:00:14.0+ @ 4443, parent: pci0000:00, cb:
> pci_pm_resume
> > [   36.652673] call 0000:00:14.0+ returned 0 after 208 usecs
> > [   36.652863] calling  0000:01:00.0+ @ 4442, parent: 0000:00:14.0, cb:
> pci_pm_resume
> >
> > Signed-off-by: Vaibhav Shankar <vaibhav.shankar@intel.com>
> > ---
> > changes in v2:
> >         - Modify patch description.
> >         - Add condition check for 100ms delay before read pci conf as
> >           suggested by Yinghai.
> >
> >  drivers/pci/hotplug/pciehp_hpc.c |   11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c
> > b/drivers/pci/hotplug/pciehp_hpc.c
> > index b57fc6d..2b10e5f 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -311,8 +311,15 @@ int pciehp_check_link_status(struct controller
> *ctrl)
> >  	else
> >  		msleep(1000);
> >
> > -	/* wait 100ms before read pci conf, and try in 1s */
> > -	msleep(100);
> > +	/*
> > +	 * If the port supports Link speeds greater than 5.0 GT/s, we
> > +	 * must wait for 100 ms after Link training completes before
> > +	 * sending configuration request.
> > +	 */
> > +	if (ctrl->pcie->port->subordinate->max_bus_speed >
> PCIE_SPEED_5_0GT)
> > +		msleep(100);
> > +
> > +	/* try in 1s */
> >  	found =3D pci_bus_check_dev(ctrl->pcie->port->subordinate,
> >  					PCI_DEVFN(0, 0));
> >
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html

Hi Bjorn,

Please find the details from regarding delays from PCIe spec 3.0:=20

1)  With a Downstream Port that does not support Link speeds greater than 5=
.0 GT/s, software
 must wait a minimum of 100 ms before sending a Configuration Request to th=
e device
immediately below that Port.

2)  With a Downstream Port that supports Link speeds greater than 5.0 GT/s,=
 software must
wait a minimum of 100 ms after Link training completes before sending a Con=
figuration
Request to the device immediately below that Port. Software can determine w=
hen Link
training completes by polling the Data Link Layer Link Active bit or by set=
ting up an
associated interrupt (see Section 6.7.3.3).

3) A system must guarantee that all components intended to be software visi=
ble at boot time
are ready to receive Configuration Requests within the applicable minimum p=
eriod based on
the end of Conventional Reset at the Root Complex - how this is done is bey=
ond the scope
of this specification.

4)  Note: Software should use 100 ms wait periods only if software enables =
CRS Software
Visibility. Otherwise, Completion timeouts, platform timeouts, or lengthy p=
rocessor
instruction stalls may result. See the Configuration Request Retry Status I=
mplementation
Note in Section 2.3.1.

The spec says we have to wait for 100ms before sending configuration reques=
t to the device.=20
On older platforms like Skylake, PCIe was never suspended during S3 because=
 Pcie was not on Vnn rail. Hence this delay never impacted S3 resume.

On newer platforms like Apollolake ,  PCIe IP is on Vnn rail. When PCIe roo=
t ports are suspended during S3,  100ms is in the critical path during PCIe=
 root port resume . This delay impacts S3 kernel resume time by ~60ms.

Could you please provide your  suggestions on how to address this issue fro=
m PCIe Spec perspective?

Thanks and regards,
vaibhav=20
