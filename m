Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0143.outbound.protection.outlook.com ([207.46.100.143]:41268
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753212AbbLCRHQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 12:07:16 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@redhat.com" <tglx@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v6 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
Date: Thu, 3 Dec 2015 17:07:14 +0000
Message-ID: <DM2PR0301MB12325F97CE4EA5035031E5B9AB0D0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1446499996-1350-1-git-send-email-jakeo@microsoft.com>
 <1446499996-1350-8-git-send-email-jakeo@microsoft.com>
 <565FB2F5.6050504@linux.intel.com>
In-Reply-To: <565FB2F5.6050504@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Jiang Liu [mailto:jiang.liu@linux.intel.com]
> Sent: Wednesday, December 2, 2015 7:12 PM
> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; tglx@redhat.com; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v6 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-
> V VMs
> 
> On 2015/11/3 5:33, jakeo@microsoft.com wrote:
> > From: Jake Oshins <jakeo@microsoft.com>
> >
[...]
> > +
> > +/**
> > + * hv_irq_unmask() - "Unmask" the IRQ by setting its current
> > + * affinity.
> > + * @data:	Describes the IRQ
> > + *
> > + * Build new a destination for the MSI and make a hypercall to
> > + * update the Interrupt Redirection Table. "Device Logical ID"
> > + * is built out of this PCI bus's instance GUID and the function
> > + * number of the device.
> > + */
> > +void hv_irq_unmask(struct irq_data *data)
> > +{
> > +	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> > +	struct irq_cfg *cfg = irqd_cfg(data);
> > +	struct retarget_msi_interrupt params;
> > +	struct hv_pcibus_device *hbus;
> > +	struct cpumask *dest;
> > +	struct pci_bus *pbus;
> > +	struct pci_dev *pdev;
> > +	int cpu;
> > +
> > +	dest = irq_data_get_affinity_mask(data);
> > +	pdev = msi_desc_to_pci_dev(msi_desc);
> > +	pbus = pdev->bus;
> > +	hbus = container_of(pbus->sysdata, struct hv_pcibus_device,
> sysdata);
> > +
> > +	memset(&params, 0, sizeof(params));
> > +	params.partition_id = HV_PARTITION_ID_SELF;
> > +	params.source = 1; /* MSI(-X) */
> > +	params.address = msi_desc->msg.address_lo;
> > +	params.data = msi_desc->msg.data;
> > +	params.device_id = (hbus->hdev->dev_instance.b[5] << 24) |
> > +			   (hbus->hdev->dev_instance.b[4] << 16) |
> > +			   (hbus->hdev->dev_instance.b[7] << 8) |
> > +			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
> > +			   PCI_FUNC(pdev->devfn);
> > +	params.vector = cfg->vector;
> > +
> > +	for_each_cpu_and(cpu, dest, cpu_online_mask)
> > +		params.vp_mask |= (1 <<
> vmbus_cpu_number_to_vp_number(cpu));
> No knowledge about the HV implementation details, but feel some chances
> of race here between hv_irq_unmask(), hv_set_affinity() and
> cpu_up()/cpu_down() when accessing 'dest' and cpu_online_mask.
> 
 
Thanks.  Is there any architectural contract here?  I tried implementing this by doing this work in the set_affinity() callback, but the vector was often wrong when that callback was invoked.  (It seems to get changed just after set_affinity().)  Can you suggest a durable strategy?

I'll respond to all the other comments you sent (and this one, once I understand the right response) and resend.

Thanks for your review,
Jake Oshins

