Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbcCIFCq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Mar 2016 00:02:46 -0500
Subject: Re: [PATCH RESEND] Revert "PCI: dra7xx: Mark driver as broken"
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1457087359-16816-1-git-send-email-kishon@ti.com>
 <20160308180526.GC21278@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul@pwsan.com>, <linux-pci@vger.kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@arm.linux.org.uk>,
	<linux-omap@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <56DFAE46.4090509@ti.com>
Date: Wed, 9 Mar 2016 10:31:58 +0530
MIME-Version: 1.0
In-Reply-To: <20160308180526.GC21278@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Tuesday 08 March 2016 11:35 PM, Bjorn Helgaas wrote:
> On Fri, Mar 04, 2016 at 03:59:19PM +0530, Kishon Vijay Abraham I wrote:
>> From: Sekhar Nori <nsekhar@ti.com>
>>
>> This reverts commit <5c3b99d057525fe2befe6a7db9b1309035d93eee>
>> ("PCI: dra7xx: Mark driver as broken").
>>
>> With support to de-assert PCIe reset present in kernel,
>> DRA7x PCIe is not broken anymore.
>>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> Bjorn,
>>
>> This patch should be merged only after [1] hits linus tree.
>>
>> Thanks
>> Kishon
>>
>> [1] -> git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git
>> 	for-v4.6/omap-hwmod-b
> 
> OK.  Would you mind pinging me about this after [1] is merged to
> Linus' tree?  I don't want to put this in my "next" branch yet,
> because I don't know whether Pauls branch or mine will be merged first
> in the merge window.  But after the merge window closes, I can
> certainly include this in a "PCI fixes" pull request for inclusion in
> v4.6.

yes sure. I can do that.

Thanks
Kishon

> 
> Bjorn
> 
>>  drivers/pci/host/Kconfig |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 75a6054..6d181ba 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -5,7 +5,6 @@ config PCI_DRA7XX
>>  	bool "TI DRA7xx PCIe controller"
>>  	select PCIE_DW
>>  	depends on OF && HAS_IOMEM && TI_PIPE3
>> -	depends on BROKEN
>>  	help
>>  	 Enables support for the PCIe controller in the DRA7xx SoC.  There
>>  	 are two instances of PCIe controller in DRA7xx.  This controller can
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
