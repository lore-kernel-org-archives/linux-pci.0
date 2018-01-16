Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 16 Jan 2018 15:49:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI/PCI: pci_link: reduce verbosity when IRQ is enabled
Message-ID: <20180116214939.GC10860@bhelgaas-glaptop.roam.corp.google.com>
References: <1516128664-23634-1-git-send-email-okaya@codeaurora.org>
 <f508e749-2976-ec6f-681a-553b79c4ab76@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <f508e749-2976-ec6f-681a-553b79c4ab76@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Linux PCI <linux-pci@vger.kernel.org>, timur@codeaurora.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 16, 2018 at 01:53:00PM -0500, Sinan Kaya wrote:
> Correcting linux-pci email.
> 
> On 1/16/2018 1:51 PM, Sinan Kaya wrote:
> > When ACPI Link object is enabled, the message is printed with a warning
> > prefix. Some test tools are capturing warning and test error types as
> > errors. Let's reduce the verbosity of success case.
> > 
> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks like this was a result of 4d9391557b68 ("ACPI: add missing KERN_*
constants to printks"), which I think added the wrong level in this case.

> > ---
> >  drivers/acpi/pci_link.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> > index bc3d914..85ad679 100644
> > --- a/drivers/acpi/pci_link.c
> > +++ b/drivers/acpi/pci_link.c
> > @@ -612,7 +612,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
> >  			acpi_isa_irq_penalty[link->irq.active] +=
> >  				PIRQ_PENALTY_PCI_USING;
> >  
> > -		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
> > +		pr_info("%s [%s] enabled at IRQ %d\n",
> >  		       acpi_device_name(link->device),
> >  		       acpi_device_bid(link->device), link->irq.active);
> >  	}
> > 
> 
> 
> -- 
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
