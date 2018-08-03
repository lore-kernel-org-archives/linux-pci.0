Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbeHCTXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Aug 2018 15:23:14 -0400
Subject: Re: [RFC] PCI: add support for Immediate Readiness
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
 <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
 <874lgcufsu.fsf@linux.intel.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org>
Date: Fri, 3 Aug 2018 13:25:58 -0400
MIME-Version: 1.0
In-Reply-To: <874lgcufsu.fsf@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/3/2018 2:26 AM, Felipe Balbi wrote:
> Sinan Kaya <okaya@kernel.org> writes:
> 
>> On 8/2/2018 7:36 AM, Felipe Balbi wrote:
>>> PCIe GEN4 defines a new bit on Status Register which tells us that, if
>>> Set, a function is immediately ready after a Reset. This means that
>>> all delays after a Conventional or Function Reset can be skipped.
>>
>> Can you give a reference to the section of the specification? or
>> a pointer to the ECN?
> 
> Section 7.5.1.1.4 of PCIe GEN4 spec. Table 7-4:
> 
> Immediate Readiness – This optional bit, when Set, indicates the
> Function is guaranteed to be ready to successfully complete valid
> configuration accesses at any time following any reset that the host is
> capable of issuing Configuration Requests to this Function.
> 
> When this bit is Set, for accesses to this Function, software is exempt
> from all requirements to delay configuration accesses following any type
> of reset, including but not limited to the timing requirements defined
> in Section 6.6.  How this guarantee is established is beyond the scope
> of this document.
> 
> It is permitted that system software/firmware provide mechanisms that
> supersede the indication provided by this bit, however such
> software/firmware mechanisms are outside the scope of this
> specification.
> 

Thanks for the spec reference.

I think the patch is touching the wrong places. pci_dev_wait() is there
to wait for CRS response to finish following reset.

Typical sequences are:
1. Do some kind of reset in another routine
2. Wait reset specific wait time (1sec for secondary bus reset as an
example and 100ms for d3-d0 transition)
3. call pci_dev_wait() after reset to see if device can accept config
transactions.

Since this applies to all resets, I think you also need to get rid of
waits following different reset types in step #2 and return immediately.
I suggest you review callers of pci_dev_wait() and tap in there.

Another thing is that this is a common functionality. Initializing
the flag in pm_init() would not be the best place.
