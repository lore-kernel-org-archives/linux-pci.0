Return-Path: <SRS0=e5yU=YR=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=e5yU=YR=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 3 Jan 2017 11:51:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lukas Wunner <lukas@wunner.de>,
	Kilian Singer <kilian.singer@quantumtechnology.info>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170103095158.GH3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <20170102121019.GA3353@lahna.fi.intel.com>
 <20170102144852.GE3353@lahna.fi.intel.com>
 <1731082.izJCnRoq0n@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1731082.izJCnRoq0n@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 02, 2017 at 10:31:07PM +0100, Rafael J. Wysocki wrote:
> On Monday, January 02, 2017 04:48:52 PM Mika Westerberg wrote:
> > On Mon, Jan 02, 2017 at 02:10:19PM +0200, Mika Westerberg wrote:
> > > I've checked the acpidump of this machine and it does not seem to be a
> > > traditional Optimus machine. At least this one is missing the magic _DSM
> > > which is used to gather capabilities of the graphics device.
> > > 
> > > However, it does have _PR3 and it is attached to the device
> > > (_SB.PCI0.PEG) itself, not the root port.
> > 
> > Nah, actually PEG is the root port. So it certainly looks like
> > a traditional Optimus machine.
> 
> So can we quirk that thing somehow and see if that helps (for debugging
> purposes at least)?

I was kind of hoping disabling D3cold would do that (prevent it from
turning off power resources). But we can also just force it to use _DSM
instead and see if it makes a difference.

I guess the reason why keyboard and mouse become unresponsive is because
the driver tries to resume the device and hogs the CPU. At least it
looks like so from the dmesg in comment 27 (of the bugzilla bug) where
NMI watchdog is triggered.

Since this might be related to nouveau, adding Peter Wu to the loop.
Peter the bug in question is https://bugzilla.kernel.org/show_bug.cgi?id=190861.

Kilian, can you try the following hack as well?

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 193573d191e5..50482d5c8072 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -282,7 +282,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 			 (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
 			 (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
 
-		*has_pr3 = nouveau_pr3_present(pdev);
+//		*has_pr3 = nouveau_pr3_present(pdev);
 	}
 }
 
