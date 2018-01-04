Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V4 11/26] iommu/amd: deprecate pci_get_bus_and_slot()
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
 <8a5dad82-2886-2a51-28bc-b84ab253c361@codeaurora.org>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <46ccdb85-1c23-c9eb-994c-9a66e6fce7cc@amd.com>
Date: Thu, 4 Jan 2018 10:28:31 -0600
MIME-Version: 1.0
In-Reply-To: <8a5dad82-2886-2a51-28bc-b84ab253c361@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/04/2018 06:25 AM, Sinan Kaya wrote:
> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>> where a PCI device is present. This restricts the device drivers to be
>> reused for other domain numbers.
>>
>> Getting ready to remove pci_get_bus_and_slot() function in favor of
>> pci_get_domain_bus_and_slot().
>>
>> Hard-code the domain number as 0 for the AMD IOMMU driver.

<snip>

 >
 > Any comments from the IOMMU people?
 >

pci_get_bus_and_slot() appears to (now) be a convenience function that 
wraps pci_get_domain_bus_and_slot() while using a 0 for the domain 
value. Exactly what you are doing here, albeit in a more overt way.

How is this patch advantageous? Seems to me that if other domains need 
to be enabled, that driver could be changed if and when that requirement 
arises.

But perhaps I'm missing a nuance here.
