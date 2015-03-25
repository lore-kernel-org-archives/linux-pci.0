Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:38299 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbCYG0e (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 02:26:34 -0400
Message-ID: <55125518.2040004@broadcom.com>
Date: Tue, 24 Mar 2015 23:26:32 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Scott Branden <sbranden@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH] pci: iproc: fix PCIE_IPROC in Kconfig
References: <1427175230-22325-1-git-send-email-rjui@broadcom.com> <CAErSpo6MPw7m-zJbCAxGAaRm7jptpaJ-937A6qNXELNTggf9ZA@mail.gmail.com>
In-Reply-To: <CAErSpo6MPw7m-zJbCAxGAaRm7jptpaJ-937A6qNXELNTggf9ZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 3/24/2015 5:28 PM, Bjorn Helgaas wrote:
> On Tue, Mar 24, 2015 at 12:33 AM, Ray Jui <rjui@broadcom.com> wrote:
>> Make PCIE_IPROC depending on both OF and ARM and default to be disabled,
>> so it cannot be accidentally enabled by other platforms
>>
>> PCIE_IPROC is meant to be enabled by a front-end bus driver. Curenntly
>> it's enabled by PCIE_IPROC_PLTFM driver
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> 
>>  drivers/pci/host/Kconfig |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
>> index feccd0d..963b507 100644
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -108,6 +108,8 @@ config PCI_VERSATILE
>>
>>  config PCIE_IPROC
>>         tristate "Broadcom iProc PCIe controller"
>> +       depends on OF && ARM
>> +       default n
>>         help
>>           This enables the iProc PCIe core controller support for Broadcom's
>>           iProc family of SoCs. An appropriate bus interface driver also needs
> 
> What pattern are you following?  There must be other drivers with
> similar front-end bus driver schemes, and I'd rather copy their
> Kconfig descriptions than invent something new.

I'm not aware of other drivers using a similar model to support
different front-end bus interfaces. Note this is requested by Arnd
Bergmann to support a normal platform bus interface and a BCMA bus
interface, which is quite unique.

PCIE_DW may be close in a way in terms of how the core code are retained
in PCIE_DW driver with PCI_EXYNOS, PCI_IMX6, and etc. to take care of
SoC specific things.

Note PCIE_DW currently has no Kconfig descriptions.

> 
> With CONFIG_PCIE_IPROC_PLTFM, can we spell out "PLATFORM"?  Doesn't
> seem like there's anything to gain by abbreviating it.

Sure. I'll submit a new patch series, which will contain this patch, and
another patch on top, to change from CONFIG_PCIE_IPROC_PLTFM to
CONFIG_PCIE_IPROC_PLATFORM.

> 
> Bjorn
> 

Thanks,

Ray
