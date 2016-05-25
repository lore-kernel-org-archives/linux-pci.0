Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60813 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755188AbcEYFqj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2016 01:46:39 -0400
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4P5htI5048488
	for <linux-pci@vger.kernel.org>; Wed, 25 May 2016 01:46:38 -0400
Message-Id: <201605250546.u4P5htI5048488@mx0a-001b2d01.pphosted.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
	by mx0a-001b2d01.pphosted.com with ESMTP id 234qhxyr25-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 25 May 2016 01:46:38 -0400
Received: from localhost
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Wed, 25 May 2016 11:16:34 +0530
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-2-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20160524205519.GA16463@localhost>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com,
	bhelgaas@google.com, aik@ozlabs.ru, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, joro@8bytes.org,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com, eric.auger@linaro.org,
	will.deacon@arm.com, gwshan@linux.vnet.ibm.com,
	David.Laight@ACULAB.COM, alistair@popple.id.au, ruscur@russell.cc
Date: Wed, 25 May 2016 13:46:23 +0800
MIME-Version: 1.0
In-Reply-To: <20160524205519.GA16463@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/5/25 4:55, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:26PM +0800, Yongji Xie wrote:
>> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
>> which indicates all devices on the bus are protected by the
>> hardware which supports IRQ remapping(intel naming).
> This changelog is ambiguous.  It's possible that there is hardware
> that *supports* IRQ remapping, but does not actually *do* IRQ
> remapping.  For example, an IRQ remapping capability may be present
> but not enabled.
>
> I think your intent is to set this flag only when MSI remapping is
> actually *enabled* for all devices on the bus.

Yes. This is exactly my intent. Thank you for the correction!

> I'd also like to know exactly what protection is implied by
> PCI_BUS_FLAGS_MSI_REMAP and IOMMU_CAP_INTR_REMAP.  I guess it means a
> device can only generate MSIs to a certain set of CPUs?  I assume the
> remapping hardware only checks the target address, not the data being
> written?

When IRQ remapping is enabled, the hardware will check both target
address and data, then compute the interrupt_index from them.
Interrupt_index will be used to find a specific Interrupt Remapping Table
Entry containing some fields which could be used to identify a device or
a group of devices(these devices should be in the same isolation domain).
Then hardware can use this to verify the interrupt request. If the interrupt
request is not from the specific devices, it will be blocked.

So this flag indicate that the hardware can ensure that a given PCI device
can only shoot the MSIs assigned for it. When there is something wrong
with MSI in device or device driver, this can prevent all damage from it.

Regards,
Yongji

