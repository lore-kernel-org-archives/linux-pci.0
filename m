Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Jun 2016 08:17:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V8 7/9] acpi: Add generic MCFG table handling
Message-ID: <20160608131709.GB16764@localhost>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-8-git-send-email-tn@semihalf.com>
 <20160608015631.GE4759@localhost> <57580DCA.7000703@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <57580DCA.7000703@semihalf.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com,
 okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org,
 Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org,
 ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
 robert.richter@caviumnetworks.com, liudongdong3@huawei.com,
 catalin.marinas@arm.com, Liviu.Dudau@arm.com, arnd@arndb.de, jcm@redhat.com,
 msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com,
 linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com, dhdang@apm.com,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org,
 Suravee.Suthikulpanit@amd.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 08, 2016 at 02:21:30PM +0200, Tomasz Nowicki wrote:
> On 08.06.2016 03:56, Bjorn Helgaas wrote:
> >On Mon, May 30, 2016 at 05:14:20PM +0200, Tomasz Nowicki wrote:
> >>In order to handle PCI config space regions properly in ACPI, new MCFG
> >>interface is defined which does sanity checks on MCFG table and keeps its
> >>root pointer. The user is able to lookup MCFG regions based on
> >>host bridge root structure and domain:bus_start:bus_end touple.
> >>Use pci_mmcfg_late_init old prototype to avoid another function name.

> >>+	/* found matching entry, bus range check */
> >>+	if (entry->end_bus_number != bus_res->end) {
> >>+		resource_size_t bus_end = min_t(resource_size_t,
> >>+					entry->end_bus_number, bus_res->end);
> >>+		pr_warn("%04x:%pR bus end mismatch, using %02lx\n",
> >>+			root->segment, bus_res, (unsigned long)bus_end);
> >>+		bus_res->end = bus_end;
> >>+	}
> 
> What about bus end mismatch case? Should we trim the host bridge bus
> range or expect MCFG entry covers that range? Sometimes we get
> _BBN-0xFF bus range, not from _CRS.

Lack of a bus range in _CRS is a firmware defect.  There's a comment
about this in acpi_pci_root_add().  On x86, we probably had to live
with firmware in the field that had this defect.  I think we should
expect all ARM64 systems to provide a bus number range in _CRS, and
fail the attach if it's not there.

I don't think we should warn about an MCFG entry that covers more than
the _CRS bus range.  On x86, it's common to have something like:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7f])
  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-ff])

with a single MCFG entry that covers [bus 00-ff].  That seems
reasonable and I don't think it's worth warning about it.

If the MCFG entry doesn't cover all of a _CRS bus range, we should
just fail so we can find and fix broken firmware.

> >>+/* Interface called by ACPI - parse and save MCFG table */
> >
> >I think we save a *pointer* to the MCFG table, not the table itself.
> 
> Right, the comment is broken.
> 
> >And acpi_table_parse() calls early_acpi_os_unmap_memory() immediately
> >after it calls pci_mcfg_parse(), so I'm doubtful that the pointer
> >remains valid.
> 
> At this stage early_acpi_os_unmap_memory() is doing nothing since
> acpi_early_init() set acpi_gbl_permanent_mmap to 1 way before. The
> pointer is fine then.

Hmmm...  I see your argument, but this is a problem waiting to happen.
We should not depend on the internal implementation of
early_acpi_os_unmap_memory().  The pattern of:

  y = x;
  unmap(x);
  z = *y;

is just broken and we shouldn't expect readers to recognize that "oh,
unmap() isn't really unmapping anything in this special case, so this
looks wrong but is really fine."

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
