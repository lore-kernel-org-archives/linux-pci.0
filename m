Return-Path: <SRS0=jq5H=ZQ=dell.com=Austin.Bolen@kernel.org>
Return-Path: <SRS0=jq5H=ZQ=dell.com=Austin.Bolen@kernel.org>
From: <Austin.Bolen@dell.com>
To: <helgaas@kernel.org>
CC: <keith.busch@intel.com>, <gregkh@linuxfoundation.org>, <lukas@wunner.de>,
	<linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <wzhang@fb.com>
Subject: RE: [PATCHv4 next 0/3] Limiting pci access
Date: Fri, 3 Feb 2017 21:43:24 +0000
Message-ID: <feb7a078e0fd497c944fe33bad41eee6@AUSX13MPC131.AMER.DELL.COM>
References: <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de> <20170121084243.GA24706@kroah.com>
 <20170123160452.GA10771@localhost.localdomain>
 <35db59dfeccf4c83b5cb0eb3a1cf00b1@AUSX13MPC131.AMER.DELL.COM>
 <20170125211718.GA18383@bhelgaas-glaptop.roam.corp.google.com>
 <1335cad92c6f4d258d5ca6738d585ccc@AUSX13MPC131.AMER.DELL.COM>
 <20170201160459.GB15793@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Resending without the confidentiality notice (hopefully) that our email sys=
tem stuffs into plain text email.


-----Original Message-----
From: Bjorn Helgaas [mailto:helgaas@kernel.org]
Sent: Wednesday, February 1, 2017 10:05 AM
To: Bolen, Austin <Austin_Bolen@Dell.com>
Cc: keith.busch@intel.com; gregkh@linuxfoundation.org; lukas@wunner.de; lin=
ux-pci@vger.kernel.org; bhelgaas@google.com; wzhang@fb.com
Subject: Re: [PATCHv4 next 0/3] Limiting pci access

[Responding inline, per linux mailing list convention]

[AB]
Hi Bjorn,
Responding in-line per convention.  It becomes a bit jumbled when I do so, =
probably because of my email client, so I'll tag my comments with [AB] ... =
[/AB] so I can keep it straight.  Hopefully it is readable on your end.
[/AB]




Hi Austin,

On Thu, Jan 26, 2017 at 01:12:40AM +0000, Austin.Bolen@dell.com wrote:
> I know of two ways that are being discussed on how to handle this in a=20
> generic way that don't require a priori knowledge of what the register=20
> value should be.  Both have tradeoffs.  It may be that neither are=20
> acceptable from OS standpoint or both are. I'm interested in your=20
> perspective and if neither are acceptable, then it will be great to=20
> get your thoughts on if there is anything that could be added to the=20
> PCIe Base Spec to provide the OS with an acceptable way to handle=20
> these types of errors.
>=20
> 1. Check Vendor ID Register If 1's are returned on a config read then=20
> read the Vendor ID.  If the Vendor ID also returns 1's (which it will=20
> if the device is removed) then we know with certainty it is an error.
> On removal events, we see this check working in practice.
>=20
> How the check above can fail:  It is possible (though we've not been=20
> able to replicate this failure IRL) that a device could be removed=20
> causing all 1's to be returned for the data and by the time the error=20
> checking code in the config read API reads the Vendor ID, a new device=20
> has been inserted and Vendor ID returns a valid value (the config read=20
> API would need to be really slow or get suspended or otherwise stalled=20
> for a large amount of time). An operating system could probably add=20
> some sort of co-ordination between this error checking code in the=20
> config space API and the operating system's PCIe hot-plug driver=20
> (perhaps using dev->is_removed or the like as the proxy) to cover this=20
> corner case and make this bullet-proof but I'm not sure if it's=20
> necessary.
>=20
> This mechanism would work for PCI and PCIe.

I like this idea, and if we do go down the route of trying to reliably retu=
rn PCIBIOS_DEVICE_NOT_FOUND, I think we'd have to do something like this at=
 least for conventional PCI.  I don't think it would help much to make a me=
chanism where drivers would have to check for errors differently for PCI vs=
. PCIe devices.

I do wonder about the MacOS guidance Lukas pointed out [1].  It sounds like=
 MacOS drivers are expected to handle 0xFFFFFFFF data values, both from con=
