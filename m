Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:60638 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbcCJRf0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2016 12:35:26 -0500
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
To: Lucas Stach <l.stach@pengutronix.de>
References: <56D5E3DF.9030906@tekno-soft.it> <56D71F27.7070708@tekno-soft.it>
 <20160302195634.GA19223@localhost>
 <DBXPR04MB2706C7C2FD2348D205331998CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D80435.90408@tekno-soft.it>
 <DBXPR04MB2702F4BC78FA28DC82DCA218CBD0@DBXPR04MB270.eurprd04.prod.outlook.com>
 <56D8180A.1050708@tekno-soft.it> <56D84B6D.1050800@tekno-soft.it>
 <56D883AD.5060601@tekno-soft.it> <56DEE426.8030902@tekno-soft.it>
 <1457448829.3207.22.camel@pengutronix.de>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Fabio Estevam <festevam@gmail.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56E1B04A.9010206@tekno-soft.it>
Date: Thu, 10 Mar 2016 18:35:06 +0100
MIME-Version: 1.0
In-Reply-To: <1457448829.3207.22.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2016 03:53 PM, Lucas Stach wrote:
> Am Dienstag, den 08.03.2016, 15:39 +0100 schrieb Roberto Fichera:
>> > On 03/03/2016 07:34 PM, Roberto Fichera wrote:
>>> > > On 03/03/2016 03:34 PM, Roberto Fichera wrote:
>>> > >
>>> > > I've also checked clock, pll, PMU_MISC1 and CCGR[45] registers, all looks fine
>>> > > and exactly equal to uboot settings.
>>> > >
>>> > > However I'm investigating a possible HW issue in the LDVS pad wiring against
>>> > > the bridge XIO2001. Let's see once this is also clarified.
>> > 
>> > Our HW engineer has applied a fix to LVDS vs XIO2001 clock wiring. However I'm still getting the same problem.
>> > 
>> > I've tried to boot a kernel with uboot not setting up the PCIe subsys and below there is the resulting kernel log.
>> > Note that the CCGR5 doesn't set the CG2 field associated to sata_clk_enable. I think this field should be set all 1 to
>> > enable the SATA ref at 100MHz, right?
>> > 
> No, the reference manual is a bit confusing about this, but the LVDS1
> clock output is driven by sata_ref_100mhz, not the sata_clk gate.
>
> So the only thing that needs to be enabled for LVDS clock output is the
> 100MHz clock output from PLL ENET. (Register CCM_ANALOG_PLL_ENETn bit
> 20).

Guys! No more idea where to look at! Still getting PCIe link reaching L0 state under
uboot but doesn't progress more than POLL_ACTIVE or POLL_COMPLIANCE states
under kernel.

Any idea what to do?

Cheers,
Roberto Fichera.
