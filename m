Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeIOEJK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Sep 2018 00:09:10 -0400
Subject: Re: [PATCH v2 6/6] PCI: Expose reset type to users of pci_reset_bus()
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Xu <peterx@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
References: <20180914211808.2564-1-okaya@kernel.org>
 <20180914211808.2564-7-okaya@kernel.org> <20180914163321.2abba9fa@t450s.home>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <65a9cc69-fd96-fa45-e271-cf2c7b1adb75@kernel.org>
Date: Fri, 14 Sep 2018 18:52:37 -0400
MIME-Version: 1.0
In-Reply-To: <20180914163321.2abba9fa@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/14/2018 6:33 PM, Alex Williamson wrote:
>> @@ -1015,7 +1015,7 @@ static long vfio_pci_ioctl(void *device_data,
>>   						    &info, slot);
>>   		if (!ret)
>>   			/* User has access, do the reset */
>> -			ret = pci_reset_bus(vdev->pdev);
>> +			ret = pci_reset_bus(vdev->pdev, PCI_RESET_LINK);
> This should have switched back the control we had prior to 811c5cb37df4
> with something like:
> 
> 	ret = pci_reset_bus(vdev->pdev,
> 			slot ? PCI_RESET_SLOT :	PCI_RESET_BUS);
> 
>>   
>>   hot_reset_release:
>>   		for (i--; i >= 0; i--)
>> @@ -1390,7 +1390,7 @@ static void vfio_pci_try_bus_reset(struct vfio_pci_device *vdev)
>>   	}
>>   
>>   	if (needs_reset)
>> -		ret = pci_reset_bus(vdev->pdev);
>> +		ret = pci_reset_bus(vdev->pdev, PCI_RESET_LINK);
> Same here.

Sure I can do that.
