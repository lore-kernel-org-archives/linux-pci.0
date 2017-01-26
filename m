Return-Path: <SRS0=hEiR=ZI=dell.com=Austin.Bolen@kernel.org>
Return-Path: <SRS0=hEiR=ZI=dell.com=Austin.Bolen@kernel.org>
From: <Austin.Bolen@dell.com>
To: <helgaas@kernel.org>
CC: <keith.busch@intel.com>, <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <wzhang@fb.com>
Subject: RE: [PATCHv4 next 0/3] Limiting pci access
Date: Thu, 26 Jan 2017 01:12:40 +0000
Message-ID: <1335cad92c6f4d258d5ca6738d585ccc@AUSX13MPC131.AMER.DELL.COM>
References: <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
 <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de> <20170121084243.GA24706@kroah.com>
 <20170123160452.GA10771@localhost.localdomain>
 <35db59dfeccf4c83b5cb0eb3a1cf00b1@AUSX13MPC131.AMER.DELL.COM>
 <20170125211718.GA18383@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170125211718.GA18383@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

You're welcome and likewise, the PCIe spec will only benefit by having a be=
tter understanding of the constraints and concerns of the operating systems=
 that utilize PCIe so thank you as well for your feedback from the OS and P=
CIe driver side.

I know of two ways that are being discussed on how to handle this in a gene=
ric way that don't require a priori knowledge of what the register value sh=
ould be.  Both have tradeoffs.  It may be that neither are acceptable from =
OS standpoint or both are. I'm interested in your perspective and if neithe=
r are acceptable, then it will be great to get your thoughts on if there is=
 anything that could be added to the PCIe Base Spec to provide the OS with =
an acceptable way to handle these types of errors.

1. Check Vendor ID Register
If 1's are returned on a config read then read the Vendor ID.  If the Vendo=
r ID also returns 1's (which it will if the device is removed) then we know=
 with certainty it is an error.  On removal events, we see this check worki=
ng in practice.

How the check above can fail:  It is possible (though we've not been able t=
o replicate this failure IRL) that a device could be removed causing all 1'=
s to be returned for the data and by the time the error checking code in th=
e config read API reads the Vendor ID, a new device has been inserted and V=
endor ID returns a valid value (the config read API would need to be really=
 slow or get suspended or otherwise stalled for a large amount of time). An=
 operating system could probably add some sort of co-ordination between thi=
s error checking code in the config space API and the operating system's PC=
Ie hot-plug driver (perhaps using dev->is_removed or the like as the proxy)=
 to cover this corner case and make this bullet-proof but I'm not sure if i=
t's necessary.

This mechanism would work for PCI and PCIe.

OSes could choose to not handle this in the core config space APIs and requ=
ire all software entities that may access a device's config space (PCI bus =
driver/device driver/systems management software/diagnostic utilities/etc.)=
 to perform this check (what we do today).

2. Use the Root Port Programmed IO (RP PIO) mechanism
The PCIe Spec architected way is to use RP PIO extensions which were added =
in the PCIe 3.1 specification (see section 6.2.10.3 and 7.31) as part of th=
e Enhanced Downstream Port Containment ECN.  This ECN added status bits in =
root ports for the various errors (Unsupported Request, Completer Abort, Co=
mpletion Timeout) that could occur due to a failed non-posted request (Conf=
iguration Space access, MMIO access, IO access), TLP Header Logs to determi=
ne the which device is associated with the failure, and a synchronous excep=
tion mechanism to notify the operating system.  This mechanism was intended=
 to solve all corner cases for these types of failures.

This feature won't be available in products for some time and is optional s=
o all root ports may not implement it.

This feature is PCIe only so won't work for PCI.  Is this a deal-breaker?

Unlike option 1, this mechanism most likely cannot be used by anyone but th=
e OS so this work cannot be pushed to the caller.  There would be no way to=
 co-ordinate ownership of the RP PIO registers amongst the many software en=
tities that may access a device's config space (PCI bus driver/device drive=
r/systems management software/diagnostic utilities/etc.)

Thanks,
Austin


