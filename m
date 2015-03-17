Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36530 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbCQHlE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2015 03:41:04 -0400
Received: by igbue6 with SMTP id ue6so63882912igb.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2015 00:41:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3714853.Vuc23EfWdL@wuerfel>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
	<1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
	<582D947C-1229-4DD9-BC82-812D1560C49E@codeaurora.org>
	<3714853.Vuc23EfWdL@wuerfel>
Date: Tue, 17 Mar 2015 08:41:03 +0100
Message-ID: <CAG374jBqtw8sW-ZpMJFQUR0skdh+oX_F120hc90ssAYHzrF15g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI: designware: Add disable IO support
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kumar Gala <galak@codeaurora.org>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
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
	linux-pci@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Ok i will try the same way that pci-versatile.c

Thanks.

Gabriel

On 16 March 2015 at 21:00, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 16 March 2015 13:00:51 Kumar Gala wrote:
>> On Mar 16, 2015, at 9:20 AM, Gabriel FERNANDEZ <gabriel.fernandez@st.com> wrote:
>>
>> > ST sti SoCs PCIe IPs are built around DesignWare IP Core.
>> > But in these SoCs PCIe IP doesn't support IO.
>> >
>> > This patch adds the possibility to disable it through
>> > a DT property, by creating an empty IO window and by
>> > removing PCI_COMMAND_IO from the setup register.
>> >
>> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> > ---
>> > .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
>> > drivers/pci/host/pcie-designware.c                 | 24 ++++++++++++++++++++--
>> > drivers/pci/host/pcie-designware.h                 |  1 +
>> > 3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> Why not just update the code such that if the ranges doesn’t have an IO
>> space rather than introducing a new DT property?
>
> I suspect we can simplify this now by changing over the designware PCI
> code from pci_common_init_dev to calling pci_scan_root_bus() in the
> same way that pci-versatile.c does. This would also clean up some
> other areas of the driver and let you do proper error handling
> in the probe.
>
>         Arnd
