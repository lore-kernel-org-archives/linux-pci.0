Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 9 Jun 2016 11:50:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH][RFC] PCI: Workaround to enable poweroff on Mac Pro 11
Message-ID: <20160609165011.GA1109@localhost>
References: <1464604404-11257-1-git-send-email-yu.c.chen@intel.com>
 <20160530213305.GA21322@localhost>
 <574D03F9.6050201@intel.com>
 <CAE9FiQV_Mc9VuyBvCB7hL_0pgj+-wW1_jupzhbTHij+VQeLF-A@mail.gmail.com>
 <574D3AAA.6090503@intel.com>
 <20160531131658.GA23837@localhost>
 <57579F9F.6010200@intel.com>
 <20160608124742.GA16764@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160608124742.GA16764@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 08, 2016 at 07:47:42AM -0500, Bjorn Helgaas wrote:
> On Wed, Jun 08, 2016 at 12:31:27PM +0800, Chen Yu wrote:
> > Hi Bjorn,
> > 
> > On 2016年05月31日 21:16, Bjorn Helgaas wrote:
> > >On Tue, May 31, 2016 at 03:18:02PM +0800, Chen Yu wrote:
> > >>On 2016年05月31日 15:00, Yinghai Lu wrote:
> > >>>On Mon, May 30, 2016 at 8:24 PM, Chen Yu <yu.c.chen@intel.com> wrote:
> > >>>
> > >>>>and then in pcibios_assign_resources, 0000:00:1c.0 tries to allocate minimal
> > >>>>resource window and then update related base/limit registers:
> > >>>>
> > >>>>[    0.865342] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus
> > >>>>02] add_size 1000
> > >>>>[    0.865343] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff
> > >>>>64bit pref] to [bus 02] add_size 200000 add_align 100000
> > >>>>[    0.865344] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff]
> > >>>>to [bus 02] add_size 200000 add_align 100000
> > >>>>
> > >>>That is for hotplug bridge, then we could use following instead.
> > >>>
> > >>>diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > >>>index ee72ebe..d3ec833 100644
> > >>>--- a/drivers/pci/quirks.c
> > >>>+++ b/drivers/pci/quirks.c
> > >>>@@ -2775,6 +2775,13 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
> > >>>
> > >>>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
> > >>>
> > >>>+static void quirk_hotplug_bridge_skip(struct pci_dev *dev)
> > >>>+{
> > >>>+       dev->is_hotplug_bridge = 0;
> > >>>+}
> > >>>+
> > >>>+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10,
> > >>>quirk_hotplug_bridge_skip);
> > >>>+
> > >>>  /*
> > >>>   * This is a quirk for the Ricoh MMC controller found as a part of
> > >>>   * some mulifunction chips.
> > >>Good idea, but in this way we might not have io window allocated for
> > >>it?I'm not sure
> > >>if this would break wifi,etc, I'll suggest reporters to have a try.
> > >Let's figure out the root cause before trying more random fixes.  I
> > >have the same objection to the patch above.  No doubt there are many
> > >ways we could "fix" this, but unless we know the root cause, we're
> > >likely to make a change that's not a complete fix or will cause other
> > >issues in the future.
> > >
> > I just let the reporter  paste their lspci in Mac OS, it looks that
> > Mac OS also
> > does not allocate any resource for this broken pci bridge, and other pci
> > devices have almost the same resource region as it is in linux, so I think
> > this is an evidence that Apple does not want to use this firmware for now,
> > maybe reserved for future use, declaim resource for this pci bridge might
> > cause unpredictable result, how about adding a dmi+pci quirk for this
> > special platform?
> 
> This is not a root cause.  We still have no idea why the problem
> occurs.  I do not think a quirk is a good idea until we know what the
> problem is and exactly how a quirk would fix it.
> 
> > lspci result from Mac OS, there's no resource behind this bridge:
> > https://bugzilla.kernel.org/attachment.cgi?id=219321

Here are some ideas for debugging this:

1) Apparently the problem is sensitive to programming the prefetchable
   memory aperture of 00:1c.0 to [mem 0x7fc00000-0x7fdfffff 64bit
   pref].  The only effect of that *should* be that the bridge will
   now claim accesses in the aperture, when it didn't before.

   We *think* there's nothing else at the address of that aperture,
   but if there is an unreported device there, it may stop working.  I
   would pore over the E820 memory map, EFI memory map, all ACPI _CRS
   methods, etc., looking for anything in that area that we haven't
   accounted for.

   There are lots of anomalies in this system, e.g., (these are from
   Bastien's dmesg log at
   https://bugzilla.kernel.org/attachment.cgi?id=208961)

     BIOS-e820: [mem 0x00000000e00f8000-0x00000000e00f8fff] reserved
     PCI: MMCONFIG for domain 0000 [bus 00-9b] at [mem 0xe0000000-0xe9bfffff] (base 0xe0000000)
     acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-9b] only partially covers this bridge
     pci_bus 0000:00: root bus resource [mem 0x7fa00000-0xfeafffff window]
     system 00:04: [mem 0xe0000000-0xefffffff] could not be reserved
     ACPI Warning: SystemIO range 0x000000000000EFA0-0x000000000000EFBF conflicts with OpRegion 0x000000000000EFA0-0x000000000000EFAF (\_SB.PCI0.SBUS.SMBI)

   The MMCONFIG area appears correctly described in the 00:04 _CRS,
   but incorrectly in MCFG.  The E820 region appears to be a chunk in
   the middle of the MMCONFIG area.  The host bridge window 
   [mem 0x7fa00000-0xfeafffff window] is clearly bogus -- it includes
   the MMCONFIG area, which is definitely not a window.  I doubt
   anything above 0xdfffffff should be included.

   I don't know what the ACPI conflict warning is about, but I'd try
   to figure it out.

   Either the firmware is badly broken, or we're not interpreting
   something correctly.

   I'd try assigning the 00:1c.0 aperture at the end of the actual
   aperture instead of the beginning.  I think Windows, and likely
   MacOS uses a top-down allocation strategy instead of bottom-up like
   Linux does.  If that makes poweroff work, there is likely an
   unreported device in the [mem 0x7fc00000-0x7fdfffff 64bit pref]
   area.

   This experimentation could all be done with setpci, without
   requiring kernel patches.

2) I would explore exactly what the grub "halt" command does and how
   it compares to what Linux is doing.  I see the assertion that this
   is related to [io 0x1804], but I don't know what that's based on.
   Programming the 00:1c.0 prefetchable aperture shouldn't have
   anything to do with I/O ports, so if it really is related, there
   might be some SMM magic or something where SMM code is doing
   something that relates to the memory aperture.

3) The lspci output at https://bugzilla.kernel.org/attachment.cgi?id=219321
   (I think this is from MacOS) shows invalid data for devices
   starting at 04:00.0.  Why?  Maybe this is an unrelated artifact,
   but it doesn't smell right.

4) If you can hot-add devices under MacOS, look to see what address
   space they get assigned.  That may tell you what allocation
   strategy MacOS uses.

5) 00:1c.0 claims to have a slot that supports hotplug.  Is that
   actually true?  Could you add a device below it?  If not, maybe the
   problem is that the BIOS should have configured 00:1c.0 so it
   doesn't report a slot.  If it didn't report a slot, we shouldn't
   assign resources to it, since there is no possibility of a device
   below it.

Bjorn
