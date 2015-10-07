Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5139149.TmJY1YjqAU@wuerfel>
References: <1444118168-13086-1-git-send-email-gabriel.fernandez@linaro.org>
 <1444118168-13086-4-git-send-email-gabriel.fernandez@linaro.org> <5139149.TmJY1YjqAU@wuerfel>
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Date: Wed, 7 Oct 2015 16:32:16 +0200
Message-ID: <CAG374jAnKQCerh3nBX9WsmwP4g6uPLKPSZ2EhhwPa-i89RsyZQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] PCI: st: Provide support for the sti PCIe controller
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Russell King <linux@arm.linux.org.uk>,
	Jingoo Han <jg1.han@samsung.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Muralidharan Karicheri <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6 October 2015 at 23:01, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 06 October 2015 09:56:08 Gabriel Fernandez wrote:
>> +
>> +/*
>> + * On ARM platforms, we actually get a bus error returned when the PCIe IP
>> + * returns a UR or CRS instead of an OK.
>> + */
>> +static int st_pcie_abort_handler(unsigned long addr, unsigned int fsr,
>> +                                struct pt_regs *regs)
>> +{
>> +       return 0;
>> +}
>>
>
> I'm not sure if we discussed this already for this driver. Usually
> you should have a register in the PCI host that you can check to see
> what caused the abort.
>
> Try to make this as narrow as possible so you return nonzero for
> any abort except the one you actually try to prevent.
>
>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Hi Arnd,

Yes we already discussed about that:
http://www.spinics.net/lists/arm-kernel/msg393705.html

We can probably improve the abort handling once the patch below will be merged
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/366215.html

As imx6 does the same, does it sound reasonable to keep this approach
of the st driver and start discussing about generic way to handle
abort for DW pci driver ?

Best regards

Gabriel
