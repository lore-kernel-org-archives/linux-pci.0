Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: RE: [Resend] [PATCH] pci-hyperv: use kmalloc to allocate hypercall
 params buffer
Date: Tue, 8 Nov 2016 20:49:47 +0000
Message-ID: <BN3PR03MB2227E95C4437C5E2916CEF8BCEA60@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1478592854-17303-1-git-send-email-longli@exchange.microsoft.com>
 <20161108070001.GA13866@kroah.com>
 <BN3PR03MB2227A432B0288764BA9EE562CEA60@BN3PR03MB2227.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR03MB2227A432B0288764BA9EE562CEA60@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: devel [mailto:driverdev-devel-bounces@linuxdriverproject.org] On
> Behalf Of Long Li
> Sent: Tuesday, November 8, 2016 8:57 AM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: linux-pci@vger.kernel.org; Haiyang Zhang <haiyangz@microsoft.com>;
> linux-kernel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>;
> devel@linuxdriverproject.org
> Subject: RE: [Resend] [PATCH] pci-hyperv: use kmalloc to allocate hyperca=
ll
> params buffer
>=20
> This sender failed our fraud detection checks and may not be who they
> appear to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing
>=20
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@linuxfoundation.org]
> > Sent: Monday, November 7, 2016 11:00 PM
> > To: Long Li <longli@microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org
> > Subject: Re: [Resend] [PATCH] pci-hyperv: use kmalloc to allocate
> > hypercall params buffer
> >
> > On Tue, Nov 08, 2016 at 12:14:14AM -0800, Long Li wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > hv_do_hypercall assumes that we pass a segment from a physically
> > continuous buffer. Buffer allocated on the stack may not work if
> > CONFIG_VMAP_STACK=3Dy is set. Use kmalloc to allocate this buffer.
> >
> > Please wrap your changelog at 72 columns.
> >
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > Reported-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > >  drivers/pci/host/pci-hyperv.c | 24 +++++++++++++-----------
> > >  1 file changed, 13 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pci-hyperv.c
> > > b/drivers/pci/host/pci-hyperv.c index 763ff87..97e6daf 100644
> > > --- a/drivers/pci/host/pci-hyperv.c
> > > +++ b/drivers/pci/host/pci-hyperv.c
> > > @@ -378,6 +378,7 @@ struct hv_pcibus_device {
> > >     struct msi_domain_info msi_info;
> > >     struct msi_controller msi_chip;
> > >     struct irq_domain *irq_domain;
> > > +   struct retarget_msi_interrupt retarget_msi_interrupt_params;
> >
> > Can you handle potentially unaligned accesses like this?  Is there
> > some lock preventing you from using this structure more than once at th=
e
> same time?
> >
> > >  };
> > >
> > >  /*
> > > @@ -774,7 +775,7 @@ void hv_irq_unmask(struct irq_data *data)  {
> > >     struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
> > >     struct irq_cfg *cfg =3D irqd_cfg(data);
> > > -   struct retarget_msi_interrupt params;
> > > +   struct retarget_msi_interrupt *params;
> > >     struct hv_pcibus_device *hbus;
> > >     struct cpumask *dest;
> > >     struct pci_bus *pbus;
> > > @@ -785,23 +786,24 @@ void hv_irq_unmask(struct irq_data *data)
> > >     pdev =3D msi_desc_to_pci_dev(msi_desc);
> > >     pbus =3D pdev->bus;
> > >     hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device,
> > > sysdata);
> > > -
> > > -   memset(&params, 0, sizeof(params));
> > > -   params.partition_id =3D HV_PARTITION_ID_SELF;
> > > -   params.source =3D 1; /* MSI(-X) */
> > > -   params.address =3D msi_desc->msg.address_lo;
> > > -   params.data =3D msi_desc->msg.data;
> > > -   params.device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> > > +   params =3D &hbus->retarget_msi_interrupt_params;
> > > +
> > > +   memset(params, 0, sizeof(*params));
> > > +   params->partition_id =3D HV_PARTITION_ID_SELF;
> > > +   params->source =3D 1; /* MSI(-X) */
> > > +   params->address =3D msi_desc->msg.address_lo;
> > > +   params->data =3D msi_desc->msg.data;
> > > +   params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> > >                        (hbus->hdev->dev_instance.b[4] << 16) |
> > >                        (hbus->hdev->dev_instance.b[7] << 8) |
> > >                        (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > >                        PCI_FUNC(pdev->devfn);
> > > -   params.vector =3D cfg->vector;
> > > +   params->vector =3D cfg->vector;
> > >
> > >     for_each_cpu_and(cpu, dest, cpu_online_mask)
> > > -           params.vp_mask |=3D (1ULL <<
> > vmbus_cpu_number_to_vp_number(cpu));
> > > +           params->vp_mask |=3D (1ULL <<
> > vmbus_cpu_number_to_vp_number(cpu));
> > >
> > > -   hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
> > > +   hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
> >
> > As you only use this in one spot, why not just allocate it here and
> > then free it?  Why add it to the pcibus device structure?
>=20
> Thanks Greg. I will send a V2.

Sorry forgot to address the reason why we don't just allocate the buffer he=
re. This function cannot fail. So it's better to pre-allocate the buffer.

>=20
> >
> > thanks,
> >
> > greg k-h
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdriverd
> ev.linuxdriverproject.org%2Fmailman%2Flistinfo%2Fdriverdev-
> devel&data=3D02%7C01%7Clongli%40microsoft.com%7C6e28f5459da345cdb5e
> 408d407f836f0%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636142
> 210041216500&sdata=3DvvVxGQUet7KMuRgs9%2BRbR8JE70rKF1AJo%2Fu3zx%
> 2FQNwY%3D&reserved=3D0
