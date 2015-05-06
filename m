Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFSKS=M8bODT8bLckwtGFziknPG=32Y1=8mz3Fq0H7JcA3GhjQ@mail.gmail.com>
References: <CAFSKS=M8bODT8bLckwtGFziknPG=32Y1=8mz3Fq0H7JcA3GhjQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 May 2015 10:51:39 -0500
Message-ID: <CAErSpo4YEUTyrFth3xVyeja0=cbk69+tSQgsOFCO5nvFK=suhw@mail.gmail.com>
Subject: Re: I/O conflict on Versalogic Tiger (VL-EPM-24)
To: George McCollister <george.mccollister@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rafael Wysocki <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Wed, May 6, 2015 at 9:47 AM, George McCollister
<george.mccollister@gmail.com> wrote:
> We're using Versalogic Tiger (VL-EPM-24) SBCs in embedded systems
> running linux 3.2.x without any problems. Recently, when testing the
> latest mainline kernel I found the system hard locked during boot.
>
> After some investigation I noticed that the kernel print time stamps
> were bogus after one of the pcieports was enabled:
> [    1.658879] io scheduler cfq registered (default)
> [    1.663905] pcieport 0000:00:1c.0: enabling device (0004 -> 0007)
> [    6.254134] Serial: 8250/16550 driver, 21 ports, IRQ sharing enabled
> [    6.254134] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
> is a 16550A
> [    6.254134] 00:04: ttyS1 at I/O 0x2f8 (irq = 0, base_baud = 115200)
> is a 16550A
> [    6.254134] 00:05: ttyS2 at I/O 0x3e8 (irq = 0, base_baud = 115200)
> is a 16550A
> [    6.254134] 00:06: ttyS4 at I/O 0x238 (irq = 0, base_baud = 115200)
> is a 16550A
>
> I was surprised to find that the problem existed as far back as 3.11.
> I checked to make sure we were using the latest BIOS and contacted the
> vendor to see if they were aware of anyone else using recent versions
> of the linux kernel. They stated that they were unaware of anyone
> using recent kernel versions on this board and tired to convince me to
> stick with an old version.
>
> I then git bisected to this commit:
> ac212b6980d8d5eda705864fc5a8ecddc6d6eacc ACPI / processor: Use common
> hotplug infrastructure
>
> After diffing the kernel output before and after this commit I noticed
> that the I/O BAR assigned to the pcieport (same one as above) changed
> from 0x1000 to 0x2000.
>
> @@ -191,13 +191,13 @@
> Switching to clocksource acpi_pm
> pci 0000:00:1c.0: BAR 9: assigned [mem 0x80000000-0x801fffff pref]
> pci 0000:00:1c.1: BAR 9: assigned [mem 0x80200000-0x803fffff pref]
> -pci 0000:00:1c.0: BAR 7: assigned [io  0x1000-0x1fff]
> +pci 0000:00:1c.0: BAR 7: assigned [io  0x2000-0x2fff]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0xdff00000-0xdfffffff]
> pci 0000:01:00.0: PCI bridge to [bus 02-03]
> pci 0000:01:00.0:   bridge window [mem 0xdff00000-0xdfffffff]
> pci 0000:00:1c.0: PCI bridge to [bus 01-03]
> -pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> +pci 0000:00:1c.0:   bridge window [io  0x2000-0x2fff]
> pci 0000:00:1c.0:   bridge window [mem 0xdff00000-0xdfffffff]
> pci 0000:00:1c.0:   bridge window [mem 0x80000000-0x801fffff pref]
> pci 0000:00:1c.1: PCI bridge to [bus 04]
>
> I also noticed the kernel output 'ACPI: PM-Timer IO Port: 0x2008' and
> made the connection that since acpi_pm was being used as the
> clocksource and since the problems started when the BAR switched from
> 0x1000 to 0x2000 an I/O conflict must be the source of the problems.
>
> I did some reading into ACPI (since my understanding of it was novice
> at the time) and dumped the DSDT. I found no reference to anything in
> the 0x2xxx I/O range though I did find the following in the FADT:
> PM1a_EVT_BLK at 0x2000-0x2003
> PM1a_CNT_BLK at 0x2004-0x2005
> PM_TMR at 0x2008-0x200b
>
> I dumped the DSDT on other systems and found that some used PNP0C02 to
> reserve I/O ranges used by the ACPI PM registers.
>
> I added the following to the Versalogic Tiger dsdt.dsl under the PCI
> bus, compiled it and and compiled into the linux kernel:
>             Device (PMIO)
>             {
>                 Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard
> Resources */)  // _HID: Hardware ID
>                 Name (_UID, 0x09)  // _UID: Unique ID
>                 Method (_CRS, 0, NotSerialized)  // _CRS: Current
> Resource Settings
>                 {
>                     Name (BUF0, ResourceTemplate ()
>                     {
>                         IO (Decode16,
>                             0x2000,            // Range Minimum
>                             0x2000,            // Range Maximum
>                             0x01,              // Alignment
>                             0xC,               // Length
>                         )
>                         IO (Decode16,
>                             0x20C0,            // Range Minimum
>                             0x20C0,            // Range Maximum
>                             0x01,              // Alignment
>                             0x8,               // Length
>                         )
>                     })
>                     Return (BUF0)
>                 }
>             }
>
> It booted just fine! (comment welcome on whether or not this looks
> like the correct fix)
>
> Unfortunately even if I get the vendor to release a new BIOS with the
> DSDT modifications, rolling out BIOS updates to thousands of systems
> in the field will be nearly impossible. When we roll out a new kernel
> to the production systems we'll need it to work with the existing
> BIOS.
>
> I've been searching around the linux kernel for a way to apply a quirk
> specific to this board.
> I've found I can do something like the following and match the Poulsbo
> Host bridge and that it'll fix the problem but I don't see a decent
> way of restricting it to this board.
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 85f247e..1f16dbf 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -413,6 +413,17 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
> DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,
> PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
>
> /*
> + * Versa Logic Tiger
> + */
> +static void quirk_versa_logic_tiger(struct pci_dev *dev)
> +{
> +       dev_info(&dev->dev, "Versalogic Tiger, reserving I/O ports\n");
> +       request_region(0x2000, 0x0C, "Versalogic Tiger");
> +       request_region(0x20C0, 0x08, "Versalogic Tiger");
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x8100, quirk_versa_logic_tiger);
> +
> +/*
>
> Any suggestions on what could be done to get a fix for this board
> mainlined into the kernel? Should I give up hope and just apply a cute
> embedded non-sense hack?

I think your DSDT tweak is on the right track.  We have some similar
things in drivers/pnp/quirks.c.  Possibly a new region could be added
to an existing PNP0C02 device, maybe via dmi_check_system() to limit
it to this platform.

But I notice that board claims Windows compatibility, so I wonder if
there's a smarter way.  I doubt that Windows would have a quirk for
this specific board, so we should be able to make Linux work without a
quirk, too.

Complete dmesg logs from pre- and post-ac212b6980d8 might have a clue
about what changed.  It looks like your FADT should be enough to
reserve those regions via acpi_reserve_resources().  But maybe there's
something wrong there, or maybe we incorrectly use that for PCI space.
Does  your post-ac212b6980d8 /proc/ioports show those regions?

Bjorn