fig reads and MMIO config reads.

Does that mean MacOS considered and rejected this idea (reading Vendor ID t=
o check for device removal) for some reason?  Or maybe MacOS config accesso=
rs don't return success/failure indication?  Or maybe MMIO accesses can't r=
eturn success/failure and they wanted the same failure model for both MMIO =
and config space?

I think there's some value in having similar driver expectations for MacOS =
and Linux, to make it easier for developers who work on both OSes.

[1] https://developer.apple.com/library/content/documentation/HardwareDrive=
rs/Conceptual/ThunderboltDevGuide/Basics02/Basics02.html

[AB]
We have a very similar guidelines.  I can't speak for why MacOS has these g=
uidelines, but we have them because OSes typically do not do the check.  If=
 the OSes do the check, then that would be our preference to avoid every ca=
ller having to do it.

Regarding reading vendor ID, it seems the MacOS guidelines are very similar=
: "If 0xFFFFFFFF is a legal value for a particular register offset, one add=
itional read of a different register, which is known to never return 0xFFFF=
FFFF is the preferred mechanism for determining if the device is still conn=
ected. "

They do not specify which register that is "known to never return 0xFFFFFFF=
F" you should read but Vendor ID is the de facto standard choice as it is a=
 register that can never be all 1's for any device.  Assume that would be o=
k for MacOS as well. Since the OS will not, in general, know when all 1's i=
s valid, it would need to always check.
[/AB]

> OSes could choose to not handle this in the core config space APIs and=20
> require all software entities that may access a device's config space=20
> (PCI bus driver/device driver/systems management software/diagnostic
> utilities/etc.) to perform this check (what we do today).
>=20
> 2. Use the Root Port Programmed IO (RP PIO) mechanism The PCIe Spec=20
> architected way is to use RP PIO extensions which were added in the=20
> PCIe 3.1 specification (see section 6.2.10.3 and 7.31) as part of the=20
> Enhanced Downstream Port Containment ECN.  This ECN added status bits=20
> in root ports for the various errors (Unsupported Request, Completer=20
> Abort, Completion Timeout) that could occur due to a failed non-posted=20
> request (Configuration Space access, MMIO access, IO access), TLP=20
> Header Logs to determine the which device is associated with the=20
> failure, and a synchronous exception mechanism to notify the operating=20
> system.  This mechanism was intended to solve all corner cases for=20
> these types of failures.
>=20
> This feature won't be available in products for some time and is=20
> optional so all root ports may not implement it.
>=20
> This feature is PCIe only so won't work for PCI.  Is this a=20
> deal-breaker?

The config accessors (pci_read_config_word(), etc.) currently work for PCI =
and PCIe devices, and the caller doesn't have to know the difference.  I wa=
nt to preserve that, so I don't want to add PCIe-specific accessors.  But i=
t's conceivable that the accessors could internally do something different =
for PCI vs. PCIe.

[AB]
Understandable.  One thing on hot-plug PCI... this sort of thing may not be=
 necessary for PCI so perhaps it would be ok with a single config accessor =
that did different thing internally depending on whether or not it was PCI =
or PCIe.  PCI hot-plug devices are shielded from a lot of this because they=
 follow the Standard Hot-Plug Controller model.  In this model, the driver =
has to be quiesced and power removed from the slot.  Therefore, Keith's pat=
ch to check if the device is present at the start of the routine should suf=
fice.

There is a corner case where a config transaction could get out to the devi=
ce just before power to the slot is turned off.  Checking for all 1's after=
 the read would catch this case.

The reason I mention this new RP PIO mechanism here is that it is more robu=
st than the all 1's check.  The all 1's check will probably suffice for con=
fig reads since there are already accessor routines and they are serialized=
.  The other PCI Express non-posted requests (mem read, io read, config wri=
te, io write, and AtomicOp) may require the RP PIO mechanism.  For now I'm =
just focusing on config read to set a baseline but long term would like to =
see errors from removal events being handled for all non-posted requests.
[/AB]

We currently serialize all config accesses system-wide, which I think is un=
necessarily strict for ECAM, so I would like to relax it.  It sounds like t=
his mechanism might require serialization at least at the Root Port level t=
o do this synchronously. =20

