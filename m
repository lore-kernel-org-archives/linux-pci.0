Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37446 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964946AbbHKOnp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 10:43:45 -0400
Received: by wibhh20 with SMTP id hh20so199457606wib.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 07:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439279761.3080.39.camel@pengutronix.de>
References: <1437662976-27188-1-git-send-email-l.stach@pengutronix.de>
 <1437662976-27188-2-git-send-email-l.stach@pengutronix.de>
 <CAHM4w1=Sz1xJ1OGc9xAMVCv8hMLwnWmGrkRLHdqpdC7EgzEbpQ@mail.gmail.com>
 <20150810223857.GC13982@google.com> <1439279761.3080.39.camel@pengutronix.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Aug 2015 09:43:23 -0500
Message-ID: <CAErSpo4Rk4NS1AdGLiZzM6MOXcTtMjTRy1fP+f7J8gwCvfGdcA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: designware: implement multivector MSI irq setup
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	patchwork-lst@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 11, 2015 at 2:56 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Montag, den 10.08.2015, 17:38 -0500 schrieb Bjorn Helgaas:
>> On Tue, Aug 04, 2015 at 08:41:15PM +0530, Pratyush Anand wrote:
>> > On Thu, Jul 23, 2015 at 8:19 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
>> > > Allows to set up and use multiple MSI irqs per device.
>> > >
>> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>>
>> Thanks Lucas, I'm hoping for a little refactoring as Pratyush suggests
>> and maybe a third patch to fill in the upper bytes of the message?  Or
>> do those look not feasible?
>>
> Pratyush suggestion looks okay and I have that on my TODO. Expect
> updated patches shortly.

Great, thanks!  I'll watch for them.

>> > > ---
>> > > The ifdef is needed to avoid a compile error on
>> > > !CONFIG_PCI_MSI, as msi_list is only part of pci_dev
>> > > when the kernel is compiled with MSI support.
>> > >
>> > > v2: move ifdeffery inside single function
>> > > ---
>> > >  drivers/pci/host/pcie-designware.c | 43 ++++++++++++++++++++++++++++++++++++++
>> > >  1 file changed, 43 insertions(+)
>> > >
>> > > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> > > index 69486be7181e..52c600327805 100644
>> > > --- a/drivers/pci/host/pcie-designware.c
>> > > +++ b/drivers/pci/host/pcie-designware.c
>> > > @@ -286,6 +286,9 @@ static int assign_irq(int no_irqs, struct msi_desc *desc, int *pos)
>> > >         }
>> > >
>> > >         *pos = pos0;
>> > > +       desc->nvec_used = no_irqs;
>> > > +       desc->msi_attrib.multiple = order_base_2(no_irqs);
>> > > +
>> > >         return irq;
>> > >
>> > >  no_valid_irq:
>> > > @@ -323,6 +326,45 @@ static int dw_msi_setup_irq(struct msi_controller *chip, struct pci_dev *pdev,
>> > >         return 0;
>> > >  }
>> > >
>> > > +static int dw_msi_setup_irqs(struct msi_controller *chip, struct pci_dev *pdev,
>> > > +                            int nvec, int type)
>> > > +{
>> > > +#ifdef CONFIG_PCI_MSI
>> > > +       int irq, pos;
>> > > +       struct msi_desc *desc;
>> > > +       struct msi_msg msg;
>> > > +       struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
>> > > +
>> > > +       /* MSI-X interrupts are not supported */
>> > > +       if (type == PCI_CAP_ID_MSIX)
>> > > +               return -EINVAL;
>> > > +
>> > > +       WARN_ON(!list_is_singular(&pdev->msi_list));
>> > > +       desc = list_entry(pdev->msi_list.next, struct msi_desc, list);
>> > > +
>> >
>> > Probably existing function dw_msi_setup_irq() can be re-factored and code after
>> > this line can be reused from refactored function, as they are almost same.
>> >
>> > > +       irq = assign_irq(nvec, desc, &pos);
>> > > +       if (irq < 0)
>> > > +               return irq;
>> > > +
>> > > +       if (pp->ops->get_msi_addr)
>> > > +               msg.address_lo = pp->ops->get_msi_addr(pp);
>> > > +       else
>> > > +               msg.address_lo = virt_to_phys((void *)pp->msi_data);
>> > > +       msg.address_hi = 0x0;
>> > > +
>> >
>> > Although, not specific to this patch, but since we are now going to have
>> > ARM64 support for DW as well, so it would be nice to fill msg.address_hi
>> > with upper bytes rather hard-coding as 0.
>> >
>> > > +       if (pp->ops->get_msi_data)
>> > > +               msg.data = pp->ops->get_msi_data(pp, pos);
>> > > +       else
>> > > +               msg.data = pos;
>> > > +
>> > > +       pci_write_msi_msg(irq, &msg);
>> > > +
>> > > +       return 0;
>> >
>> > ~Pratyush
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
>
