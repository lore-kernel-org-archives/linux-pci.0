Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39444 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbbLKXap (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Dec 2015 18:30:45 -0500
Subject: Re: [PATCH v2] PCI/AER: enable SERR# forwarding for bridges and
 switches
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1449074998-9664-1-git-send-email-okaya@codeaurora.org>
 <20151204210622.GI20125@localhost> <5669E073.4000801@codeaurora.org>
 <20151210223742.GC367@localhost>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, izumi.taku@jp.fujitsu.com, jcm@redhat.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <566B5CA1.1010306@codeaurora.org>
Date: Fri, 11 Dec 2015 18:30:41 -0500
MIME-Version: 1.0
In-Reply-To: <20151210223742.GC367@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/10/2015 5:37 PM, Bjorn Helgaas wrote:
> On Thu, Dec 10, 2015 at 03:28:35PM -0500, Sinan Kaya wrote:
>> Hi Bjorn,
>>
>> On 12/4/2015 4:06 PM, Bjorn Helgaas wrote:
>>> I'm sitting on this for the moment because if you have _HPP, it seems
>>> like that should be enough to get SERR# forwarding turned on, and if
>>> it's not, I'd like to understand why.  So no hurry, but I'm waiting on
>>> your investigation.
>>>
>>> Bjorn
>>
>> Here is the overall summary after my investigation.
>>
>> It looks like the kernel covers the hotplug use case. This patch is
>> needed for systems without hotplug support and when the firmware is not
>> setting up the SERR.
> 
> Here's how I understand your results:
> 
>   Firmware   _HPP or     Devices      Hot-added    Hot-added
>   enables    _HPX sets   present at   root ports   endpoints
>   SERR#      SERR#       boot work    work         work
>   --------   ---------   ----------   ----------   ---------
>   no         no          no (1)       no (2)       no (4)
>   no         yes         yes          yes          yes
>   yes        no          yes          no (3)       no (5)
>   yes        yes         yes          yes          yes
> 
> Your patch fixes cases 1-3 above, but I don't think it fixes cases 4
> or 5.
> 

I think so. I don't supported 4 and 5 cases on our platform. But, I
could write up a patch if somebody can test it on such a platform.

> The difference is that in cases 2 and 3, when we hot-add a root port,
> the AER driver binds to the root port and (with your patch) enables
> SERR for anything below it.
> 
> But in cases 4 and 5, the root port is already there, the AER driver
> has already bound to it.  The AER driver tried to enable SERR for the
> hierarchy below the root port, but there was nothing there.  Now we
> add the endpoint, and the AER driver isn't involved, so I don't think
> anything will enable SERR for the new endpoint.
> 
> I think the best way to fix all the cases would be to do something in
> in pci_configure_device().  Then we could drop the AER bus walk in
> set_downstream_devices_error_reporting().  A bus walk like that is
> always an issue for hotplug.
> 

Let me read some code.

> In principle, we should be able to just enable PCI_COMMAND_SERR and
> PCI_BRIDGE_CTL_SERR for everything, and then errors would get
> forwarded to the root port, and if/when the AER driver claimed the
> root port, it would start collecting them.
> 
> But I'm a little leery of doing it unconditionally because there are a
> lot of platform- and driver-specific uses of those bits, and I'm
> afraid of breaking something.  It might be possible, but it'll take
> some care to do it safely.

Sure, when we were talking about ECRC the other day; you said we could
enable it on platforms post 2000 using some SMBIOS API. We could go the
same route here.

> 
>> after boot
>>
>> /# dmesg | grep hpp
>>
>> [    3.115227] pci 0004:01:00.0: program_hpp_type0:1376
>> [    3.128870] pci 0004:01:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.149597] pci 0004:01:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [    3.191601] pci 0004:02:08.0: program_hpp_type0:1376
>> [    3.191611] pci 0004:02:08.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.206630] pci 0004:02:08.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [    3.253760] pci 0004:03:00.0: program_hpp_type0:1376
>> [    3.267335] pci 0004:03:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.288046] pci 0004:03:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [    3.355296] pci 0004:04:00.0: program_hpp_type0:1376
>> [    3.355306] pci 0004:04:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.370334] pci 0004:04:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>>
>> / # lspci
>> 00:00.0 Class 0604: 17cb:0400
>> 01:00.0 Class 0604: 10b5:8732
>> 02:08.0 Class 0604: 10b5:8732
>> 03:00.0 Class 0604: 10b5:8732
>> 04:00.0 Class 0604: 10b5:8732
>> / #
>>
>>
>> Without hpp in ACPI table, SERR is not enabled.
>>
>> /# dmesg | grep type0
>> /#
>>
>> Power up with HPP after boot.
>>
>> [    3.129325]_pci_0004:01:00.0:_program_hpp_type0:1376
>> [    3.143286] pci 0004:01:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.164016] pci 0004:01:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [    3.206019] pci 0004:02:08.0: program_hpp_type0:1376
>> [    3.206028] pci 0004:02:08.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.220609] pci 0004:02:08.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [    3.267783] pci 0004:03:00.0: program_hpp_type0:1376
>> [    3.281420] pci 0004:03:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.302197] pci 0004:03:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [    3.369684] pci 0004:04:00.0: program_hpp_type0:1376
>> [    3.369694] pci 0004:04:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [    3.384080] pci 0004:04:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>>
>> hotplug eject
>>
>> hotplug insert
>>
>> [   98.338131] pci 0004:01:00.0: program_hpp_type0:1376
>> [   98.351813] pci 0004:01:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [   98.373147] pci 0004:01:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [   98.452051] pci 0004:02:08.0: program_hpp_type0:1376
>> [   98.465772] pci 0004:02:08.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [   98.487142] pci 0004:02:08.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [   98.597579] pci 0004:03:00.0: program_hpp_type0:1376
>> [   98.611290] pci 0004:03:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [   98.632181] pci 0004:03:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> [   98.736153] pci 0004:04:00.0: program_hpp_type0:1376
>> [   98.750437] pci 0004:04:00.0: program_hpp_type0:1378 pci_cmd |=
>> PCI_COMMAND_SERR
>> [   98.771202] pci 0004:04:00.0: program_hpp_type0:1391 pci_bctl |=
>> PCI_BRIDGE_CTL_SERR
>> / #
>>
>>
>>
>> -- 
>> Sinan Kaya
>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
>> Linux Foundation Collaborative Project
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