[AB]
The RP PIO mechanism should not require serialization.  It should work for =
MMIO which is not currently serialized on most OSes.  There are some talks =
on building a proof-of-concept in Linux to show how it would work.

On the topic of relaxing the requirement to serialize ECAM access, I'll thr=
ow in my .02.  There are some weird corner cases you can get into on PCIe p=
ower down sequence that can lead to Completion Timeout Errors if config acc=
esses are not serialized (though there may be other ways to handle this).  =
There may also be other scenarios that currently rely on the fact that all =
OSes serialize config access.  I would be hesitant to make a change like th=
is on the servers that we ship.  Might be safer to leave default as is and =
allow the user a knob to un-serialize if they know for certain it is ok in =
their current operating environment.  But I'd like to better understand the=
 problems being seen with serializing config accesses today.  Is this for p=
erformance optimization?
[/AB]


> Unlike option 1, this mechanism most likely cannot be used by anyone=20
> but the OS so this work cannot be pushed to the caller.  There would=20
> be no way to co-ordinate ownership of the RP PIO registers amongst the=20
> many software entities that may access a device's config space (PCI=20
> bus driver/device driver/systems management software/diagnostic
> utilities/etc.)

If we want a change in this area, I think we have to figure out what the be=
nefit would be.  The current situation is that drivers should check for 0xf=
fffffff data and treat that as an (unreliable) indication that the device w=
as removed.  We can't change all those drivers, so I think we have to prese=
rve this behavior.

[AB]
Agree the behavior has to be preserved.  Looks like Keith's patch return's =
all 1's as the data even in failure so that it works the same way for drive=
rs that check all 1's.  If we used the RP PIO mechanism it could also retur=
n all 1's as the data.
[/AB]

We could also make the accessor return something like PCIBIOS_DEVICE_NOT_FO=
UND (in addition to returning data of 0xffffffff), which might be a more re=
liable indication.

In that case, would we change the message to driver writers from "treat 0xf=
fffffff data as possible removal" to "treat PCIBIOS_DEVICE_NOT_FOUND as rem=
oval indication"?

[AB]
I think drivers could either check for error return code or check for all 1=
's or both.  New drivers can just check the return code (or check all 1's i=
f they really want to).  Old drivers can continue to check all 1's or they =
can update to check the error return code if they want.
[/AB]


If PCIBIOS_DEVICE_NOT_FOUND were reliable, that would be an improvement.  B=
ut maybe we could get most of that benefit by adding a new "pci_device_remo=
ved(dev)" API that uses one of the mechanisms you mention?  Then the guidan=
ce could be "if you read 0xffffffff, use
pci_device_removed() and act accordingly."  That's an incremental change an=
d makes it easier to maintain a driver that works across old and new versio=
ns of Linux.

[AB]
That may be a good middle ground.  The tradeoff here is that well written c=
ode that does check the return code does not need to change if the API does=
 that check and returns error.  Only code that does no checks would need to=
 change.  With this proposal, the code that currently checks the API status=
 would also need to change but at least they don't have to invent their mec=
hanism to determine device presence.

For MMIO/IO, something like this may be needed anyway.  My understanding is=
 that in Linux the convention is to read MMIO directly from the driver rath=
er than using an OS accessor routine so you'd either need an MMIO accessor =
routine or a way for the driver to manually check for presence when it rece=
ives all 1's data back.
[/AB]

You mention other entities (systems management, utilities, etc.) above.  I =
don't really know what the tradeoffs are there.  Obviously they wouldn't us=
e the Linux accessors directly, so the strategy there might not have to be =
the same.  Maybe the wrappers they use could use one of these mechanisms.

