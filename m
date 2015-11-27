Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:6830 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbbK0U4H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2015 15:56:07 -0500
Subject: Re: [PATCH v4 2/5] PCI: iproc: Add PAXC interface support
To: Arnd Bergmann <arnd@arndb.de>
References: <1448645868-5730-1-git-send-email-rjui@broadcom.com>
 <1448645868-5730-3-git-send-email-rjui@broadcom.com>
 <2502233.oJMLi3GpfH@wuerfel>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <5658C365.5080209@broadcom.com>
Date: Fri, 27 Nov 2015 12:56:05 -0800
MIME-Version: 1.0
In-Reply-To: <2502233.oJMLi3GpfH@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On 11/27/2015 12:22 PM, Arnd Bergmann wrote:
> On Friday 27 November 2015 09:37:45 Ray Jui wrote:
>>
>> +static const struct of_device_id iproc_pcie_of_match_table[] = {
>> +       {
>> +               .compatible = "brcm,iproc-pcie",
>> +               .data = (int *)IPROC_PCIE_PAXB,
>> +       }, {
>> +               .compatible = "brcm,iproc-pcie-paxc",
>> +               .data = (int *)IPROC_PCIE_PAXC,
>> +       },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
>
> You seem to only need the identifiers in order to set a single
> pointer, so just point to that array directly.

Not just a single pointer. This sets the iProc PCIe interface type, 
which is an enum. Based on the interface type, both the iProc PCIe core 
driver and the iProc PCIe MSI driver can 1) load the correct set of 
register offsets; 2) skip/invoke some of the link detection, controller 
reset related behaviors; 3) setting up the correct number of MSI event 
queue regions and MSI address regions.

> Alternatively,
> do the more common thing and point to a structure of function
> pointers and have different implementations of the low-level
> access functions there.

I thought about replacing the reset and link check functions in 
pcie-iproc.c with callbacks but felt it has not reached the point where 
we need callbacks to completely differentiate the operations. I'm hoping 
to wait until I see the next revision of PAXC (PAXC v2) implementation 
in the next-gen iProc SoC to make the call....

Note even with the callback approach, it would not change much of the 
pcie-iproc-platform.c here, which still needs to pass in just the 
interface information but no more than that. Main reason being the core 
driver and MSI drivers are used by both the platform driver and BCMA 
driver, and I do not want to duplicate the callback implementation at 
the bus driver level.

>
> 	Arnd
>

Thanks,

Ray
