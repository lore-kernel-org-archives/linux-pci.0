Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47936 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeDZTp7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 15:45:59 -0400
Subject: Re: [PATCH 1/2] PCI: Add pci_bus_specific_read_dev_vendor_id() to
 workaround PCI switch specific issues prior to accessing newly added endpoint
To: James Puthukattukaran <james.puthukattukaran@oracle.com>,
        kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Alex Williamson <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <16461819-82a1-8122-4a30-842f9a078988@oracle.com>
 <201804261426.2HZUSMma%fengguang.wu@intel.com>
 <32d9b7ce-0993-c749-3285-a51146fe37d6@oracle.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3292f826-077d-88f5-0406-947476777c43@codeaurora.org>
Date: Thu, 26 Apr 2018 15:45:56 -0400
MIME-Version: 1.0
In-Reply-To: <32d9b7ce-0993-c749-3285-a51146fe37d6@oracle.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/26/2018 3:32 PM, James Puthukattukaran wrote:
>> All errors (new ones prefixed by >>):
>>
>>    drivers/pci/probe.o: In function `pci_bus_read_dev_vendor_id':
>>>> probe.c:(.text+0x3e02): undefined reference to `pci_bus_specific_read_dev_vendor_id'
> Alex/Sinan -
> 
> Would it be an acceptable fix for this problem?
> 
> 
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2097,6 +2097,13 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
>  	return true;
>  }
>  
> +int __weak pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn, 
> +					u32 *l, int timeout)
> +{
> +	return -ENOTTY;
> +}
> +
> +

I don't think so. pci_bus_specific_read_dev_vendor_id() is defined in quirks.c if
CONFIG_PCI_QUIRKS is defined only. 

You need to add something similar to drivers/pci.h file

#ifdef CONFIG_PCI_QUIRKS
int pci_dev_specific_reset(struct pci_dev *dev, int probe);
#else
static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
{
	return -ENOTTY;
}
#endif 


while you are there please convert

> +
> +

to 

> +

in your patch and bump the version number on your next post using 

--subject-prefix="PATCH V2"

to your git send-email command.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
