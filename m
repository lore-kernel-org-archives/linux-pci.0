Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:46875 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbbCFRfv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 12:35:51 -0500
Received: by igbhl2 with SMTP id hl2so5647198igb.5
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2015 09:35:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54F9E32D.4090005@broadcom.com>
References: <1425603699-13416-1-git-send-email-rjui@broadcom.com>
	<1425603699-13416-3-git-send-email-rjui@broadcom.com>
	<1425639640.24292.271.camel@x220>
	<54F9E32D.4090005@broadcom.com>
Date: Fri, 6 Mar 2015 09:35:51 -0800
Message-ID: <CAE_wzQ_Rq5u83UXOYRLShxuCzcgxA0BSPFZT4RmvDj8nfTSGcg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pci: iproc: Add Broadcom iProc PCIe support
From: Dmitry Torokhov <dtor@google.com>
To: Ray Jui <rjui@broadcom.com>
Cc: Paul Bolle <pebolle@tiscali.nl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Anatol Pomazau <anatol@google.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 6, 2015 at 9:26 AM, Ray Jui <rjui@broadcom.com> wrote:
> Hi Paul,
>
> On 3/6/2015 3:00 AM, Paul Bolle wrote:
>> On Thu, 2015-03-05 at 17:01 -0800, Ray Jui wrote:
>>> --- a/drivers/pci/host/Kconfig
>>> +++ b/drivers/pci/host/Kconfig
>>> @@ -106,4 +106,21 @@ config PCI_VERSATILE
>>>      bool "ARM Versatile PB PCI controller"
>>>      depends on ARCH_VERSATILE
>>>
>>> +config PCIE_IPROC
>>> +    bool "Broadcom iProc PCIe controller"
>>
>> bool symbol.
>>
>>> +    help
>>> +      This enables the iProc PCIe core controller support for Broadcom's
>>> +      iProc family of SoCs. An appropriate bus interface driver also needs
>>> +      to be enabled
>>> +
>>> +config PCIE_IPROC_PLTFM
>>> +    bool "Broadcom iProc PCIe platform bus driver"
>>
>> Another bool symbol.
>>
>>> +    depends on ARCH_BCM_IPROC || COMPILE_TEST
>>> +    depends on OF
>>> +    select PCIE_IPROC
>>> +    default ARCH_BCM_IPROC
>>> +    help
>>> +      Say Y here if you want to use the Broadcom iProc PCIe controller
>>> +      through the generic platform bus interface
>>> +
>>>  endmenu
>>
>>> --- a/drivers/pci/host/Makefile
>>> +++ b/drivers/pci/host/Makefile
>>
>>> +obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
>>> +obj-$(CONFIG_PCIE_IPROC_PLTFM) += pcie-iproc-pltfm.o
>>
>> Both objectfiles will never be part of a module.
>>
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-iproc-pltfm.c
>>
>>> +#include <linux/module.h>
>>
>> Is this needed?
>>
>>> +MODULE_DEVICE_TABLE(of, iproc_pcie_of_match_table);
>>
>> This macro will be preprocessed away, won't it?
>>
>>> +static struct platform_driver iproc_pcie_pltfm_driver = {
>>> +    .driver = {
>>> +            .name = "iproc-pcie",
>>> +            .of_match_table = of_match_ptr(iproc_pcie_of_match_table),
>>> +            .suppress_bind_attrs = true,
>>> +    },
>>> +    .probe = iproc_pcie_pltfm_probe,
>>> +};
>>> +module_platform_driver(iproc_pcie_pltfm_driver);
>>
>> Perhaps it's clearer to have make this a call to
>> platform_driver_register(), put that in a wrapper function, and invoke
>> that wrapper function through device_initcall() or similar. I haven't
>> actually tested that, so the details could be off.
>>
>>> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>>> +MODULE_DESCRIPTION("Broadcom iPROC PCIe platform driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>> And these three macros will, effectively, be preprocessed away.
>>
>>> --- /dev/null
>>> +++ b/drivers/pci/host/pcie-iproc.c
>>
>>> +#include <linux/module.h>
>>
>> See above.
>>
>>> +MODULE_AUTHOR("Ray Jui <rjui@broadcom.com>");
>>> +MODULE_DESCRIPTION("Broadcom iPROC PCIe common driver");
>>> +MODULE_LICENSE("GPL v2");
>>
>> Ditto.
>>
>>
>> Paul Bolle
>>
>
> So every single PCIe host driver under drivers/pci/host/* has their
> config flag of "bool" type, and all of them except pci-keystone-dw.c
> have these MODULE based macros in their driver. While I agree with you
> that these macros will preprocessed away while compiled as statically
> linked in, I thought it's a convention to have these macros in the
> driver. At least it provides information on the author, driver
> description, and license (although one can also argue you can find all
> of those info from the maintainer list, Kconfig, and license header).
>
> Would you be able to sort this out with a developer or subsystem
> maintainer who is familiar with this matter and let us know what is the
> convention for MODULE macros usage in a driver when its config flag is
> set to "bool" instead of "tristate"?

Is there a technical reason why the driver can't be a module? We can
suppress module unloading if unloading properly is hard (i see you
already suppress unbinding via sysfs), but we should be able to load
it after kernel booted, no?

Thanks,
Dmitry
