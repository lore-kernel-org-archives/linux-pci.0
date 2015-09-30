Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37785 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857AbbI3JT0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2015 05:19:26 -0400
Received: by wicfx3 with SMTP id fx3so51993260wic.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2015 02:19:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHM4w1=g=UFoz=R-6hxJC0=fSieN1WDvZT97ykL1b3_YPhBjZg@mail.gmail.com>
References: <1440678857-27118-1-git-send-email-gabriel.fernandez@linaro.org>
 <1440678857-27118-4-git-send-email-gabriel.fernandez@linaro.org> <CAHM4w1=g=UFoz=R-6hxJC0=fSieN1WDvZT97ykL1b3_YPhBjZg@mail.gmail.com>
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Date: Wed, 30 Sep 2015 11:18:45 +0200
Message-ID: <CAG374jAx8DN8GXkv7O0jcgnvVTnH4U3LegX-hPq5RWo1_cy+OQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] PCI: st: Provide support for the sti PCIe controller
To: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	Murali Karicheri <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
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

Hi Pratyush,

Thanks for the review.

Best regards

Gabriel

On 27 August 2015 at 19:31, Pratyush Anand <pratyush.anand@gmail.com> wrote:
> Hi Gabriel,
>
> Looks good to me.
>
> On Thu, Aug 27, 2015 at 6:04 PM, Gabriel Fernandez
> <gabriel.fernandez@linaro.org> wrote:
>> sti pcie is built around a Synopsis Designware PCIe IP.
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>
>
>> +static int st_pcie_link_up(struct pcie_port *pp)
>> +{
>> +       u32 status;
>> +       int link_up;
>
> nit: why not bool

i prefer to keep it as 'int' because the prototype of link_up callback
is an 'int'.

>
>> +       int count = 0;
>
> [...]
>
>> +static void st_pcie_board_reset(struct pcie_port *pp)
>> +{
>> +       struct st_pcie *pcie = to_st_pcie(pp);
>> +
>> +       if (!gpio_is_valid(pcie->reset_gpio))
>> +               return;
>> +
>> +       if (gpio_direction_output(pcie->reset_gpio, 0)) {
>> +               dev_err(pp->dev, "Cannot set PERST# (gpio %u) to output\n",
>> +                       pcie->reset_gpio);
>> +               return;
>> +       }
>> +
>> +       /* From PCIe spec */
>> +       msleep(2);
>> +       gpio_direction_output(pcie->reset_gpio, 1);
>> +
>> +       /*
>> +        * PCIe specification states that you should not issue any config
>> +        * requests until 100ms after asserting reset, so we enforce that here
>> +        */
>> +       msleep(100);
>
> IIRC, specification says to wait after link training completes. So
> shouldn't it be after st_pcie_enable_ltssm. Moreover, I wonder why
> others do not need it.
>
Ok i will fix it.

> Reviewed-by: Pratyush Anand <pratyush.anand@gmail.com>
