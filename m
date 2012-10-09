Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab2JIQMJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 9 Oct 2012 12:12:09 -0400
Message-ID: <50744CD1.6080105@redhat.com>
Date: Tue, 09 Oct 2012 12:12:01 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com,
	yuvalmin@broadcom.com, bhutchings@solarflare.com,
	gregory.v.rose@intel.com, davem@davemloft.net
Subject: Re: [RFC v2] PCI: sysfs per device SRIOV control and status
References: <1349388885-43938-1-git-send-email-ddutile@redhat.com> <5070768C.4030905@gmail.com>
In-Reply-To: <5070768C.4030905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/06/2012 02:21 PM, Alexander Duyck wrote:
> On 10/4/2012 3:14 PM, Donald Dutile wrote:
>> Provide files under sysfs to determine the max number of vfs
>> an SRIOV-capable PCIe device supports, and methods to enable and
>> disable the vfs on a per device basis.
>>
>> Currently, VF enablement by SRIOV-capable PCIe devices is done
>> in driver-specific module parameters. If not setup in modprobe files,
>> it requires admin to unload & reload PF drivers with number of desired
>> VFs to enable. Additionally, the enablement is system wide: all
>> devices controlled by the same driver have the same number of VFs
>> enabled. Although the latter is probably desired, there are PCI
>> configurations setup by system BIOS that may not enable that to occur.
>>
>> Three files are created if a PCIe device has SRIOV support:
>> sriov_max_vfs -- cat-ing this file returns the maximum number
>> of VFs a PCIe device supports.
>> sriov_enable_vfs -- echo'ing a number to this file enables this
>> number of VFs for this given PCIe device.
>> -- cat-ing this file will return the number of VFs
>> currently enabled on this PCIe device.
>> sriov_disable_vfs -- echo-ing any number other than 0 disables all
>> VFs associated with this PCIe device.
>>
>> VF enable and disablement is invoked much like other PCIe
>> configuration functions -- via registered callbacks in the driver,
>> i.e., probe, release, etc.
>>
>> v1->v2:
>> This patch is based on previous 2 patches by Yinghai Lu
>> that cleaned up the vga attributes for PCI devices under sysfs,
>> and uses visibility-checking group attributes as recommended by
>> Greg K-H.
>>
>> Signed-off-by: Donald Dutile <ddutile@redhat.com>
>
> I'm not certain if having separate values/functions for enable and disabling VFs will work out very well. It seems like it would probably make more sense just to have one value that manipulates NumVFs. As is, in the sriov_enable_vfs case we would end up having to disable SR-IOV should we be changing the number of VFs anyway so it would probably make sense to just merge both values into a single one and use 0 as the value to disable SR-IOV.
>
> Also in the naming scheme for the values it may preferable to use the names of the values from the SR-IOV PCIe capability to avoid any confusion on what the values represent. I believe the names for the two values you are representing are TotalVFs and NumVFs.
>
> Thanks,
>
> Alex
Agreed!
The reason I changed the names from 'set_max_vfs' to 'sriov_enable_vfs' was to
not confuse terms.  I think the 'set_max_vfs' was taken from the context that the
drivers currently set the number of enabled vfs by a driver param named 'max_vfs' today;
maybe that should be changed as well to 'numvfs'.

If patches go as you & Greg Rose suggest, then 'sriov_number_vfs' becomes 'sriov_totalvfs'.
cat'ing the (renamed sriov_enable_vfs to ) 'sriov_numvfs' would work.
  

