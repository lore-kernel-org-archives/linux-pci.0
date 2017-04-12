Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:64632
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753950AbdDLQAW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Apr 2017 12:00:22 -0400
Subject: Re: [v2] PCI: Add an option to control probing of VFs before enabling
 SR-IOV
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1490198038-20465-1-git-send-email-bodong@mellanox.com>
 <20170411211211.GB14778@bhelgaas-glaptop.roam.corp.google.com>
 <2e39e1b6-0205-2780-0223-3552d2c871a3@mellanox.com>
 <20170412152216.GA25197@bhelgaas-glaptop.roam.corp.google.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saeedm@mellanox.com>,
        Eli Cohen <eli@mellanox.com>
From: Bodong Wang <bodong@mellanox.com>
Message-ID: <601c08f0-ccc9-984f-0fce-5fc6012fe1f9@mellanox.com>
Date: Wed, 12 Apr 2017 11:00:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170412152216.GA25197@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/12/2017 10:22 AM, Bjorn Helgaas wrote:
> On Wed, Apr 12, 2017 at 09:37:22AM -0500, Bodong Wang wrote:
>> On 4/11/2017 4:12 PM, Bjorn Helgaas wrote:
>>> Hi Bodong,
>>>
>>> On Wed, Mar 22, 2017 at 05:53:58PM +0200, bodong@mellanox.com wrote:
>>>> From: Bodong Wang <bodong@mellanox.com>
>>>>
>>>> Sometimes it is not desirable to probe the virtual functions after
>>>> SRIOV is enabled. This can save host side resource usage by VF
>>>> instances which would be eventually probed to VMs.
>>>>
>>>> Add a new PCI sysfs interface "sriov_probe_vfs" to control that
>>> >from the PF, all current callers still retain the same functionality.
>>>> To modify it, echo 0/n/N (disable probe) or 1/y/Y (enable probe) to
>>>>
>>>> /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_probe_vfs
>>> Is this basically the same functionality as /sys/bus/pci/drivers_autoprobe,
>>> but limited to a specific PF?  I.e., could we accomplish the same thing
>>> with the following?
>>>
>>>    # echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>>>    # echo 0 > /sys/bus/pci/drivers_autoprobe
>>>    # echo 2 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
>>>    # echo 1 > /sys/bus/pci/drivers_autoprobe
>>>
>>> If not, can you contrast the above with drivers_autoprobe?  If we need
>>> both, should they be named more similarly?
>> Hi Bjorn,
>>
>> I agree with Alex about not using driver_autoprobe to achieve this.
>> It will affect all pci related device once it's disabled(probably in
>> a bad way).
> Alex mooted the idea of a generic driver core knob for devices that
> create child devices.  That's intriguing.  What other situations
> besides SR-IOV do this?  Maybe we could add a "drivers_autoprobe"
> inside the directory of each device that's capable of having child
> devices?
This seems interesting to me as well. Not sure if USB driver is 
applicable or not. And, drivers_autoprobe might work for USB if it 
doesn't probe the sub-device as default like sriov. Worth to take a look.
> If we continue with the current approach (instead of Alex's idea),
> I propose that you:
>
>    - Name your new knob "sriov_drivers_autoprobe" to be consistent with
>      other sriov sysfs files while also being parallel to
>      "drivers_autoprobe"
>
>    - Update Documentation/ABI/testing/sysfs-bus-pci to document your
>      new knob
>
>    - Update Documentation/ABI/... to document drivers_autoprobe
Ack, will send v3.

Thanks,

Bodong
