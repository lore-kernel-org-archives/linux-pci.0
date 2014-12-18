Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Gabriel FERNANDEZ' <gabriel.fernandez@st.com>
Cc: 'Arnd Bergmann' <arnd@arndb.de>,
	'Rob Herring' <robh+dt@kernel.org>,
	'Pawel Moll' <pawel.moll@arm.com>,
	'Mark Rutland' <mark.rutland@arm.com>,
	'Ian Campbell' <ijc+devicetree@hellion.org.uk>,
	'Kumar Gala' <galak@codeaurora.org>,
	'Srinivas Kandagatla' <srinivas.kandagatla@gmail.com>,
	'Maxime Coquelin' <maxime.coquelin@st.com>,
	'Patrice Chotard' <patrice.chotard@st.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Grant Likely' <grant.likely@linaro.org>,
	'Gabriel Fernandez' <gabriel.fernandez@linaro.org>,
	'Fabrice Gasnier' <fabrice.gasnier@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Thierry Reding' <treding@nvidia.com>,
	'Minghuan Lian' <Minghuan.Lian@freescale.com>,
	'Magnus Damm' <damm@opensource.se>,
	'Will Deacon' <will.deacon@arm.com>,
	'Tanmay Inamdar' <tinamdar@apm.com>,
	'Murali Karicheri' <m-karicheri2@ti.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Sachin Kamat' <sachin.kamat@samsung.com>,
	'Andrew Lunn' <andrew@lunn.ch>,
	'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Srikanth Thokala' <sthokal@xilinx.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, 'Lee Jones' <lee.jones@linaro.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
 <1418812486-12394-5-git-send-email-gabriel.fernandez@linaro.org>
 <1507589.aeTeyNn1QF@wuerfel>
In-reply-to: <1507589.aeTeyNn1QF@wuerfel>
Subject: Re: [PATCH 4/5] PCI: designware: Add setup bus-related to pcie_host_ops
Date: Thu, 18 Dec 2014 13:58:27 +0900
Message-id: <000e01d01a7f$47592e20$d60b8a60$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 18, 2014 7:16 AM, Arnd Bergmann wrote:
> On Wednesday 17 December 2014 11:34:45 Gabriel FERNANDEZ wrote:
> > ST sti SoCs PCIe IPs are built around DesignWare IP Core.
> > But in these SoCs PCIe IP doesn't support IO.

Hi Gabriel,

I cannot understand how ST sti SoCs PCIe IP does not support I/O.
As far as I know, it cannot be selected by the 'parameter'.
Then, H/W engineers dropped out the I/O control logic?

> >
> > To support this, add setup_bus() to pcie_host_ops.


> >
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> 
> The dw-pcie driver should be able to tell whether the device has
> an I/O space or not, and do the right thing based on that. Don't
> add an implementation specific callback for that.

I agree with Arnd's opinion.

In addition, I have one more question.
Then, if a device that requires I/O region is connected to
PCIe slot of ST sti SoCs PCIe, what will happen?
It just prints error messages?

Best regards,
Jingoo Han

> 
> 	Arnd

