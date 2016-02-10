Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39602 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbcBJJsu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 04:48:50 -0500
Subject: Re: [PATCH v9 2/2] pcie-designware platform driver
To: Bjorn Helgaas <helgaas@kernel.org>
References: <9069117816a5cd9cc3314b6d584c26d457807b8e.1454952698.git.jpinto@synopsys.com>
 <201602090552.plkRtxUR%fengguang.wu@intel.com>
 <20160208232808.GB1353@localhost>
CC: Joao Pinto <Joao.Pinto@synopsys.com>, <kbuild-all@01.org>,
	<Vineet.Gupta1@synopsys.com>, <arnd@arndb.de>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56BB0777.6080208@synopsys.com>
Date: Wed, 10 Feb 2016 09:48:39 +0000
MIME-Version: 1.0
In-Reply-To: <20160208232808.GB1353@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 2/8/2016 11:28 PM, Bjorn Helgaas wrote:
>>      if (!pci_has_flag(PCI_PROBE_ONLY)) {
>>                        ^
>>    drivers/pci/host/pcie-designware.c:581:20: note: each undeclared identifier is reported only once for each function it appears in
>>    cc1: some warnings being treated as errors
> 
> I have fixes for this on my pci/misc branch, so you don't need to
> worry about these errors.  Basically I'm moving the PCI_PROBE_ONLY and
> pci_has_flag() declarations from the arch-specific asm/pci-bridge.h
> files to the generic linux/pci.h file.

Ok, thanks.

> 
>> vim +/pci_has_flag +581 drivers/pci/host/pcie-designware.c
>>
>> cbce7900 Zhou Wang   2015-10-29  575  
>> cbce7900 Zhou Wang   2015-10-29  576  #ifdef CONFIG_ARM
>> cbce7900 Zhou Wang   2015-10-29  577  	/* support old dtbs that incorrectly describe IRQs */
>> cbce7900 Zhou Wang   2015-10-29  578  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>> 0815f957 Yijing Wang 2014-11-11  579  #endif
>> 0815f957 Yijing Wang 2014-11-11  580  
>> cbce7900 Zhou Wang   2015-10-29 @581  	if (!pci_has_flag(PCI_PROBE_ONLY)) {
>> cbce7900 Zhou Wang   2015-10-29  582  		pci_bus_size_bridges(bus);
>> cbce7900 Zhou Wang   2015-10-29  583  		pci_bus_assign_resources(bus);
>> 4b1ced84 Jingoo Han  2013-07-31  584  
>>
>> :::::: The code at line 581 was first introduced by commit
>> :::::: cbce7900598c26a12652f8ca9c41c5b29034c38d PCI: designware: Make driver arch-agnostic
>>
>> :::::: TO: Zhou Wang <wangzhou1@hisilicon.com>
>> :::::: CC: Bjorn Helgaas <bhelgaas@google.com>
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 

If there's anything else that is needed for the pcie-designware platform driver,
please let me know.

Thanks,
Joao
