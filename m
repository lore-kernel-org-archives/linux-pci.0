Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43569 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbbCFR6I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Mar 2015 12:58:08 -0500
Message-ID: <54F9EAA8.30007@ti.com>
Date: Fri, 6 Mar 2015 12:58:00 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Fengguang Wu <fengguang.wu@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, LKP <lkp@01.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PCI] BUG: unable to handle kernel
References: <20150306060631.GD28187@wfg-t540p.sh.intel.com> <54F9C407.5020602@ti.com> <54F9CC6B.5070803@ti.com> <20150306165504.GA30094@roeck-us.net>
In-Reply-To: <20150306165504.GA30094@roeck-us.net>
Content-Type: multipart/mixed;
	boundary="------------030700000309030004040609"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------030700000309030004040609
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2015 11:55 AM, Guenter Roeck wrote:
> On Fri, Mar 06, 2015 at 10:48:59AM -0500, Murali Karicheri wrote:
> [ ... ]
>
>> > From 098b4f5e4ab9407fbdbfcca3a91785c17e25cf03 Mon Sep 17 00:00:00 2001
>> From: Murali Karicheri<m-karicheri2@ti.com>
>> Date: Fri, 6 Mar 2015 10:23:08 -0500
>> Subject: [PATCH] pci: of : fix kernel crash
>>
>> This is a debug patch to root cause the kernel crash
>>
>> 	commit 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6
>>
>> 	PCI: Update DMA configuration from DT
>>
>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>> ---
>>   drivers/of/of_pci.c       |    8 ++++++++
>>   drivers/pci/host-bridge.c |    5 +++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>> index 86d3c38..5a59fb8 100644
>> --- a/drivers/of/of_pci.c
>> +++ b/drivers/of/of_pci.c
>> @@ -129,6 +129,14 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
>>   	struct device *dev =&pci_dev->dev;
>>   	struct device *bridge = pci_get_host_bridge_device(pci_dev);
>>
>> +	if (!bridge || !bridge->parent) {
>> +		if (!bridge)
>> +			pr_err("PCI bridge not found\n");
>> +		if (!bridge->parent)
>> +			pr_err("PCI bridge parent not found\n");
>
> You'll see a crash here if bridge is NULL. Maybe add an else before the second
> if statement ? Also, dev_err might be a bit more useful and would be available.
>
Fixed and attached.

Murali
> Thanks,
> Guenter
>
>> +		return;
>> +	}
>> +
>>   	of_dma_configure(dev, bridge->parent->of_node);
>>   	pci_put_host_bridge_device(bridge);
>>   }
>> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
>> index 3e5bbf9..ef2ab51 100644
>> --- a/drivers/pci/host-bridge.c
>> +++ b/drivers/pci/host-bridge.c
>> @@ -28,6 +28,11 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev)
>>   	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
>>   	struct device *bridge = root_bus->bridge;
>>
>> +	if (!bridge) {
>> +		pr_err("PCI: bridge not found\n");
>> +		return NULL;
>> +	}
>> +
>>   	kobject_get(&bridge->kobj);
>>   	return bridge;
>>   }
>> --
>> 1.7.9.5
>>
>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments

--------------030700000309030004040609
Content-Type: text/x-diff; name="0001-pci-of-fix-kernel-crash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-pci-of-fix-kernel-crash.patch"

>From 4965a4580e0ffe13e7e6e9fd58d6e56b08c730c4 Mon Sep 17 00:00:00 2001
From: Murali Karicheri <m-karicheri2@ti.com>
Date: Fri, 6 Mar 2015 10:23:08 -0500
Subject: [PATCH] pci: of : fix kernel crash

This is a debug patch to root cause the kernel crash

	commit 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6

	PCI: Update DMA configuration from DT

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/of/of_pci.c       |    9 +++++++++
 drivers/pci/host-bridge.c |    5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 86d3c38..6e1b111 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -129,6 +129,15 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
 	struct device *dev = &pci_dev->dev;
 	struct device *bridge = pci_get_host_bridge_device(pci_dev);
 
+	if (!bridge || !bridge->parent) {
+		if (!bridge)
+			dev_err(&pci_dev->dev, "PCI bridge not found\n");
+		else if (!bridge->parent)
+			dev_err(&pci_dev->dev,
+				"PCI bridge parent not found\n");
+		return;
+	}
+
 	of_dma_configure(dev, bridge->parent->of_node);
 	pci_put_host_bridge_device(bridge);
 }
diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 3e5bbf9..ba642b8 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -28,6 +28,11 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev)
 	struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
 	struct device *bridge = root_bus->bridge;
 
+	if (!bridge) {
+		dev_err(&dev->dev, "PCI: bridge not found\n");
+		return NULL;
+	}
+
 	kobject_get(&bridge->kobj);
 	return bridge;
 }
-- 
1.7.9.5


--------------030700000309030004040609--
