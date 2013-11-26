Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37342 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab3KZUqM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 15:46:12 -0500
From: Marek Vasut <marex@denx.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Tue, 26 Nov 2013 21:46:09 +0100
Cc: Tim Harvey <tharvey@gateworks.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com> <20131023064051.GA7646@pratyush-vbox>
In-Reply-To: <20131023064051.GA7646@pratyush-vbox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201311262146.09780.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Pratyush Anand,

> Hi,
> 
> On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> > The IMX6 iATU is used for address translation between the AXI bus
> > address space and PCI address space.  This is used for type0 and type1
> > config cycles but is not necessary for outbound io/mem regions.
> > 
> > This patch removes the calls that inappropriately re-configures the ATU
> > viewport for outbound memory and IO after config cycles and removes them
> > altogether as they are not necessary.
> > 
> > This resolves issues with PCI devices behind switches and has been tested
> > with a Gige device behind a PLX PEX860x switch.  More testing is needed
> > for other configurations.
> 
> It seems to me that in your controller you have only one view port.
> Also mem_base and mem_bus_addr is same. Thats why it works in your
> case.

MX6 has 4 In/4 Out viewports AFAICT.

Best regards,
Marek Vasut
