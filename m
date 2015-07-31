Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55B899BB.2090008@arm.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
	<1438080345-7233-5-git-send-email-lftan@altera.com>
	<55B7C2D0.8080107@arm.com>
	<CAFiDJ59kb=tDbnktmdF5r1_ShUfwvpxDQUtWV8LieS5Y=iVi4w@mail.gmail.com>
	<55B899BB.2090008@arm.com>
Date: Fri, 31 Jul 2015 11:19:01 +0800
Message-ID: <CAFiDJ5_eUvubr-=p7v+5iByvF9WnBZp_y+XzAfH=K6j_Gmc9SQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] pci: altera: Add Altera PCIe MSI driver
From: Ley Foon Tan <lftan@altera.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 5:15 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>
> On 29/07/15 09:52, Ley Foon Tan wrote:
> > On Wed, Jul 29, 2015 at 1:58 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> Hi Ley,
> >>
> >> On 28/07/15 11:45, Ley Foon Tan wrote:
> >>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
> >>> number of vectors, which is a dts parameter.
> >>
> >> Can't you read this configuration from the HW?
> > No, we can't read from HW.
>
> Ah, that's a shame. Specially on HW that is configurable by design.
>
> [...]
>
> >>> +
> >>> +                     irq = irq_find_mapping(msi->msi_domain->parent, offset);
> >>
> >> This would tend to indicate that you don't really need to store the
> >> msi_domain pointer, but the inner_domain pointer instead.
> > Will store the inner_domain pointer. But, I think we still need
> > msi_domain for irq_domain_remove.
> > Or do we have any way to retrieve msi_domain from inner_domain?
>
> Do you have any case where you remove the domains, aside from the
> obvious error cases?
Yes, if there is error in _probe().

> [...]
>
> >>> +
> >>> +static struct msi_domain_info altera_msi_domain_info = {
> >>> +     .flags  = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
> >>
> >> So you don't support MSIX? That's a bit weird.
> > Yes, this MSI IP doesn't support it.
>
> This is not really a function of the MSI IP, but of the PCI device. In
> your case, this is just a set of doorbells, so I hardly see what would
> prevent MSI-X to be supported. Multi-MSI, I can see why.
Yes, you are right. Will add MSI_FLAG_PCI_MSIX flag here.

>
> [...]
>
> >>> +static int altera_msi_set_affinity(struct irq_data *irq_data,
> >>> +                              const struct cpumask *mask, bool force)
> >>> +{
> >>> +      return irq_set_affinity(irq_data->hwirq, mask);
> >>
> >> There is no way this can be right. irq_data->hwirq can *never* be passed
> >> as a Linux IRQ. This really should be the IRQ to the GIC.
> >>
> >> Which raises another issue: as you only have a single interrupt to the
> >> GIC, changing the affinity of a single MSI is going to affect all the
> >> other MSIs as well. This doesn't seem like a desirable behaviour.
> > Do we must provide '.irq_set_affinity" callback to msi domain? I have
> > tried set it to NULL,
> > but kernel got the NULL pointer deference error from msi_domain_set_affinity().
> > Recently, I saw this new patch for pci-tegra.c from [1], it doesn't
> > set the ".irq_set_affinity".
> > Just wonder how it can work.
> >
> > Do you have any recommendation way for this?
> >
> > [1] https://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/commit/drivers/pci/host?h=irq/gsi-irq-domain-v2&id=17c22fc4e60e6ad54c7e3b73868cbc057360fa63
>
> Please realize that I *never* tested this patch (I don't think I ever
> posted it officially, I just keep here for convenience), and I wouldn't
> take it as a reference.
>
> When it comes to msi_domain_set_affinity issue, this look more like an
> oversight. I'll cook a patch for that.
>
> Anyway, whichever way you want to do it, you need to fix this. You could
> always return -EINVAL in the meantime,
Will add  -EINVAL for now.

Thanks for reviewing.

Regards
Ley Foon
