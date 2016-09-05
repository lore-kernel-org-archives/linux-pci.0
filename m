Return-Path: <yu.c.chen@intel.com>
Return-Path: <yu.c.chen@intel.com>
Date: Mon, 5 Sep 2016 12:01:21 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC v3] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20160905040121.GA10008@sharon>
References: <1471595425-1752-1-git-send-email-yu.c.chen@intel.com>
 <20160824141731.GA23108@wunner.de>
 <20160902162527.GA10403@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902162527.GA10403@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 02, 2016 at 11:25:27AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 24, 2016 at 04:17:31PM +0200, Lukas Wunner wrote:
> > On Fri, Aug 19, 2016 at 04:30:25PM +0800, Chen Yu wrote:
> > > People reported that they can not do a poweroff nor a
> > > suspend to ram on their Mac Pro 11. After some investigations
> > > it was found that, once the PCI bridge 0000:00:1c.0 reassigns its
> > > mm windows to ([mem 0x7fa00000-0x7fbfffff] and
> > > [mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
> > > io resource 0x1804 becomes unaccessible immediately, where the
> > > ACPI Sleep register is located, as a result neither poweroff(S5)
> > > nor suspend to ram(S3) works.
> > 
> > To provide a bit more context:
> > 
> > The root port in question (0000:00:1c.0) is not listed in the DSDT.
> > On macOS, only devices present in the ACPI namespace are incorporated
> > into the I/O Kit registry. Consequently macOS pretends that this root
> > port doesn't exist. It's not listed in the "ioreg -l" output and thus
> > no driver is attached to this device.
> > 
> > So what we're dealing with is sloppiness on the part of Apple:
> > Some engineer probably forgot to disable this unused root port
> > and they didn't notice it during testing because their OS ignores
> > such devices.
> > 
> > We could in principle achieve the same behaviour by adding a PCI
> > device only if it has an ACPI companion, perhaps quirk this only
> > to Macs. I'm not sure if that's the right thing to do though.
> > What if they hide devices from macOS but we want to access them
> > on Linux?
> > 
> > What's really odd is that changing *memory* windows affects
> > accessibility of *I/O ports*.
> > 
> > One theory would be that I/O ports are somehow mapped into memory.
> > The GPIO pins of Intel chipsets are usually accessible through
> > I/O ports, but I've recently looked at the DSDT of the newest
> > MacBook9,1 (2016) and it looks like they're now accessed through
> > SystemMemory instead of SystemIO. Perhaps someone at Intel knows
> > about these intricacies of their chipsets.
> 
> Hey, look, Chen Yu works at Intel :)
>
Ah yes, please give me some time and I'll try to search for related info
and give feeback later.
> This apparent connection between memory windows and I/O port
> accessibility is indeed very concerning.
> 
> I know there are PCI host bridges with windows that translate CPU
> memory accesses into PCI I/O port accesses.  If this is one of them,
> and it has such a window enabled at the address we happened to choose
> for the mem window, that would be a problem.
> 
> I assume this would be documented somewhere in the chipset datasheet.
> 
> > If I/O ports are indeed mapped into memory, we need to find a way
> > to identify and reserve that region. So while this patch seems
> > like a workable and sufficiently small fix, it might mask a larger
> > underlying issue. It's certainly a problem though that these
> > machines currently cannot power off or suspend.
> > 
> > FWIW, we have a somewhat similar issue with the Apple gmux
> > (a microcontroller built into dual GPU MacBook Pros). That chip
> > is attached to the LPC bus and accessed through I/O ports.
> > It turns out that once VGA IO is locked to the discrete GPU
> > using vgaarb, gmux' I/O ports suddenly become inaccessible.
> > Apparently its I/O ports are routed to the secondary PCI bus
> > to which the discrete GPU is connected, and no longer to the
> > root bus on which the LPC bridge resides. However gmux' I/O ports
> > are in the 0x700-0x7ff range, whereas the VGA registers are in
> > the 0x3b0-0x3bb and 0x3c0-0x3df range. So that's another oddity
> > of Intel chipsets with regards to I/O accessibility.
> > 
