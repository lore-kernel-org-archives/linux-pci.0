Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:59679
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754106AbdDLOhk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 10:37:40 -0400
Subject: Re: [v2] PCI: Add an option to control probing of VFs before enabling
 SR-IOV
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1490198038-20465-1-git-send-email-bodong@mellanox.com>
 <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saeedm@mellanox.com>,
        Eli Cohen <eli@mellanox.com>
From: Bodong Wang <bodong@mellanox.com>
Message-ID: <2e39e1b6-0205-2780-0223-3552d2c871a3@mellanox.com>
Date: Wed, 12 Apr 2017 09:37:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/11/2017 4:12 PM, Bjorn Helgaas wrote:
> Hi Bodong,
>
> On Wed, Mar 22, 2017 at 05:53:58PM +0200, bodong@mellanox.com wrote:
>> From: Bodong Wang <bodong@mellanox.com>
>>
>> Sometimes it is not desirable to probe the virtual functions after
>> SRIOV is enabled. This can save host side resource usage by VF
>> instances which would be eventually probed to VMs.
>>
>> Add a new PCI sysfs interface "sriov_probe_vfs" to control that
>> from the PF, all current callers still retain the same functionality.
>> To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
>>
>> /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
> Is this basically the same functionality as /sys/bus/pci/drivers_autoprobe,
> but limited to a specific PF?  I.e., could we accomplish the same thing
> with the following?
>
>    # echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>    # echo 0 > /sys/bus/pci/drivers_autoprobe
>    # echo 2 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>    # echo 1 > /sys/bus/pci/drivers_autoprobe
>
> If not, can you contrast the above with drivers_autoprobe?  If we need
> both, should they be named more similarly?
Hi Bjorn,

I agree with Alex about not using driver_autoprobe to achieve this. It 
will affect all pci related device once it's disabled(probably in a bad 
way). On the other hand, current pci driver doesn't work for this use 
case at all. VFs drivers(if any) will be probed once sriov is enabled no 
matter what. The code path is pci_enable_sriov-> 
pci_bus_add_device->device_attach, and drivers will be probed at the 
end. Drivers_autoprobe only prevents probing pci_device_add is called. 
This patch bounded the change to the device itself and requires no 
device driver update.

For the name convention, it's aligned with other sriov related sysfs 
entries. Let me know if you have better options.

Thanks,

Bodong
