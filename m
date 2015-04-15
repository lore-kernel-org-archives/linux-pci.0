Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 15 Apr 2015 14:42:26 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tony Luck <tony.luck@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-acpi <linux-acpi@vger.kernel.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH v1 2/4] PCI: Mark invalid BARs as unassigned
Message-ID: <20150415194226.GA27352@google.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150312173533.1052.46464.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <CA+8MBbJv-RwX_RDzk85X_sHAHUG6cTsCAKd-_iE7wrdQ9wYKsQ@mail.gmail.com>
 <CAErSpo6PV7+cZKgDPBA7tDn4oyp_hONqJFegTFxVLz2KaTeK4A@mail.gmail.com>
 <CA+8MBbLnFQ2_zWniBFN6=kJMo-3PbBQvdsfPFV+zyApYpN6BQA@mail.gmail.com>
 <20150415144819.GD19151@google.com>
 <CA+8MBbJEf9gOyWq_Urw3T5s7jj2-2pHkuQRcn9X3TxSYYUK5ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+8MBbJEf9gOyWq_Urw3T5s7jj2-2pHkuQRcn9X3TxSYYUK5ZA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, Jiang]

On Wed, Apr 15, 2015 at 09:27:41AM -0700, Tony Luck wrote:
> > +       /* ACPI_RESOURCE_TYPE_IRQ etc. */
> > +       printk("host bridge resource %02d length %#02x\n", res->type,
> > +              res->length);
> > +       print_hex_dump(KERN_INFO, "  : ", DUMP_PREFIX_OFFSET, 16, 1,
> > +                      &res->data, res->length, 0);
> > +
> 
> Patch applied to the tree with the offending commit reverted. Serial
> log attached,

Thanks.  Your log shows several descriptors that we currently ignore
because their Producer/Consumer bits are set to "Consumer".   Here's one
that contains the MMIO area used by these igb and mptsas devices:

  host bridge resource 12 length 0x38       ACPI_RESOURCE_TYPE_ADDRESS32
    : 00000000: 00 01 00 01 01 01 00 00 00 00 00 00 00 00 00 00
    : 00000010: 00 00 00 a0 ff ff ff ef 00 00 00 00 00 00 00 50
    : 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    : 00000030: 0d 00 00 00 50 00 00 00
  [mem 0xa0000000-0xefffffff]

I think we're about to conclude that the Producer/Consumer bit is useless
and should be ignored.

Can you drop the previous debug patch and try this one?


diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 48cc65705db4..cd96ddc2bc6c 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -240,15 +240,12 @@ static acpi_status resource_to_window(struct acpi_resource *resource,
 	 * We're only interested in _CRS descriptors that are
 	 *	- address space descriptors for memory or I/O space
 	 *	- non-zero size
-	 *	- producers, i.e., the address space is routed downstream,
-	 *	  not consumed by the bridge itself
 	 */
 	status = acpi_resource_to_address64(resource, addr);
 	if (ACPI_SUCCESS(status) &&
 	    (addr->resource_type == ACPI_MEMORY_RANGE ||
 	     addr->resource_type == ACPI_IO_RANGE) &&
-	    addr->address.address_length &&
-	    addr->producer_consumer == ACPI_PRODUCER)
+	    addr->address.address_length)
 		return AE_OK;
 
 	return AE_ERROR;
@@ -276,6 +273,12 @@ static acpi_status add_window(struct acpi_resource *res, void *data)
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
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 5589a6e2a023..ae5534a6bce7 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -483,6 +483,11 @@ static acpi_status acpi_dev_process_resource(struct acpi_resource *ares,
 	struct resource *res = &win.res;
 	int i;
 
+	printk("process resource %02d length %#02x\n", ares->type,
+	       ares->length);
+	print_hex_dump(KERN_INFO, "  : ", DUMP_PREFIX_OFFSET, 16, 1,
+		       &ares->data, ares->length, 0);
+
 	if (c->preproc) {
 		int ret;
 
