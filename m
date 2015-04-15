Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 15 Apr 2015 09:48:19 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tony Luck <tony.luck@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-acpi <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] PCI: Mark invalid BARs as unassigned
Message-ID: <20150415144819.GD19151@google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150312173533.1052.46464.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CA+8MBbJv-RwX_RDzk85X_sHAHUG6cTsCAKd-_iE7wrdQ9wYKsQ@mail.gmail.com>
 <CAErSpo6PV7+cZKgDPBA7tDn4oyp_hONqJFegTFxVLz2KaTeK4A@mail.gmail.com>
 <CA+8MBbLnFQ2_zWniBFN6=kJMo-3PbBQvdsfPFV+zyApYpN6BQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+8MBbLnFQ2_zWniBFN6=kJMo-3PbBQvdsfPFV+zyApYpN6BQA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 14, 2015 at 04:57:06PM -0700, Tony Luck wrote:
> On Tue, Apr 14, 2015 at 4:30 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > Thanks for the report, and sorry for breaking you.  I hate to ask for
> > more after all your work already, but would you mind collecting logs
> > with "ignore_loglevel"?  We only print the BAR information at
> > KERN_DEBUG, so it doesn't make it to the console unless you use
> > ignore_loglevel.
> >
> > I don't really see how the mptsas device at 83:00.0 worked before;
> > ACPI didn't tell us about any MMIO apertures in the PCI1 host bridge.
> > But I'll look closer.
> 
> Attached logs with ignore_loglevel

Thanks, Tony.  Can you try with the attached debug patch (old kernel or
new, it doesn't matter)?

We think the host bridge apertures are (note that we didn't find an
MMIO aperture):

  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])
  pci_bus 0000:80: root bus resource [io  0x9000-0xfffe]
  pci_bus 0000:80: root bus resource [bus 80-ff]

but BIOS set up MMIO windows on the bridges at 80:01.0 and 80:05.0,
and it assigned space for igb and mptsas BARs below those bridges:

  pci 0000:80:01.0: PCI bridge to [bus 81]
  pci 0000:80:01.0:   bridge window [mem 0xa0100000-0xa01fffff]
  pci 0000:81:00.0: reg 0x10: [mem 0xa0160000-0xa017ffff]
  pci 0000:81:00.1: reg 0x10: [mem 0xa0120000-0xa013ffff]

  pci 0000:80:05.0: PCI bridge to [bus 83]
  pci 0000:80:05.0:   bridge window [mem 0xa0000000-0xa00fffff]
  pci 0000:83:00.0: reg 0x14: [mem 0xa0010000-0xa0013fff 64bit]

Prior to c770cb4cb505, we complained about the PCI bridge windows not
being inside a host bridge window, but we enabled the igb and mptsas
devices anyway.  After c770cb4cb505, we don't enable them (you reported
that your disk is broken, and I think those two NICs are also broken).

I don't know whether the BIOS failed to tell us about the MMIO aperture,
or it did tell us and we parsed the _CRS info incorrectly.

Bjorn

diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 48cc65705db4..9e419c5a3d43 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -276,6 +276,12 @@ static acpi_status add_window(struct acpi_resource *res, void *data)
 	unsigned long flags, offset = 0;
 	struct resource *root;
 
+	/* ACPI_RESOURCE_TYPE_IRQ etc. */
+	printk("host bridge resource %02d length %#02x\n", res->type,
+	       res->length);
+	print_hex_dump(KERN_INFO, "  : ", DUMP_PREFIX_OFFSET, 16, 1,
+		       &res->data, res->length, 0);
+
 	/* Return AE_OK for non-window resources to keep scanning for more */
 	status = resource_to_window(res, &addr);
 	if (!ACPI_SUCCESS(status))
