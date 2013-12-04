Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43204 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab3LDQDD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 11:03:03 -0500
From: Marek Vasut <marex@denx.de>
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Wed, 4 Dec 2013 16:45:20 +0100
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
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com> <201312031019.58708.marex@denx.de> <0E83723C55F66F43A6041464FE31119D47AB51@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <0E83723C55F66F43A6041464FE31119D47AB51@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312041645.21028.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 04, 2013 at 03:38:49 AM, Richard Zhu wrote:
[...]
> > > [Richard] One Pericom PI7C9X2G303EL pcie switch, and two pcie ep
> > > deivces(one is intel e1000e nic, the other is one xhci device) are
> > > tested on imx6q sabresd board.
> > 
> > How/what does have such pericom switch and can be attached to an MX6
> > sabresdp ? Where can I get it?
> 
> [Richard] You can apply the example from Pericom.

Which one? Please point me to a website or something here.

> > > Without removing outbound io/mem regions view map during the cfg0/1
> > > read/write cycle, both of these devices can't work well at my side.
> > > Works well after remove them during the cfg0/1 read/write cycles.
> > 
> > Understood. Given that the iATU programming works on other CPUs
> > (confirmed on st spear and ti dra7xx), we might have some issues with
> > the iATU on MX6 . Is there anything special about the iATU on the MX6 ?
> 
> [Richard] As I know that there is no anything special about the iATU on
> MX6. Let me to make a double check with IC team later.

Oh this would be absolutelly _amazing_ if you could do that. Thank you very 
much!
[...]
Best regards,
Marek Vasut
