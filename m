Return-Path: <SRS0=uRZx=ZT=ti.com=kishon@kernel.org>
Return-Path: <SRS0=uRZx=ZT=ti.com=kishon@kernel.org>
Subject: Re: [PATCH 0/5] PCI: dwc: miscellaneous cleanups and fixes
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1484136415-20798-1-git-send-email-kishon@ti.com>
 <20170203200638.GE10291@bhelgaas-glaptop.roam.corp.google.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58986BD1.2020803@ti.com>
Date: Mon, 6 Feb 2017 17:58:01 +0530
MIME-Version: 1.0
In-Reply-To: <20170203200638.GE10291@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>



On Saturday 04 February 2017 01:36 AM, Bjorn Helgaas wrote:
> On Wed, Jan 11, 2017 at 05:36:50PM +0530, Kishon Vijay Abraham I wrote:
>> This series includes miscellaneous cleanups and fixes in dra7xx
>> pci driver and it also adds COMPILE_TEST to all designware
>> based drivers (except dra7xx driver and hisi driver), since
>> dra7xx driver doesn't depend on architecture specific config and
>> hisi driver is compiled based on only ARM64.
>>
>> These patches have been created after applying [1].
>>
>> [1] -> https://lkml.org/lkml/2017/1/6/246
>>
>> Kishon Vijay Abraham I (5):
>>   PCI: dwc: Add COMPILE_TEST to all designware based drivers
>>   PCI: dwc: dra7xx: Simplify the probe code
>>   PCI: dwc: dra7xx: Add support to force RC to work in GEN1 mode
>>   PCI: dwc: dra7xx: Enable MSI and legacy interrupts simultaneously
>>   PCI: dwc: dra7xx: Group phy API invocations
>>
>>  drivers/pci/dwc/Kconfig      |   16 ++--
>>  drivers/pci/dwc/pci-dra7xx.c |  174 ++++++++++++++++++++++++------------------
>>  2 files changed, 106 insertions(+), 84 deletions(-)
> 
> Applied to pci/host-designware for v4.11, thanks!  I added Pankaj's
> reviewed-by to the COMPILE_TEST patch.  His reviewed-by was
> technically for your standalone post of that patch, but I think both
> postings have the identical patch.

Thanks Bjorn! Right, that was the same patch.

Regards
Kishon
