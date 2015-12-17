Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49909 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932670AbbLQVP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 16:15:29 -0500
Date: Thu, 17 Dec 2015 15:15:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v4 3/5] PCI: qcom: Add Qualcomm PCIe controller driver
Message-ID: <20151217211525.GA4129@localhost>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-4-git-send-email-stanimir.varbanov@linaro.org>
 <20151216215304.GB27791@localhost>
 <5672B633.6030503@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5672B633.6030503@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 03:18:43PM +0200, Stanimir Varbanov wrote:
> Bjorn, thanks for the comments!
> 
> On 12/16/2015 11:53 PM, Bjorn Helgaas wrote:
> > On Thu, Dec 03, 2015 at 03:35:22PM +0200, Stanimir Varbanov wrote:
> >> From: Stanimir Varbanov <svarbanov@mm-sol.com>
> >>
> >> The PCIe driver reuse the Designware common code for host
> >> and MSI initialization, and also program the Qualcomm
> >> application specific registers.
> >>
> >> Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  MAINTAINERS                  |    7 +
> >>  drivers/pci/host/Kconfig     |   10 +
> >>  drivers/pci/host/Makefile    |    1 +
> >>  drivers/pci/host/pcie-qcom.c |  624 ++++++++++++++++++++++++++++++++++++++++++
> > 
> >> +#define PCIE20_CAP				0x70
> >> +#define PCIE20_CAP_LINKCTRLSTATUS		(PCIE20_CAP + 0x10)
> >> +#define PCIE20_CAP_LINKCTRLSTATUS_LINK_UP	BIT(29)
> > 
> > This looks like it could be referring to a standard PCIe Capability;
> > could you use the existing PCI_EXP_LNKSTA and PCI_EXP_LNKSTA_DLLLA
> > symbols here?  And readw() instead of readl()?
> 
> Yes, that is possible but I still need to keep PCIE20_CAP capabilities
> offset.

Great, thanks!  I think that will help keep generic PCIe things from
looking like they're special implementation-specific things.

Bjorn
