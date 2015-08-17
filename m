Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150814145310.GD26431@google.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org> <20150814145310.GD26431@google.com>
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Date: Mon, 17 Aug 2015 09:53:16 +0200
Message-ID: <CAG374jB3sjfb5Y2L_SBeZ-9Yaw6uZL6OQsk81K8mE6a0MEYkdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PCI: st: provide support for dw pcie
To: Bjorn Helgaas <bhelgaas@google.com>
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
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

To be honest I'm wainting that Zhou patch (PCI: designware: Add ARM64
support) is accepted.

Because this patch allows to remove "pci: designware: remove
pci_common_init_dev()" from my patchset. I think it's more judicious
to do that.

I can send a v4 based on Zhou patchset ([PATCH v6 0/6] PCI: hisi: Add
PCIe host support for HiSilicon SoC Hip05) if you want ?

Best Regards

Gabriel.

On 14 August 2015 at 16:53, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Apr 10, 2015 at 11:12:43AM +0200, Gabriel FERNANDEZ wrote:
>> Changes in v3:
>>  - Remove power management functions (was not fully tested)
>>  - Remove configuration space range from dt binding
>>  - Remove pci_common_init_dev() call in pcie-designware.c to avoid
>>    default IO space declaration.
>>
>> Changes in v2:
>>  - comestic corrections in device tree binding
>>  - add pci-st.c into MAINTAINERS
>>  - remove st_pcie_ops structure to avoid another level of indirection
>>  - remove nasty busy-loop
>>  - remove useless test using virt_to_phys()
>>  - move disable io support into dw-pcie driver
>>
>> I don't change the st_pcie_abort_handler() function because abort handling
>> is masked during boot.
>>
>>
>> This patch-set introduces a STMicroelectronics PCIe controller.
>> It's based on designware PCIe driver.
>>
>> Gabriel Fernandez (5):
>>   ARM: STi: Kconfig update for PCIe support
>>   PCI: st: Add Device Tree bindings for sti pcie
>>   PCI: st: Provide support for the sti PCIe controller
>>   pci: designware: remove pci_common_init_dev()
>>   MAINTAINERS: Add pci-st.c to ARCH/STI architecture
>
> Hi Gabriel,
>
> I lost track of where we are with this.  I *think* I'm waiting for a v4
> posting, but I haven't seen it yet.  Let me know if I've missed something.
>
> Bjorn
