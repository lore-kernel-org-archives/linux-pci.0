Return-Path: <SRS0=uEmv=YR=lekensteyn.nl=peter@kernel.org>
Return-Path: <SRS0=uEmv=YR=lekensteyn.nl=peter@kernel.org>
Date: Tue, 3 Jan 2017 16:15:47 +0100
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170103151547.GB9763@al>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170102121019.GA3353@lahna.fi.intel.com>
 <20170102144852.GE3353@lahna.fi.intel.com>
 <1731082.izJCnRoq0n@aspire.rjw.lan>
 <20170103095158.GH3353@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170103095158.GH3353@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

(replying to earlier comments in the thread:)

Changing (lowering?) the cut-off date would not help as the laptop has
DMI year 2016. (For the long-term, it would probably be desirable to
lower the date or otherwise add detection of _PR3, see
https://bugs.freedesktop.org/show_bug.cgi?id=98505#c23).

Reverting the patch is not a good idea either, it would reintroduce the
memory corruption that have plagued some Lenovo models
(https://bugs.freedesktop.org/show_bug.cgi?id=78530).

On Tue, Jan 03, 2017 at 11:51:58AM +0200, Mika Westerberg wrote:
> On Mon, Jan 02, 2017 at 10:31:07PM +0100, Rafael J. Wysocki wrote:
> > On Monday, January 02, 2017 04:48:52 PM Mika Westerberg wrote:
> > > On Mon, Jan 02, 2017 at 02:10:19PM +0200, Mika Westerberg wrote:
> > > > I've checked the acpidump of this machine and it does not seem to be a
> > > > traditional Optimus machine. At least this one is missing the magic _DSM
> > > > which is used to gather capabilities of the graphics device.
> > > > 
> > > > However, it does have _PR3 and it is attached to the device
> > > > (_SB.PCI0.PEG) itself, not the root port.
> > > 
> > > Nah, actually PEG is the root port. So it certainly looks like
> > > a traditional Optimus machine.
> > 
> > So can we quirk that thing somehow and see if that helps (for debugging
> > purposes at least)?
> 
> I was kind of hoping disabling D3cold would do that (prevent it from
> turning off power resources). But we can also just force it to use _DSM
> instead and see if it makes a difference.

Disabling d3cold that way might be too late due to the short RPM suspend
delay. You would need a udev rule to activate this ASAP. E.g., create
/etc/udev/rules.d/42-nvidia-rpm.rules with:

    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/d3cold_allowed}="0"

This disables D3cold on the child device (which should also prevent the
parent PCIe port from using D3cold).

Alternatively, can you try to boot with nouveau.runpm=0 and see if it
makes any difference? When runpm is disabled, then the PCIe port and
Nvidia device should not be suspended and therefore prevent the issue
from being triggered.

> I guess the reason why keyboard and mouse become unresponsive is because
> the driver tries to resume the device and hogs the CPU. At least it
> looks like so from the dmesg in comment 27 (of the bugzilla bug) where
> NMI watchdog is triggered.
> 
> Since this might be related to nouveau, adding Peter Wu to the loop.
> Peter the bug in question is https://bugzilla.kernel.org/show_bug.cgi?id=190861.

Kilian, in the bug you had the issue with Firefox. The trace suggests
that runtime resume was triggered, so you should have this problem too
when using lspci. Can you try:

 1. Switch to a text console (e.g. Ctrl-Alt-F2).
 2. sleep 5; lspci

If that command does not return immediately, you likely have triggered
the same issue.

The acpidump from the bug does not show known issues, it *looks* fine.
There have been other issues related to resuming power on newer Nvidia
hardware (https://bugs.freedesktop.org/show_bug.cgi?id=94725,
https://bugzilla.kernel.org/show_bug.cgi?id=156341) but there is not
much progress here.  (The last time I traced the PCIe register accesses
(via kprobes) and tried to disable some of those, it still did not help
with preventing the power issue.)

> Kilian, can you try the following hack as well?
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> index 193573d191e5..50482d5c8072 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> @@ -282,7 +282,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
>  			 (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
>  			 (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
>  
> -		*has_pr3 = nouveau_pr3_present(pdev);
> +//		*has_pr3 = nouveau_pr3_present(pdev);
>  	}
>  }
>  

This would not disable D3cold support and as a result both PR3 and DSM
would be active. Try the above with this line added to force DSM:

    pci_d3cold_disable(pdev);

(This should have the same effect as setting d3cold_allowed=0.)
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
