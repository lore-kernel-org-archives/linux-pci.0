Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61655 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbcBBJcp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 04:32:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Minghuan Lian <minghuan.lian@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Roy Zang <roy.zang@nxp.com>,
	Stuart Yoder <stuart.yoder@nxp.com>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mingkai Hu <mingkai.hu@nxp.com>
Subject: Re: [PATCH 1/4] ARM: dts: ls1021a: add PCIe dts node
Date: Tue, 02 Feb 2016 10:32:07 +0100
Message-ID: <6117401.iajrHOL4Mn@wuerfel>
In-Reply-To: <VI1PR04MB1615DCF54369ED2E01234E64E8DF0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <1454401807-28751-1-git-send-email-Minghuan.Lian@nxp.com> <VI1PR04MB1615DCF54369ED2E01234E64E8DF0@VI1PR04MB1615.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 02 February 2016 08:48:36 Minghuan Lian wrote:
> Hi Shawn,
> 
> Could you please help to review the patch?  Thank you very much.
> There is only one patch not a set of patch, please ignore [1/4] 
> 
> Arnd has given a ack.

For some reason, I did not get the other three patches though,
I was going to look at them, but I can't tell if this was a series
of patches doing PCI support, or patches doing other dts changes.

If you have additional patches for the PCI driver, let's review
it all together first.

	Arnd
