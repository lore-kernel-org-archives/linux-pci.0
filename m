Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32805 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbEFN3f (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 09:29:35 -0400
Received: by qkx62 with SMTP id 62so5615392qkx.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2015 06:29:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org>
 <1428657168-12495-4-git-send-email-gabriel.fernandez@linaro.org>
 <20150505221646.GE24643@google.com> <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 6 May 2015 08:29:14 -0500
Message-ID: <CAErSpo7_ev1oYptvBObK2dS9_LXkU2_W_OMD825POE6L5Yh7Lw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe controller
To: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
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
	Tanmay Inamdar <tinamdar@apm.com>,
	Muralidharan Karicheri <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 6, 2015 at 4:14 AM, Gabriel Fernandez
<gabriel.fernandez@linaro.org> wrote:
> Hi Bjorn,
>
> On 6 May 2015 at 00:16, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, Apr 10, 2015 at 11:12:46AM +0200, Gabriel FERNANDEZ wrote:
>>> sti pcie is built around a Synopsis Designware PCIe IP.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>>
>>> +/* ST PCIe driver does not allow module unload */
>>
>> Is there something that prevents module unload, or is it just untested?
>>
> Yes we haven't tested
>
>>> +static int __init pcie_init(void)
>>> +{
>>> +     return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
>>> +}
>>> +device_initcall(pcie_init);
>>
>> Can you use module_platform_driver_probe() or module_init() here?
>>
>
> Yes we can use module_init() here.
>
> By the way if figure out i removed __init attribute on st_pcie_probe()
> in previous version to follow Arnd's remark.
> But st_pcie_probe calls hook_fault_code() that has __init attribute.
> So I think we need to keep __init for probe routine ?
> Also, we have to restrict bind/unbind with "suppress_bind_attrs" in
> platform_driver structure.
> This is the main reason to not allow module unload/reload.

I don't really care which solution you end up with here.  But please
do take a look at how the other drivers solve the same problem.  Using
"device_initcall()" is unique in drivers/pci/host, and I don't believe
the problem is unique.  If several drivers have the same issue, they
should solve it the same way.

> If you are ok i will send a v4 ?

I think I'll have a few questions about the designware changes, too,
so you might want to wait a day or two.

>>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>>> +MODULE_DESCRIPTION("PCI express Driver for ST SoCs");
>>> +MODULE_LICENSE("GPL v2");
>>> --
>>> 1.9.1
>>>
