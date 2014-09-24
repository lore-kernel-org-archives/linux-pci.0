Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0115.outbound.protection.outlook.com ([157.56.111.115]:24608
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751328AbaIXCRo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Sep 2014 22:17:44 -0400
Message-ID: <542229D6.50405@freescale.com>
Date: Wed, 24 Sep 2014 10:17:58 +0800
From: Lian Minghuan-B31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"Zang Roy-R61911" <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 3/3] PCI: Layerscape: Add Layerscape PCIe driver
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
	 <1411482540-31297-5-git-send-email-Minghuan.Lian@freescale.com>
 <1411507511.13320.155.camel@snotra.buserror.net>
In-Reply-To: <1411507511.13320.155.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Scott,

Please see my comments inline.

On 2014年09月24日 05:25, Scott Wood wrote:
> On Tue, 2014-09-23 at 22:29 +0800, Minghuan Lian wrote:
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index 34134d6..7c49456 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -82,4 +82,11 @@ config PCIE_XILINX
>>   	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>>   	  Host Bridge driver.
>>   
>> +config PCI_LAYERSCAPE
>> +	bool "Freescale Layerscape PCIe controller"
>> +	select PCIE_DW
>> +	select MFD_SYSCON
>> +	help
>> +	  Say Y here if you want PCIe controller support on Layerscape SoCs.
>> +
>>   endmenu
> Are you sure there are no dependencies for this to build?  At the least
> you need OF.
>
> I think you should also be selecting REGMAP.
[Minghuan] Yes, it does need OF. I will add 'depends on OF' next version.
Because MFS_SYSCON will select REGMAP, so I think it is enough to select 
MFS_SYSCON.

> -Scott
>
>

