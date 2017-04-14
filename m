Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve1eur01on0045.outbound.protection.outlook.com ([104.47.1.45]:42900
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751720AbdDNPob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Apr 2017 11:44:31 -0400
Subject: Re: [v3] PCI: Add an option to control probing of VFs before enabling
 SR-IOV
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1492037500-84654-1-git-send-email-bodong@mellanox.com>
 <20170414153718.GD29349@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <saeedm@mellanox.com>, Eli Cohen <eli@mellanox.com>
From: Bodong Wang <bodong@mellanox.com>
Message-ID: <e11e080f-241e-7d6e-832d-7e5d819dfc57@mellanox.com>
Date: Fri, 14 Apr 2017 10:44:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170414153718.GD29349@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/14/2017 10:37 AM, Bjorn Helgaas wrote:
> On Thu, Apr 13, 2017 at 01:51:40AM +0300, bodong@mellanox.com wrote:
>> From: Bodong Wang <bodong@mellanox.com>
>>
>> Sometimes it is not desirable to probe the virtual functions after
>> SRIOV is enabled. This can save host side resource usage by VF
>> instances which would be eventually probed to VMs.
>>
>> Add a new PCI sysfs interface "sriov_drivers_autoprobe" to control
>> that from the PF, all current callers still retain the same
>> functionality. To modify it, echo 0/n/N (disable probe) or 1/y/Y
>> (enable probe) to:
>>
>> /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
>>
>> Note that, the choice must be made before enabling VFs. The change
>> will not take effect if VFs are already enabled. Simply, one can set
>> sriov_numvfs to 0, choose whether to probe or not, and then resume
>> sriov_numvfs.
>>
>> Signed-off-by: Bodong Wang <bodong@mellanox.com>
>> Signed-off-by: Eli Cohen <eli@mellanox.com>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>> Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
> Applied to pci/virtualization for v4.12, thanks, Bodong!
Thank you! Bjorn/Alex/Gavin.
