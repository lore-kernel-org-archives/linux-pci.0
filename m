Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:45618 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300Ab3KZUrO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2013 15:47:14 -0500
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Tue, 26 Nov 2013 21:47:06 +0100
Cc: Tim Harvey <tharvey@gateworks.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Frank Li <lznuaa@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com> <20131125230935.GA4034@google.com>
In-Reply-To: <20131125230935.GA4034@google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201311262147.07036.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

> On Tue, Oct 22, 2013 at 09:55:43PM -0700, Tim Harvey wrote:
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
> > 
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Dropping for now, per Marek and Pratyush's concerns.  Poke me if/when those
> are resolved.

I hope (unless of course I again fail to under load of other stuff to do) to 
look at the PCIe stuff again next week once I'm in the office. In the meantime, 
I'd love to submit new set of patches.

Best regards,
Marek Vasut
