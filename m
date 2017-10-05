Return-Path: <SRS0=eSAM=BE=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=eSAM=BE=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Qiang Zheng <zhengqiang10@huawei.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, gabriele.paoloni@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH V2] Bug fix for PME interrupt handler, add Root Status check
Date: Thu, 05 Oct 2017 15:02:54 +0200
Message-ID: <4989012.MpNStB6gzp@aspire.rjw.lan>
In-Reply-To: <20171004221157.GL25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1506737526-94266-1-git-send-email-zhengqiang10@huawei.com> <20171004221157.GL25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 5, 2017 12:11:57 AM CEST Bjorn Helgaas wrote:
> On Sat, Sep 30, 2017 at 10:12:06AM +0800, Qiang Zheng wrote:
> > PCIe PME and hot plug share same interrupt number. In some special case,
> > Link down event cause hot plug interrupt, devices is not disconnected,
> > But read config will return 0xff.
> > 
> > In that case, PME work function will run and not return Because
> > Root Status PME bit always 1 and can not be cleared.
> > 
> > This patch add Root Status check in PME interrupt handler,
> > Just do same as pciehp isr Slot status check.
> > 
> > Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
> > ---
> >  drivers/pci/pcie/pme.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> > index fafdb16..2ff2e57 100644
> > --- a/drivers/pci/pcie/pme.c
> > +++ b/drivers/pci/pcie/pme.c
> > @@ -273,7 +273,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
> >  	spin_lock_irqsave(&data->lock, flags);
> >  	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
> >  
> > -	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> > +	if (rtsta == U32_MAX || !(rtsta & PCI_EXP_RTSTA_PME)) {
> >  		spin_unlock_irqrestore(&data->lock, flags);
> >  		return IRQ_NONE;
> >  	}
> > 
> 
> I applied the patch below to pci/misc for v4.15.
> 
> I think we need a similar test in pcie_pme_work_fn() itself.  Without
> it, I think there's a race: if we get a legitimate PME, enter
> pcie_pme_work_fn(), and the link goes down, we could still get
> 0xffffffff the next time we read PCI_EXP_RTSTA.
> 
> I also used "(u32) ~0" instead of U32_MAX because that's the style
> used elsewhere.  It might be clunkier than necessary, but U32_MAX
> suggests a limit, and that's not really the concept here.
> 
> I didn't add your reviewed-by, Rafael, since I made non-trivial
> changes to the patch.
> 
> Bjorn
> 
> 
> 
> commit 303029d6d55ba10a37c82c31a89eb5550cde77ec
> Author: Qiang <zhengqiang10@huawei.com>
> Date:   Thu Sep 28 11:54:34 2017 +0800
> 
>     PCI/PME: Handle invalid data when reading Root Status
>     
>     PCIe PME and native hotplug share the same interrupt number, so hotplug
>     interrupts are also processed by PME.  In some cases, e.g., a Link Down
>     interrupt, a device may be present but unreachable, so when we try to
>     read its Root Status register, the read fails and we get all ones data
>     (0xffffffff).
>     
>     Previously, we interpreted that data as PCI_EXP_RTSTA_PME being set, i.e.,
>     "some device has asserted PME," so we scheduled pcie_pme_work_fn().  This
>     caused an infinite loop because pcie_pme_work_fn() tried to handle PME
>     requests until PCI_EXP_RTSTA_PME is cleared, but with the link down,
>     PCI_EXP_RTSTA_PME can't be cleared.
>     
>     Check for the invalid 0xffffffff data everywhere we read the Root Status
>     register.
>     
>     1469d17dd341 ("PCI: pciehp: Handle invalid data when reading from
>     non-existent devices") added similar checks in the hotplug driver.
>     
>     Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
>     [bhelgaas: changelog, also check in pcie_pme_work_fn(), use "~0" to follow
>     other similar checks]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index fafdb165dd2e..df290aa58dce 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -226,6 +226,9 @@ static void pcie_pme_work_fn(struct work_struct *work)
>  			break;
>  
>  		pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
> +		if (rtsta == (u32) ~0)
> +			break;
> +
>  		if (rtsta & PCI_EXP_RTSTA_PME) {
>  			/*
>  			 * Clear PME status of the port.  If there are other
> @@ -273,7 +276,7 @@ static irqreturn_t pcie_pme_irq(int irq, void *context)
>  	spin_lock_irqsave(&data->lock, flags);
>  	pcie_capability_read_dword(port, PCI_EXP_RTSTA, &rtsta);
>  
> -	if (!(rtsta & PCI_EXP_RTSTA_PME)) {
> +	if (rtsta == (u32) ~0 || !(rtsta & PCI_EXP_RTSTA_PME)) {
>  		spin_unlock_irqrestore(&data->lock, flags);
>  		return IRQ_NONE;
>  	}
> 

FWIW, it looks OK to me.

Thanks,
Rafael
