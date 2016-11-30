Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 30 Nov 2016 09:56:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] ACPI: Ignore Consumer/Producer for QWord/DWord/Word
 Address Space
Message-ID: <20161130155616.GA9693@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129182415.7618.99129.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129184334.7618.5495.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161130120425.GA13765@red-moon>
MIME-Version: 1.0
In-Reply-To: <20161130120425.GA13765@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 30, 2016 at 12:04:25PM +0000, Lorenzo Pieralisi wrote:
> On Tue, Nov 29, 2016 at 12:43:34PM -0600, Bjorn Helgaas wrote:
> > Per ACPI spec r6.0, sec 6.4.3.5.1, 2, 3, Bit [0] of General Flags (the
> > Consumer/Producer bit) should be ignored for QWord/DWord/Word Address Space
> > descriptors.  The Consumer/Producer bit is defined only for the Extended
> > Address Space descriptor.
> > 
> > Ignore Consumer/Producer except for Extended Address Space descriptors.
> > 
> > Note that for QWord/DWord/Word descriptors, we previously applied the
> > translation offset (_TRA) only when the Consumer/Producer bit was set.
> 
> "..Consumer/Producer bit was clear" ? If that bit was set:
> 
> struct acpi_resource_address->producer_consumer == ACPI_CONSUMER
> 
> and we are not applying the _TRA offset in that case, right ?

Right, of course.  How about this instead?

    Note that for QWord/DWord/Word descriptors, we previously applied the
    translation offset (_TRA) only for Producers, i.e., when the Consumer/
    Producer bit was clear.  This patch changes that: for those descriptors,
    we ignore Consumer/Producer and always apply the translation offset.

> > This patch changes that: for those descriptors, we ignore Consumer/Producer
> > and always apply the translation offset.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/acpi/resource.c |   16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> > index 2732d39e..b45cd8f 100644
> > --- a/drivers/acpi/resource.c
> > +++ b/drivers/acpi/resource.c
> > @@ -261,11 +261,16 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
> >  	 * primary side. Non-bridge devices must list 0 for all Address
> >  	 * Translation offset bits.
> >  	 */
> > -	if (addr->producer_consumer == ACPI_PRODUCER)
> > +	if (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64) {
> > +		if (addr->producer_consumer == ACPI_PRODUCER)
> > +			offset = attr->translation_offset;
> > +		else if (attr->translation_offset)
> > +			pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
> > +				 attr->translation_offset);
> > +	} else {
> >  		offset = attr->translation_offset;
> > -	else if (attr->translation_offset)
> > -		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge device.\n",
> > -			 attr->translation_offset);
> > +	}
> > +
> >  	start = attr->minimum + offset;
> >  	end = attr->maximum + offset;
> >  
> > @@ -294,7 +299,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
> >  		return false;
> >  	}
> >  
> > -	if (addr->producer_consumer == ACPI_PRODUCER)
> > +	if (ares->type == ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64 &&
> > +	    addr->producer_consumer == ACPI_PRODUCER)
> >  		res->flags |= IORESOURCE_WINDOW;
> >  
> >  	if (addr->info.mem.caching == ACPI_PREFETCHABLE_MEMORY)
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
