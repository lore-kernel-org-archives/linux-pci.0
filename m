Return-Path: <SRS0=YAYN=2T=gmail.com=zajec5@kernel.org>
Return-Path: <SRS0=YAYN=2T=gmail.com=zajec5@kernel.org>
Subject: Re: pcie-iproc: broken 2nd (& 3rd?) controller support by
 c3245a566400 ("PCI: iproc: Request host bridge window resources")
To: Bjorn Helgaas <helgaas@kernel.org>
References: <faab6b85-58e8-3e62-8763-56a94b13fba1@gmail.com>
 <f40bbf2f-3ba9-3992-d417-6588085f3d62@gmail.com>
 <20170309182205.GB3685@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Oza Oza <oza.oza@broadcom.com>, JD Zheng <jiandong.zheng@broadcom.com>,
 Andy Gospodarek <gospo@broadcom.com>, linux-pci@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <04f747ef-0f39-33ec-0cea-2e9fb85d46e8@gmail.com>
Date: Fri, 10 Mar 2017 17:02:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170309182205.GB3685@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 03/09/2017 07:22 PM, Bjorn Helgaas wrote:
> On Thu, Mar 09, 2017 at 08:39:07AM +0100, Rafał Miłecki wrote:
>> On 03/08/2017 01:56 PM, Rafał Miłecki wrote:
>>> I just tried upgrading BCM5301X from 4.4 to 4.9 and noticed I don't see card
>>> connected to the 2nd controller.
>>>
>>> pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
>>> pcie_iproc_bcma bcma0:7: link: UP
>>> PCI: bus0: Fast back to back transfers disabled
>>> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>> PCI: bus1: Fast back to back transfers disabled
>>> pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
>>> pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>> pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
>>>
>>> pcie_iproc_bcma bcma0:8: resource collision: [mem 0x40000000-0x47ffffff] conflicts with PCIe MEM space [mem 0x40000000-0x47ffffff]
>>> pcie_iproc_bcma bcma0:8: PCIe controller setup failed
>>> pcie_iproc_bcma: probe of bcma0:8 failed with error -16
>>>
>>>
>>> This used to work with older kernels because there wasn't any collision check:
>>>
>>> pcie_iproc_bcma bcma0:7: PCI host bridge to bus 0000:00
>>> pci_bus 0000:00: root bus resource [mem 0x08000000-0x0fffffff]
>>> pcie_iproc_bcma bcma0:7: link: UP
>>> PCI: bus0: Fast back to back transfers disabled
>>> pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>> PCI: bus1: Fast back to back transfers disabled
>>> pci 0000:00:00.0: BAR 8: assigned [mem 0x08000000-0x080fffff]
>>> pci 0000:01:00.0: BAR 0: assigned [mem 0x08000000-0x08007fff 64bit]
>>> pci 0000:00:00.0: PCI bridge to [bus 01]
>>> pci 0000:00:00.0:   bridge window [mem 0x08000000-0x080fffff]
>>>
>>> pcie_iproc_bcma bcma0:8: PCI host bridge to bus 0001:00
>>> pci_bus 0001:00: root bus resource [mem 0x40000000-0x47ffffff]
>>> pcie_iproc_bcma bcma0:8: link: UP
>>> PCI: bus0: Fast back to back transfers disabled
>>> pci 0001:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>> PCI: bus1: Fast back to back transfers disabled
>>> pci 0001:00:00.0: BAR 8: assigned [mem 0x40000000-0x400fffff]
>>> pci 0001:01:00.0: BAR 0: assigned [mem 0x40000000-0x40007fff 64bit]
>>> pci 0001:00:00.0: PCI bridge to [bus 01]
>>> pci 0001:00:00.0:   bridge window [mem 0x40000000-0x400fffff]
>>>
>>>
>>> I guess the check is OK after all and the real problem is iproc driver assigning
>>> the same resource.
>>>
>>> Broadcom team: could you take a look at this, please?
>>
>> I found a reason of this conflict (and probably random crashes I started
>> seeing with 4.9). I believe we have a memory corruption.
>
> Yep, we're using a resource structure on the stack when we shouldn't.  Can
> you try the patch below?

Works great! Will you push it with
Cc: stable@vger.kernel.org # v4.8+
please?

Thanks for looking at this!

Also see below...


> (...)
>  	if (ret)
>  		dev_err(dev, "PCIe controller setup failed\n");
> -
> -	pci_free_resource_list(&res);
> +		pci_free_resource_list(&resources);
> +		return ret;
> +	}

Works great, except it doesn't compile (braces) ;)
