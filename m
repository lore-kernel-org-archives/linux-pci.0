Return-Path: <SRS0=2Oyo=DB=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=2Oyo=DB=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH -next] pci: add function stub for
 pci_get_domain_bus_and_slot()
To: Bjorn Helgaas <helgaas@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Guenter Roeck <linux@roeck-us.net>,
 LKML <linux-kernel@vger.kernel.org>, Fengguang Wu <fengguang.wu@intel.com>
References: <80e3c9bb-fb65-4d87-76f9-db7c1273cef3@infradead.org>
 <20171205203920.GI23510@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <919704f8-5b26-0f45-c8df-53154de470b6@codeaurora.org>
Date: Tue, 5 Dec 2017 15:50:03 -0500
MIME-Version: 1.0
In-Reply-To: <20171205203920.GI23510@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 12/5/2017 3:39 PM, Bjorn Helgaas wrote:
> [+cc Sinan]
> 
> On Tue, Nov 28, 2017 at 02:31:21PM -0800, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> The coretemp driver build fails when CONFIG_PCI is not enabled
>> because it uses a function that does not have a stub for that
>> config case, so add the function stub.
>>
>> ../drivers/hwmon/coretemp.c: In function 'adjust_tjmax':
>> ../drivers/hwmon/coretemp.c:250:9: error: implicit declaration of function 'pci_get_domain_bus_and_slot' [-Werror=implicit-function-declaration]
>>   struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
>> ../drivers/hwmon/coretemp.c:250:32: warning: initialization makes pointer from integer without a cast [enabled by default]
>>   struct pci_dev *host_bridge = pci_get_domain_bus_and_slot(0, 0, devfn);
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Applied with Guenter's ack to pci/enumeration for v4.16, thanks!
> 
> Apparently no other code calls pci_get_domain_bus_and_slot() when
> CONFIG_PCI isn't enabled.
> 
> 15ab6790f628 ("hwmon: (coretemp) deprecate pci_get_bus_and_slot()") is
> already in linux-next via hwmon-staging.
> 
> The pci tree is merged into next slightly before hwmon-staging, so
> this should be resolved as soon as the 0-day builder builds my
> pci/enumeration branch and I merge it into my next branch.
> 

Thanks for catching this. I assumed we do have a stub. It turns out we
don't.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
