Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
To: David Laight <David.Laight@ACULAB.COM>,
	"'Tian, Kevin'" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
 <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
 <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"paulus@samba.org" <paulus@samba.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
	"zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
	"nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
	"eric.auger@linaro.org" <eric.auger@linaro.org>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	"gwshan@linux.vnet.ibm.com" <gwshan@linux.vnet.ibm.com>,
	"alistair@popple.id.au" <alistair@popple.id.au>,
	"ruscur@russell.cc" <ruscur@russell.cc>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
Date: Thu, 5 May 2016 19:42:38 +0800
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David and Kevin,

On 2016/5/5 17:54, David Laight wrote:

> From: Tian, Kevin
>> Sent: 05 May 2016 10:37
> ...
>>> Acutually, we are not aimed at accessing MSI-X table from
>>> guest. So I think it's safe to passthrough MSI-X table if we
>>> can make sure guest kernel would not touch MSI-X table in
>>> normal code path such as para-virtualized guest kernel on PPC64.
>>>
>> Then how do you prevent malicious guest kernel accessing it?
> Or a malicious guest driver for an ethernet card setting up
> the receive buffer ring to contain a single word entry that
> contains the address associated with an MSI-X interrupt and
> then using a loopback mode to cause a specific packet be
> received that writes the required word through that address.
>
> Remember the PCIe cycle for an interrupt is a normal memory write
> cycle.
>
> 	David
>

If we have enough permission to load a malicious driver or
kernel, we can easily break the guest without exposed
MSI-X table.

I think it should be safe to expose MSI-X table if we can
make sure that malicious guest driver/kernel can't use
the MSI-X table to break other guest or host. The
capability of IRQ remapping could provide this
kind of protection.

Thanks,
Yongji
