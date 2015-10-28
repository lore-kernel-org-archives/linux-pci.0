Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:42967 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbbJ1CBw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 27 Oct 2015 22:01:52 -0400
Subject: Re: [PATCH v3 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-V
 VMs
To: Jake Oshins <jakeo@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1445901339-11924-1-git-send-email-jakeo@microsoft.com>
 <1445901339-11924-8-git-send-email-jakeo@microsoft.com>
 <562F2389.9050305@linux.intel.com>
 <DM2PR0301MB1232E93FC2DD8C26EEDBB69AAB220@DM2PR0301MB1232.namprd03.prod.outlook.com>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <56302C8B.20202@linux.intel.com>
Date: Wed, 28 Oct 2015 10:01:47 +0800
MIME-Version: 1.0
In-Reply-To: <DM2PR0301MB1232E93FC2DD8C26EEDBB69AAB220@DM2PR0301MB1232.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/10/28 4:38, Jake Oshins wrote:
>> -----Original Message-----
>> From: Jiang Liu [mailto:jiang.liu@linux.intel.com]
>> Sent: Tuesday, October 27, 2015 12:11 AM
>> To: Jake Oshins <jakeo@microsoft.com>; gregkh@linuxfoundation.org; KY
>> Srinivasan <kys@microsoft.com>; linux-kernel@vger.kernel.org;
>> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
>> vkuznets@redhat.com; tglx@linutronix.de; Haiyang Zhang
>> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
>> bhelgaas@google.com; linux-pci@vger.kernel.org
>> Subject: Re: [PATCH v3 7/7] PCI: hv: New paravirtual PCI front-end for Hyper-
>> V VMs
>>
>> On 2015/10/27 7:15, jakeo@microsoft.com wrote:
>>> From: Jake Oshins <jakeo@microsoft.com>
>>>
> (snip)
>>> +/**
>>> + * hv_pcie_init_irq_domain() - Initialize IRQ domain
>>> + * @hbus:	The root PCI bus
>>> + *
>>> + * Return: '0' on success and error value on failure
>>> + */
>>> +static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>>> +{
>>> +	hbus->msi_info.chip = &hv_msi_irq_chip;
>>> +	hbus->msi_info.chip_data = hbus;
>>> +	hbus->msi_info.ops = &hv_msi_ops;
>>> +	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>>> +		MSI_FLAG_USE_DEF_CHIP_OPS |
>> MSI_FLAG_MULTI_PCI_MSI |
>>> +		MSI_FLAG_PCI_MSIX);
>> When interrupt remapping is not supported, x86 vector allocator
>> can't support multiple MSI because it can't allocate continuous
>> vectors yet. So please confirm whether we could enable
>> MSI_FLAG_MULTI_PCI_MSI for HV.
>>
> 
> We can actually handle the remapping in the hypervisor.  I'll add a comment to that effect.
> 
>>> +	hbus->msi_info.handler = handle_edge_irq;
>>> +	hbus->msi_info.handler_name = "edge";
>>> +	hbus->msi_info.data = hbus;
>> How about using following pattern so we could avoid exporting
>> too many interfaces?
>>
>> struct irq_domain *parent_domain = NULL;
>> hbus->msi_info.chip = &hv_msi_irq_chip;
>> hbus->msi_info.ops = &hv_msi_ops;
>> // Let arch code to fill in default ops for chip and domain
>> x86_setup_default_msi_irqdomian_info(&hbus->msi_info,
>> &parent_domain);
>> // Override default ops if not applicable
>> hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
>> 					     &hbus->msi_info,
>> 					     parent_domain);
>>
> 
> I understand your point here, but I'm having trouble making it play out.  When I look at this, the only functions or structures which are supplied straight from exports (in my proposed patches) are irq_chip_ack_parent(), pci_msi_prepare() and x86_vector_domain.  The other exports either already exist for other reasons or they're needed within functions that I need to supply.  If you feel strongly that adding a new function to avoid exporting these is the right way to go, I'll do it, but I want to confirm that first.
No strong preference here, just feeling that pci_msi_prepare() and
x86_vector_domain are arch specific:)

And I was hoping that we could find some commonality between this
driver and the VMD driver posted at http://lkml.org/lkml/2015/10/27/607
so we could abstract the common part into core.

For the VMD driver, it has put the code to create irqdomain into core
as vmd_create_irq_domain().

Thanks,
Gerry

> 
> Thanks,
> Jake Oshins
> 
