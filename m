Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:20386 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbbG2QRF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 12:17:05 -0400
Subject: Re: [PATCH] PCI: iproc: Fix BCMA dependency in Kconfig
To: Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
References: <1438109533-28694-1-git-send-email-rjui@broadcom.com>
 <33449873.RA3z6vhrMA@wuerfel>
CC: Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <arm@kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <55B8FC7E.50900@broadcom.com>
Date: Wed, 29 Jul 2015 09:17:02 -0700
MIME-Version: 1.0
In-Reply-To: <33449873.RA3z6vhrMA@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 7/29/2015 7:30 AM, Arnd Bergmann wrote:
> On Tuesday 28 July 2015 11:52:13 Ray Jui wrote:
>>  config PCIE_IPROC_BCMA
>>         bool "Broadcom iProc PCIe BCMA bus driver"
>> -       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
>> +       depends on ARCH_BCM_IPROC && ARM
>>         select PCIE_IPROC
>>         select BCMA
>>         select PCI_DOMAINS
>>
> 
> How about this:
> 
> 	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
> 
> That would leave the compile test present for non-iproc
> ARM platforms while preventing ARM64 and MIPS builds with
> ARCH_BCM_IPROC set.
> 
> 	Arnd
> 

That is indeed better. Broader compile test coverage is always good.
I'll submit another patch with the above suggested change.

Thanks,

Ray
