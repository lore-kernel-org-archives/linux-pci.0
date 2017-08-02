Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34548 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdHBTGt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2017 15:06:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id i19so5528041qte.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Aug 2017 12:06:48 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'vidya sagar'" <sagar.tv@gmail.com>
Cc: "'Lucas Stach'" <l.stach@pengutronix.de>,
        "'Pratyush Anand'" <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>,
        "'Joao Pinto'" <Joao.Pinto@synopsys.com>
References: <CAN7O0+L8ergfE1_Thow2Lz+5UnhLvQO_LmEqhh=XqKfiu3m8XA@mail.gmail.com> <CAErSpo58kndyFLOnq-85HK8NnYOG2mMkn3HzRP_+FKPY0La7AQ@mail.gmail.com>
In-Reply-To: <CAErSpo58kndyFLOnq-85HK8NnYOG2mMkn3HzRP_+FKPY0La7AQ@mail.gmail.com>
Subject: Re: MSI-X support with Synopsys DesignWare IP core driver
Date: Wed, 2 Aug 2017 15:06:45 -0400
Message-ID: <000401d30bc2$7cfdb8c0$76f92a40$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, August 1, 2017 1:13 PM, Bjorn Helgaas wrote:
> 
> This was a multi-part message with HTML, which I think causes the
> mailing list to automatically drop it.  Please post this as plain text
> with a changelog and signed-off-by and copy the DesignWare maintainers
> (Jingoo and Joao, cc'd).
> 
> On Tue, Aug 1, 2017 at 12:28 AM, vidya sagar <sagar.tv@gmail.com> wrote:
> > Hi,
> > As you might be knowing it already, in the current pcie-designware.c ,
> there
> > is no support for MSI-X
> > Although there is no native support from Synopsys IP as well to have
> 2048
> > interrupts, we can at least have basic support to get MSI-X also
> allocated
> > (along with MSI) as many as possible in the system at that point. Of
> course,
> > all these interrupts will have the same address to which downstream
> devices
> > need to initiate mem-write transactions. Though it doesn't leverage one
> of
> > the advantages of having MSI-X over MSI, it at least avoids drivers
> falling
> > back to legacy interrupts when the card doesn't support MSI. Some of the
> > Intel NVMe cards are examples here. Legacy interrupt being a shared
> > interrupt, it unnecessarily triggers all other shared ISRs to be called
> > whenever there is a legacy interrupt.
> >
> > I have the following patch which enables MSI-X support also. Would like
> to
> > have your comments on this.

Hi all,

As far as I know, in order to support MSI-X with Synopsys IP, additional
controller is required. For example, GICv2m can be used to do so.

In addition, I think that some HACK patches can be used to support some
MSI-X only PCI cards. In this case, we cannot take advantage of MSI-X really.
Nevertheless, I am not sure that the following patch is safe.

Best regards,
Jingoo Han

> >
> >
> > diff --git a/drivers/pci/host/pcie-designware.c
> > b/drivers/pci/host/pcie-designware.c
> > index af8f6e9..9086253 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -406,9 +406,6 @@ static int dw_msi_setup_irq(struct msi_controller
> *chip,
> > struct pci_dev *pdev,
> >      int irq, pos;
> >      struct pcie_port *pp = pdev->bus->sysdata;
> >
> > -    if (desc->msi_attrib.is_msix)
> > -        return -EINVAL;
> > -
> >      irq = assign_irq(1, desc, &pos);
> >      if (irq < 0)
> >          return irq;
> > @@ -426,9 +423,16 @@ static int dw_msi_setup_irqs(struct msi_controller
> > *chip, struct pci_dev *pdev,
> >      struct msi_desc *desc;
> >      struct pcie_port *pp = pdev->bus->sysdata;
> >
> > -    /* MSI-X interrupts are not supported */
> > -    if (type == PCI_CAP_ID_MSIX)
> > -        return -EINVAL;
> > +    if (type == PCI_CAP_ID_MSIX) {
> > +        for_each_pci_msi_entry(desc, pdev) {
> > +            irq = arch_setup_msi_irq(pdev, desc);
> > +            if (irq < 0)
> > +                return irq;
> > +            if (irq > 0)
> > +                return -ENOSPC;
> > +        }
> > +        return 0;
> > +    }
> >
> >      WARN_ON(!list_is_singular(&pdev->dev.msi_list));
> >      desc = list_entry(pdev->dev.msi_list.next, struct msi_desc, list);
> >
