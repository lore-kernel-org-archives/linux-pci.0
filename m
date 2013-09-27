Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:11780 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3I0DkN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2013 23:40:13 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Shawn Guo' <shawn.guo@linaro.org>
Cc: 'Zhu Richard-R65037' <r65037@freescale.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Sean Cross' <xobs@kosagi.com>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Sascha Hauer' <s.hauer@pengutronix.de>, bhelgaas@google.com,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
 <1379319655-20210-4-git-send-email-xobs@kosagi.com>
 <CAJ+vNU32oMZq=jrSCpk_ZjYc08kRBAqhOS8uYfor28gY8WGhnw@mail.gmail.com>
 <0E83723C55F66F43A6041464FE31119D3F7E6A@039-SN2MPN1-012.039d.mgd.msft.net>
 <20130927021925.GF25146@S2101-09.ap.freescale.net>
In-reply-to: <20130927021925.GF25146@S2101-09.ap.freescale.net>
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Date: Fri, 27 Sep 2013 12:40:11 +0900
Message-id: <017e01cebb33$44fa65b0$ceef3110$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, September 27, 2013 11:19 AM, Shawn Guo wrote:
> On Fri, Sep 27, 2013 at 01:38:39AM +0000, Zhu Richard-R65037 wrote:
> > Hi Tim:
> > Thanks for your tests.
> > Yes, it is. There are some problems when the PCIe switch is used
> > on the 3.1x kernel at my side too,
> although the PCIe switch
> > is ok on FSL imx_3.0.35 kernels.
> > I'm debugging this issue now, and would summit the patches asap.
> >
> 
> From what I read, it seems Sean's series does not support PCIe switch.
> At least, he hasn't got any device to test it.  And there is some
> problem with PCIe switch running the latest kernel, which might not be
> related to the controller driver.
> 
> I suggest we ask Bjorn to merge the v7 I sent yesterday, so that people
> can have a same base to work on, and add PCIe switch support with
> incremental patches.   Does that sound good to you, Tim?
> 

Hi Shawn Guo,

I agree with your suggestion. :-)
The PCIe switch support patches can be added later, after the v7 patch for
i.MX6 PCIe controller driver is merged.

Also, if the PCIe switch support patches modify the synopsys designware PCIe
driver (pcie-designware.c), it should be confirmed by other related people.

Best regards,
Jingoo Han

