Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:36106
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159Ab3I2LuX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 29 Sep 2013 07:50:23 -0400
Message-ID: <5248144A.6070307@freescale.com>
Date: Sun, 29 Sep 2013 19:51:38 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: fsl: rework PCI driver compatible with Layerscape
References: <1379502122-20792-1-git-send-email-Minghuan.Lian@freescale.com>	 <1379502122-20792-2-git-send-email-Minghuan.Lian@freescale.com> <1380300847.24959.394.camel@snotra.buserror.net>
In-Reply-To: <1380300847.24959.394.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Scott,

please see my comments inline.

On 09/28/2013 12:54 AM, Scott Wood wrote:
> On Wed, 2013-09-18 at 19:02 +0800, Minghuan Lian wrote:
>> @@ -592,6 +719,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>>   #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
>>   
>>   struct device_node *fsl_pci_primary;
>> +extern const struct of_device_id fsl_pci_ids[];
> Externs go in headers.
[Minghuan] ok.
>
>> -static int fsl_pci_probe(struct platform_device *pdev)
>> +static int __init fsl_pci_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>> -	struct device_node *node;
>> +	struct fsl_pci *pci;
>> +
>> +	if (!of_device_is_available(pdev->dev.of_node)) {
>> +		dev_warn(&pdev->dev, "disabled\n");
>> +		return -ENODEV;
>> +	}
> This should be dev_dbg().
[Minghuan] ok.
>> -#ifdef CONFIG_PM
>> -static int fsl_pci_resume(struct device *dev)
>> +static int __exit fsl_pci_remove(struct platform_device *pdev)
> Why __exit?  What happens if someone unbinds the PCI controller via
> sysfs?
>   
[Minghuan] Sorry. should remove __exit
>> +/*
>> + * Structure of a PCI controller (host bridge)
>> + */
>> +struct fsl_pci {
>> +	struct list_head node;
>> +	int is_pcie;
> bool is_pcie;
[Minghuan] ok.
>> +/* Return link status 0-> link, 1-> no link */
>> +int fsl_pci_check_link(struct fsl_pci *pci);
> bool
[Minghuan] ok.
>> +
>> +/*
>> + * The fsl_arch_* functions are arch hooks. Those functions are
>> + * implemented as weak symbols so that they can be overridden by
>> + * architecture specific code if needed.
>> + */
>> +
>> +/* Return PCI64 DMA offset */
>> +u64 fsl_arch_pci64_dma_offset(void);
> Is this always guaranteed to exist?
[Minghuan] Yes. I define a __weak implementation in pci-fsl.c
>> +/* Register PCI/PCIe controller to architecture system */
>> +int __weak fsl_arch_pci_sys_register(struct fsl_pci *pci);
>> +
>> +/* Remove PCI/PCIe controller from architecture system */
>> +void __weak fsl_arch_pci_sys_remove(struct fsl_pci *pci);
> Why do these need to be weak?  Won't there be exactly one implementation
> per supported arch?
[Minghuan] I added __weak for compiling kernel when selecting pci-fsl 
module but
there is no related arch pci implementation.
I can remove the __weak, and use
"depends on FSL_SOC_BOOKE || PPC_86xx" in Kconfig to make sure there is 
one implementation
of supported arch.
> -Scott
>
>


