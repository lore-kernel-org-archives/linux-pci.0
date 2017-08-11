Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbdHKJXJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Aug 2017 05:23:09 -0400
Subject: Re: Support SVM without PASID
To: "Tian, Kevin" <kevin.tian@intel.com>, Bob Liu <liubo95@huawei.com>,
        valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <32b6402d-40fb-d40c-32f3-1ed6b9a3185a@gmail.com>
 <c142fb8e-3618-152a-fbe3-521e6c8ff9bf@arm.com>
 <dd3a7852-cd9a-3797-9421-dff97f6d7213@gmail.com>
 <9b8611ca-3e39-90ec-e18e-7455115b38b3@arm.com>
 <ed289d79-880a-a542-dcb1-0de8c55a8ca0@huawei.com>
 <1ef75c2d-f980-5cef-f760-be3b133c82ca@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D6EDB7@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <017d8f2f-d72d-c037-1769-339da392e24f@arm.com>
Date: Fri, 11 Aug 2017 10:25:20 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D6EDB7@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/08/17 07:41, Tian, Kevin wrote:
[...]
>>> Hi Jean,
>>>
>>> I think there is another way to support SVM without PASID.
>>>
>>> Suppose there is a device in the same SOC-chip, the device access memory
>> through SMMU(using internal bus instead of PCIe)
>>> Once page fault, the device send an event with (vaddr, substreamID) to
>> SMMU, then SMMU triggers an event interrupt.
>>>
>>> In the event interrupt handler, we can implement the same logic as PRI
>> interrupt in your patch.
>>> What do you think about that?
>> What you're describing is the SMMU stall model for platform devices. From
>> the driver perspective it's the same as PRI and PASID (SubstreamID=PASID).
>>
>> When a stall-capable device accesses unmapped memory, the SMMU parks
>> the
>> transaction and sends an event marked "stall" on the event queue, with a
>> stall tag (STAG, roughly equivalent to PRG Index). The OS handles the
>> fault and sends a CMD_RESUME command with the status and the STAG.
>> Then
>> the SMMU completes the access or terminates it.
> 
> Can such platform device send multiple SubstreamIDs, or one ID per
> device? 

Yes, SVM-capable platform devices should issue multiple SubstreamIDs and a
single StreamID (equivalent to VT-d's Source-ID).

Thanks,
Jean
