Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeGCLmX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 07:42:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 03 Jul 2018 07:42:22 -0400
From: okaya@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Coccinelle report for drivers/pci/
In-Reply-To: <20180703080910.GB21136@wunner.de>
References: <7db07760-49fe-e94b-62fc-556ba02c8e9e@codeaurora.org>
 <20180703080910.GB21136@wunner.de>
Message-ID: <770c6adfdba8c02a2eeae336217b00d2@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-07-03 04:09, Lukas Wunner wrote:
> On Mon, Jul 02, 2018 at 09:45:55PM -0400, Sinan Kaya wrote:
>> drivers/pci/hotplug/pciehp_pci.c:67:5-7: Unneeded variable: "rc". 
>> Return "0" on line 110
> 
> Fixed by
> https://patchwork.ozlabs.org/patch/930379/
> 
> 
>> drivers/pci/hotplug/pcihp_skeleton.c:98:5-11: Unneeded variable: 
>> "retval". Return "0" on line 106
>> drivers/pci/hotplug/pcihp_skeleton.c:84:5-11: Unneeded variable: 
>> "retval". Return "0" on line 92
>> drivers/pci/hotplug/pcihp_skeleton.c:201:5-11: Unneeded variable: 
>> "retval". Return "0" on line 210
>> drivers/pci/hotplug/pcihp_skeleton.c:171:5-11: Unneeded variable: 
>> "retval". Return "0" on line 180
>> drivers/pci/hotplug/pcihp_skeleton.c:186:5-11: Unneeded variable: 
>> "retval". Return "0" on line 195
>> drivers/pci/hotplug/pcihp_skeleton.c:156:5-11: Unneeded variable: 
>> "retval". Return "0" on line 165
>> drivers/pci/hotplug/pcihp_skeleton.c:137:5-11: Unneeded variable: 
>> "retval". Return "0" on line 150
>> drivers/pci/hotplug/pcihp_skeleton.c:112:5-11: Unneeded variable: 
>> "retval". Return "0" on line 131
> 
> Fixed by 6c9c6bd4e2c8 ("PCI: hotplug: Delete skeleton driver"),
> queued on Bjorn's pci/hotplug branch for 4.19.

Thanks, glad to hear we are doing some house cleaning.
