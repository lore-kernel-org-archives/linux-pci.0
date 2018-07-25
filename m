Return-Path: <SRS0=+K0T=KJ=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=+K0T=KJ=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 25 Jul 2018 13:59:16 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Keith
 Busch <keith.busch@intel.com>, linux-arm-msm@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <d34eb5da-0ae1-d455-93e2-2432ec7931ea@kernel.org>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
 <20180709160008.GA1490@wunner.de>
 <CAK9iUCMMVR114msKiMHu7ik0VK8T5j=LAYAKsEkdnocTqkdMjQ@mail.gmail.com>
 <20180720200123.GS128988@bhelgaas-glaptop.roam.corp.google.com>
 <2febe688-f973-5ff5-f61d-0451ad7d36ae@kernel.org>
 <d34eb5da-0ae1-d455-93e2-2432ec7931ea@kernel.org>
Message-ID: <5cdaf58f3c848b2a5097484cd703acae@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-21 11:37, Sinan Kaya wrote:
> On 7/20/2018 7:58 PM, Sinan Kaya wrote:
>> We need to figure out how to gracefully return inside hotplug driver
>> if link down happened and there is an error pending.
> 
> How about adding the following into the hotplug ISR?
> 
> 1. check if firmware first is disabled
> 2. check if there is a fatal error pending in the device_status 
> register
> of the PCI Express capability on the root port.
> 3. bail out from hotplug routine if this is the case.
> 4. otherwise, existing behavior.

This makes sense.

from Lukas's text

"
The user may turn the slot on/off via sysfs.  If an Attention Button
is present, the user may also press that button to turn the slot on/off
after 5 seconds.  Either way, it may cause pciehp's IRQ thread to run
concurrently to a reset initiated by the AER driver, independently of
any events signalled by the slot.
"

so if device gets removed and re-enumerated other than hotplug ISR,
or any other similar path has to take care of checking ERR_FATAL status.

Regards,
Oza.
