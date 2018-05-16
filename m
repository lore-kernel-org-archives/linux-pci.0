Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37031 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPUVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 May 2018 16:21:36 -0400
Received: by mail-yw0-f196.google.com with SMTP id u83-v6so650849ywc.4
        for <linux-pci@vger.kernel.org>; Wed, 16 May 2018 13:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180516012947.12474.2286.stgit@scvm10.sc.intel.com>
 <20180516013129.12474.16333.stgit@scvm10.sc.intel.com> <20180516200400.GM25661@ziepe.ca>
In-Reply-To: <20180516200400.GM25661@ziepe.ca>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 16 May 2018 15:21:14 -0500
Message-ID: <CAErSpo7J2g5BZysA92xL81U6nmUoz8htQR25wrpijcPC4_z=Lg@mail.gmail.com>
Subject: Re: [PATCH for-next 4/5] IB/Hfi1: Mask Unsupported Request error bit
 in PCIe AER
To: jgg@ziepe.ca
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        michael.j.ruhl@intel.com, kamenee.arumugam@intel.com,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Wed, May 16, 2018 at 3:04 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, May 15, 2018 at 06:31:32PM -0700, Dennis Dalessandro wrote:
> > From: Kamenee Arumugam <kamenee.arumugam@intel.com>
> >
> > For Hfi1, this unsupported request error is not considered a fatal
> > error. Set Unsupported Request Error bit in Uncorrectable Error Mask
> > register to disable error reporting to the PCIe root complex.
> >
> > Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> > Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
> > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> > ---
> >  drivers/infiniband/hw/hfi1/pcie.c |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)

> Should this really be in a driver not in a quirk?

> Is this a hardware errta?

> Bjorn is it OK for drivers to touch these config registers, seems
> questionable to me?

Seems dubious to me, too.  I have the same questions.  Does this fix a
bug?  If so, what are the symptoms?  This patch isn't for me, but I would
be looking for more details, including an erratum citation if appropriate.

I'd *rather* that drivers use PCI core interfaces instead of directly
programming registers like this, but I don't think an interface for this
purpose currently exists.

> > diff --git a/drivers/infiniband/hw/hfi1/pcie.c
b/drivers/infiniband/hw/hfi1/pcie.c
> > index 87bd6b6..332c843 100644
> > --- a/drivers/infiniband/hw/hfi1/pcie.c
> > +++ b/drivers/infiniband/hw/hfi1/pcie.c
> > @@ -79,6 +79,8 @@
> >  int hfi1_pcie_init(struct pci_dev *pdev, const struct pci_device_id
*ent)
> >  {
> >       int ret;
> > +     int aer;
> > +     u32 data;
> >
> >       ret = pci_enable_device(pdev);
> >       if (ret) {
> > @@ -130,6 +132,19 @@ int hfi1_pcie_init(struct pci_dev *pdev, const
struct pci_device_id *ent)
> >       }
> >
> >       pci_set_master(pdev);
> > +
> > +     aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > +     if (!aer)
> > +             goto done;
> > +     pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, &data);
> > +     if (!(data & PCI_ERR_UNC_UNSUP)) {
> > +             data |= PCI_ERR_UNC_UNSUP;
> > +             if (!pci_write_config_dword(pdev, aer +
PCI_ERR_UNCOR_MASK,
> > +                                         data))
> > +                     hfi1_early_err(&pdev->dev,
> > +                                    "Masking Unsupported Request
error\n");
> > +     }
> > +
> >       (void)pci_enable_pcie_error_reporting(pdev);
> >       goto done;
> >
