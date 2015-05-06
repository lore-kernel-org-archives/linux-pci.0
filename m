Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61479 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751369AbbEFVs6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 17:48:58 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: George McCollister <george.mccollister@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: I/O conflict on Versalogic Tiger (VL-EPM-24)
Date: Thu, 07 May 2015 00:14:01 +0200
Message-ID: <16669466.MatE2KDcHs@vostro.rjw.lan>
In-Reply-To: <CAFSKS=NbDdmr+khTTTPRRdj_wen4c5LR0X2AShO-ARE0yWGg1g@mail.gmail.com>
References: <CAFSKS=M8bODT8bLckwtGFziknPG=32Y1=8mz3Fq0H7JcA3GhjQ@mail.gmail.com> <CAErSpo4YEUTyrFth3xVyeja0=cbk69+tSQgsOFCO5nvFK=suhw@mail.gmail.com> <CAFSKS=NbDdmr+khTTTPRRdj_wen4c5LR0X2AShO-ARE0yWGg1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, May 06, 2015 02:15:15 PM George McCollister wrote:
> On Wed, May 6, 2015 at 10:51 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > [+cc Rafael]
> >
> > On Wed, May 6, 2015 at 9:47 AM, George McCollister
> > <george.mccollister@gmail.com> wrote:
> >> We're using Versalogic Tiger (VL-EPM-24) SBCs in embedded systems
> >> running linux 3.2.x without any problems. Recently, when testing the
> >> latest mainline kernel I found the system hard locked during boot.
> >>
> >> After some investigation I noticed that the kernel print time stamps
> >> were bogus after one of the pcieports was enabled:
> >> [    1.658879] io scheduler cfq registered (default)
> >> [    1.663905] pcieport 0000:00:1c.0: enabling device (0004 -> 0007)
> >> [    6.254134] Serial: 8250/16550 driver, 21 ports, IRQ sharing enabled
> >> [    6.254134] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
> >> is a 16550A
> >> [    6.254134] 00:04: ttyS1 at I/O 0x2f8 (irq = 0, base_baud = 115200)
> >> is a 16550A
> >> [    6.254134] 00:05: ttyS2 at I/O 0x3e8 (irq = 0, base_baud = 115200)
> >> is a 16550A
> >> [    6.254134] 00:06: ttyS4 at I/O 0x238 (irq = 0, base_baud = 115200)
> >> is a 16550A
> >>
> >> I was surprised to find that the problem existed as far back as 3.11.
> >> I checked to make sure we were using the latest BIOS and contacted the
> >> vendor to see if they were aware of anyone else using recent versions
> >> of the linux kernel. They stated that they were unaware of anyone
> >> using recent kernel versions on this board and tired to convince me to
> >> stick with an old version.
> >>
> >> I then git bisected to this commit:
> >> ac212b6980d8d5eda705864fc5a8ecddc6d6eacc ACPI / processor: Use common
> >> hotplug infrastructure
> >>
> >> After diffing the kernel output before and after this commit I noticed
> >> that the I/O BAR assigned to the pcieport (same one as above) changed
> >> from 0x1000 to 0x2000.
> >>
> >> @@ -191,13 +191,13 @@
> >> Switching to clocksource acpi_pm
> >> pci 0000:00:1c.0: BAR 9: assigned [mem 0x80000000-0x801fffff pref]
> >> pci 0000:00:1c.1: BAR 9: assigned [mem 0x80200000-0x803fffff pref]
> >> -pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
> >> +pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
> >> pci 0000:02:01.0: PCI bridge to [bus 03]
> >> pci 0000:02:01.0:   bridge window [mem 0xdff00000-0xdfffffff]
> >> pci 0000:01:00.0: PCI bridge to [bus 02-03]
> >> pci 0000:01:00.0:   bridge window [mem 0xdff00000-0xdfffffff]
> >> pci 0000:00:1c.0: PCI bridge to [bus 01-03]
> >> -pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> >> +pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> >> pci 0000:00:1c.0:   bridge window [mem 0xdff00000-0xdfffffff]
> >> pci 0000:00:1c.0:   bridge window [mem 0x80000000-0x801fffff pref]
> >> pci 0000:00:1c.1: PCI bridge to [bus 04]
> >>
> >> I also noticed the kernel output 'ACPI: PM-Timer IO Port: 0x2008' and
> >> made the connection that since acpi_pm was being used as the
> >> clocksource and since the problems started when the BAR switched from
> >> 0x1000 to 0x2000 an I/O conflict must be the source of the problems.
> >>
> >> I did some reading into ACPI (since my understanding of it was novice
> >> at the time) and dumped the DSDT. I found no reference to anything in
> >> the 0x2xxx I/O range though I did find the following in the FADT:
> >> PM1a_EVT_BLK at 0x2000-0x2003
> >> PM1a_CNT_BLK at 0x2004-0x2005
> >> PM_TMR at 0x2008-0x200b
> >>
> >> I dumped the DSDT on other systems and found that some used PNP0C02 to
> >> reserve I/O ranges used by the ACPI PM registers.
> >>
> >> I added the following to the Versalogic Tiger dsdt.dsl under the PCI
> >> bus, compiled it and and compiled into the linux kernel:
> >>             Device (PMIO)
> >>             {
> >>                 Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard
> >> Resources */)  // _HID: Hardware ID
> >>                 Name (_UID, 0x09)  // _UID: Unique ID
> >>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current
> >> Resource Settings
> >>                 {
> >>                     Name (BUF0, ResourceTemplate ()
> >>                     {
> >>                         IO (Decode16,
> >>                             0x2000,            // Range Minimum
> >>                             0x2000,            // Range Maximum
> >>                             0x01,              // Alignment
> >>                             0xC,               // Length
> >>                         )
> >>                         IO (Decode16,
> >>                             0x20C0,            // Range Minimum
> >>                             0x20C0,            // Range Maximum
> >>                             0x01,              // Alignment
> >>                             0x8,               // Length
> >>                         )
> >>                     })
> >>                     Return (BUF0)
> >>                 }
> >>             }
> >>
> >> It booted just fine! (comment welcome on whether or not this looks
> >> like the correct fix)
> >>
> >> Unfortunately even if I get the vendor to release a new BIOS with the
> >> DSDT modifications, rolling out BIOS updates to thousands of systems
> >> in the field will be nearly impossible. When we roll out a new kernel
> >> to the production systems we'll need it to work with the existing
> >> BIOS.
> >>
> >> I've been searching around the linux kernel for a way to apply a quirk
> >> specific to this board.
> >> I've found I can do something like the following and match the Poulsbo
> >> Host bridge and that it'll fix the problem but I don't see a decent
> >> way of restricting it to this board.
> >>
> >> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >> index 85f247e..1f16dbf 100644
> >> --- a/drivers/pci/quirks.c
> >> +++ b/drivers/pci/quirks.c
> >> @@ -413,6 +413,17 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
> >> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> >> PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
> >>
> >> /*
> >> + * Versa Logic Tiger
> >> + */
> >> +static void quirk_versa_logic_tiger(struct pci_dev *dev)
> >> +{
> >> +       dev_info(&dev->dev, "Versalogic Tiger, reserving I/O ports\n");
> >> +       request_region(0x2000, 0x0C, "Versalogic Tiger");
> >> +       request_region(0x20C0, 0x08, "Versalogic Tiger");
> >> +}
> >> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x8100, quirk_versa_logic_tiger);
> >> +
> >> +/*
> >>
> >> Any suggestions on what could be done to get a fix for this board
> >> mainlined into the kernel? Should I give up hope and just apply a cute
> >> embedded non-sense hack?
> >
> > I think your DSDT tweak is on the right track.  We have some similar
> > things in drivers/pnp/quirks.c.  Possibly a new region could be added
> > to an existing PNP0C02 device, maybe via dmi_check_system() to limit
> > it to this platform.
> >
> > But I notice that board claims Windows compatibility, so I wonder if
> > there's a smarter way.  I doubt that Windows would have a quirk for
> > this specific board, so we should be able to make Linux work without a
> > quirk, too.
>
> Maybe it works by accident, linux worked too until 0x2000 started
> getting used for the I/O window. Though I'm not sure why it changed
> just by looking at the commit.
>

The commit change the initialization ordering, especially if the ACPI processor
driver is modular in your kernel.  Before it would register the processors on
the module load and after the commit in question is registers them before
enumerating the PCI bus.

> > Complete dmesg logs from pre- and post-ac212b6980d8 might have a clue
> > about what changed.  It looks like your FADT should be enough to
> > reserve those regions via acpi_reserve_resources().  But maybe there's
> > something wrong there, or maybe we incorrectly use that for PCI space.
> > Does  your post-ac212b6980d8 /proc/ioports show those regions?
> I've attached the the last good and first bad dmesg logs.
> acpi_reserve_resources() doesn't do any good (at least in 4.1rc2)
> because it's called after pcieport has already enabled the device and
> put the i/o window into use.
> I wasn't able to get ac212b6980d8 to boot without making DSDT or
> quirks.c changes but I was able to get 4.1rc2 to boot by disabling
> PCIEPORTBUS which keeps 0000:00:1c.0 from being enabled. I've attached
> the ioports information. It looks like ACPI PM1a_EVT_BLK, ACPI
> PM1a_CNT_BLK and ACPI PM_TMR show up at 2000-2003, 2004-2005 and
> 2008-200b respectively but instead of conflicting with the PCI-bridge
> window they show up underneath it.
> 
> I think the key here is that the region needs to be requested before
> bridge window is assigned.

That's correct, so things don't happen in the right order now.

Well, acpi_reserve_resources() is a device_initcall(), so its ordering with
respect to other things is somewhat random.

Does the patch below make any difference by any chance?


---
 drivers/acpi/osl.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -182,7 +182,7 @@ static void __init acpi_request_region (
 		request_mem_region(addr, length, desc);
 }
 
-static int __init acpi_reserve_resources(void)
+static void __init acpi_reserve_resources(void)
 {
 	acpi_request_region(&acpi_gbl_FADT.xpm1a_event_block, acpi_gbl_FADT.pm1_event_length,
 		"ACPI PM1a_EVT_BLK");
@@ -211,10 +211,7 @@ static int __init acpi_reserve_resources
 	if (!(acpi_gbl_FADT.gpe1_block_length & 0x1))
 		acpi_request_region(&acpi_gbl_FADT.xgpe1_block,
 			       acpi_gbl_FADT.gpe1_block_length, "ACPI GPE1_BLK");
-
-	return 0;
 }
-device_initcall(acpi_reserve_resources);
 
 void acpi_os_printf(const char *fmt, ...)
 {
@@ -1845,6 +1842,7 @@ acpi_status __init acpi_os_initialize(vo
 
 acpi_status __init acpi_os_initialize1(void)
 {
+	acpi_reserve_resources();
 	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
 	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 1);
 	kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);

