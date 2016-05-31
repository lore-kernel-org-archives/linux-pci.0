Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Tue, 31 May 2016 13:02:31 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160531110231.GB1308@al>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
 <20160530130909.GA1743@lahna.fi.intel.com>
 <20160530161351.GA1355@al>
 <20160531084356.GH1743@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160531084356.GH1743@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 31, 2016 at 11:43:56AM +0300, Mika Westerberg wrote:
> On Mon, May 30, 2016 at 06:13:51PM +0200, Peter Wu wrote:
> > Do you have any suggestions for the case where the pcieport driver
> > refuses to put the bridge in D3 (because the BIOS is too old)? In that
> > case the nouveau driver needs to fallback to the DSM method (but not
> > when runtime PM is deliberately disabled by writing control=on).
> 
> Do you know what Windows does then? I think we should do the same if
> possible.

If the BIOS is too old, then it probably does not have _PR3 objects nor
calls to _OSI("Windows 2013"). See below.

> If user has disabled runtime PM from the root port deliberately, there
> might be good reason to do so. Why we want to fallback to something that
> could cause problems? I mean _DSM on such systems is probably not that
> much tested because everybody runs Windows 8+ and using standard ACPI
> power resources.

I agree that when runtime PM on the root port is disabled (control=on),
then there should be no fallback to DSM. For devices without _PR3 it is
clear that DSM will always be used (if available).

In other cases (where _PR3 is available) we can distinguish:
 - pre-Windows 8 machines. I have never seen this combination. Firmware
   writers seems to prefer sticking to reference code which did not use
   power resources before.
 - Machines targeting Windows 8 or newer. (Note that there exist
   machines with Windows 8 support that do not have _PR3, DSM is used in
   that case.)

If Windows 7 is running on a Windows 8 machine, PR3 will not be used
anyway. If the Linux kernel claims support for Windows 8, but does not
use PR3, then we are probably approaching an untested area. So far
firmware seems fine with using *only* DSM *or* PR3, but at least my
laptop gets confused when you use both at the same time.

The latter happens on pci/pm (8b71f565) without other patches:

 1. nouveau invokes _DSM and _PS3, device is put in D3cold.
 2. pcieport driver calls PG00._OFF (PG00 is returned by _PR3).
 3. Wake up Nvidia device (e.g. by power=on).
 4. This will trigger PG00._ON (via pcieport) and _PS0 (via nouveau).
 5. Nvidia card is not really ready (observed via "restoring config
    space at offset ... (was 0xffffffff, writing ...)", a soft lockup
    and RCU stall after that requiring a reboot to recover).

nouveau could be patched not to invoke DSM when PR3 is detected
(proposal is ready) but will keep the device powered on in these cases:
 - nouveau is patched, but pci/pm patches are not.
 - PR3 is supported but due to the cutoff date (2015) it is not used.
 - Boot option pcie_port_pm=off.
 - runtime PM is disabled for pcieport (should be fine).


There is a wealth of acpidumps on Launchpad bug 752542
(https://bugs.launchpad.net/bugs/752542). Search for example for
comments in early 2015 or before, those will likely be machine from 2014
or before.

Interesting to see is the _PR3 method of a HP Envy TS 15 (11/20/2014):

    Method (_PR3, 0, NotSerialized) {
        If (\_OSI ("Windows 2013")) {
            Return (Package (0x01) {
                \NVP3
            })
        } Else {
            Return (Package (0x00) {})
        }
    }

(Note for self: just checking for the _PR3 handle in the nouveau patch
is apparently not sufficient, it must really be evaluated.)

Other machines with _PR3:
 - Dell Inspiron 3543 (11/04/2014), comment 757.
 - Dell XPS 15 9530 (03/28/2014), comment 711.
 - Novatech 15.6 NSPIRE Laptop (01/20/2014), comment 695.
 - Lenovo ThinkPad T440p (10/27/2013), comment 659.

There were many models from 2013 without _PR3 method but still checking
for _OSI("Windows 2013"). Maybe some heuristics based on _PR3 would be
more helpful than just a cutoff date?
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
