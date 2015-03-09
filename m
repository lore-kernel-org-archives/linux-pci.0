Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <54FDAB8B.3010404@ti.com>
References: <20150306060631.GD28187@wfg-t540p.sh.intel.com>
 <54F9C407.5020602@ti.com> <54F9CC6B.5070803@ti.com> <20150306165504.GA30094@roeck-us.net>
 <54F9EAA8.30007@ti.com> <54FDAB8B.3010404@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Mar 2015 09:44:31 -0500
Message-ID: <CAErSpo52A+S-SSp2TG=W3oskyg_pgg9LYZzrissvfTogTSazPg@mail.gmail.com>
Subject: Re: [PCI] BUG: unable to handle kernel
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 9, 2015 at 9:17 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
> On 03/06/2015 12:58 PM, Murali Karicheri wrote:
>>
>> On 03/06/2015 11:55 AM, Guenter Roeck wrote:
>>>
>>> On Fri, Mar 06, 2015 at 10:48:59AM -0500, Murali Karicheri wrote:
>>> [ ... ]
>>>
>>>> > From 098b4f5e4ab9407fbdbfcca3a91785c17e25cf03 Mon Sep 17 00:00:00 2001
>>>> From: Murali Karicheri<m-karicheri2@ti.com>
>>>> Date: Fri, 6 Mar 2015 10:23:08 -0500
>>>> Subject: [PATCH] pci: of : fix kernel crash
>>>>
>>>> This is a debug patch to root cause the kernel crash
>>>>
>>>> commit 0b2af171520e5d5e7d5b5f479b90a6a5014d9df6
>>>>
>>>> PCI: Update DMA configuration from DT
>>>>
>>>> Signed-off-by: Murali Karicheri<m-karicheri2@ti.com>
>>>> ---
>>>> drivers/of/of_pci.c | 8 ++++++++
>>>> drivers/pci/host-bridge.c | 5 +++++
>>>> 2 files changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>>>> index 86d3c38..5a59fb8 100644
>>>> --- a/drivers/of/of_pci.c
>>>> +++ b/drivers/of/of_pci.c
>>>> @@ -129,6 +129,14 @@ void of_pci_dma_configure(struct pci_dev *pci_dev)
>>>> struct device *dev =&pci_dev->dev;
>>>> struct device *bridge = pci_get_host_bridge_device(pci_dev);
>>>>
>>>> + if (!bridge || !bridge->parent) {
>>>> + if (!bridge)
>>>> + pr_err("PCI bridge not found\n");
>>>> + if (!bridge->parent)
>>>> + pr_err("PCI bridge parent not found\n");
>>>
>>>
>>> You'll see a crash here if bridge is NULL. Maybe add an else before
>>> the second
>>> if statement ? Also, dev_err might be a bit more useful and would be
>>> available.
>>>
>> Fixed and attached.
>>
>> Murali
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> + return;
>>>> + }
>>>> +
>>>> of_dma_configure(dev, bridge->parent->of_node);
>>>> pci_put_host_bridge_device(bridge);
>>>> }
>>>> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
>>>> index 3e5bbf9..ef2ab51 100644
>>>> --- a/drivers/pci/host-bridge.c
>>>> +++ b/drivers/pci/host-bridge.c
>>>> @@ -28,6 +28,11 @@ struct device *pci_get_host_bridge_device(struct
>>>> pci_dev *dev)
>>>> struct pci_bus *root_bus = find_pci_root_bus(dev->bus);
>>>> struct device *bridge = root_bus->bridge;
>>>>
>>>> + if (!bridge) {
>>>> + pr_err("PCI: bridge not found\n");
>>>> + return NULL;
>>>> + }
>>>> +
>>>> kobject_get(&bridge->kobj);
>>>> return bridge;
>>>> }
>>>> --
>>>> 1.7.9.5
>>>>
>>>
>>
> BJorn,
>
> Any chance of applying the attached debug patch to see if this fixes and
> provide some additional information on this BUG? Not sure who will pick this
> one and apply.

The change that caused the oops (0b2af171520e ("PCI: Update DMA
configuration from DT")) only exists on my pci/iommu branch, so I'm
the one to apply it.

It's much easier for me to deal with plain text patches (not attachments).

I'm hesitating because I don't want to encourage use of the 0-day
testing robot as a tool at which we can just throw debug patches.  The
robot is a service that costs somebody real money, and I want to be a
good neighbor when using it.

Was the information in the robot's report enough to reproduce the
oops?  If not, is there additional information we could add to the
report that would enable you to reproduce it?  Even if we can't
reproduce the oops, the report seems detailed enough that we should be
able to deduce the problem and produce a fix in which we have high
confidence.

Bjorn
