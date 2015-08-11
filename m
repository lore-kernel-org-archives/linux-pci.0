Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:43312 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbbHKUXD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 16:23:03 -0400
Subject: Re: [PATCH] PCI: iproc_bcma: allow build as module
To: Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
References: <1437851724-10519-1-git-send-email-hauke@hauke-m.de>
 <20150811201215.GF13982@google.com>
CC: <linux-pci@vger.kernel.org>, <zajec5@gmail.com>,
	<rjui@broadcom.com.com>, Scott Branden <sbranden@broadcom.com>,
	<bcm-kernel-feedback-list@broadcom.com>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55CA598D.2080704@broadcom.com>
Date: Tue, 11 Aug 2015 13:22:37 -0700
MIME-Version: 1.0
In-Reply-To: <20150811201215.GF13982@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 8/11/2015 1:12 PM, Bjorn Helgaas wrote:
> [+cc Scott, bcm-kernel-feedback-list]
> 
> On Sat, Jul 25, 2015 at 09:15:24PM +0200, Hauke Mehrtens wrote:
>> Changes this to tristate to make it possible to build this driver as a
>> module.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> Waiting for an ack from Ray or Scott.
> 
>> ---
>>  drivers/pci/host/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index c132bdd..e339a8c 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -135,7 +135,7 @@ config PCIE_IPROC_PLATFORM
>>  	  through the generic platform bus interface
>>  
>>  config PCIE_IPROC_BCMA
>> -	bool "Broadcom iProc PCIe BCMA bus driver"
>> +	tristate "Broadcom iProc PCIe BCMA bus driver"

This looks fine. I also build test it to make sure there's no export
symbol related issues.

Acked-by: Ray Jui <rjui@broadcom.com>

Thanks,

Ray

>>  	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>>  	select PCIE_IPROC
>>  	select BCMA
>> -- 
>> 2.1.4
>>
