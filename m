Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 8 Jun 2016 08:22:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V8 5/9] pci, acpi: add acpi hook to assign domain number.
Message-ID: <20160608132250.GC16764@localhost>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-6-git-send-email-tn@semihalf.com>
 <20160608001559.GD4759@localhost> <5757F19F.6020200@semihalf.com>
MIME-Version: 1.0
In-Reply-To: <5757F19F.6020200@semihalf.com>
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

On Wed, Jun 08, 2016 at 12:21:19PM +0200, Tomasz Nowicki wrote:
> On 08.06.2016 02:15, Bjorn Helgaas wrote:
> >On Mon, May 30, 2016 at 05:14:18PM +0200, Tomasz Nowicki wrote:
> >>PCI core code provides a config option (CONFIG_PCI_DOMAINS_GENERIC)
> >>that allows assigning the PCI bus domain number generically by
> >>relying on device tree bindings, and falling back to a simple counter
> >>when the respective DT properties (ie "linux,pci-domain") are not
> >>specified in the host bridge device tree node.
> >>
> >>In a similar way, when a system is booted through ACPI, architectures
> >>that are selecting CONFIG_PCI_DOMAINS_GENERIC (ie ARM64) require kernel
> >>hooks to retrieve the domain number so that the PCI bus domain number
> >>set-up can be handled seamlessly with DT and ACPI in generic core code
> >>when CONFIG_PCI_DOMAINS_GENERIC is selected.
> >>
> >>Since currently it is not possible to retrieve a pointer to the PCI
> >>host bridge ACPI device backing the host bridge from core PCI code
> >>(which would allow retrieving the domain number in an arch agnostic
> >>way through the ACPI _SEG method), an arch specific ACPI hook has to
> >>be declared and implemented by all arches that rely on
> >>CONFIG_PCI_DOMAINS_GENERIC to retrieve the domain number and set it
> >>up in core PCI code.
> >>
> >>For the aforementioned reasons, this patch introduces a dummy
> >>acpi_pci_bus_domain_nr() hook in preparation for per-arch implementation
> >>of the same to retrieve the domain number on a per-arch basis when
> >>the system boots through ACPI.
> >>
> >>For the sake of code clarity the current code implementing generic
> >>domain number assignment (ie pci_bus_assign_domain_nr(), selected by
> >>CONFIG_PCI_DOMAINS_GENERIC) is reshuffled so that the code implementing
> >>the DT domain assignment function is stubbed out into a corresponding
> >>helper, so that DT and ACPI functions are clearly separated in
> >>preparation for arches acpi_pci_bus_domain_nr() implementations.
> >>
> >>Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> >>Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>---
> >>  drivers/pci/pci.c   | 11 +++++++++--
> >>  include/linux/pci.h |  1 +
> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>index eb431b5..2b52178 100644
> >>--- a/drivers/pci/pci.c
> >>+++ b/drivers/pci/pci.c
> >>@@ -7,6 +7,7 @@
> >>   *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
> >>   */
> >>
> >>+#include <linux/acpi.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/init.h>
> >>@@ -4941,7 +4942,7 @@ int pci_get_new_domain_nr(void)
> >>  }
> >>
> >>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> >>-void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> >>+static int of_pci_bus_domain_nr(struct device *parent)
> >
> >Can we do a little cleanup before this patch?
> >
> >   - pci_bus_assign_domain_nr() is only used inside drivers/pci, so
> >     maybe we move the prototype to drivers/pci/pci.h?
> 
> pci_bus_assign_domain_nr() goes with pci_domain_nr() as an option
> for CONFIG_PCI_DOMAINS_GENERIC. pci_domain_nr() is used commonly
> outside drivers/pci so we would need to split these calls then, thus
> personally I think it would be better to keep both in
> inclue/linux/pci.h

OK.

> >   - I don't really like the style of calling a function that
> >     internally assigns bus->domain_nr.  Could we do something like
> >     this instead?
> >
> >     int pci_bus_domain_nr(...)
> >     {
> >       ...
> >       return domain;
> >     }
> >
> >     ... pci_create_root_bus(...)
> >     {
> >       ...
> >       b->domain_nr = pci_bus_domain_nr(...);
> 
> 
> We can. I do not see much difference between pci_bus_domain_nr() and
> pci_domain_nr() which we already have so how about calling it
> pci_bus_find_domain_nr instead? Lorenzo, any strong preference for
> it?

I suggested that to make them all parallel:

  pci_bus_domain_nr()
  of_pci_bus_domain_nr()
  acpi_pci_bus_domain_nr()

If you want to make them all *pci_bus_find_domain_nr() that would be
OK with me, but I think it is worth keeping them the same except for
the prefix (none/"of_"/"acpi_").  I think that's what you suggested
below.

> >That would be two new patches, if this makes sense.
> >
> >And this patch would only rename pci_bus_assign_domain_nr() to
> >of_pci_bus_domain_nr() and add the pci_bus_domain_nr() wrapper.
> 
> Giving that we would keep prototypes in inclue/linux/pci.h
> 
> 1. First patch would rename pci_bus_assign_domain_nr() to
> pci_bus_find_domain_nr() and it would return domain number so that
> we could do:
>      ... pci_create_root_bus(...)
>      {
>        ...
>        b->domain_nr = pci_bus_domain_nr(...);
>        ...
>      }
> 
> 2. Second patch would transform pci_bus_find_domain_nr() to be the
> wrapper for of_pci_bus_domain_nr()
> 
> 3. Third patch would add stub definition, the ARM64 definition and
> the new call acpi_pci_bus_domain_nr() in pci_bus_find_domain_nr()
> wrapper.
> 
> Does this plan sound reasonable?

Sounds perfect!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
