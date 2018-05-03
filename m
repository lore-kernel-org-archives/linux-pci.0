Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54084 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeECNqi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 May 2018 09:46:38 -0400
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
To: Joerg Roedel <joro@8bytes.org>, Gil Kupfer <gilkup@gmail.com>
Cc: dwmw2@infradead.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
        Gil Kupfer <gilkup@cs.technion.ac.il>,
        Will Deacon <will.deacon@arm.com>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
Date: Thu, 3 May 2018 09:46:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180503133459.waawna3ebtu3udn6@8bytes.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/3/2018 9:35 AM, Joerg Roedel wrote:
> On Sun, Apr 29, 2018 at 09:16:48PM +0300, Gil Kupfer wrote:
>> This patch adds noats option to the pci boot parameter.
>> When noats is selected, all ATS related functions fail immediately and
>> the IOMMU is configured to not use device-iotlb.
>>
>> Any function that checks for ATS capabilities directly against the
>> devices should also check this flag. (Currently, such functions exist
>> only in IOMMU drivers, and they are covered by this patch.)
>>
>> The motivation behind this patch is the existence of malicious devices.
>> Lots of research has been done about how to utilitize the IOMMU as a
>> protection from such devices. When ATS is supported, any I/O device can
>> access any physical access by faking device-IOTLB entries.
>> Adding the ability to ignore these entries lets sysadmins enhance system
>> security.
>>
>> Signed-off-by: Gil Kupfer <gilkup@cs.technion.ac.il>
> 
> This has also been on my list, thanks for doing that.
> 
> Acked-by: Joerg Roedel <jroedel@suse.de>
> 

I also like the idea in general.
Minor nit..

Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
We now have an iommu.passthrough argument that prevents page translation.

Doesn't this fit into the same category especially when it is the IOMMU drivers that
call ATS functions for enablement not the PCI drivers.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
