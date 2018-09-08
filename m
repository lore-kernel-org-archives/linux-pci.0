Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Sat, 8 Sep 2018 08:16:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 04/10] PCI: pciehp: Do not handle events if interrupts
 are masked
Message-ID: <20180908061617.odqpcjeo525bm5mb@wunner.de>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-5-mika.westerberg@linux.intel.com>
 <20180907224546.GA1598@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907224546.GA1598@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 07, 2018 at 04:45:46PM -0600, Keith Busch wrote:
> On Thu, Sep 06, 2018 at 06:50:14PM +0300, Mika Westerberg wrote:
> > PCIe native hotplug shares MSI vector with native PME so the interrupt
> > handler might get called even the hotplug interrupt is masked. In that
> > case we should not handle any events because the interrupt was not meant
> > for us. Modify the PCIe hotplug interrupt handler to check this
> > accordingly and bail out if it finds out that the interrupt was not
> > about hotplug.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/hotplug/pciehp_hpc.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 2249c4d06efd..19ed13d44b8f 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -533,9 +533,11 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
> >  	u16 status, events;
> >  
> >  	/*
> > -	 * Interrupts only occur in D3hot or shallower (PCIe r4.0, sec 6.7.3.4).
> > +	 * Interrupts only occur in D3hot or shallower and only if enabled
> > +	 * in the Slot Control register (PCIe r4.0, sec 6.7.3.4).
> >  	 */
> > -	if (pdev->current_state == PCI_D3cold)
> > +	if (pdev->current_state == PCI_D3cold ||
> > +	    !(ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE))
> >  		return IRQ_NONE;
> >  
> >  	/*
> 
> Isn't this going to break pciehp_poll_mode?

Excellent catch, you're right, it needs to be constrained to
!pciehp_poll_mode.
