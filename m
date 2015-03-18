Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <55093C12.7070004@st.com>
Date: Wed, 18 Mar 2015 09:49:22 +0100
From: Fabrice Gasnier <fabrice.gasnier@st.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@stlinux.com>,
	<linux-pci@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe controller
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>	 <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org> <1426518695.26437.55.camel@x220>
In-Reply-To: <1426518695.26437.55.camel@x220>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

On 03/16/2015 04:11 PM, Paul Bolle wrote:
>> +config PCI_ST
>> +	bool "ST PCIe controller"
> You add a bool Kconfig symbol. A week or two ago I saw some patches fly
> by that - I think - allowed PCIe controllers to be built modular.

Thanks for your review.

Are you talking about "PCI: Export symbols of PCI functions" patch, that 
is part of a series
named "pci: iproc: Add Broadcom iProc PCIe support" ?

This controller doesn't look like to be based on pcie-designware core 
driver.
Other vendors that are using "pcie-designware" core driver are also make 
it bool.
The current core driver doesn't support module loading/unloading as I 
see it.
If this is required, I also think this should be part of another patchset.

What do you think ?

Please advise,
BR,
Fabrice
>
>> +	depends on ARCH_STI || (ARM && COMPILE_TEST)
>> +	select PCIE_DW
>> +	help
>> +	  Enable PCIe controller support on ST Socs. This controller is based
>> +	  on Designware hardware and therefore the driver re-uses the
>> +	  Designware core functions to implement the driver.
>> --- a/drivers/pci/host/Makefile
>> +++ b/drivers/pci/host/Makefile
>> +obj-$(CONFIG_PCI_ST) += pci-st.o
> If you keep that symbol bool this objectfile will never be part of a
> module.
>
>> diff --git a/drivers/pci/host/pci-st.c b/drivers/pci/host/pci-st.c
>> new file mode 100644
>> index 0000000..470000d
>> --- /dev/null
>> +++ b/drivers/pci/host/pci-st.c
>> +#include <linux/module.h>
> For built-in code this include is, probably, not needed.
>
>> +MODULE_DEVICE_TABLE(of, st_pcie_of_match);
> For built-in code that macro will always be preprocessed away.
>
>> +/* ST PCIe driver does not allow module unload */
>> +static int __init pcie_init(void)
>> +{
>> +	return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
>> +}
>> +device_initcall(pcie_init);
> I think the module unload comment is a bit odd for built-in only code.
>
>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
>> +MODULE_LICENSE("GPL v2");
> These three macros will be, basically, always preprocessed away as long
> as this code can't be built to be modular.
>
>
> Paul Bolle
>

