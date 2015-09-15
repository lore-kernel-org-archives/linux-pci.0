Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jake Oshins <jakeo@microsoft.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: RE: [PATCH v2 00/12] New paravirtual PCI front-end for Hyper-V VMs
Date: Tue, 15 Sep 2015 23:32:52 +0000
Message-ID: <DM2PR0301MB1232B0C4BCB539F7452FF091AB5C0@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
 <55F6E115.9050502@arm.com>
 <DM2PR0301MB12326BCA329D5D98A587C2DCAB5D0@DM2PR0301MB1232.namprd03.prod.outlook.com>
 <55F7EB82.20309@arm.com>
In-Reply-To: <55F7EB82.20309@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier@arm.com]
> Sent: Tuesday, September 15, 2015 2:57 AM
> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; linux-pci@vger.kernel.org; bhelgaas@google.com;
> tglx@linutronix.de; Jiang Liu <jiang.liu@linux.intel.com>
> Subject: Re: [PATCH v2 00/12] New paravirtual PCI front-end for Hyper-V
> VMs
> 


> >
> > Is there a way to do that with the infrastructure that you're
> > introducing?
> 
> The ACPI/GSI stuff is a red herring, and is completely unrelated to the
> problem you're trying to solve. What I think is of interest to you is
> contained in the first three patches.
> 
> In your 4th patch, you have the following code:
> 
> +	pci_domain = pci_domain_nr(bus);
> +	d = irq_find_matching_host(NULL, DOMAIN_BUS_PCI_MSI,
> &pci_domain);
> 
> which really feels like you're trying to create a namespace that is
> parallel to the one defined by the device_node parameter. What I'm
> trying to do is to be able to replace the device_node by something more
> generic (at the moment, you can either pass a device_node or some token
> that the irqdomain subsystem generates for you - see patch #7 for an
> example).
> 
> You could pass this token to pci_msi_create_irq_domain (which obviously
> needs some repainting not to take a device_node), store it in your bus
> structure, and perform the lookup based on this value. Or store the
> actual domain there, whatever.
> 
> What I want to do is really to make this device_node pointer for systems
> that do not have a DT node to pass there, which is exactly your case (by
> the look of it, the bus number is your identifier of choice, but I
> suspect a pointer to an internal structure would be better suited).
> 
> 	M.
> --

Got it.  I'll rebase on your changes and send this series again, using the strategy that you outline here.  I may wait a little while until your patches make it into linux-next.

Thanks again,
Jake Oshins

