Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:33869 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEGNNZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2015 09:13:25 -0400
Received: by qcyk17 with SMTP id k17so20602659qcy.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2015 06:13:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <554AC48A.2030209@huawei.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
 <20150506221818.GH24643@google.com> <554AC48A.2030209@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 May 2015 08:13:04 -0500
Message-ID: <CAErSpo6xp5kM57PX9RkXKr5MM4BQM7-uXPtvCBL8=9Br8FYLdA@mail.gmail.com>
Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
To: Yijing Wang <wangyijing@huawei.com>
Cc: wdavis@nvidia.com, Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	tripperda@nvidia.com, jhubbard@nvidia.com,
	Jerome Glisse <jglisse@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 6, 2015 at 8:48 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2015/5/7 6:18, Bjorn Helgaas wrote:
>> [+cc Yijing, Dave J, Dave M, Alex]
>>
>> On Fri, May 01, 2015 at 01:32:12PM -0500, wdavis@nvidia.com wrote:
>>> From: Will Davis <wdavis@nvidia.com>
>>>
>>> Hi,
>>>
>>> This patch series adds DMA APIs to map and unmap a struct resource to and from
>>> a PCI device's IOVA domain, and implements the AMD, Intel, and nommu versions
>>> of these interfaces.
>>>
>>> This solves a long-standing problem with the existing DMA-remapping interfaces,
>>> which require that a struct page be given for the region to be mapped into a
>>> device's IOVA domain. This requirement cannot support peer device BAR ranges,
>>> for which no struct pages exist.
>>> ...

>> I think we currently assume there's no peer-to-peer traffic.
>>
>> I don't know whether changing that will break anything, but I'm concerned
>> about these:
>>
>>   - PCIe MPS configuration (see pcie_bus_configure_settings()).
>
> I think it should be ok for PCIe MPS configuration, PCIE_BUS_PEER2PEER force every
> device's MPS to 128B, what its concern is the TLP payload size. In this series, it
> seems to only map a iova for device bar region.

MPS configuration makes assumptions about whether there will be any
peer-to-peer traffic.  If there will be none, MPS can be configured
more aggressively.

I don't think Linux has any way to detect whether a driver is doing
peer-to-peer, and there's no way to prevent a driver from doing it.
We're stuck with requiring the user to specify boot options
("pci=pcie_bus_safe", "pci=pcie_bus_perf", "pci=pcie_bus_peer2peer",
etc.) that tell the PCI core what the user expects to happen.

This is a terrible user experience.  The user has no way to tell what
drivers are going to do.  If he specifies the wrong thing, e.g.,
"assume no peer-to-peer traffic," and then loads a driver that does
peer-to-peer, the kernel will configure MPS aggressively and when the
device does a peer-to-peer transfer, it may cause a Malformed TLP
error.

Bjorn
