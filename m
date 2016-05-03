Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:39291 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbcECGJM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2016 02:09:12 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Tue, 3 May 2016 16:09:08 +1000
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
 remapping is supported
To: "Tian, Kevin" <kevin.tian@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
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
	"David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
	"alistair@popple.id.au" <alistair@popple.id.au>,
	"ruscur@russell.cc" <ruscur@russell.cc>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Message-ID: <f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
Date: Tue, 3 May 2016 14:08:22 +0800
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/3 13:34, Tian, Kevin wrote:

>> From: Yongji Xie
>> Sent: Wednesday, April 27, 2016 8:43 PM
>>
>> This patch enables mmapping MSI-X tables if hardware supports
>> interrupt remapping which can ensure that a given pci device
>> can only shoot the MSIs assigned for it.
>>
>> With MSI-X table mmapped, we also need to expose the
>> read/write interface which will be used to access MSI-X table.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> A curious question here. Does "allow to mmap MSI-X" essentially
> mean that KVM guest can directly read/write physical MSI-X
> structure then?
>
> Thanks
> Kevin
>

Here we just allow to mmap MSI-X table in kernel. It doesn't
mean all KVM guest can directly read/write physical MSI-X
structure. This should be decided by QEMU. For PPC64
platform, we would allow to passthrough the MSI-X table
because we know guest kernel would not write physical
MSI-X structure when enabling MSI.

Thanks,
Yongji

