Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V4 11/26] iommu/amd: deprecate pci_get_bus_and_slot()
To: Gary R Hook <gary.hook@amd.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-12-git-send-email-okaya@codeaurora.org>
 <8a5dad82-2886-2a51-28bc-b84ab253c361@codeaurora.org>
 <46ccdb85-1c23-c9eb-994c-9a66e6fce7cc@amd.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9014a9e1-9545-4f3c-08c2-8e8eb4762101@codeaurora.org>
Date: Thu, 4 Jan 2018 11:32:26 -0500
MIME-Version: 1.0
In-Reply-To: <46ccdb85-1c23-c9eb-994c-9a66e6fce7cc@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 1/4/2018 11:28 AM, Gary R Hook wrote:
> On 01/04/2018 06:25 AM, Sinan Kaya wrote:
>> On 12/19/2017 12:37 AM, Sinan Kaya wrote:
>>> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
>>> where a PCI device is present. This restricts the device drivers to be
>>> reused for other domain numbers.
>>>
>>> Getting ready to remove pci_get_bus_and_slot() function in favor of
>>> pci_get_domain_bus_and_slot().
>>>
>>> Hard-code the domain number as 0 for the AMD IOMMU driver.
> 
> <snip>
> 
>>
>> Any comments from the IOMMU people?
>>
> 
> pci_get_bus_and_slot() appears to (now) be a convenience function that wraps pci_get_domain_bus_and_slot() while using a 0 for the domain value. Exactly what you are doing here, albeit in a more overt way.
> 
> How is this patch advantageous? Seems to me that if other domains need to be enabled, that driver could be changed if and when that requirement arises.
> 
> But perhaps I'm missing a nuance here.
> 
> 

The benefit of the change was discussed here:

https://lkml.org/lkml/2017/12/19/349

I hope it helps.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
