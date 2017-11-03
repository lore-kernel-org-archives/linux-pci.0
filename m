Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:54118 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbdKCJ5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2017 05:57:14 -0400
Subject: Re: [PATCH v3 14/17] PCI: dwc: artpec6: Add support for endpoint mode
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@axis.com>
References: <20171031223936.27549-1-niklas.cassel@axis.com>
 <20171031223936.27549-15-niklas.cassel@axis.com>
 <CAK8P3a1yGwyZPzd2-usqLe=BiQpdFsyyFOhpP1ZyaCb16rzCSQ@mail.gmail.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <5a8c7aaf-552c-7170-2a36-13b50168a9cc@axis.com>
Date: Fri, 3 Nov 2017 10:56:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1yGwyZPzd2-usqLe=BiQpdFsyyFOhpP1ZyaCb16rzCSQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/02/2017 10:13 AM, Arnd Bergmann wrote:
> On Tue, Oct 31, 2017 at 11:39 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> 
> It seems like you are missing a changelog text. Please explain what
> your work is good for
> in any patch you send.

You are correct, this patch is missing a changelog text.
I will send a V4 of the patch series for this.

> 
>> V3:
>> * Removed ifdefs around match table and match table data.
>> * Removed ifdefs in probe, use dummy implementations instead.
> 
> I think there is room for more of the same ;-)
> 
>>
>> +#ifdef CONFIG_PCIE_ARTPEC6_HOST
>>  static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
>>  {
>>         struct dw_pcie *pci = artpec6_pcie->pci;
>> @@ -231,11 +257,92 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>>
>>         return 0;
>>  }
>> +#else
>> +static inline int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
>> +                                       struct platform_device *pdev)
>> +{
>> +       return -ENODEV;
>> +}
>> +#endif
> 
> 
> Can you try replacing the #ifdef with
> 
> 
>         if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
>                  return -ENODEV;
> 
> at the start of artpec6_pcie_enable_interrupts? I think that would improve
> readability here.
> 

artpec6_pcie_enable_interrupts is a void function, so
I guess that you meant at the start of artpec6_add_pcie_port.
That would not really help since artpec6_add_pcie_port
calls artpec6_pcie_msi_handler, and uses artpec6_pcie_host_ops,
which is still inside the CONFIG_PCIE_ARTPEC6_HOST ifdef block.

Please note that there are several functions, as well as
artpec6_pcie_host_ops inside the 
CONFIG_PCIE_ARTPEC6_HOST ifdef block.

The reason for this is because Bjorn was surprised that
this driver at V1 didn't have any ifdefs, even though
it supports two different modes: HOST and EP.
I suspected that his reasoning was that if you compile
the driver with only one of the modes, it is wasteful
to compile and include the functions that belong to the
mode that we are not using in the vmlinux.

>> +static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
>> +                              struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct dw_pcie_ep *ep;
>> +       struct resource *res;
>> +       struct device *dev = &pdev->dev;
>> +       struct dw_pcie *pci = artpec6_pcie->pci;
> 
> The same trick should work here with the other symbol.

While artpec6_add_pcie_ep doesn't call any other
function in this file, it does use pcie_ep_ops,
which does reference other functions in this file
(which are inside the ifdef block).


Regards,
Niklas
