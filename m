Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:46364 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab3LCJcu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2013 04:32:50 -0500
From: Marek Vasut <marex@denx.de>
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Tue, 3 Dec 2013 10:19:58 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Frank Li'" <lznuaa@gmail.com>,
	"'Sascha Hauer'" <s.hauer@pengutronix.de>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Shawn Guo'" <shawn.guo@linaro.org>,
	"'Siva Reddy Kallam'" <siva.kallam@samsung.com>,
	"'Srikanth T Shivanand'" <ts.srikanth@samsung.com>,
	"'Troy Kisky'" <troy.kisky@boundarydevices.com>,
	"'Yinghai Lu'" <yinghai@kernel.org>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com> <201311290321.22415.marex@denx.de> <0E83723C55F66F43A6041464FE31119D478F0C@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <0E83723C55F66F43A6041464FE31119D478F0C@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312031019.58708.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Richard Zhu,

> Hi Marek:
> > -----Original Message-----
> > From: Marek Vasut [mailto:marex@denx.de]
> > Sent: Friday, November 29, 2013 10:21 AM
> > To: Jingoo Han
> > Cc: 'Pratyush Anand'; 'Mohit KUMAR DCG'; 'Tim Harvey'; 'Kishon Vijay
> > Abraham I'; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; 'Bjorn Helgaas'; 'Frank Li'; Zhu
> > Richard-R65037; 'Sascha Hauer'; 'Sean Cross'; 'Shawn Guo'; 'Siva Reddy
> > Kallam'; 'Srikanth T Shivanand'; 'Troy Kisky'; 'Yinghai Lu' Subject: Re:
> > [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
> > 
> > Dear Jingoo Han,
> > 
> > > On Wednesday, November 27, 2013 5:37 PM, Pratyush Anand wrote:
> > > > On Wed, Nov 27, 2013 at 04:24:47PM +0800, Marek Vasut wrote:
> > > > > > On Wed, Nov 27, 2013 at 04:46:09AM +0800, Marek Vasut wrote:
> > > > > > > Dear Pratyush Anand,
> > > > > > > 
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > > > On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> > > > > > > > > The IMX6 iATU is used for address translation between the
> > > > > > > > > AXI bus address space and PCI address space.  This is used
> > > > > > > > > for
> > > > > > > > > type0 and type1 config cycles but is not necessary for
> > > > > > > > > outbound io/mem regions.
> > > > > > > > > 
> > > > > > > > > This patch removes the calls that inappropriately
> > > > > > > > > re-configures the ATU viewport for outbound memory and IO
> > > > > > > > > after config cycles and removes them altogether as they are
> > > > > > > > > not
> > 
> > necessary.
> > 
> > > > > > > > > This resolves issues with PCI devices behind switches and
> > > > > > > > > has been tested with a Gige device behind a PLX PEX860x
> > > > > > > > > switch. More testing is needed for other configurations.
> > > > > > > > 
> > > > > > > > It seems to me that in your controller you have only one
> > > > > > > > view port. Also mem_base and mem_bus_addr is same. Thats why
> > > > > > > > it works in your case.
> > > > > > > 
> > > > > > > MX6 has 4 In/4 Out viewports AFAICT.
> > > > > > 
> > > > > > Then if I do not miss anything, MX6 should work even without
> > > > > > this patch.
> > > > > 
> > > > > Yes, yet, it does not. On the other hand, this defect is only
> > > > > problematic if you use the devices behind a switch. Do you use a
> > > > > PCIe switch on your platform please?
> > > > 
> > > > I had tested with device under bridge.
> > > > Mohit is in process of validating SPEAr patches with latest kernel.
> > > > Mohit, see if we can arrange a switch and test, once SPEAr platform
> > > > is ready with latest kernel.
> > > 
> > > I agree with Pratyush Anand's opinion.
> > > One of our engineers had tested PCI cards under switch.
> > > As far as I know, there was no issue about this.
> > > However, currently, I don't have any switches. So, I Cannot test this
> > > on Exynos platform.
> > 
> > OK, I will wait for Richard to come up with confirmation if possible.
> > Looks like he's out of the office, so it might take a bit.
> 
> [Richard] One Pericom PI7C9X2G303EL pcie switch, and two pcie ep
> deivces(one is intel e1000e nic, the other is one xhci device) are tested
> on imx6q sabresd board.

How/what does have such pericom switch and can be attached to an MX6 sabresdp ? 
Where can I get it?

> Without removing outbound io/mem regions view map during the cfg0/1
> read/write cycle, both of these devices can't work well at my side.
> Works well after remove them during the cfg0/1 read/write cycles.

Understood. Given that the iATU programming works on other CPUs (confirmed on st 
spear and ti dra7xx), we might have some issues with the iATU on MX6 . Is there 
anything special about the iATU on the MX6 ?