-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org]=20
Sent: Wednesday, January 25, 2017 3:17 PM
To: Bolen, Austin <Austin_Bolen@Dell.com>
Cc: keith.busch@intel.com; gregkh@linuxfoundation.org; lukas@wunner.de; lin=
ux-pci@vger.kernel.org; bhelgaas@google.com; wzhang@fb.com
Subject: Re: [PATCHv4 next 0/3] Limiting pci access

Hi Austin,

Thanks a lot for bringing some more PCIe spec expertise.  I wish we had mor=
e insight into what the spec authors were thinking because I'm sure we ofte=
n miss the point and cause face-palms on the committee.

On Wed, Jan 25, 2017 at 12:44:34AM +0000, Austin.Bolen@dell.com wrote:
> To add to what Keith sent, I wanted to throw in my 2 cents on this=20
> issue.  Full disclosure - I'm not a Linux developer and so my thoughts=20
> on this are more from the PCIe Base Specification point of view and=20
> specifically, hardening the spec to better support PCIe hot-plug for=20
> storage use cases (NVMe) and providing better guidance in the PCIe=20
> spec on how system software can interact with the PCIe subsystem to=20
> better determine/handle the sort of errors that arise in PCIe removal=20
> scenarios.
>=20
> From Dell EMC side, we would definitely like to see the config read=20
> routines in all operating environments return an error status code any=20
> time data is synthesized by the root port - but especially for=20
> failures due to device removal.  Today, if bad data is synthesized by=20
> a root port due to a failed config read, the config read routines in=20
> various operating environments do not return an error.  We, and=20
> others, have found cases where the caller of these config routines=20
> will consume the bad data since the API did not return an error due to=20
> this type of failure.  Most folks have been patching up every caller=20
> to check if data is synthesized after every config read.

How exactly do the callers do this?  By checking for all ones data?  It's l=
egal for a config register to contain all ones, of course, so checking for =
all ones by itself is not definitive.  A driver does have additional knowle=
dge about what registers exist and what their legal contents are, but of co=
urse, the config accessor in the core does not.

> This is not very efficient as there are many entities that read config=20
> space (device driver, bus driver, systems management
> software, diagnostic software, etc.).   This patch, or similar,
> is very beneficial because it localizes the error checking for=20
> synthesized data to a single location in the core config read APIs=20
> rather than distributing this code to every caller.

This sounds like you mean checking for synthesized data in the PCI core.  H=
ow can we figure that out?  Is there something in the root port that can te=
ll us the data was synthesized?

Is there a way to do this check for both conventional PCI and PCIe, since w=
e use the same config accessors for PCI and PCIe?

We support many host bridges and most of the time (x86 platforms with ACPI)=
 we have no bridge-specific support in Linux, so anything we do in the core=
 would have to be pretty generic.  I'm sure this is all obvious, so I apolo=
gize for restating it.  I'm just not sure what the concrete details should =
look like.

> The callers benefit by only requiring a simple check of the return=20
> status code from the API (which many are already doing).

Very roughly, I'd guess about 10% of current Linux callers check the status=
 code:

  $ git grep "pci_read_config" | wc -l
  2922
  $ git grep "pci_read_config" | egrep "if \(pci| =3D pci" | wc -l
  219

But I certainly agree that the current API is hard for callers to deal with=
.

> Having the check for a removed device before reading config space will=20
> result in correctly returning an error for most failures of this=20
> nature.  There is a race condition even with this patch, however.  If=20
> the device is present when the check occurs, but is removed just after=20
> that and before the config read goes out, the config routine can still=20
> return bad data without an error status return code.  To eliminate=20
> this race condition where bad data is returned, I think that config=20
> read routines will need to have a check *after* reading the data in=20
> addition to the check *before* reading.  The check after reading would=20
> need to determine if the data was synthesized and return and error=20
> status if so.
>=20
> I'm interested in hearing what others think on returning an error for=20
> this case in the core config read APIs or any alternative ways to more=20
> gracefully handle these types of errors.

>=20
> Thanks,
> Austin
