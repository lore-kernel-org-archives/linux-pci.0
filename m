Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Long Li <longli@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH] pci-hyperv: use kmalloc to allocate hypercall params
 buffer
Date: Thu, 24 Nov 2016 02:18:46 +0000
Message-ID: <DM5PR03MB24902727D39E48272BC9B3D1A0B60@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <1478642678-31659-1-git-send-email-longli@exchange.microsoft.com>
 <20161123232027.GM16033@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161123232027.GM16033@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, November 23, 2016 3:20 PM
> To: Long Li <longli@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Long Li <longli@microsoft.com>
> Subject: Re: [PATCH] pci-hyperv: use kmalloc to allocate hypercall params
> buffer
>=20
> On Tue, Nov 08, 2016 at 02:04:38PM -0800, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > hv_do_hypercall assumes that we pass a segment from a physically
> > continuous buffer. Buffer allocated on the stack may not work if
> > CONFIG_VMAP_STACK=3Dy is set.
> >
> > Change to use kmalloc to allocate this buffer.
> >
> > The v2 patch adds locking to access the pre-allocated buffer.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Reported-by: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> Waiting for a maintainer ack for this.

Acked-by: K. Y. Srinivasan <kys@microsoft.com>

>=20
> $ ./scripts/get_maintainer.pl -f drivers/pci/host/pci-hyperv.c
> "K. Y. Srinivasan" <kys@microsoft.com> (maintainer:Hyper-V CORE AND
> DRIVERS)
> Haiyang Zhang <haiyangz@microsoft.com> (maintainer:Hyper-V CORE AND
> DRIVERS)
> ...
>=20
> > ---
> >  drivers/pci/host/pci-hyperv.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyper=
v.c
> > index 763ff87..ca553df 100644
> > --- a/drivers/pci/host/pci-hyperv.c
> > +++ b/drivers/pci/host/pci-hyperv.c
> > @@ -378,6 +378,8 @@ struct hv_pcibus_device {
> >  	struct msi_domain_info msi_info;
> >  	struct msi_controller msi_chip;
> >  	struct irq_domain *irq_domain;
> > +	struct retarget_msi_interrupt retarget_msi_interrupt_params;
> > +	spinlock_t retarget_msi_interrupt_lock;;
> >  };
> >
> >  /*
> > @@ -774,34 +776,40 @@ void hv_irq_unmask(struct irq_data *data)
> >  {
> >  	struct msi_desc *msi_desc =3D irq_data_get_msi_desc(data);
> >  	struct irq_cfg *cfg =3D irqd_cfg(data);
> > -	struct retarget_msi_interrupt params;
> > +	struct retarget_msi_interrupt *params;
> >  	struct hv_pcibus_device *hbus;
> >  	struct cpumask *dest;
> >  	struct pci_bus *pbus;
> >  	struct pci_dev *pdev;
> >  	int cpu;
> > +	unsigned long flags;
> >
> >  	dest =3D irq_data_get_affinity_mask(data);
> >  	pdev =3D msi_desc_to_pci_dev(msi_desc);
> >  	pbus =3D pdev->bus;
> >  	hbus =3D container_of(pbus->sysdata, struct hv_pcibus_device,
> sysdata);
> >
> > -	memset(&params, 0, sizeof(params));
> > -	params.partition_id =3D HV_PARTITION_ID_SELF;
> > -	params.source =3D 1; /* MSI(-X) */
> > -	params.address =3D msi_desc->msg.address_lo;
> > -	params.data =3D msi_desc->msg.data;
> > -	params.device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> > +	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
> > +
> > +	params =3D &hbus->retarget_msi_interrupt_params;
> > +	memset(params, 0, sizeof(*params));
> > +	params->partition_id =3D HV_PARTITION_ID_SELF;
> > +	params->source =3D 1; /* MSI(-X) */
> > +	params->address =3D msi_desc->msg.address_lo;
> > +	params->data =3D msi_desc->msg.data;
> > +	params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
> >  			   (hbus->hdev->dev_instance.b[4] << 16) |
> >  			   (hbus->hdev->dev_instance.b[7] << 8) |
> >  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> >  			   PCI_FUNC(pdev->devfn);
> > -	params.vector =3D cfg->vector;
> > +	params->vector =3D cfg->vector;
> >
> >  	for_each_cpu_and(cpu, dest, cpu_online_mask)
> > -		params.vp_mask |=3D (1ULL <<
> vmbus_cpu_number_to_vp_number(cpu));
> > +		params->vp_mask |=3D (1ULL <<
> vmbus_cpu_number_to_vp_number(cpu));
> > +
> > +	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, params, NULL);
> >
> > -	hv_do_hypercall(HVCALL_RETARGET_INTERRUPT, &params, NULL);
> > +	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
> >
> >  	pci_msi_unmask_irq(data);
> >  }
> > @@ -2186,6 +2194,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	INIT_LIST_HEAD(&hbus->resources_for_children);
> >  	spin_lock_init(&hbus->config_lock);
> >  	spin_lock_init(&hbus->device_list_lock);
> > +	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> >  	sema_init(&hbus->enum_sem, 1);
> >  	init_completion(&hbus->remove_event);
> >
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=3D02%7C01%7Ckys%40microsoft.com%7C95f624c719384a83b0
> e308d413f75282%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6361
> 55400348714262&sdata=3DiE5j0UF00ExjolDvuilAe9Kxo17TrPScjbkFU%2BA426w
> %3D&reserved=3D0
