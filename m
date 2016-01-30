Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35730 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591AbcA3AOc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 19:14:32 -0500
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org> <20160129230645.GG12965@localhost>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56AC0065.5030909@codeaurora.org>
Date: Fri, 29 Jan 2016 19:14:29 -0500
MIME-Version: 1.0
In-Reply-To: <20160129230645.GG12965@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/29/2016 6:06 PM, Bjorn Helgaas wrote:
> On Wed, Jan 20, 2016 at 11:13:04AM -0500, Sinan Kaya wrote:
>> On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
>>>
>>> We want to get rid of PCI_PROBE_ONLY on ARM/ARM64:
>>
>> For platforms that does not have UEFI BIOS, it makes sense to remove the probe only
>> option as the firmware is not doing anything.
> 
> I don't understand this statement.  It sounds like you mean "non-UEFI
> BIOS firmware doesn't assign PCI BARs", but that's not true, so you
> must mean something else.

It depends on the firmware flavor. I know u-boot does some PCI assignment but it does minimum
to use PCI itself not for OS consumption. It may not deal with with switches/bridges etc. or 
will only assign mem32 resources and not touch prefetchable. 

Most non-UEFI firmwares I have seen on ARM rely on device specific driver
like synopsys etc. to do the device initialization and ask kernel to do the enumeration.

ACPI systems on the other hand handle the resource assignment before the OS starts.

> 
>> For server like arm64 platforms, the behavior should be identical to
>> x86 world. 
> 
>> The UEFI BIOS sets up the resources, kernel uses the resources.
> 
> Is there actually a requirement that a UEFI BIOS assign resources to
> PCI BARs?   I know that historically, x86 BIOS has set up most or all
> PCI BARs.  But I thought there was something in UEFI that relaxed
> that, so it would only have to program BARs for the boot and console
> devices it actually needed.  But I can't find a spec reference either
> way.

I don't have a spec reference. This statement was purely out of x86 experience not based on some
spec. We are trying to follow the PC model.

> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
