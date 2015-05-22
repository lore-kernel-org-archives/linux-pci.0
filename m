Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Stephen Boyd <sboyd@codeaurora.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mathieu Olivari <mathieu@codeaurora.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ARM: qcom: Add Qualcomm APQ8084 SoC
Date: Fri, 22 May 2015 21:26:14 +0200
Message-ID: <2504338.ikNh5XCYe2@wuerfel>
In-Reply-To: <555F73FC.1030102@codeaurora.org>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com> <1430743338-10441-6-git-send-email-svarbanov@mm-sol.com> <555F73FC.1030102@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 May 2015 11:22:52 Stephen Boyd wrote:
> > diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
> > index 2256cd1..9cfebee 100644
> > --- a/arch/arm/mach-qcom/Kconfig
> > +++ b/arch/arm/mach-qcom/Kconfig
> > @@ -22,4 +22,11 @@ config ARCH_MSM8974
> >       bool "Enable support for MSM8974"
> >       select HAVE_ARM_ARCH_TIMER
> >  
> > +config ARCH_APQ8084
> > +     bool "Enable support for APQ8084"
> > +     select HAVE_ARM_ARCH_TIMER
> > +     select MIGHT_HAVE_PCI
> > +     select PCI_DOMAINS if PCI
> > +     select PCI_MSI if PCI
> > +
> >
> 
> Can we move these PCI selects up to ARCH_QCOM directly? Let's try to
> avoid adding more SoC specific options under ARCH_QCOM.

I thought we already select 'MIGHT_HAVE_PCI' and 'PCI_DOMAINS' for
all ARMv7 platforms. If not, we probably should.

For PCI_MSI, I would leave that as user-selectable, there is no
need to enforce that as far as I can tell. If the driver needs
PCI_MSI support at compile-time, a dependency for that driver
would make sense.

	Arnd
