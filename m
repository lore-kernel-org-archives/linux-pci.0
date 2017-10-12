Return-Path: <SRS0=d13r=BL=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=d13r=BL=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 2/5] PCI: handle FLR failure and allow other reset types
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1506212218-29103-1-git-send-email-okaya@codeaurora.org>
 <1506212218-29103-2-git-send-email-okaya@codeaurora.org>
 <20171011210057.GU25517@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <972aee6d-7f55-12f5-08ef-7809b7f133e0@codeaurora.org>
Date: Thu, 12 Oct 2017 12:42:08 -0400
MIME-Version: 1.0
In-Reply-To: <20171011210057.GU25517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 10/11/2017 5:00 PM, Bjorn Helgaas wrote:
> On Sat, Sep 23, 2017 at 08:16:55PM -0400, Sinan Kaya wrote:
>> pci_flr_wait() and pci_af_flr() functions assume graceful return even
>> though the device is inaccessible under error conditions.
>>
>> Return -ENOTTY in error cases so that __pci_reset_function_locked() can
>> try other reset types if AF_FLR/FLR reset fails.
> 
> This makes sense to me, but I think the error handling in
> __pci_reset_function_locked() is confusing.  It currently is:
> 
>   rc = pci_dev_specific_reset(dev, 0);
>   if (rc != -ENOTTY)
>     return rc;
>   if (pcie_has_flr(dev)) {
>     pcie_flr(dev);
>     return 0;
>   }
>   rc = pci_af_flr(dev, 0);
>   if (rc != -ENOTTY)
>     return rc;
> 
> Would it make sense to change this to the following?
> 
>   rc = pci_dev_specific_reset(dev, 0);
>   if (rc == 0)
>     return 0;
> 
>   if (pcie_has_flr(dev)) {
>     pcie_flr(dev);
>     return 0;
>   }
> 
>   rc = pci_af_flr(dev, 0);
>   if (rc == 0)
>     return 0;
> 

Yeah, this is cleaner. I'll create a separate patch for that. 

> I found two cases where this would make a difference: reset_ivb_igd()
> returns -ENOMEM if pci_iomap() fails, and pci_pm_reset() returns
> -EINVAL if the device is not in D0.
> 
> In both cases we currently return the failure, but it would seem
> reasonable to me to try another reset method.
> 
> That could be done in a new patch before this one.  Then *this* patch
> could use -ETIMEDOUT instead of -ENOTTY, and I think the whole thing
> would become a little more readable.
> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
