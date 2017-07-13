Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:47119
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750808AbdGMGDM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jul 2017 02:03:12 -0400
Subject: Re: [PATCH] microblaze/PCI: Remove pcibios_setup_bus_{self/devices}
 dead code
To: Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20170620130844.11109-1-lorenzo.pieralisi@arm.com>
 <20170713023808.GB4486@bhelgaas-glaptop.roam.corp.google.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <154db2a9-3051-71b7-384c-04e4a29c38c0@xilinx.com>
Date: Thu, 13 Jul 2017 08:02:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170713023808.GB4486@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 13.7.2017 04:38, Bjorn Helgaas wrote:
> On Tue, Jun 20, 2017 at 02:08:44PM +0100, Lorenzo Pieralisi wrote:
>> commit 01cf9d524ff0 ("microblaze/PCI: Support generic Xilinx AXI PCIe Host
>> Bridge IP driver") removed pcibios calls to:
>>
>> pcibios_setup_bus_self()
>> pcibios_setup_bus_devices()
>>
>> Given that pcibios_fixup_bus() was the only caller of those functions
>> they have now become dead code (along with the functions they were
>> calling in turn) so they can be removed.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Bharat Kumar Gogada <bharatku@xilinx.com>
>> Cc: Ravi Kiran Gummaluri <rgummal@xilinx.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
> 
> Applied with Michal's ack to pci/misc for v4.14, thanks!
> 
> I also removed the "Fixup resources of a PCI<->PCI bridge" comment
> since it's no longer applicable.

Thanks,
Michal
