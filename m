Return-Path: <SRS0=fqZp=FP=cavium.com=George.Cherian@kernel.org>
Return-Path: <SRS0=fqZp=FP=cavium.com=George.Cherian@kernel.org>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, Jayachandran.Nair@cavium.com,
 Robert.Richter@cavium.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Huang Ying <ying.huang@intel.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
Date: Wed, 21 Feb 2018 16:25:08 +0530
MIME-Version: 1.0
In-Reply-To: <20180221095435.xe5lmes7mpxca3en@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lukas,

On 02/21/2018 03:24 PM, Lukas Wunner wrote:
> On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
>> I will explain the setup used
>> To the Cavium ThunderX RC the following PLX device is connected.
>> PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 GT/s)
>> Switch
>> There is no device connected downstream to the PLX switch.
>>
>> AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms
>> since pci_bridge_d3_possible() returns true.
>>
>> And later pci_sysfs_init() ends up doing a config access of PLX which fails
>> with a "synchronous external abort"
> 
> Then you're missing a pci_config_pm_runtime_get() in pci_sysfs_init() or
> further down in the call stack, rather than a quirk which just papers
> over the issue.

I have found another configuration where this fails.
Following is the configuration
1) Connected a PCIe Intel i40 card under the root port.
2) unbind the i40 driver and bind with vfio-pci driver.
3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"

I get the same synchronous external abort.
In this case the vfio-pci driver probe it moves the device (i40) to
D3hot provided disable_idle_d3 is not set. lspci tries to do
the config_access which fails with synchronous external abort when
the root port transitions to D3hot.
> 
> Thanks,
> 
> Lukas
> 
Regards,
-George
