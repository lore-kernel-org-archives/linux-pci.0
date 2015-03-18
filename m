Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:61229 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074AbbCRKfd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2015 06:35:33 -0400
Message-ID: <1426674930.2649.50.camel@tiscali.nl>
Subject: Re: [PATCH v2 3/5] PCI: st: Provide support for the sti PCIe
 controller
From: Paul Bolle <pebolle@tiscali.nl>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
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
	Tanmay Inamdar <tinamdar@apm.com>, m-karicheri2@ti.com,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@stlinux.com, linux-pci@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Date: Wed, 18 Mar 2015 11:35:30 +0100
In-Reply-To: <55093C12.7070004@st.com>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
		 <1426515635-9466-4-git-send-email-gabriel.fernandez@linaro.org>
	 <1426518695.26437.55.camel@x220> <55093C12.7070004@st.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabrice,

Fabrice Gasnier schreef op wo 18-03-2015 om 09:49 [+0100]:
> On 03/16/2015 04:11 PM, Paul Bolle wrote:
> >> +config PCI_ST
> >> +	bool "ST PCIe controller"
> > You add a bool Kconfig symbol. A week or two ago I saw some patches fly
> > by that - I think - allowed PCIe controllers to be built modular.
> 
> Thanks for your review.
> 
> Are you talking about "PCI: Export symbols of PCI functions" patch, that 
> is part of a series
> named "pci: iproc: Add Broadcom iProc PCIe support" ?

Yes, that is the series I was thinking about. (I made you search lkml,
and that was a bit rude. But you found the patch anyhow.)

> This controller doesn't look like to be based on pcie-designware core 
> driver.
> Other vendors that are using "pcie-designware" core driver are also make 
> it bool.
> The current core driver doesn't support module loading/unloading as I 
> see it.
> If this is required, I also think this should be part of another patchset.
> 
> What do you think ?

I wouldn't know whether your driver might work as a loadable module, but
other people reading this surely will. But if it can't work as a module
you should drop all the module related macros etc. I spotted. Because
then they serve no purpose.


Paul Bolle

