Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51397 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbbCKP0R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Mar 2015 11:26:17 -0400
Message-ID: <55005E82.4050607@ti.com>
Date: Wed, 11 Mar 2015 11:25:54 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
CC: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Suravee Suthikulanit <Suravee.Suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] pci: of : fix BUG: unable to handle kernel
References: <1426001139-18419-1-git-send-email-m-karicheri2@ti.com> <CAL_JsqJPvW5q4XwwenFTHrDG4cU5uTd7n-vLKj0mdV9FbVC4Ag@mail.gmail.com>
In-Reply-To: <CAL_JsqJPvW5q4XwwenFTHrDG4cU5uTd7n-vLKj0mdV9FbVC4Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/11/2015 08:35 AM, Rob Herring wrote:
> On Tue, Mar 10, 2015 at 10:25 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
>> On some platforms such as that based on x86, ia64 etc, root bus is
>> created with parent node passed in as NULL to pci_create_root_bus().
>> On these platforms, the patch series "PCI: get DMA configuration from
>> parent device" when applied causes kernel crash. So add a check for this
>> in of_pci_dma_configure()
>
> Wouldn't these arches have OF disabled and call an empty function?
The current patch series does have a empty function if OF is disabled.
> Regardless, we still need this.
These archs have OF enabled, but they call  pci_create_root_bus() with 
NULL parent node passed in. That is why the crash happens.

Murali
>
>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>
> I'm assuming Bjorn will apply this.
>
> Acked-by: Rob Herring<robh@kernel.org>
>
>> ---
>>   drivers/of/of_pci.c |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>> index 86d3c38..a8e485c 100644
>> --- a/drivers/of/of_pci.c
>> +++ b/drivers/of/of_pci.c
>> @@ -129,6 +129,10 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
>>          struct device *dev =&pci_dev->dev;
>>          struct device *bridge = pci_get_host_bridge_device(pci_dev);
>>
>> +       /* Some platforms can have bridge->parent set to NULL */
>> +       if (!bridge->parent)
>> +               return;
>> +
>>          of_dma_configure(dev, bridge->parent->of_node);
>>          pci_put_host_bridge_device(bridge);
>>   }
>> --
>> 1.7.9.5
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
