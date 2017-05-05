Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 5 May 2017 17:51:19 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Khuong Dinh <kdinh@apm.com>
Subject: Re: [PATCH v2 pci] PCI/MSI: pci-xgene-msi: Enable MSI support in
 ACPI boot for X-Gene v1
Message-ID: <20170505165119.GA8614@red-moon>
References: <1493340847-25720-1-git-send-email-kdinh@apm.com>
 <f5cb58a5-7c06-8d54-6293-1a72ee0a4707@arm.com>
 <CAAsHzquFJE7X0MQyZCP4+UW_E+WK2ORe1EK6yxiq-ev81i1-xg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAsHzquFJE7X0MQyZCP4+UW_E+WK2ORe1EK6yxiq-ev81i1-xg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: rjw@rjwysocki.net, Duc Dang <dhdang@apm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 msalter@redhat.com, patches@apm.com, linux-kernel@vger.kernel.org,
 jcm@redhat.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 04, 2017 at 05:36:06PM -0700, Khuong Dinh wrote:
> Hi Marc,
> There's no explicit dependency between pcie driver and msi
> controller.  The current solution that we did is relying on the
> node ordering in BIOS.  ACPI 5.0 introduced _DEP method to assign a
> higher priority in start ordering.  This method could be applied in
> case of msi and pcie are the same level of subsys_init (in ACPI
> boot).  However, PCIe driver has not supported for this dependency
> check yet.  How do you think about this solution.

First off, you can't post emails with confidentiality notices on
mailing lists so remove it from now onwards.

Secondly, I commented on this before, so you know what my opinion is.

Finally, please execute this command on the vmlinux that "works"
for you:

nm vmlinux | grep -E '__initcall_(xgene_pcie_msi_init|acpi_init)'

Even by ordering devices in the ACPI tables (that I abhor) I still do
not understand how this works (I mean without relying on kernel link
order to ensure that the MSI driver is probed before PCI devices are
enumerated in acpi_init()).

Thanks,
Lorenzo

> Best regards,
> Khuong
> 
> On Fri, Apr 28, 2017 at 2:27 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 28/04/17 01:54, Khuong Dinh wrote:
> >> From: Khuong Dinh <kdinh@apm.com>
> >>
> >> This patch makes pci-xgene-msi driver ACPI-aware and provides
> >> MSI capability for X-Gene v1 PCIe controllers in ACPI boot mode.
> >>
> >> Signed-off-by: Khuong Dinh <kdinh@apm.com>
> >> Signed-off-by: Duc Dang <dhdang@apm.com>
> >> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >> v2:
> >>  - Verify with BIOS version 3.06.25 and 3.07.09
> >> v1:
> >>  - Initial version
> >> ---
> >>  drivers/pci/host/pci-xgene-msi.c |   35 ++++++++++++++++++++++++++++++++---
> >>  1 files changed, 32 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/host/pci-xgene-msi.c b/drivers/pci/host/pci-xgene-msi.c
> >> index f1b633b..00aaa3d 100644
> >> --- a/drivers/pci/host/pci-xgene-msi.c
> >> +++ b/drivers/pci/host/pci-xgene-msi.c
> >> @@ -24,6 +24,7 @@
> >>  #include <linux/pci.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/of_pci.h>
> >> +#include <linux/acpi.h>
> >>
> >>  #define MSI_IR0                      0x000000
> >>  #define MSI_INT0             0x800000
> >> @@ -39,7 +40,7 @@ struct xgene_msi_group {
> >>  };
> >>
> >>  struct xgene_msi {
> >> -     struct device_node      *node;
> >> +     struct fwnode_handle    *fwnode;
> >>       struct irq_domain       *inner_domain;
> >>       struct irq_domain       *msi_domain;
> >>       u64                     msi_addr;
> >> @@ -249,6 +250,13 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
> >>       .free   = xgene_irq_domain_free,
> >>  };
> >>
> >> +#ifdef CONFIG_ACPI
> >> +static struct fwnode_handle *xgene_msi_get_fwnode(struct device *dev)
> >> +{
> >> +     return xgene_msi_ctrl.fwnode;
> >> +}
> >> +#endif
> >> +
> >>  static int xgene_allocate_domains(struct xgene_msi *msi)
> >>  {
> >>       msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
> >> @@ -256,7 +264,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
> >>       if (!msi->inner_domain)
> >>               return -ENOMEM;
> >>
> >> -     msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
> >> +     msi->msi_domain = pci_msi_create_irq_domain(msi->fwnode,
> >>                                                   &xgene_msi_domain_info,
> >>                                                   msi->inner_domain);
> >>
> >> @@ -265,6 +273,9 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
> >>               return -ENOMEM;
> >>       }
> >>
> >> +#ifdef CONFIG_ACPI
> >> +     pci_msi_register_fwnode_provider(&xgene_msi_get_fwnode);
> >> +#endif
> >>       return 0;
> >>  }
> >>
> >> @@ -449,6 +460,13 @@ static int xgene_msi_hwirq_free(unsigned int cpu)
> >>       {},
> >>  };
> >>
> >> +#ifdef CONFIG_ACPI
> >> +static const struct acpi_device_id xgene_msi_acpi_ids[] = {
> >> +     {"APMC0D0E", 0},
> >> +     { },
> >> +};
> >> +#endif
> >> +
> >>  static int xgene_msi_probe(struct platform_device *pdev)
> >>  {
> >>       struct resource *res;
> >> @@ -469,7 +487,17 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>               goto error;
> >>       }
> >>       xgene_msi->msi_addr = res->start;
> >> -     xgene_msi->node = pdev->dev.of_node;
> >> +
> >> +     xgene_msi->fwnode = of_node_to_fwnode(pdev->dev.of_node);
> >> +     if (!xgene_msi->fwnode) {
> >> +             xgene_msi->fwnode = irq_domain_alloc_fwnode(NULL);
> >
> > Please provide something other than NULL, such as the base address if
> > the device. That's quite useful for debugging.
> >
> >> +             if (!xgene_msi->fwnode) {
> >> +                     dev_err(&pdev->dev, "Failed to create fwnode\n");
> >> +                     rc = ENOMEM;
> >> +                     goto error;
> >> +             }
> >> +     }
> >> +
> >>       xgene_msi->num_cpus = num_possible_cpus();
> >>
> >>       rc = xgene_msi_init_allocator(xgene_msi);
> >> @@ -540,6 +568,7 @@ static int xgene_msi_probe(struct platform_device *pdev)
> >>       .driver = {
> >>               .name = "xgene-msi",
> >>               .of_match_table = xgene_msi_match_table,
> >> +             .acpi_match_table = ACPI_PTR(xgene_msi_acpi_ids),
> >>       },
> >>       .probe = xgene_msi_probe,
> >>       .remove = xgene_msi_remove,
> >>
> >
> > The code is trivial, but relies on the MSI controller to probe before
> > the PCI bus. What enforces this? How is it making sure that this is not
> > going to break in the next kernel release? As far as I can tell, there
> > is no explicit dependency between the two, making it the whole thing
> > extremely fragile.
> >
> > Thanks,
> >
> >         M.
> > --
> > Jazz is not dead. It just smells funny...
> 
> -- 
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
> for the sole use of the intended recipient(s) and contains information that 
> is confidential and proprietary to Applied Micro Circuits Corporation or 
> its subsidiaries. It is to be used solely for the purpose of furthering the 
> parties' business relationship. All unauthorized review, use, disclosure or 
> distribution is prohibited. If you are not the intended recipient, please 
> contact the sender by reply e-mail and destroy all copies of the original 
> message.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
