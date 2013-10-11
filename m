Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34997 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab3JKCNH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 22:13:07 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Fri, 11 Oct 2013 04:13:02 +0200
Cc: "Zhu Richard-R65037" <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Yinghai Lu <yinghai@kernel.org>,
	Tim Harvey <tharvey@gateworks.com>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <201310101939.44295.marex@denx.de> <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
In-Reply-To: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310110413.02354.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

> On Thu, Oct 10, 2013 at 11:39 AM, Marek Vasut <marex@denx.de> wrote:
> > Hi Bjorn,
> > 
> >> [+cc Yinghai]
> >> 
> >> On Thu, Oct 10, 2013 at 9:58 AM, Marek Vasut <marex@denx.de> wrote:
> >> >> On Thu, Oct 10, 2013 at 4:25 AM, Marek Vasut <marex@denx.de> wrote:
> >> > I tried you suggestion, this is what I got now (and with V7 of the
> >> > patches):
> >> > 
> >> > Note that my topology is: rootport->2_port_switch->ethernet_chip , the
> >> > other port of the switch is not used .
> >> > 
> >> > imx6q-pcie 1ffc000.pcie: phy link never came up

After discussing with Tim a little, looks like a clock bit was missing. The 
above line was the cause of all the issues. Now I can probe the bus, but I still 
need more patches:

This dirty patch here limits the PCIe operation to GEN1 only. It's based on this 
Freescale patch [1]. Without this change, the PCIe switch is not detected. Any 
idea why? (I also had to increase the PHY startup delay to get GEN1 going).

[1] https://www.osadl.org/monitoring/patches/r8s7/1342-ENGR00180230-MX6-PCIE-
enlarge-the-eye-diagram-and-fo.patch

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 32b30ca..df2838b 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -330,13 +330,16 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 
        dw_pcie_setup_rc(pp);
 
+// Enable GEN1
+writel(((readl(pp->dbi_base + 0x7c) & 0xfffffff0) | 0x1), pp->dbi_base + 0x7c);
+
        regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
                        IMX6Q_GPR12_PCIE_CTL_2, 1 << 10);
 
        while (!dw_pcie_link_up(pp)) {
                usleep_range(100, 1000);
                count++;
-               if (count >= 10) {
+               if (count >= 200) {
                        dev_err(pp->dev, "phy link never came up\n");
                        dev_dbg(pp->dev,
                                "DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",

Best regards,
Marek Vasut
