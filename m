Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:3430
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752171AbaAFD5a (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jan 2014 22:57:30 -0500
Message-ID: <52CA29C1.9010405@freescale.com>
Date: Mon, 6 Jan 2014 11:57:53 +0800
From: Lian Minghuan-b31939 <b31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [11/12,v3] pci: fsl: update PCI EDAC driver
References: <1382524894-15164-11-git-send-email-Minghuan.Lian@freescale.com> <20140103221603.GA22546@home.buserror.net>
In-Reply-To: <20140103221603.GA22546@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Scott,

I think we should reverse this commit

0f1741c74aa6794b1c7fbdd19f26a4f2377a11c6.

PCI controller driver is a platform driver supports probe and remove,
when removing the driver we should call mpc85xx_pci_err_remove() to free EDAC PCI resource.

Thanks,
Minghuan

On 01/04/2014 06:16 AM, Scott Wood wrote:
> On Wed, Oct 23, 2013 at 06:41:33PM +0800, Minghuan Lian wrote:
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>> index 40d2e1d..4a03e1a 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -236,6 +236,7 @@ void fsl_arch_pci_sys_remove(struct fsl_pci *pci)
>>   	if (!hose)
>>   		return;
>>   
>> +	mpc85xx_pci_err_remove(to_platform_device(pci->dev));
>>   	pcibios_free_controller(hose);
> This causes a linker error if the EDAC driver is enabled, due to commit
> 0f1741c74aa6794b1c7fbdd19f26a4f2377a11c6 ("edac/85xx: Remove
> mpc85xx_pci_err_remove").
>
> -Scott