[AB]
Our management tools typically install a small driver that provides low-lev=
el access including to config space.  I believe they do use operating syste=
m calls to read config space today so they would also benefit.  So all OS p=
roduced config access mechanisms callable by driver or application would ne=
ed to return error for these device removal cases.  I can check into which =
mechanisms our tools use in Linux to access config space.
[/AB]

Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, January 25, 2017 3:17 PM
> To: Bolen, Austin <Austin_Bolen@Dell.com>
> Cc: keith.busch@intel.com; gregkh@linuxfoundation.org;=20
> lukas@wunner.de; linux-pci@vger.kernel.org; bhelgaas@google.com;=20
> wzhang@fb.com
> Subject: Re: [PATCHv4 next 0/3] Limiting pci access
>=20
> Hi Austin,
>=20
> Thanks a lot for bringing some more PCIe spec expertise.  I wish we had m=
ore insight into what the spec authors were thinking because I'm sure we of=
ten miss the point and cause face-palms on the committee.
>=20
> On Wed, Jan 25, 2017 at 12:44:34AM +0000, Austin.Bolen@dell.com wrote:
> > To add to what Keith sent, I wanted to throw in my 2 cents on this=20
> > issue.  Full disclosure - I'm not a Linux developer and so my=20
> > thoughts on this are more from the PCIe Base Specification point of=20
> > view and specifically, hardening the spec to better support PCIe=20
> > hot-plug for storage use cases (NVMe) and providing better guidance=20
> > in the PCIe spec on how system software can interact with the PCIe=20
> > subsystem to better determine/handle the sort of errors that arise=20
> > in PCIe removal scenarios.
> >=20
> > From Dell EMC side, we would definitely like to see the config read=20
> > routines in all operating environments return an error status code=20
> > any time data is synthesized by the root port - but especially for=20
> > failures due to device removal.  Today, if bad data is synthesized=20
> > by a root port due to a failed config read, the config read routines=20
> > in various operating environments do not return an error.  We, and=20
> > others, have found cases where the caller of these config routines=20
> > will consume the bad data since the API did not return an error due=20
> > to this type of failure.  Most folks have been patching up every=20
> > caller to check if data is synthesized after every config read.
>=20
> How exactly do the callers do this?  By checking for all ones data?  It's=
 legal for a config register to contain all ones, of course, so checking fo=
r all ones by itself is not definitive.  A driver does have additional know=
ledge about what registers exist and what their legal contents are, but of =
course, the config accessor in the core does not.
>=20
> > This is not very efficient as there are many entities that read=20
> > config space (device driver, bus driver, systems management
> > software, diagnostic software, etc.).   This patch, or similar,
> > is very beneficial because it localizes the error checking for=20
> > synthesized data to a single location in the core config read APIs=20
> > rather than distributing this code to every caller.
>=20
> This sounds like you mean checking for synthesized data in the PCI core. =
 How can we figure that out?  Is there something in the root port that can =
tell us the data was synthesized?
>=20
> Is there a way to do this check for both conventional PCI and PCIe, since=
 we use the same config accessors for PCI and PCIe?
>=20
> We support many host bridges and most of the time (x86 platforms with ACP=
I) we have no bridge-specific support in Linux, so anything we do in the co=
re would have to be pretty generic.  I'm sure this is all obvious, so I apo=
logize for restating it.  I'm just not sure what the concrete details shoul=
d look like.
>=20
> > The callers benefit by only requiring a simple check of the return=20
> > status code from the API (which many are already doing).
>=20
> Very roughly, I'd guess about 10% of current Linux callers check the stat=
us code:
>=20
>   $ git grep "pci_read_config" | wc -l
>   2922
>   $ git grep "pci_read_config" | egrep "if \(pci| =3D pci" | wc -l
>   219
>=20
> But I certainly agree that the current API is hard for callers to deal wi=
th.
>=20
> > Having the check for a removed device before reading config space=20
> > will result in correctly returning an error for most failures of=20
> > this nature.  There is a race condition even with this patch,=20
> > however.  If the device is present when the check occurs, but is=20
> > removed just after that and before the config read goes out, the=20
> > config routine can still return bad data without an error status=20
> > return code.  To eliminate this race condition where bad data is=20
> > returned, I think that config read routines will need to have a=20
> > check *after* reading the data in addition to the check *before*=20
> > reading.  The check after reading would need to determine if the=20
> > data was synthesized and return and error status if so.
> >=20
> > I'm interested in hearing what others think on returning an error=20
> > for this case in the core config read APIs or any alternative ways=20
> > to more gracefully handle these types of errors.
>=20
> >=20
> > Thanks,
> > Austin
