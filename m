Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Wed, 1 Jun 2016 19:21:44 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160601172144.GB1947@al>
References: <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
 <20160530130909.GA1743@lahna.fi.intel.com>
 <20160530161351.GA1355@al>
 <20160531084356.GH1743@lahna.fi.intel.com>
 <20160531110231.GB1308@al>
 <20160601092847.GQ1743@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160601092847.GQ1743@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 01, 2016 at 12:28:47PM +0300, Mika Westerberg wrote:
> On Tue, May 31, 2016 at 01:02:31PM +0200, Peter Wu wrote:
> > On Tue, May 31, 2016 at 11:43:56AM +0300, Mika Westerberg wrote:
> > > On Mon, May 30, 2016 at 06:13:51PM +0200, Peter Wu wrote:
> > > > Do you have any suggestions for the case where the pcieport driver
> > > > refuses to put the bridge in D3 (because the BIOS is too old)? In that
> > > > case the nouveau driver needs to fallback to the DSM method (but not
> > > > when runtime PM is deliberately disabled by writing control=on).
> > > 
> > > Do you know what Windows does then? I think we should do the same if
> > > possible.
> > 
> > If the BIOS is too old, then it probably does not have _PR3 objects nor
> > calls to _OSI("Windows 2013"). See below.
> > 
> > > If user has disabled runtime PM from the root port deliberately, there
> > > might be good reason to do so. Why we want to fallback to something that
> > > could cause problems? I mean _DSM on such systems is probably not that
> > > much tested because everybody runs Windows 8+ and using standard ACPI
> > > power resources.
> > 
> > I agree that when runtime PM on the root port is disabled (control=on),
> > then there should be no fallback to DSM. For devices without _PR3 it is
> > clear that DSM will always be used (if available).
> > 
> > In other cases (where _PR3 is available) we can distinguish:
> >  - pre-Windows 8 machines. I have never seen this combination. Firmware
> >    writers seems to prefer sticking to reference code which did not use
> >    power resources before.
> >  - Machines targeting Windows 8 or newer. (Note that there exist
> >    machines with Windows 8 support that do not have _PR3, DSM is used in
> >    that case.)
> > 
> > If Windows 7 is running on a Windows 8 machine, PR3 will not be used
> > anyway. If the Linux kernel claims support for Windows 8, but does not
> > use PR3, then we are probably approaching an untested area. So far
> > firmware seems fine with using *only* DSM *or* PR3, but at least my
> > laptop gets confused when you use both at the same time.
> > 
> > The latter happens on pci/pm (8b71f565) without other patches:
> > 
> >  1. nouveau invokes _DSM and _PS3, device is put in D3cold.
> >  2. pcieport driver calls PG00._OFF (PG00 is returned by _PR3).
> >  3. Wake up Nvidia device (e.g. by power=on).
> >  4. This will trigger PG00._ON (via pcieport) and _PS0 (via nouveau).
> >  5. Nvidia card is not really ready (observed via "restoring config
> >     space at offset ... (was 0xffffffff, writing ...)", a soft lockup
> >     and RCU stall after that requiring a reboot to recover).
> > 
> > nouveau could be patched not to invoke DSM when PR3 is detected
> > (proposal is ready) but will keep the device powered on in these cases:
> >  - nouveau is patched, but pci/pm patches are not.
> >  - PR3 is supported but due to the cutoff date (2015) it is not used.
> >  - Boot option pcie_port_pm=off.
> >  - runtime PM is disabled for pcieport (should be fine).
> 
> Since using only _DSM has been the only method to power down the card
> currently inńLinux (even if the root port has had _PR3), and it has been
> working fine, why not stick with that when _DSM is supported?

Maybe it is not really working, people have been reporting memory
corruption[1] for example on certain Lenovo models that was gone after
hacking the bbswitch module to disable the root port:

https://bugs.freedesktop.org/show_bug.cgi?id=78530
https://github.com/Bumblebee-Project/bbswitch/issues/78
https://github.com/Bumblebee-Project/bbswitch/issues/115

I'll try to solicit some feedback from the affected people on these
patch series, whether it solves their memory corruption issue.

Dave also said "This fixes GPU auto powerdown on the Lenovo W541," when
he added PR3 support in https://patchwork.freedesktop.org/patch/76313/
So apparently it did not work with just DSM.

> In other words, something like this:
> 
> 	nouveau_dsm_pci_probe()
> 	{
> 		...
> 		if (retval & (NOUVEAU_DSM_HAS_OPT | NOUVEAU_DSM_HAS_MUX)) {
> 			/*
> 			 * We have custom _DSM method to power down the card so
> 			 * prevent the PCI core from transitioning the
> 			 * card into D3cold.
> 			 */
> 			pci_d3cold_disable(pdev);
> 		}
> 	}
> 
> (Not sure about those flags above, though).
> 
> Yes, it does not follow Windows 8+ but if it works... ;-)
> 
> > There is a wealth of acpidumps on Launchpad bug 752542
> > (https://bugs.launchpad.net/bugs/752542). Search for example for
> > comments in early 2015 or before, those will likely be machine from 2014
> > or before.
> > 
> > Interesting to see is the _PR3 method of a HP Envy TS 15 (11/20/2014):
> > 
> >     Method (_PR3, 0, NotSerialized) {
> >         If (\_OSI ("Windows 2013")) {
> >             Return (Package (0x01) {
> >                 \NVP3
> >             })
> >         } Else {
> >             Return (Package (0x00) {})
> >         }
> >     }
> > 
> > (Note for self: just checking for the _PR3 handle in the nouveau patch
> > is apparently not sufficient, it must really be evaluated.)
> > 
> > Other machines with _PR3:
> >  - Dell Inspiron 3543 (11/04/2014), comment 757.
> >  - Dell XPS 15 9530 (03/28/2014), comment 711.
> >  - Novatech 15.6 NSPIRE Laptop (01/20/2014), comment 695.
> >  - Lenovo ThinkPad T440p (10/27/2013), comment 659.
> > 
> > There were many models from 2013 without _PR3 method but still checking
> > for _OSI("Windows 2013"). Maybe some heuristics based on _PR3 would be
> > more helpful than just a cutoff date?
> 
> You mean for allowing bridge_d3? I don't think checking _PR3 helps us in
> any way. We can put PCIe port into D3hot just fine without any help from
> ACPI. Only thing that matters here is that we should be able to do that
> safely without causing problems to hardware which does not support it
> properly.

Currently bridge_d3 will always be false when pci_bridge_d3_possible
fails (that is, on BIOSes older than 2015). The idea is to add an
additional whitelist condition when _PR3 exists and _OSI("Windows 2013")
is requested in ACPI. This should help modern Nvidia Optimus laptops
which rely on ACPI to save power.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
